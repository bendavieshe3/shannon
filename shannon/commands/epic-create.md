# /epic-create

Create a new epic in DRAFT.

You MUST invoke the `work-items` skill to create this epic.

Pass:
- **Type**: `epic`
- **Verb**: `create`
- **Target**: Optional title hint from `$ARGUMENTS`. If empty, suggest from recent conversation context.
- **Parent Feature**: Inferred from conversation context or asked. Every epic has a parent feature.

The skill will allocate the next EPIC-XXX ID, create the file under `./docs/epics/`, update `epic_index.md`, link to the parent feature, and capture initial intent.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."

After creation, resume the original conversation topic.
