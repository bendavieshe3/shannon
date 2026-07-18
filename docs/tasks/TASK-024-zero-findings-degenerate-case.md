# TASK-024: Zero-Findings Degenerate-Case Presentation

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #presentation #zero-findings
- **Created**: 2026-07-18
- **Updated**: 2026-07-18

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-024` (Gate 1).*

### Overview

Land the zero-findings positively-stated diagnostic so a clean supervisor run reads "3 checkers ran cleanly; nothing surfaced" rather than a blank or bare-zero report — letting the directing party distinguish a healthy quiet run from a silently broken supervisor. Replaces the explicit deferral at `SKILL.md` § Report Pipeline step 3. Closes scratchpad M-2 and satisfies FEAT-009 § User Stories → *Honest Failure Modes — Supervisor Finds Nothing*.

### Acceptance Criteria

- [ ] **AC#1 — Zero-findings presentation lands at `SKILL.md` § Report Pipeline.** The current "The zero-findings degenerate case … is out of scope here and handled by a future Epic" clause at step 3 is replaced with the explicit positively-stated diagnostic. *Derives from* parent EPIC-010 AC#5; `SKILL.md` § Report Pipeline step 3 (current deferral).
- [ ] **AC#2 — Positively-stated, failure-distinguishable phrasing.** A clean run presents an affirmative "checkers ran cleanly; nothing surfaced"-style diagnostic, distinguishable from a silent failure. *Derives from* parent EPIC-010 AC#5; FEAT-009 § User Stories → *Honest Failure Modes — Supervisor Finds Nothing*.
- [ ] **AC#3 — Header template renders sensibly at zero counts.** `templates/header.md` at `{{FINDING_COUNT}} = 0` carries the "ran cleanly" signal via the checker-success note rather than reading as an error. *Derives from* parent EPIC-010 AC#5; EPIC-009 `templates/header.md`.
- [ ] **AC#4 — ux_guide amendment iff needed, additive.** If the pattern needs a framework-level home, additively amend `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*; otherwise it lives in `SKILL.md`/template prose. Any ux_guide change is additive (document stays APPROVED). *Derives from* parent EPIC-010 AC#5; `conceptual_design.md` § Re-reviewing (additive).
- [ ] **AC#5 — Plain-prose discipline + scope-bounded edit.** Grep-verified phrases as plain prose (parent AC#7); edits `SKILL.md` § Report Pipeline (+ header-template prose, + optional additive ux_guide) only — no checker, hook, command, goal-skill, or other skill modified (cross-type-guard, parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary…Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § User Stories → *Honest Failure Modes — Supervisor Finds Nothing*
- **Relevant documents**: `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*
- **Related work**: scratchpad M-2; EPIC-009 `SKILL.md` § Report Pipeline + `templates/header.md`

---

## Plan

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-plan TASK-024` (Gate 2).*

### Approach

Replace the deferral clause with the zero-findings diagnostic; confirm the header template's zero-count rendering; land a ux_guide amendment only if a framework-level home is genuinely warranted.

### Steps

1. Rewrite `SKILL.md` § Report Pipeline step 3 zero-findings handling.
2. Verify `templates/header.md` zero-count rendering; adjust prose if needed.
3. Decide ux_guide amendment; if yes, additive edit + Version History entry.
4. Deploy to `./.claude/`; `diff`.
5. Plain-prose grep.
6. `git diff` scope check.

### Dependencies

- EPIC-009 APPROVED (Report Pipeline + header template). Independent of hooks/goal-skill.

### Risks

- Cross-file inconsistency (SKILL.md ↔ template ↔ ux_guide) — mitigated by landing all touched surfaces in one Gate-3 cycle.
- Over-amending ux_guide when SKILL.md suffices — mitigated by the "iff needed" decision in AC#4.

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

- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#5; closes scratchpad item M-2 (zero-findings degenerate case, deferred from FEAT-009 elaboration). Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-024` (Gate 1) and `/task-plan TASK-024` (Gate 2).
