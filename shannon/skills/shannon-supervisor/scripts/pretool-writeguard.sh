#!/usr/bin/env bash
# PreToolUse write-guard hook for the Shannon supervisor.
#
# Inert unless SHANNON_SUPERVISOR_SCOPE is set to a non-empty value. When active,
# refuses Write/Edit-family operations whose target path (relative, or absolute under the
# project root) is outside the configured
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

# NotebookEdit names its target notebook_path; the other write tools use file_path.
target="$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.notebook_path // ""' 2>/dev/null)"
[ -z "$target" ] && exit 0
# Write and Edit pass absolute paths. Make the target relative to the project root before
# comparing. Candidate roots, first match wins: the git top level of the event's cwd (a
# supervisor run may sit in a worktree nested inside the main checkout), the event's cwd,
# CLAUDE_PROJECT_DIR, and the hook's working directory, each also in its physical form
# (symlinked roots such as macOS /tmp). An absolute path under none of them stays
# absolute and is refused below.
case "$target" in
  /*)
    event_cwd="$(printf '%s' "$input" | jq -r '.cwd // ""' 2>/dev/null)"
    top=""
    [ -n "$event_cwd" ] && top="$(git -C "$event_cwd" rev-parse --show-toplevel 2>/dev/null)"
    for root in "$top" "$event_cwd" "${CLAUDE_PROJECT_DIR:-}" "$PWD"; do
      [ -z "$root" ] && continue
      root="${root%/}"
      physical="$(cd "$root" 2>/dev/null && pwd -P)"
      for r in "$root" "$physical"; do
        [ -z "$r" ] && continue
        case "$target" in
          "$r"/*) target="${target#"$r"/}"; break 2 ;;
        esac
      done
    done
    ;;
esac
target="$(normalise "$target")"

# A path with a .. segment could climb out of the report directory; refuse it outright.
case "/$target/" in
  */../*)
    printf "Supervisor scope: refusing write to '%s' — paths containing '..' are not allowed.\n" "$target" >&2
    exit 2
    ;;
esac

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
