# /spike-review

Review and approve a spike (Gate 3).

You MUST invoke the `work-items` skill to review this spike.

Pass:
- **Type**: `spike`
- **Verb**: `review`
- **Target**: Spike ID from `$ARGUMENTS`. If empty, list candidate IMPLEMENTED or REVIEW spikes and ask.

The skill verifies that the question was answered (or confirmed unanswerable within the time-box), that a knowledge note exists and is indexed, and that a recommendation is captured. Gate 3 requires explicit user approval to transition REVIEW → APPROVED. The spike file remains as an activity record; the knowledge note is the durable artefact.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
