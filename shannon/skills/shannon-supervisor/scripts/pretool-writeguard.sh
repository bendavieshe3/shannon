#!/usr/bin/env bash
# PreToolUse write-guard hook for the Shannon supervisor.
#
# Inert unless SHANNON_SUPERVISOR_SCOPE is set to a non-empty value. When active,
# refuses Write/Edit-family operations whose target path is outside the configured
# report_directory (default docs/supervisor), with an explicit exception for
# docs/knowledge/knowledge_index.md. Refusal exits 2 (blocking, per the Claude Code hook
# contract); allow exits 0. Reads the PreToolUse event JSON on stdin.
set -u

# Inert outside supervisor scope — never interfere with ordinary development.
# Checked before reading stdin or invoking jq, so a normal session pays nothing.
if [ -z "${SHANNON_SUPERVISOR_SCOPE:-}" ]; then
  exit 0
fi

default_report_dir="docs/supervisor"
index_exception="docs/knowledge/knowledge_index.md"
config_path=".claude/shannon-supervisor.json"

normalise() {
  # Strip a leading ./ and any trailing / so comparisons are stable.
  local p="$1"
  p="${p#./}"
  p="${p%/}"
  printf '%s' "$p"
}

input="$(cat)"

tool_name="$(printf '%s' "$input" | jq -r '.tool_name // ""' 2>/dev/null)"

# Only write-family tools are guarded; reads pass through untouched.
case "$tool_name" in
  Write|Edit|MultiEdit|NotebookEdit) ;;
  *) exit 0 ;;
esac

target="$(printf '%s' "$input" | jq -r '.tool_input.file_path // ""' 2>/dev/null)"
[ -z "$target" ] && exit 0
target="$(normalise "$target")"

# report_directory: configuration override if present, else the default.
report_dir="$default_report_dir"
if [ -f "$config_path" ]; then
  configured="$(jq -r '.report_directory // ""' "$config_path" 2>/dev/null)"
  [ -n "$configured" ] && report_dir="$configured"
fi
report_dir="$(normalise "$report_dir")"
index_exception="$(normalise "$index_exception")"

# Allow: the explicit knowledge-index exception (reciprocal of the report-indexing step).
if [ "$target" = "$index_exception" ]; then
  exit 0
fi

# Allow: the report directory itself or anything beneath it.
case "$target" in
  "$report_dir"|"$report_dir"/*)
    exit 0
    ;;
esac

# Otherwise refuse, blocking the write.
printf "Supervisor scope: refusing write to '%s' — outside the report directory '%s' (exception: %s).\n" \
  "$target" "$report_dir" "$index_exception" >&2
exit 2
