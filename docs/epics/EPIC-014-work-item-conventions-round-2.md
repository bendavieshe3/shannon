# EPIC-014: Work-Item Conventions Surfaced Through Dogfooding, Round 2

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Created**: 2026-10-18
- **Updated**: 2026-10-18
- **Tags**: #framework #conventions #conceptual-design #work-items

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Initial intent captured at Epic creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage on directing-party approval (Ben, 2026-10-18). Epic promotion needs that approval under `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*. Not yet reviewed; full elaboration pending `/epic-elaborate EPIC-014` (Gate 1).*

### Overview

Three work-item conventions are in use but not codified. EPIC-007 settled the first round.

1. **A re-elaboration trigger for siblings.** `conceptual_design.md` § Re-elaborating a Work Item names three triggers: upstream cascade, downstream gap, framework evolution. It has twice had to fit "a sibling Feature implements part of my scope" (FEAT-009 against FEAT-006, 2026-05-29 and 2026-07-12) under *downstream gap*, which assumes a child surfaced the gap.
2. **Cascading Preparation as one named workflow.** The Feature-plan → Epic and Epic-plan → Task cases share one mechanism, but it is named only in `work-items/skill.md` § Process: Plan and in `technical_design.md` § Key Algorithms → *Cascading Operations*. It has no § Key Workflows entry in `conceptual_design.md`.
3. **The *Future Epics* forward-deferral paragraph.** FEAT-009 § Plan names Phase 5+ work with deferral rationale instead of creating DRAFT stubs. The pattern is sound, but it is not part of the Feature domain model or the Plan process.

All three are work-item workflow conventions, so they sit under FEAT-003 rather than FEAT-008, per FEAT-008's split.

### Goal

`conceptual_design.md` and the `work-items` skill name all three conventions, so a future Plan does not re-derive them.

### Acceptance Criteria

*Candidate criteria; refined at Gate 1.*

- [ ] `conceptual_design.md` § Re-elaborating a Work Item names a sibling-scope trigger, citing FEAT-006's 2026-07-12 re-elaboration as precedent
- [ ] `conceptual_design.md` § Key Workflows carries *Cascading Preparation* as one workflow, with the Feature-plan and Epic-plan instances
- [ ] The Feature domain model and `work-items` skill § Process: Plan name the *Future Epics* paragraph and when to use it instead of DRAFT stubs
- [ ] `conceptual_design.md` changes go through `/document-review`, additive where possible; deployed skill copies are refreshed

### Context

- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md). Ideal State bullet 4 (work-item conventions accumulated through use are promoted into the mandated documents and skills) already aspires to this (*Responsible Promotion* step 4: yes)
- **Precedent**: [EPIC-007](EPIC-007-work-item-conventions-from-dogfooding.md), the first round
- **Conceptual Design**: § Key Workflows → *Re-elaborating a Work Item*; § Domain Model → *Feature*
- **Technical Design**: § Key Algorithms → *Cascading Operations*

---

## Plan

[Filled during planning. The epic's plan is its list of tasks plus the integration story across them.]

### Approach

*Not yet planned. EPIC-007's shape (doc half and skill half per convention) is the likely template.*

### Tasks

*None yet; identified at Gate 2 (`/epic-plan`).*

### Dependencies

[Other epics, features, or external work this epic depends on, or that depends on it.]

**Depends on**: [Other work or external dependencies]

**Depended on by**: [Other epics or features]

### Risks

- [Risk — mitigation]

---

## Implementation Notes

[Filled during implementation. Cross-task decisions and learnings that don't belong to a single task.]

### Cross-Task Decisions

- [Decision and rationale]

### Documents Updated

- [Documents updated by this epic, with sections]

---

## Review

[Filled during review (Gate 3).]

### Verification

- [ ] All tasks APPROVED
- [ ] Epic acceptance criteria met
- [ ] Parent feature updated with epic outcome
- [ ] Relevant documents updated and approved

### Review Notes

[Findings from review. Outcomes worth reflecting back into the parent feature or the mandated documents.]

---

## Activity Log

[Timestamped entries recording the history. Newest at the top.]

- **2026-10-18** — DRAFT: Epic created from three scratchpad items (sibling re-elaboration trigger; Cascading Preparation naming; forward-deferral pattern) by the 2026-10-17 triage, on directing-party approval
