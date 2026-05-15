# /task-review

Review and approve a task (Gate 3).

You MUST invoke the `work-items` skill to review this task.

Pass:
- **Type**: `task`
- **Verb**: `review`
- **Target**: Task ID from `$ARGUMENTS`. If empty, list candidate IMPLEMENTED or REVIEW tasks and ask.

The skill verifies each acceptance criterion, checks alignment with the parent epic and feature, and confirms that any relevant documents were updated. Gate 3 requires explicit user approval to transition REVIEW → APPROVED. On approval, the task file is moved to `./docs/tasks/archive/`.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
