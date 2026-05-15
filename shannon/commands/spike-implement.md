# /spike-implement

Run the spike investigation.

You MUST invoke the `work-items` skill to implement this spike.

Pass:
- **Type**: `spike`
- **Verb**: `implement`
- **Target**: Spike ID from `$ARGUMENTS` (must be in PLANNED status). If empty, list candidate PLANNED spikes and ask.

The skill will run the investigation within the agreed time-box, capture findings in Investigation Notes, produce a knowledge note as the durable output, and record a recommendation. If the time-box expires without a conclusive answer, surface that as a result and stop.

If the `work-items` skill does not activate, report:
"Error: work-items skill failed to activate."
