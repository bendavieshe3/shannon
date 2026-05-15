# /spike-create

Create a new spike in DRAFT.

You MUST invoke the `work-items` skill to create this spike.

Pass:
- **Type**: `spike`
- **Verb**: `create`
- **Target**: Optional title hint from `$ARGUMENTS`. If empty, suggest from recent conversation context.
- **Feature** *(optional)*: Linked feature for context, or `standalone`.

The skill will allocate the next SPIKE-XXX ID, create the file under `./spikes/` (project root, not under `docs/`), update `spike_index.md`, and capture the initial question to investigate.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."

After creation, resume the original conversation topic.
