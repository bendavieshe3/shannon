# TASK-022: Goal-Decomposition `/shannon-goal` Skill and Command

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #command #goal-decomposition
- **Created**: 2026-07-18
- **Updated**: 2026-07-18

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-022` (Gate 1).*

### Overview

Implement the `/shannon-goal [intent]` entry-point as a new contract section in `./shannon/skills/shannon-supervisor/SKILL.md`, plus the thin command file `./shannon/commands/shannon-goal.md` (deployed to `./.claude/`). Given a free-text intent (e.g. *"make onboarding feel less abrupt"*), the skill produces a categorised list of candidate work items — those aligned with existing artefacts (cited by ID) and those surfacing gaps (flagged for the approval authority they require) — reusing EPIC-009's shipped report-aggregation for the aligned category rather than rebuilding it. Out of scope: the SessionStart / preCompact hooks (TASK-025 / TASK-026), the zero-findings pattern (TASK-024), and any checker or template change.

### Acceptance Criteria

- [ ] **AC#1 — `/shannon-goal` contract + thin command authored in `./shannon/`.** A new `## /shannon-goal — Contract` section in `SKILL.md` defines the verb; the thin command file `./shannon/commands/shannon-goal.md` follows the `/shannon-report` command pattern (invoke skill, pass verb `goal`, fallback wording), deployed to `./.claude/commands/`. *Derives from* `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Slash-command surface* + § API Design → *Supervisor Verbs*, and the EPIC-009 TASK-020 command-entry-point lesson.
- [ ] **AC#2 — Output shape matches the ux_guide example.** A `/shannon-goal` invocation renders the two labelled categories and the promotion-authority footer line matching `ux_guide.md` v1.2 § Command Surface → *Supervisor Commands*. *Derives from* parent EPIC-010 AC#1.
- [ ] **AC#3 — Aligned candidates cite artefacts by ID.** Candidates in the *aligned with existing artefacts* category name the specific Feature, Epic, or document section they align with. *Derives from* parent EPIC-010 AC#6.
- [ ] **AC#4 — Gap candidates flag directing-party approval per the Gate Authority Split.** Candidates *surfacing gaps* explicitly indicate which require directing-party approval before promotion to Feature/Epic (Tasks auto-promotable on supervisor authority). *Derives from* `conceptual_design.md` § Business Rules → *Gate Authority Split*; parent EPIC-010 AC#1.
- [ ] **AC#5 — Live dogfood invocation.** A test invocation against a real Shannon-self intent produces conforming output with both categories present (or an explicit "no candidates in category X" line). *Derives from* parent EPIC-010 AC#1 verifiable clause.
- [ ] **AC#6 — Plain-prose discipline + scope-bounded edit.** Any grep-verified verbatim phrase lands as plain prose (parent AC#7). This Task creates the `/shannon-goal` `SKILL.md` section and the command file only; it does **not** modify any checker definition, report template, hook script/snippet, the `/shannon-report` contract, or any other skill (cross-type-guard phrasing per parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Goal decomposition via `/shannon-goal`*
- **Relevant documents**: `technical_design.md` § System Architecture → *Supervisor* + § API Design → *Supervisor Verbs*; `ux_guide.md` § Command Surface → *Supervisor Commands*; `conceptual_design.md` § Business Rules → *Gate Authority Split*
- **Related work**: EPIC-009 (shipped aggregation pipeline; TASK-020 command-entry-point lesson)

---

## Plan

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-plan TASK-022` (Gate 2).*

### Approach

Author the `/shannon-goal` contract in `SKILL.md` (source-of-truth) then the thin command file; deploy both to `./.claude/`. The contract reuses the shipped § Report Pipeline aggregation for the aligned category and adds the intent-decomposition + categorisation logic. Verify with a live Shannon-self invocation before commit.

### Steps

1. Author `## /shannon-goal — Contract` in `SKILL.md` (intent arg, two-category decomposition, aligned-cites, gap-approval flagging, output shape).
2. Author `./shannon/commands/shannon-goal.md` on the `/shannon-report` pattern.
3. Deploy both to `./.claude/`; `diff` confirms identical.
4. Live dogfood invocation against a real intent; confirm shape + both categories (AC#5).
5. Plain-prose grep of the landed verbatim phrases (AC#6).
6. `git diff` scope-bounded verification; absence checks (no checker/template/hook/other-skill change).

### Dependencies

- EPIC-009 APPROVED (aggregation pipeline + `SKILL.md` skeleton). Independent of sibling EPIC-010 Tasks. First (or parallel) in the order.

### Risks

- Decomposition heuristic quality is directional, not shape-verifiable — mitigated by AC#1/AC#2 verifying shape; quality measured after dogfood.
- `SKILL.md` edit collides with sibling Tasks — mitigated by editing-order sequencing (TASK-022 first).

---

## Implementation Notes

*Filled during implementation.*

### Deviations from Plan

- *None yet.*

### Gotchas

- *None yet.*

### Documents Updated

- *None yet.*

---

## Review

*Filled during review (Gate 3).*

### Verification

- [ ] All acceptance criteria met
- [ ] Code follows development_guide.md
- [ ] Tests added or updated, passing
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

*Filled at Gate 3.*

---

## Activity Log

- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*). Covers EPIC-010 AC#1 and AC#6. Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-022` (Gate 1) and `/task-plan TASK-022` (Gate 2).
