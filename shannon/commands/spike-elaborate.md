# /spike-elaborate

Elaborate a spike's question and expected output (Gate 1).

You MUST invoke the `work-items` skill to elaborate this spike.

Pass:
- **Type**: `spike`
- **Verb**: `elaborate`
- **Target**: Spike ID from `$ARGUMENTS`. If empty, list candidate DRAFT spikes and ask.

The skill will sharpen the question, agree on the expected output (typically a knowledge note plus a recommendation), and set a time-box. Gate 1 requires explicit user approval to transition DRAFT → ELABORATED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
