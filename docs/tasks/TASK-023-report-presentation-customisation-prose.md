# TASK-023: Report-Presentation Customisation Prose

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #presentation #documentation
- **Created**: 2026-07-18
- **Updated**: 2026-07-18

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-023` (Gate 1).*

### Overview

Add prose to `SKILL.md` documenting the diagnostic-only and conversational-only report-presentation customisations, defaulting to the hybrid shape EPIC-009 already shipped, and documenting that the SessionStart injection (TASK-025) reuses that hybrid/terse header-counts shape. This is the reconciled, narrowed residual of EPIC-010 AC#2 — additive documentation only; the hybrid default itself was shipped by EPIC-009 TASK-015 and is not re-implemented here. Out of scope: any template/pipeline behaviour change; the SessionStart hook implementation (TASK-025).

### Acceptance Criteria

- [ ] **AC#1 — Customisation prose lands in `SKILL.md`.** Prose (near § Report Pipeline) documents the diagnostic-only and conversational-only customisations and names hybrid as the default. *Derives from* parent EPIC-010 AC#2(a); `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*.
- [ ] **AC#2 — SessionStart reuse documented.** `SKILL.md` states that the SessionStart terse injection reuses the hybrid/terse header-counts shape (drift / stuck / push-lag counts). *Derives from* parent EPIC-010 AC#2(b) and AC#3.
- [ ] **AC#3 — No feature behaviour changed; hybrid default untouched.** The Task adds documentation only — it does not modify `templates/` or the § Report Pipeline flow shipped by EPIC-009 TASK-015. *Derives from* EPIC-009 § Report Pipeline (shipped); `conceptual_design.md` § Re-reviewing (additive).
- [ ] **AC#4 — Plain-prose discipline + scope-bounded edit.** Grep-verified phrases land as plain prose (parent AC#7); the Task edits `SKILL.md` prose only — no template, checker, hook, command, or other skill modified (cross-type-guard, parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary…Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Hybrid report presentation by default*
- **Relevant documents**: `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*
- **Related work**: EPIC-009 TASK-015 (shipped hybrid default); sibling TASK-025 (SessionStart reuses the documented shape)

---

## Plan

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-plan TASK-023` (Gate 2).*

### Approach

Small additive `SKILL.md` prose change documenting the two customisations and the SessionStart reuse. No executable deliverable.

### Steps

1. Add customisation prose to `SKILL.md`.
2. Add the SessionStart-reuse sentence.
3. Deploy to `./.claude/`; `diff`.
4. Plain-prose grep.
5. `git diff` scope check.

### Dependencies

- EPIC-009 APPROVED (hybrid default shipped). Precedes TASK-025 (documents the shape TASK-025 reuses).

### Risks

- Prose could drift from the shipped template shape — mitigated by referencing `templates/header.md` counts verbatim.
- `SKILL.md` edit collision with sibling Tasks — mitigated by editing-order sequencing.

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

- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#2 (the narrowed customisation-docs residual after old Plan Task 2 was retired — EPIC-009 already shipped the hybrid default). Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-023` (Gate 1) and `/task-plan TASK-023` (Gate 2).
