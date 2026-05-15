# /task-create

Create a new task in DRAFT.

You MUST invoke the `work-items` skill to create this task.

Pass:
- **Type**: `task`
- **Verb**: `create`
- **Target**: Optional title hint from `$ARGUMENTS`. If empty, suggest a title from recent conversation context.
- **Parent Epic**: Inferred from conversation context, or `orphan` for one-off tasks not linked to an epic.

The skill will allocate the next TASK-XXX ID, create the file under `./docs/tasks/`, update `task_index.md`, link to the parent (epic or feature, if applicable), and capture initial intent. Full elaboration happens via `/task-elaborate`.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."

After creation, resume the original conversation topic.
