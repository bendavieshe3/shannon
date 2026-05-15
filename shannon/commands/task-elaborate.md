# /task-elaborate

Elaborate a task's requirements (Gate 1).

You MUST invoke the `work-items` skill to elaborate this task.

Pass:
- **Type**: `task`
- **Verb**: `elaborate`
- **Target**: Task ID from `$ARGUMENTS`. If empty, list candidate DRAFT tasks and ask.

The skill will read the parent Epic/Feature and any relevant Guides (UX Guide, etc.); draft the Requirements section including acceptance criteria; and present alignment findings. Gate 1 requires explicit user approval to transition DRAFT → ELABORATED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
