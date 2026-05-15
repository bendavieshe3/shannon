# /feature-implement

Execute a feature's plan (typically by progressing its epics).

You MUST invoke the `work-items` skill to implement this feature.

Pass:
- **Type**: `feature`
- **Verb**: `implement`
- **Target**: Feature ID from `$ARGUMENTS` (must be in PLANNED status). If empty, list candidate PLANNED features and ask.

For a feature, "implement" typically means progressing one or more epics. The skill will mark the feature ACTIVE and surface the next epic to work on. Use `/epic-implement EPIC-XXX` to do the actual epic work.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
