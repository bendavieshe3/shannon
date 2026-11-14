# /scratchpad-add [idea]

Capture an idea in the project scratchpad without classifying it.

You MUST invoke the `work-items` skill to perform this work.

Pass:
- **Type**: `scratchpad`
- **Verb**: `add`
- **Item**: `$ARGUMENTS`

If `$ARGUMENTS` is empty, ask the user for the idea in one line.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate. Please confirm `./.claude/skills/work-items/` is present."

When the item is captured, resume the original conversation topic.
