#!/usr/bin/env bash
# Stop hook for the Shannon supervisor: completion check.
#
# Inert unless SHANNON_SUPERVISOR_SCOPE is set. When a supervisor run tries to stop while
# today's in-progress fragments exist under <report_directory>/.in-progress/YYYY-MM-DD/ but
# no report for today has been written since the first fragment, it blocks the stop once
# and tells Claude to assemble and write the report. stop_hook_active=true (Claude is
# already continuing because of this hook) always allows the stop, so it cannot loop.
# Reads the Stop event JSON on stdin; exits 0 in every case.
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

today="$(date +%Y-%m-%d)"
run_dir="$report_dir/.in-progress/$today"
[ -d "$run_dir" ] || exit 0

# Fragments are the checker outputs; COMPACTED is only a marker.
fragments="$(find "$run_dir" -maxdepth 1 -type f -name '*.md' 2>/dev/null)"
[ -z "$fragments" ] && exit 0

oldest="$(ls -tr $fragments 2>/dev/null | head -n 1)"
written=""
for r in "$report_dir"/report-"$today".md "$report_dir"/report-"$today"-*.md; do
  [ -f "$r" ] || continue
  # A report not older than the run's first fragment was written by this run.
  if [ ! "$r" -ot "$oldest" ]; then
    written="$r"
  fi
done
[ -n "$written" ] && exit 0

count="$(printf '%s\n' "$fragments" | wc -l | tr -d ' ')"
reason="Supervisor run is stopping with $count checker fragment(s) in $run_dir but no report for $today. Assemble and write the report from those files (shannon-supervisor SKILL.md § Report Pipeline steps 2-6) before stopping."
jq -n --arg r "$reason" '{decision: "block", reason: $r}'
exit 0
