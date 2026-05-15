# /feature-plan

Plan a feature's epics (Gate 2).

You MUST invoke the `work-items` skill to plan this feature.

Pass:
- **Type**: `feature`
- **Verb**: `plan`
- **Target**: Feature ID from `$ARGUMENTS` (must be in ELABORATED status). If empty, list candidate ELABORATED features and ask.

The skill will read the feature's Requirements, Vision § referenced sections, Conceptual Design, and Technology Stack; draft an Epic breakdown; and may create child Epic stubs in PLAN-PENDING. Gate 2 requires explicit user approval to transition ELABORATED → PLANNED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."

After approval, resume the original conversation topic.
