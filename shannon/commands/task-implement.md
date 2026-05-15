# /task-implement

Execute a task's plan.

You MUST invoke the `work-items` skill to implement this task.

Pass:
- **Type**: `task`
- **Verb**: `implement`
- **Target**: Task ID from `$ARGUMENTS` (must be in PLANNED status). If empty, list candidate PLANNED tasks and ask.

The skill will mark the task IMPLEMENTING, execute the plan, update the Activity Log with significant decisions, and mark IMPLEMENTED when complete. The user may iterate between IMPLEMENTING, IMPLEMENTED, and REVIEW without crossing a gate.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
