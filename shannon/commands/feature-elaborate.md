# /feature-elaborate

Elaborate a feature's requirements (Gate 1).

You MUST invoke the `work-items` skill to elaborate this feature.

Pass:
- **Type**: `feature`
- **Verb**: `elaborate`
- **Target**: Feature ID from `$ARGUMENTS` (e.g. `FEAT-001`). If empty, list candidate DRAFT features and ask.

The skill will spawn a subagent to read the Vision and other required documents, draft the Requirements section, and present alignment findings. Gate 1 requires explicit user approval to transition DRAFT → ELABORATED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."

After approval, resume the original conversation topic.
