# TASK-028: Per-Category Finding Counts in the Report Header

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #templates #report-pipeline #header #machine-readable
- **Created**: 2026-08-21
- **Updated**: 2026-08-21

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated at Gate 1 on 2026-08-21. Split out of TASK-025's Gate 1 elaboration on 2026-08-21 by directing-party ruling.*

### Overview

A supervisor report's header carries one findings number — the total across all four categories — plus stuck-or-stale items, push lag, and the checkers-succeeded count. It carries no per-category breakdown. This Task adds one line stating the count in each of the four canonical categories (Drift, Gap, Internal contradiction, Strength), rendered by `templates/header.md` and filled by the pipeline at `SKILL.md` § Report Pipeline step 2.

The pipeline already has the data. Each checker returns its fragment in the four-category schema, so the counts exist at aggregation time and are simply not surfaced. This is a rendering gap, not a computation one.

### Why this is its own Task

It surfaced inside TASK-025's Gate 1 elaboration, which found that `ux_guide.md` v1.3's session-start summary — specified to lead with the Drift-category count — had no data source to read from. Folding the fix into TASK-025 was the faster path and was rejected: this is a change to the **report format**, consumed by every future reader of a report, whereas TASK-025 is a change to **one hook**. Giving the format change its own gate keeps each Task's scope guard honest and gives the header change review in its own right rather than as a rider.

It earns its place independently of the hook. A reader who sees `Findings: 9` learns less than one who sees that the nine are two gaps and six strengths — which, on `report-2026-08-20.md`, is the difference between "nine problems" and "two problems and a mostly healthy project".

### The line

Rendered directly beneath the existing counts line, sharing its `**Label:** value  ·  value` style:

```
**Findings:** {{FINDING_COUNT}}  ·  **Stuck or stale items:** {{STUCK_COUNT}}  ·  **Push lag:** {{PUSH_LAG_COMMITS}} commit(s) ahead of remote

**By category:** Drift {{DRIFT_COUNT}}  ·  Gap {{GAP_COUNT}}  ·  Internal contradiction {{CONTRADICTION_COUNT}}  ·  Strength {{STRENGTH_COUNT}}
```

Four properties make it consumable without prose parsing:

- **A unique line prefix.** `**By category:**` occurs nowhere else in any report surface, so a consumer selects the line before reading any number. The bare category words are *not* unique — `Drift` also appears in the header's own `Checkers run:` line and in every Drift finding heading — so a consumer that greps for a category word alone will mis-hit. The prefix is the anchor, and the AC binds it.
- **Fixed category order** — Drift, Gap, Internal contradiction, Strength — matching the canonical schema order used by `ux_guide.md` § Interaction Patterns → *Presenting Findings* and by `technical_design.md` § Document Alignment Check.
- **All four always present.** A category with no findings renders `0`. Never blank, never omitted, never collapsed to a shorter list of the non-zero categories.
- **Bare integers.** No annotations, no ranges, no qualifiers on this line.

### Counting rule

The four counts **partition exactly the finding set that `{{FINDING_COUNT}}`'s principal number counts**, so the four sum to it. Findings the checkers returned as uncertain stay where they already live — as the parenthesised annotation on the `Findings:` total (`9 (+1 uncertain)`, as `report-2026-08-20.md` renders it) — and are excluded from both the total's principal number and the per-category counts. They are not silently folded into a category, and the per-category line grows no annotation syntax of its own.

This keeps the machine-readable line machine-readable and leaves uncertainty visible on the human-facing total, where the supervisor's *never ambiguously quiet* principle is already served. It also gives the pipeline a checkable self-invariant at write time: if the four do not sum to the total, the aggregation is wrong.

### Deliberately NOT in scope

- **Retrofitting existing reports.** `report-2026-07-05.md` and `report-2026-08-20.md` stay exactly as written. They are historical records; rewriting them to satisfy a later format is worse than the gap it closes. Consumers must handle a report with no per-category line — that requirement lands on the consumer (TASK-025), not here.
- **The announcement surface.** `ux_guide.md`'s worked example of the spoken report announcement renders its breakdown inline and non-zero-only (`3 findings (2 drift, 1 gap)`). That is a different surface with a different reader, it is an example rather than a specification, and this Task does not touch it. The two shapes are not required to converge, and reasoning from the example to the file format is the error TASK-027 exists to correct.
- **The choice of which count leads the session-start summary.** That is `ux_guide.md` v1.3's, and a Task may not amend a Guide. See the scratchpad item questioning whether Drift is the right lead.
- **Reconciling the body's enumerated findings with the header's total.** A real defect — `report-2026-07-05.md` says 10 in the header and enumerates 9 — but a separate one, captured in the scratchpad. This Task adds a line and states an invariant for future runs; it does not audit past counting.
- **The `{{...}}` versus `[...]` placeholder divergence.** All three supervisor templates use `{{SLOT}}` where `development_guide.md` § Code Style → *Template Structure* specifies square brackets. This Task follows the local convention of the file it edits rather than introducing a fourth style inside it; the framework-general divergence goes to the scratchpad.

### Acceptance Criteria

- [ ] **AC#1 — The line renders.** `shannon/skills/shannon-supervisor/templates/header.md` carries a per-category counts line directly beneath the existing counts line, with the literal prefix `**By category:**`, the four canonical categories in the order Drift, Gap, Internal contradiction, Strength, and one `{{...}}` slot per category.
- [ ] **AC#2 — The pipeline fills it.** `shannon/skills/shannon-supervisor/SKILL.md` § Report Pipeline step 2 is **additively** extended to state that the header's per-category counts are filled from the collected checker fragments' four-category schema. The existing step-2 prose — the total, stuck-or-stale items, push lag, checkers-succeeded, and the hybrid-presentation framing — is preserved, not rewritten.
- [ ] **AC#3 — The leading total is unchanged.** `{{FINDING_COUNT}}` remains the total across all four categories, per `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation* ("The header's leading count is the total across all four finding categories, not the count of any one of them"). The new line adds to the header; it does not displace, replace, or re-scope the leading count.
- [ ] **AC#4 — The counting rule is written down.** The step-2 prose states that the four counts partition the same finding set the leading total's principal number counts, that they therefore sum to it, and that uncertain findings are carried as the annotation on the total rather than inside any category.
- [ ] **AC#5 — Zero renders as `0`.** Consistent with the zero-findings discipline TASK-024 established, every category with no findings renders a literal `0`, and all four categories render on a zero-findings run. Verifiable by a dry render against a zero fragment set: the line reads `**By category:** Drift 0  ·  Gap 0  ·  Internal contradiction 0  ·  Strength 0`.
- [ ] **AC#6 — A consumer can select the line without parsing prose.** Verifiable on a dry-rendered report: selecting the line by its `**By category:**` prefix and reading the four integers yields the correct counts, and the same selection applied to `report-2026-07-05.md` and `report-2026-08-20.md` yields nothing rather than a wrong number — the absent-line case TASK-025 must handle.
- [ ] **AC#7 — Dry render checked against real data.** The changed template is rendered by hand against `report-2026-08-20.md`'s actual fragment counts and read for coherence, per `development_guide.md` § Testing Strategy → *Template review* and *Dogfood pass*. The rendered result is recorded in § Implementation Notes. This is a Markdown template change with no executable body, so no unit test applies.
- [ ] **AC#8 — Source before deployed, and re-synced.** `shannon/` is edited first, then the change is deployed to `.claude/skills/shannon-supervisor/`, per `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts*. Verifiable: the two copies of `templates/header.md` and `SKILL.md` are identical after the change.
- [ ] **AC#9 — Scope guard.** No existing supervisor report is modified. No checker subagent, hook script or registration snippet, command file, work-item or document template of any type, index, or mandated document is modified. The only files this Task changes are `templates/header.md` and `SKILL.md` in `shannon/skills/shannon-supervisor/`, their deployed counterparts, and this Task file.

### Context

- **Parent Epic**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md) — Synthesis and Reports (IMPLEMENTING). Seventh child Task; sequenced **before** TASK-025, which consumes this line. Enables EPIC-010 **AC#3** by giving the SessionStart summary a Drift count to read; adds no new Epic AC.
- **Consumer**: [TASK-025](./TASK-025-sessionstart-health-summary-hook.md) — the SessionStart summary leads with the Drift count and reads it from this line, and must handle its absence honestly on the two historical reports.
- **Governing documents**: `ux_guide.md` v1.3 § Interaction Patterns → *Supervisor Report Presentation* (the leading count is the total; the clean run still reports); § Interaction Patterns → *Presenting Findings* (canonical four-category schema and its order); § Command Surface → *Supervisor Failure Modes* (never ambiguously quiet).
- **Shipped surfaces extended**: `shannon/skills/shannon-supervisor/templates/header.md` (TASK-015, last amended TASK-024); `shannon/skills/shannon-supervisor/SKILL.md` § Report Pipeline step 2.
- **Unchanged by design**: `templates/footer.md`, whose "The full finding set is reflected in the header counts above" becomes more true, not less, and needs no edit.
- **Discipline**: `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts*; § Testing Strategy → *Template review*, *Dogfood pass*; `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#9 phrasing).

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

- **2026-08-21** — ELABORATED (Gate 1, directing-party approval). Requirements drafted: the header gains one `**By category:**` line carrying the four canonical categories in schema order, rendered by `templates/header.md` and filled by `SKILL.md` § Report Pipeline step 2 from the checker fragments the pipeline already collects. Four directing-party-confirmed rulings: (1) the machine-readable anchor is the literal `**By category:**` line prefix, not the category words — `Drift` also occurs in the header's own `Checkers run:` line and in every Drift finding heading, so a consumer grepping a bare category word mis-hits; (2) the four counts partition exactly the finding set the leading total's principal number counts and therefore sum to it, with uncertain findings left as the annotation on the total (`9 (+1 uncertain)`) rather than folded into a category — this keeps the line bare integers and gives the pipeline a write-time self-invariant; (3) `ux_guide.md`'s worked announcement example (`3 findings (2 drift, 1 gap)` — inline, non-zero-only) is a different surface and an example, deliberately **not** reasoned from as a specification, that inference being the error TASK-027 exists to correct; (4) the Task enables EPIC-010 AC#3 rather than owning an Epic AC of its own, so the line is exercised at TASK-025's verification. Two findings routed rather than fixed: the `{{SLOT}}` versus `[Placeholder]` divergence across all three supervisor templates against `development_guide.md` § Code Style → *Template Structure* (framework-general → scratchpad), and a strength — `templates/footer.md`'s existing claim that the header reflects the full finding set becomes true without the footer being touched.

- **2026-08-21** — DRAFT: Task created by directing-party ruling during TASK-025's Gate 1 elaboration. That elaboration found `ux_guide.md` v1.3's session-start summary specified to lead with a Drift-category count that no shipped report surface carries, and that deriving the count by parsing report bodies is unsound — the body narrates only the highest-signal findings, its additional-findings labels are not uniform, and on `report-2026-07-05.md` the enumerated items do not reconcile with the header's own total. Ruled: add the count to the header rather than parse it, and split that change into its own Task sequenced before TASK-025, keeping the report-format change separate from the hook that consumes it. Full elaboration pending `/task-elaborate TASK-028`.
