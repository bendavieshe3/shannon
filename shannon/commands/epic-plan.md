# /epic-plan

Plan an epic's tasks (Gate 2).

You MUST invoke the `work-items` skill to plan this epic.

Pass:
- **Type**: `epic`
- **Verb**: `plan`
- **Target**: Epic ID from `$ARGUMENTS` (must be in ELABORATED status). If empty, list candidate ELABORATED epics and ask.

The skill will read the epic's Requirements, Technology Stack, parent Feature, and may update Technical Design; draft a task breakdown; and create child Task stubs in PLAN-PENDING (each requiring its own Gate 2 approval via `/task-plan`). Gate 2 requires explicit user approval to transition the epic ELABORATED → PLANNED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
