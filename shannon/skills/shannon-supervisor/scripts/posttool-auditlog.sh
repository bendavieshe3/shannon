#!/usr/bin/env bash
# PostToolUse audit-logging hook for the Shannon supervisor.
#
# Inert unless SHANNON_SUPERVISOR_SCOPE is set to a non-empty value. When active,
# appends one line per tool invocation — "ISO-8601-timestamp <TAB> TOOL_NAME <TAB> <args>"
# — to the audit log (default .claude/skills/shannon-supervisor/audit.log; override
# with SHANNON_AUDIT_LOG, e.g. for testing). Operational telemetry, append-only.
# Reads the PostToolUse event JSON on stdin. Always exits 0 — PostToolUse is
# observational and does not block the tool.
set -u

# Inert outside supervisor scope — never log ordinary development.
# Checked before reading stdin or invoking jq, so a normal session pays nothing.
if [ -z "${SHANNON_SUPERVISOR_SCOPE:-}" ]; then
  exit 0
fi

audit_log="${SHANNON_AUDIT_LOG:-.claude/skills/shannon-supervisor/audit.log}"

input="$(cat)"
tool_name="$(printf '%s' "$input" | jq -r '.tool_name // ""' 2>/dev/null)"
[ -z "$tool_name" ] && exit 0

# Compact argument summary: the command for Bash, the file_path for Write/Edit.
case "$tool_name" in
  Bash)
    args="$(printf '%s' "$input" | jq -r '.tool_input.command // ""' 2>/dev/null)"
    ;;
  *)
    args="$(printf '%s' "$input" | jq -r '.tool_input.file_path // ""' 2>/dev/null)"
    ;;
esac

# Collapse any newlines so each entry stays a single line.
args="$(printf '%s' "$args" | tr '\n' ' ')"

timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

mkdir -p "$(dirname "$audit_log")"
printf '%s\t%s\t%s\n' "$timestamp" "$tool_name" "$args" >> "$audit_log"
exit 0
