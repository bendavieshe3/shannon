# EPIC-006: Work Item Lifecycle Maturation (Re-elaboration + Queryable Completeness)

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Created**: 2026-05-19
- **Updated**: 2026-05-19

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*To be filled during `/epic-elaborate EPIC-006` (Gate 1). The high-level intent below is captured at creation time as a placeholder.*

### Overview

Close two aspirational gaps in FEAT-003's Ideal State (added 2026-05-19 in the re-elaboration following Vision v2.3 § Adaptive Coherence). Both gaps surfaced organically during framework use; both were captured in the scratchpad as F1 and F2:

1. **Re-elaboration workflow for work items** (F1) — Conceptual_design v1.3 canonised *Re-reviewing an APPROVED Mandated Document* for documents. The analogous pattern for *work items* — re-elaborating an ELABORATED Feature/Epic/Task that needs refresh after upstream evolution — was simulated during the FEAT-006 and FEAT-003 re-elaborations but has no canonical workflow yet. FEAT-003 now aspires to one.

2. **Queryable implementation completeness** (F2) — Features carry an "Initial Implementation" field (Built through Shannon / Retrospective / Partial), but the "Partial" state's details are buried in the Activity Log. FEAT-003 now aspires to surface implementation completeness at the metadata level — visible at-a-glance, queryable, not requiring a deep read.

The Epic bundles these because both touch the same conceptual area (work-item lifecycle and metadata) and the same review surface (conceptual_design § Key Workflows and the work-item templates). Splitting them would force coordination on overlapping paragraphs.

### Goal

*Filled during elaboration.*

### Acceptance Criteria

*Filled during elaboration. Provisional starting points from FEAT-003 § Ideal State aspirations:*

- [ ] Conceptual_design has a canonical **Re-elaborating a Work Item** workflow describing trigger, flow, status semantics, and rules applied — parallel to the existing *Re-reviewing an APPROVED Mandated Document* workflow
- [ ] Work-items skill recognises re-elaboration as a first-class operation (e.g. `/feature-elaborate` on an ELABORATED Feature surfaces the re-elaboration flow rather than failing or silently re-running)
- [ ] Implementation completeness is queryable at metadata level: the "Partial" state surfaces beyond just the Activity Log, possibly through a dedicated section, a queryable substatus, or a feature_index annotation pattern
- [ ] FEAT-003 itself reflects the new model — its own Initial Implementation status moves toward "Met" through this Epic's delivery (recursive dogfood)
- [ ] FEAT-006's Initial Implementation surfacing also benefits from F2 (FEAT-006 is currently "Partial"; the same queryability pattern applies)

### Context

*Filled during elaboration. Initial pointers:*

- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md), specifically the aspirational Ideal State bullets added 2026-05-19 (commit `e2198bc`)
- **Vision**: § Core Principle 4 ("Adaptive Coherence") — the framework's commitment to absorbing change without losing alignment; this Epic operationalises that commitment for work items
- **Conceptual Design v1.4**: § Re-reviewing an APPROVED Mandated Document (the precedent pattern this Epic extends to work items); § Responsible Promotion (the workflow that created this Epic)
- **Scratchpad items**: F1 and F2 (both currently active; will move to Processed when this Epic is APPROVED)
- **Files likely in scope**:
  - `docs/conceptual_design.md` (add work-item re-elaboration workflow + maybe a metadata clarification for queryable completeness)
  - `shannon/skills/work-items/skill.md` (extend `Process: Elaborate` to recognise re-elaboration case)
  - `shannon/skills/work-items/templates/feature.md` (possibly add a structured "Partial — pending" section if F2 needs more than the existing field)
  - Possibly the other work-item templates (epic, task, spike) for consistency
  - Possibly `feature_index.md` and friends if surfacing happens at the index level

---

## Plan

*To be filled during `/epic-plan EPIC-006` (Gate 2). Will likely produce 2-3 Tasks: one for the re-elaboration workflow + skill extension (F1), one for the queryable-completeness pattern + template/index updates (F2), and possibly a third for retrospective application to FEAT-003 and FEAT-006 themselves.*

### Approach

*Filled during planning.*

### Tasks

*Filled during planning.*

### Dependencies

**Depends on**: All six mandated documents APPROVED (met); conceptual_design v1.4 (met — provides the canonical pattern for the new workflow this Epic adds)

**Depended on by**: Future adoption of Shannon onto existing projects — those adopters benefit directly from re-elaboration and queryable completeness when their pre-existing capabilities are imported

### Risks

*Filled during planning. Anticipated:*

- Over-formalising the queryable-completeness pattern beyond what's useful — the goal is at-a-glance visibility, not a new substatus system
- Recursive scope creep: this Epic exists because FEAT-003 evolved; its outputs are themselves changes to the framework that might surface further gaps

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-19** — DRAFT: Epic created via `/epic-create` under FEAT-003 following the Responsible Promotion workflow (conceptual_design v1.4 §). FEAT-003 was re-elaborated upstream (commit `e2198bc`) to add aspirational criteria the Epic now fulfils; without that re-elaboration this Epic would not have traced to an upstream commitment. Captures F1 (work-item re-elaboration workflow) and F2 (queryable implementation completeness) as a bundled unit since both touch the same review surface.
