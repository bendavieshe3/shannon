# /feature-review

Review and approve a feature (Gate 3).

You MUST invoke the `work-items` skill to review this feature.

Pass:
- **Type**: `feature`
- **Verb**: `review`
- **Target**: Feature ID from `$ARGUMENTS`. If empty, list candidate IMPLEMENTED or REVIEW features and ask.

For a feature reaching APPROVED, the skill verifies that the constituent epics have themselves been APPROVED, that the feature's acceptance has been met, and that the parent Vision section is still aligned. Gate 3 requires explicit user approval. Once APPROVED, the feature's Activity becomes STABLE.

Note: Features rarely fully "complete" — they accumulate epics over time. `/feature-review` is typically used to confirm a milestone state rather than a terminal one.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
