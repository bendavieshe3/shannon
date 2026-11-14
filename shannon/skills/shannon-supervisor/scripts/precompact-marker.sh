#!/usr/bin/env bash
# PreCompact hook for the Shannon supervisor.
#
# Inert unless SHANNON_SUPERVISOR_SCOPE is set. During a supervisor run, each checker's
# finding fragment is already written to <report_directory>/.in-progress/YYYY-MM-DD/ as it
# returns (SKILL.md § Report Pipeline step 1), so findings survive compaction on disk.
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

run_dir="$report_dir/.in-progress/$(date +%Y-%m-%d)"
mkdir -p "$run_dir"
printf '%s\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$trigger" >> "$run_dir/COMPACTED"
exit 0
