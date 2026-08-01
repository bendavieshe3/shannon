# TASK-023: Report-Presentation Customisation Prose

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #presentation #documentation
- **Created**: 2026-07-18
- **Updated**: 2026-08-01

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated and approved at Gate 1 on 2026-08-01 (DRAFT → ELABORATED).*

### Overview

Add prose to `SKILL.md` documenting the diagnostic-only and conversational-only report-presentation customisations, defaulting to the hybrid shape EPIC-009 already shipped, and documenting that the SessionStart injection (TASK-025) uses the same terse three-count style (drift / stuck / push-lag counts, per EPIC-010 AC#3) as the report's diagnostic header, noting the leading count differs (drift-category count for SessionStart vs total findings in the report header). This is the reconciled, narrowed residual of EPIC-010 AC#2 — additive documentation only; the hybrid default itself was shipped by EPIC-009 TASK-015 and is not re-implemented here. Out of scope: any template/pipeline behaviour change; the SessionStart hook implementation (TASK-025).

### Acceptance Criteria

- [ ] **AC#1 — Customisation prose lands in `SKILL.md`.** Prose (near § Report Pipeline) documents the diagnostic-only and conversational-only customisations and names hybrid as the default. *Derives from* parent EPIC-010 AC#2(a); `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*.
- [ ] **AC#2 — SessionStart reuse documented.** `SKILL.md` states that the SessionStart terse injection presents the same terse three-count *style* as the report's hybrid diagnostic header — its counts are drift count, stuck items count, push lag count (per EPIC-010 AC#3). It notes explicitly that the SessionStart summary's leading count is the **Drift-category** count, whereas the report header's leading slot in `templates/header.md` is **total findings** (`{{FINDING_COUNT}}`); the two shapes share the terse form but differ in the first count. *Derives from* parent EPIC-010 AC#2(b) and AC#3.
- [ ] **AC#3 — No feature behaviour changed; hybrid default untouched.** The Task adds documentation only — it does not modify `templates/` or renumber the § Report Pipeline Flow steps (the `/shannon-goal` § Read-only reuse cross-references "Flow step 1" / "Flow steps 2–6" by number; TASK-024 and TASK-026 also anchor to Flow step numbers). Customisation prose lands as a paragraph or sub-heading, not as a new numbered Flow step. *Derives from* EPIC-009 § Report Pipeline (shipped); `conceptual_design.md` § Re-reviewing (additive).
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

- Prose could drift from the shipped shapes — mitigated by quoting `templates/header.md` for the *report header* triple (findings / stuck / push-lag) and EPIC-010 AC#3 for the *SessionStart summary* triple (drift / stuck / push-lag), keeping the two shapes distinct rather than conflated.
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

- **2026-08-01** — ELABORATED (Gate 1 approved). Verification pass on the prepared draft against source. Confirmed sound and left untouched: **AC#1** (the diagnostic-only / conversational-only / hybrid-default distinction is verbatim in `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*, line 223 — not an invented distinction); **AC#4** (cross-type-guard scope phrasing complies); the (a)/(b) derivation mapping to EPIC-010 AC#2 is real; version citation v1.2 correct; landing site "near § Report Pipeline" survives TASK-022's `/shannon-goal` insertion. **One substantive fix — AC#2 conflation corrected**: the draft said SessionStart "reuses the hybrid/terse header-counts shape (drift / stuck / push-lag)", but the shipped `templates/header.md` leads with **total findings** (`{{FINDING_COUNT}}`), not drift; the drift/stuck/push-lag triple is the *SessionStart summary* shape (EPIC-010 AC#3), a sibling of the header shape, not the header itself. AC#2 (and the Overview + Plan Risk) rewritten to keep the two triples distinct — same terse style, different leading count — so the implemented prose cannot misstate the shipped template. **Structural guard added to AC#3**: TASK-022 introduced by-number cross-references to "Flow step 1"/"steps 2–6" in § Report Pipeline (TASK-024/026 also anchor to Flow step numbers), so the customisation prose must land as a paragraph/sub-heading, not a renumbered Flow step. **Parent note**: EPIC-010 AC#2's "reuses the shipped hybrid default" is loose against AC#3's different lead count, but it is defensible as reusing the presentation *approach*; not reverting the PLANNED parent — the Task-level fix removes the actual risk. Status: DRAFT → ELABORATED.
- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#2 (the narrowed customisation-docs residual after old Plan Task 2 was retired — EPIC-009 already shipped the hybrid default). Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-023` (Gate 1) and `/task-plan TASK-023` (Gate 2).
