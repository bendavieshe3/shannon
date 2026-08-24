# Skill: shannon-supervisor

When invoked, **start your response with**: "Activating shannon-supervisor skill for [verb]."

The self-identification line above is emitted **only** for direct slash-command invocations (`/shannon-report` and `/shannon-goal`; additional verbs may be added by sibling work items). Hook-event activations (PreToolUse, PostToolUse, SessionStart, preCompact, Stop) and autonomous-cadence invocations are not user-message responses and do not emit a self-identification line.

## Purpose

This skill is the supervisor — the third role in the Shannon role taxonomy alongside the directing party and the implementer. The supervisor performs continuous health vigilance on the project: detecting document-vs-implementation drift, auditing work-item lifecycle state, surfacing operational drift (scratchpad pressure, uncommitted changes, branch lag), and synthesising findings into reports for the directing party to act on.

The supervisor is invokable both interactively (via slash commands) and autonomously (on a cadence the project configures; autonomous invocation lives in a sibling work item).

## When to Invoke

- `/shannon-report` — interactively, when the directing party wants a current health report. Contract codified below.
- `/shannon-goal [intent]` — interactively, when the directing party wants a free-text intent decomposed into candidate work items. Contract codified below.
- Autonomous cadence runs (forward work — invoked by a sibling work item's headless contract).
- Hook events (forward work — sibling work items configure PreToolUse, PostToolUse, SessionStart, preCompact, and Stop).

## Skill Directory Layout

The skill lives at `./.claude/skills/shannon-supervisor/` with five entries:

- `SKILL.md` — this file; supervisor logic and slash-command contracts.
- `templates/` — report templates (header, finding sections, footer). Populated by a sibling work item.
- `checkers/` — definitions for the three checker subagents (Alignment, Lifecycle, Drift). Populated by sibling work items.
- `scripts/` — helper scripts (git log parsers, index validators, hook bodies). Populated by sibling work items.
- `hooks/` — `settings.json` registration snippets for the supervisor's hooks (the shippable form merged into the project's `./.claude/settings.json`). Populated by the hook work items.

## /shannon-report — Contract

Invocation: `/shannon-report` (takes no arguments).

The skill:

1. Reads the supervisor configuration per § Configuration below to determine the report directory and any directing-party-reserved gate authorities.
2. Spawns three checker subagents in parallel — Alignment, Lifecycle, Drift — each returning a structured finding fragment using the canonical four-category schema: Drift, Gap, Internal contradiction, Strength.
3. Aggregates the fragments into a single dated report at `./docs/supervisor/report-YYYY-MM-DD.md` (or under the configured `report_directory` if overridden).
4. Indexes the report in `./docs/knowledge/knowledge_index.md` with Type marked as *Supervisor Report* per the Knowledge Note subtype convention.

The report follows the hybrid-presentation default: a diagnostic header (counts of findings, stuck items, push lag) followed by a one- or two-finding narrative body.

The implementation body of the report-writing pipeline — template instantiation, same-day-suffix handling for repeated runs, knowledge-index update flow — is forward work to be added by a sibling work item as a § Report Pipeline section appended below the Configuration section.

## /shannon-goal — Contract

Invocation: `/shannon-goal [intent]`, where `[intent]` is a free-text hint describing something the directing party wants (e.g. *"make onboarding feel less abrupt"*).

The verb decomposes the intent into a categorised list of candidate work items and presents it for the directing party to act on. It is a **read-only** verb — it writes nothing (see *Read-only reuse* below).

The skill:

1. Reads the supervisor configuration per § Configuration to determine the directing-party-reserved gate authorities — these decide which candidates the supervisor may promote autonomously and which require directing-party approval.
2. Discovers the existing artefacts the intent touches by reusing the § Report Pipeline checker fan-out (Flow step 1 only): the three checkers traverse the mandated documents and the work items and return four-category fragments that name specific artefacts by ID. Goal-decomposition maps those artefacts to the intent.
3. Sorts the candidate work items into two categories:
   - those aligned with existing artefacts — each candidate names the specific Feature, Epic, or document section it aligns with, cited by ID (e.g. FEAT-001, EPIC-005) or by document-and-section.
   - those surfacing gaps — each candidate names what no current artefact covers, and flags the promotion authority it requires: a Task may be auto-promoted on supervisor authority, but promotion to an Epic or a Feature requires directing-party approval (per the *Gate Authority Split* business rule).
4. Renders the result in the shape below.

### Output shape

The output carries four elements — an `Intent:` echo of the hint, one heading per category each carrying a parenthesised count, and a closing promotion-authority footer:

```
Intent: "make onboarding feel less abrupt"

Candidates aligned with existing artefacts (2):
  - Extend FEAT-001 § Ideal State to name first-session experience
  - New Task under EPIC-005 — Soften /shannon-setup conclusion message

Candidates surfacing gaps (1):
  - No Feature elaborates "first-session experience" yet — directing-party
    approval needed before scratchpad promotion to Feature

Promote which? (Tasks may be auto-promoted on supervisor authority;
Epics and Features require your approval.)
```

When a category is empty, its heading still renders with a `(0)` count and an explicit "no candidates in this category" line, so the directing party can distinguish a considered-empty category from a truncated run.

### Read-only reuse

`/shannon-goal` reuses only the § Report Pipeline checker fan-out — Flow step 1 (the parallel Alignment/Lifecycle/Drift spawn and the canonical four-category fragment schema) — for artefact discovery. It does **not** run the report-construction steps (Flow steps 2–6): no template instantiation, no dated report written under the configured `report_directory`, and no entry appended to `./docs/knowledge/knowledge_index.md`. The verb's entire output is the categorised candidate list rendered to the directing party; it produces no file.

### Failure modes

Configuration handling follows § Configuration and § Failure Modes exactly. A **missing** `./.claude/shannon-supervisor.json` is not an error — the file is optional and `/shannon-goal` proceeds on the § Configuration defaults. A **malformed** file (present but not valid JSON) is surfaced explicitly: `/shannon-goal` names the offending file — `./.claude/shannon-supervisor.json` — reports the parse error, and refuses to run rather than silently falling back to defaults. In neither case is a generic "config missing" string emitted; the actual file path is always named.

## Configuration

The supervisor reads `./.claude/shannon-supervisor.json` for project-specific configuration. The file is optional.

**Default values** — applied when the file is absent or a specific field is absent:

| Field | Default |
|---|---|
| epic_gate_authority | supervisor |
| spike_gate_authority | supervisor |
| report_directory | docs/supervisor |

**Override semantics**:

- File absent → all fields take defaults; the skill must not crash on a missing file.
- File present but empty (`{}`) → all fields take defaults; the skill must not crash on an empty file.
- File present with a subset of fields → named fields override defaults; absent fields take the default value.
- File present with all fields → each field's value is honoured uniformly.

The supervisor handles file-not-found and empty-JSON-document cases gracefully — no exception raised, defaults applied silently.

The `report_directory` value is interpreted as a path relative to the project root. The `epic_gate_authority` and `spike_gate_authority` fields each take the value `supervisor` (the default, meaning the supervisor may approve the corresponding gate autonomously) or `directing_party` (meaning the gate is reserved to the directing party). Task gates are always supervisor authority and not configurable per the *Gate Authority Split* business rule. The fixed-floor gates (Vision, Features) are always directing-party authority and not configurable.

## Report Pipeline

The `/shannon-report` contract (above) delegates report construction to this pipeline. The pipeline aggregates the three checkers' finding fragments into a single dated report using the templates under `templates/` (`header.md`, `finding-section.md`, `footer.md`).

### Flow

1. **Spawn and collect.** Spawn the three checker subagents (Alignment, Lifecycle, Drift) in parallel per the `/shannon-report` contract; collect each one's finding fragment in the canonical four-category schema: Drift, Gap, Internal contradiction, Strength. If a checker fails to return a fragment, record that — the header reports how many of the three succeeded rather than failing the whole run.

2. **Instantiate the header.** Fill `templates/header.md` with the run date and the diagnostic counts — total findings, stuck-or-stale items (from the Lifecycle fragment), and push lag in commits ahead of the remote (from the Drift fragment) — plus the count of checkers that succeeded. This is the diagnostic half of the hybrid-presentation default. Fill the header's per-category counts line from the same collected fragments' four-category schema, in the fixed order Drift, Gap, Internal contradiction, Strength, rendering a literal `0` for any category that surfaced nothing — all four categories always appear, never blank, never omitted, never collapsed to only the non-zero ones. The four counts partition exactly the finding set the leading total's principal number counts, and therefore sum to it; a finding a checker returned as uncertain is carried as the parenthesised annotation on the total (`9 (+1 uncertain)`) and is never folded into a category, so the per-category line carries bare integers and no annotation syntax of its own. Four counts that do not sum to the leading total mean the aggregation is wrong — treat the mismatch as a defect in this step, not as a rounding of the report.

3. **Instantiate the finding sections.** For the one or two highest-signal findings across the collected fragments, fill `templates/finding-section.md` once per finding — category, title, originating checker, narrative, and the specific source citation (file path and section or line) the checker supplied. The remaining findings are represented by the header counts, not narrated individually — this is the narrative half of the hybrid-presentation default. When no findings surface across all fragments, this step instantiates no finding section; instead it emits a single positively-stated line — for example "3 checkers ran cleanly; nothing surfaced" — so a clean run reads as an affirmative bill of health rather than a blank body. Combined with the header's `Checkers run: {{CHECKERS_SUCCEEDED}} of 3` note (which reads 3 of 3 on a healthy run and a lower count when a checker failed) and the header's `Findings: 0` (the literal `0`, never blank), this lets the directing party distinguish "checked and found nothing" from a supervisor that silently failed to check.

4. **Instantiate the footer.** Fill `templates/footer.md` with the run date.

5. **Assemble and write.** Concatenate header + finding sections + footer into a single Markdown body and write it to `<report_directory>/report-YYYY-MM-DD.md` (default `./docs/supervisor/`, per § Configuration). **Reports are never overwritten**: if a report for the current date already exists, write `report-YYYY-MM-DD-2.md` (then `-3`, and so on) — the same-day suffix increments to the next free name.

6. **Index the report.** Append an entry for the new report to `./docs/knowledge/knowledge_index.md`, under its *Supervisor Reports* section (created on first use), with the entry's Type label reading *Supervisor Report* (a Knowledge Note subtype) and a project-relative reference to the report file. This write is the explicit exception the PreToolUse write-guard permits (sibling work item); every other write outside the configured report directory is refused.

The configured report directory and `./docs/knowledge/knowledge_index.md` are the only paths this pipeline writes.

### Presentation

The report's presentation is hybrid by default, as EPIC-009 shipped it: a diagnostic header (the Flow-step-2 counts) followed by a one- or two-finding narrative body (Flow step 3). Two project-level customisations are valid but are not the framework default — diagnostic-only (the diagnostic header alone, no narrative body) and conversational-only (the narrative body alone, no header). These, and the hybrid default, are described in `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*; choosing a non-hybrid presentation is a project configuration choice, not a change to this pipeline's behaviour.

The terse three-count style is shared by two distinct surfaces that differ only in their leading count:

- The report header (`templates/header.md`, Flow step 2) leads with total findings: Findings · Stuck or stale items · Push lag.
- The SessionStart summary — the terse health line the SessionStart hook injects at session open — leads with the Drift-category count: Drift · stuck items · push lag.

Both share the same terse form (a leading count, then stuck-or-stale items, then push lag); only the first count differs — total findings for the report header, the Drift-category count for the SessionStart summary. The SessionStart hook reuses this terse style rather than re-deriving it.

## Hook Integration

The supervisor integrates with five Claude Code hook points; each is implemented by a sibling work item:

- **PreToolUse** — write-guard refusing writes outside the configured `report_directory`, with an explicit exception for `./docs/knowledge/knowledge_index.md`.
- **PostToolUse** — audit log recording each tool invocation with timestamp and arguments, appended to `./.claude/skills/shannon-supervisor/audit.log` (operational telemetry, append-only; written only when the supervisor scope is active).
- **SessionStart** — terse health summary at session open, implemented as `scripts/sessionstart-summary.sh` (registration snippet `hooks/sessionstart.settings.json`). Reads the most-recent report under the configured `report_directory` (honouring the same-day `-N` suffix) and injects one line leading with the **Drift-category count** from the header's `**By category:**` line — where the report header leads with the total. On a report predating that line it names the total and says the per-category breakdown is unavailable rather than deriving one. It states the report's date and age, distinguishes the quiet outcomes (no report / clean run / partial run / unreadable report) so it is never ambiguously silent, writes nothing, and always exits 0. Deliberately **not** `SHANNON_SUPERVISOR_SCOPE`-gated — session orientation must fire in ordinary sessions; muted instead via `.claude/supervisor/state.json`.
- **preCompact** — snapshot of in-flight findings to disk before context compaction.
- **Stop** — completion check on autonomous runs (warn on context threshold or unflushed findings).

Hook event activations are not user-message responses and do not emit the self-identification line — the supervisor performs its hook role silently and writes its output to the relevant location (the audit log for PostToolUse, the report findings buffer for preCompact, etc.).

## Failure Modes

- **Configuration file malformed** — If `./.claude/shannon-supervisor.json` exists but is not valid JSON, surface the parse error explicitly and refuse to run rather than silently fall back to defaults. A malformed configuration is a directing-party error and should be visible.
- **`report_directory` writable but outside scope** — If the configured `report_directory` is outside the project tree, the PreToolUse hook will refuse writes; surface the configuration mismatch explicitly.
- **Checker subagent failure** — If one of the three checkers fails to return a finding fragment, surface the failure in the report header (counts of successful checkers) rather than failing the entire run.

## Self-Identification

The self-identification line — *"Activating shannon-supervisor skill for [verb]."* — is emitted **only** when this skill activates in response to a direct slash-command invocation (`/shannon-report` or `/shannon-goal`). Hook-event activations and autonomous-cadence invocations do not emit the self-identification line; they are not user-message responses.

If this skill cannot perform its work for any reason, it must say so explicitly rather than silently doing something else.
