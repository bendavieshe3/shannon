# Shannon Changelog

The newest `## [x.y]` heading is the framework version; `/shannon-setup` and `/shannon-update` read it from here and record it in `.claude/.shannon-version`.

Each entry has a **Summary**, a **Records** list telling `/shannon-update` how existing work items and documents absorb the change, and, when one is needed, a **Migration** list for steps the directing party must take. A *Records* note is **additive** (nothing to do until a record is next touched), **meaning** (re-elaborate the affected records with trigger *framework evolution*), or **document** (re-review the named sections of the project's own documents).

## [5.2] - 2026-11-14

### Summary

- Command files call the human the *directing party* throughout, matching the skills and documents.
- When a Feature's approach creates a skill, `work-items` Plan asks that the plan include the skill's command entry point.

### Records

- **additive** — No change to existing records.

## [5.1] - 2026-11-13

### Summary

- The skill files are now `SKILL.md`. Claude Code loads only that name, so earlier installs ran `work-items`, `project-documentation` and `project-setup` only when the model read the files by hand.
- `/shannon-update` upgrades an install from a newer clone. It reports versions, protects local customisations through a hash manifest, backs files up and walks existing records through these notes.
- `/shannon-setup` installs more safely into existing projects. It backs files up before overwriting, merges `CLAUDE.md` inside `<!-- shannon:begin/end -->` markers and merges `.claude/settings.json`, detects Node, Python, Go and Rust projects, and verifies the result.
- `/shannon-setup` now wires the supervisor: hook registrations, a default `shannon-supervisor.json`, the audit-log ignore and `docs/supervisor/`.
- The supervisor gains PreCompact and Stop hooks, so a report survives context compaction and a run cannot end with unassembled findings, and `scripts/cadence-run.sh`, which runs `/shannon-report` unattended in a throwaway worktree and commits only the report. Scheduling it is the project's choice (cron, launchd or similar).
- The supervisor's write-guard no longer blocks every absolute path, which in practice blocked all supervisor writes once scoped; it refuses `..` segments instead. Its checkers now declare their model and tools in the form Claude Code reads.
- The supervisor hooks need `bash` and `jq`; `/shannon-setup` checks for both.
- The scratchpad is part of the framework: a `docs/scratchpad.md` template, `/scratchpad-add` and `/scratchpad-process`.
- Feature elaboration and planning now record a *Documents Consulted* list, and gates show it.

### Records

- **additive** — Features gain optional *Documents Consulted* subsections under Requirements and Plan. Fill them in when a Feature next passes Gate 1 or Gate 2.
- **additive** — `docs/scratchpad.md` is created if missing. An existing scratchpad is kept; add a § Processed heading if it has none.
- **document** — In the project's `conceptual_design.md`, consider a *Scratchpad* glossary entry if the project relies on its scratchpad.

### Migration

- The lowercase `.claude/skills/{work-items,project-documentation,project-setup}/skill.md` files become `SKILL.md`. `/shannon-update` renames each one in two steps (`skill.md` → a temporary name → `SKILL.md`) before copying the new file in, because on a case-insensitive filesystem (the macOS default) a plain copy would overwrite `skill.md` in place and keep the lowercase name, and deleting `skill.md` afterwards would delete the only copy. Check afterwards with `ls`, which shows the stored case.
- Existing `CLAUDE.md` content is kept. The Shannon block is appended once, after your content; remove any duplicated Shannon guidance above it by hand.
- If you scheduled the supervisor with the old documented `claude --bare -p` command, switch to `scripts/cadence-run.sh`: `--bare` skips skills and hooks, so that command never ran the report.
- Restart Claude Code sessions after updating so new commands and hooks load.

## [5.0] - 2026-11-01

### Summary

- Feature-level governance. Human gates are Feature requirements (Gate 1), approach (Gate 2) and delivered capability (Gate 3). Epics, Tasks and Spikes are optional execution aids with no mandatory sequence or human gates. Independent technical review stays distinct from implementation and human acceptance.

### Records

- **meaning** — Existing Epics, Tasks and Spikes keep their identifiers, labels and history. A legacy lower-level APPROVED label is historical and is not Feature acceptance. No bulk migration or archive.
- **meaning** — `epic_gate_authority` and `spike_gate_authority` in `shannon-supervisor.json` no longer grant authority. Leave them in place; the supervisor reports them.
- **document** — Re-review the project's governing documents wherever they describe mandatory Epic, Task or Spike gates.

## Before 5.0

Installs before 5.0 recorded no version. `/shannon-update` treats them as version "unknown", applies every entry above, and asks about each framework file that differs from the new source, because without a manifest it cannot tell a local customisation from an older shipped file.
