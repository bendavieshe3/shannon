# /shannon-report

Produce a current supervisor health report for this project.

You MUST invoke the `shannon-supervisor` skill to perform this work.

Pass:
- **Verb**: `report`

`/shannon-report` takes no arguments. The skill fans out into the three checker subagents (Alignment, Lifecycle, Drift), aggregates their findings into a single dated report under the configured report directory (default `./docs/supervisor/report-YYYY-MM-DD.md`), and indexes it in `./docs/knowledge_index.md` as a *Supervisor Report*. The report follows the hybrid-presentation default (a diagnostic header followed by a one- or two-finding narrative body).

If the `shannon-supervisor` skill does not activate, report:
"Error: shannon-supervisor skill failed to activate. Please confirm `./.claude/skills/shannon-supervisor/SKILL.md` is present."

When the report is written, surface its path to the user and resume the original conversation topic.
