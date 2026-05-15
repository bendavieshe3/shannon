# /epic-elaborate

Elaborate an epic's requirements (Gate 1).

You MUST invoke the `work-items` skill to elaborate this epic.

Pass:
- **Type**: `epic`
- **Verb**: `elaborate`
- **Target**: Epic ID from `$ARGUMENTS`. If empty, list candidate DRAFT epics and ask.

The skill will read the parent Feature, Vision § referenced sections, and Conceptual Design; draft the Requirements section; and present alignment findings. Gate 1 requires explicit user approval to transition DRAFT → ELABORATED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
