# /epic-implement

Execute an epic's plan (typically by progressing its tasks).

You MUST invoke the `work-items` skill to implement this epic.

Pass:
- **Type**: `epic`
- **Verb**: `implement`
- **Target**: Epic ID from `$ARGUMENTS` (must be in PLANNED status). If empty, list candidate PLANNED epics and ask.

For an epic, "implement" typically means progressing its tasks. The skill will mark the epic IMPLEMENTING and surface the next task to work on. Use `/task-implement TASK-XXX` to do the actual task work.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
