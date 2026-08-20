# TASK-028: Per-Category Finding Counts in the Report Header

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #templates #report-pipeline #header #machine-readable
- **Created**: 2026-08-21
- **Updated**: 2026-08-21

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at task creation, split out of TASK-025's Gate 1 elaboration on 2026-08-21 by directing-party ruling. Full elaboration pending `/task-elaborate TASK-028`.*

### Overview

A supervisor report's header carries one findings number — the total across all four categories — plus stuck-or-stale items, push lag, and the checkers-succeeded count. It carries no per-category breakdown. This Task adds one: a line stating the count in each of the four canonical categories (Drift, Gap, Internal contradiction, Strength), rendered by `templates/header.md` and filled by the pipeline at `SKILL.md` § Report Pipeline step 2.

The pipeline already has the data. Each checker returns its fragment in the four-category schema, so the counts exist at aggregation time and are simply not surfaced. This is a rendering gap, not a computation one.

### Why this is its own Task

It surfaced inside TASK-025's Gate 1 elaboration, which found that `ux_guide.md` v1.3's session-start summary — specified to lead with the Drift-category count — had no data source to read from. Folding the fix into TASK-025 was the faster path and was rejected: this is a change to the **report format**, consumed by every future reader of a report, whereas TASK-025 is a change to **one hook**. Giving the format change its own gate keeps each Task's scope guard honest and gives the header change review in its own right rather than as a rider.

It earns its place independently of the hook. A reader who sees `Findings: 9` learns less than one who sees that the nine are two gaps and six strengths — which, on `report-2026-08-20.md`, is the difference between "nine problems" and "two problems and a mostly healthy project".

### Deliberately NOT in scope

- **Retrofitting existing reports.** `report-2026-07-05.md` and `report-2026-08-20.md` stay exactly as written. They are historical records; rewriting them to satisfy a later format is worse than the gap it closes. Consumers must handle a report with no per-category line — that requirement lands on the consumer (TASK-025), not here.
- **The choice of which count leads the session-start summary.** That is `ux_guide.md` v1.3's, and a Task may not amend a Guide. See the scratchpad item questioning whether Drift is the right lead.
- **Reconciling the body's enumerated findings with the header's total.** A real defect — `report-2026-07-05.md` says 10 in the header and enumerates 9 — but a separate one, captured in the scratchpad. This Task adds a line; it does not audit the counting.

### Acceptance Criteria

*Drafted at `/task-elaborate TASK-028`. Expected shape:*

- [ ] `templates/header.md` renders a per-category counts line covering all four canonical categories, in a form a shell script can read without parsing prose
- [ ] `SKILL.md` § Report Pipeline step 2 is additively extended so the pipeline fills the new line from the collected fragments
- [ ] The line renders sensibly at zero — consistent with the zero-findings discipline TASK-024 established, a category with no findings shows `0`, never a blank or an omitted entry
- [ ] Source and deployed copy re-synced; the next `/shannon-report` run produces a report carrying the line
- [ ] No existing report is modified; no checker, hook, other template, or command file is touched

### Context

- **Parent Epic**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md) — Synthesis and Reports (IMPLEMENTING). Sequenced **before** TASK-025, which consumes this line.
- **Consumer**: [TASK-025](./TASK-025-sessionstart-health-summary-hook.md) — the SessionStart summary leads with the Drift count and reads it from this line.
- **Governing documents**: `ux_guide.md` v1.3 § Interaction Patterns → *Supervisor Report Presentation*; `ux_guide.md` § Interaction Patterns → *Presenting Findings*, which already renders a per-category shape and is the precedent for the wording.
- **Shipped surfaces extended**: `shannon/skills/shannon-supervisor/templates/header.md` (TASK-015, last amended TASK-024); `shannon/skills/shannon-supervisor/SKILL.md` § Report Pipeline step 2.
- **Discipline**: `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts* — edit `shannon/`, then deploy.

---

## Plan

*Drafted at `/task-plan TASK-028` (Gate 2).*

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review.*

---

## Activity Log

- **2026-08-21** — DRAFT: Task created by directing-party ruling during TASK-025's Gate 1 elaboration. That elaboration found `ux_guide.md` v1.3's session-start summary specified to lead with a Drift-category count that no shipped report surface carries, and that deriving the count by parsing report bodies is unsound — the body narrates only the highest-signal findings, its additional-findings labels are not uniform, and on `report-2026-07-05.md` the enumerated items do not reconcile with the header's own total. Ruled: add the count to the header rather than parse it, and split that change into its own Task sequenced before TASK-025, keeping the report-format change separate from the hook that consumes it. Full elaboration pending `/task-elaborate TASK-028`.
