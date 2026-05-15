# /spike-plan

Plan a spike's investigation approach (Gate 2).

You MUST invoke the `work-items` skill to plan this spike.

Pass:
- **Type**: `spike`
- **Verb**: `plan`
- **Target**: Spike ID from `$ARGUMENTS` (must be in ELABORATED status). If empty, list candidate ELABORATED spikes and ask.

The skill will define the investigation approach (experiments, comparisons, prototypes, research steps) and confirm the time-box. Gate 2 requires explicit user approval to transition ELABORATED → PLANNED.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
