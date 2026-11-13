# /scratchpad-process

Work through the project scratchpad and give each item a disposition.

You MUST invoke the `work-items` skill to perform this work.

Pass:
- **Type**: `scratchpad`
- **Verb**: `process`
- **Scope**: `$ARGUMENTS` (optional: a tag or item title to limit the pass; empty means every item)

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate. Please confirm `./.claude/skills/work-items/` is present."

When processing ends, surface the dispositions and any decisions waiting on the user, then resume the original conversation topic.
