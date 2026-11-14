#!/usr/bin/env bash
# Stop hook for the Shannon supervisor: completion check.
#
# Inert unless SHANNON_SUPERVISOR_SCOPE is set. A supervisor run opens its own run directory,
# <report_directory>/.in-progress/<YYYY-MM-DD-HHMMSS>/, by writing a RUN file there
# (SKILL.md § Report Pipeline step 0), and saves each checker fragment beside it. When the
# newest run (by RUN file time, started within the last 24 hours) holds fragments but no
# report has been written since that run started, the hook blocks the stop once and tells
# Claude to assemble and write the report. Earlier runs' directories are never consulted,
# so a same-day rerun cannot be satisfied by an earlier report. stop_hook_active=true
# (Claude is already continuing because of this hook) always allows the stop, so it cannot
# loop. Reads the Stop event JSON on stdin; exits 0 in every case.
set -u

if [ -z "${SHANNON_SUPERVISOR_SCOPE:-}" ]; then
  exit 0
fi

input="$(cat)"
active="$(printf '%s' "$input" | jq -r '.stop_hook_active // false' 2>/dev/null)"
[ "$active" = "true" ] && exit 0

report_dir="docs/supervisor"
config_path=".claude/shannon-supervisor.json"
if [ -f "$config_path" ]; then
  configured="$(jq -r '.report_directory // ""' "$config_path" 2>/dev/null)"
  [ -n "$configured" ] && report_dir="$configured"
fi
report_dir="${report_dir#./}"; report_dir="${report_dir%/}"
base="$report_dir/.in-progress"
[ -d "$base" ] || exit 0

# Newest run marker started in the last 24 hours.
run_marker=""
while IFS= read -r -d '' m; do
  if [ -z "$run_marker" ] || [ "$m" -nt "$run_marker" ]; then
    run_marker="$m"
  fi
done < <(find "$base" -mindepth 2 -maxdepth 2 -type f -name RUN -mmin -1440 -print0 2>/dev/null)
[ -n "$run_marker" ] || exit 0
run_dir="$(dirname "$run_marker")"

# Fragments are the checker outputs; RUN and COMPACTED are markers.
count=0
while IFS= read -r -d '' _; do
  count=$((count + 1))
done < <(find "$run_dir" -maxdepth 1 -type f -name '*.md' -print0 2>/dev/null)
[ "$count" -eq 0 ] && exit 0

# A report not older than this run's RUN marker was written by this run.
while IFS= read -r -d '' r; do
  [ ! "$r" -ot "$run_marker" ] && exit 0
done < <(find "$report_dir" -maxdepth 1 -type f -name 'report-*.md' -print0 2>/dev/null)

reason="Supervisor run is stopping with $count checker fragment(s) in $run_dir but no report written since the run started. Assemble and write the report from those files (shannon-supervisor SKILL.md § Report Pipeline steps 2-6) before stopping."
jq -n --arg r "$reason" '{decision: "block", reason: $r}'
exit 0
