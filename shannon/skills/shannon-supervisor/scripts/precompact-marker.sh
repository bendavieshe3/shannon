#!/usr/bin/env bash
# PreCompact hook for the Shannon supervisor.
#
# Inert unless SHANNON_SUPERVISOR_SCOPE is set. During a supervisor run, each checker's
# finding fragment is already written to the run's own directory,
# <report_directory>/.in-progress/<YYYY-MM-DD-HHMMSS>/ (opened with a RUN file, SKILL.md
# § Report Pipeline steps 0-1), so findings survive compaction on disk. The marker goes into
# the newest run directory started in the last 24 hours; with no open run there is nothing
# to protect and the hook does nothing.
# This hook records that compaction happened, so the assemble step knows to rebuild the
# report from those files rather than from (summarised) context, and says so in the report.
# Reads the PreCompact event JSON on stdin. Never blocks: always exits 0.
set -u

if [ -z "${SHANNON_SUPERVISOR_SCOPE:-}" ]; then
  exit 0
fi

input="$(cat)"
trigger="$(printf '%s' "$input" | jq -r '.trigger // "unknown"' 2>/dev/null)"
[ -z "$trigger" ] && trigger="unknown"

report_dir="docs/supervisor"
config_path=".claude/shannon-supervisor.json"
if [ -f "$config_path" ]; then
  configured="$(jq -r '.report_directory // ""' "$config_path" 2>/dev/null)"
  [ -n "$configured" ] && report_dir="$configured"
fi
report_dir="${report_dir#./}"; report_dir="${report_dir%/}"

base="$report_dir/.in-progress"
[ -d "$base" ] || exit 0
run_marker=""
while IFS= read -r -d '' m; do
  if [ -z "$run_marker" ] || [ "$m" -nt "$run_marker" ]; then
    run_marker="$m"
  fi
done < <(find "$base" -mindepth 2 -maxdepth 2 -type f -name RUN -mmin -1440 -print0 2>/dev/null)
[ -n "$run_marker" ] || exit 0
run_dir="$(dirname "$run_marker")"
printf '%s\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$trigger" >> "$run_dir/COMPACTED"
exit 0
