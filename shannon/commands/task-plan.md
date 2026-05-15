# /task-plan

Plan a task's implementation (Gate 2).

You MUST invoke the `work-items` skill to plan this task.

Pass:
- **Type**: `task`
- **Verb**: `plan`
- **Target**: Task ID from `$ARGUMENTS` (must be in ELABORATED status). If empty, list candidate ELABORATED tasks and ask.

The skill will read the task's Requirements, Development Guide, and Technical Design; draft the implementation Plan (approach, steps, dependencies, risks); and present it. Gate 2 requires explicit user approval to transition ELABORATED → PLANNED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
