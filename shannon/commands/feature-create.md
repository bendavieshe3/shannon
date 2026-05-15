# /feature-create

Create a new feature in DRAFT.

You MUST invoke the `work-items` skill to create this feature.

Pass:
- **Type**: `feature`
- **Verb**: `create`
- **Target**: Optional title hint from `$ARGUMENTS`. If empty, suggest a title from recent conversation context.

The skill will allocate the next FEAT-XXX ID, create the file under `./docs/features/`, update `feature_index.md`, and capture initial intent. Full elaboration happens in a separate step (`/feature-elaborate`).

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate. Please confirm `./.claude/skills/work-items/skill.md` is present."

After creation, resume the original conversation topic.
