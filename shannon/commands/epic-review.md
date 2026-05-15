# /epic-review

Review and approve an epic (Gate 3).

You MUST invoke the `work-items` skill to review this epic.

Pass:
- **Type**: `epic`
- **Verb**: `review`
- **Target**: Epic ID from `$ARGUMENTS`. If empty, list candidate IMPLEMENTED or REVIEW epics and ask.

The skill verifies that all child tasks have reached APPROVED, that the epic's acceptance criteria are met, and that the parent feature's state should be updated. Gate 3 requires explicit user approval to transition REVIEW → APPROVED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
