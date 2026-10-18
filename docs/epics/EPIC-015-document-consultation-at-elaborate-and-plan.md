# EPIC-015: Document Consultation at Elaborate and Plan

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Created**: 2026-10-18
- **Updated**: 2026-10-18
- **Tags**: #framework #work-items #alignment #gates

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Initial intent captured at Epic creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage on directing-party approval (Ben, 2026-10-18). Epic promotion needs that approval under `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*. Not yet reviewed; full elaboration pending `/epic-elaborate EPIC-015` (Gate 1).*

### Overview

A field report from another project running an older Shannon found that implementer agents do not consistently read the mandated documents during `*-elaborate` and `*-plan`. The *Work Item ↔ Document Relationships* table in `shannon/skills/work-items/skill.md` names what each verb must align to, but enforcement is prose-level. Checking at triage (2026-10-17) found three gaps:

- The Plan subagent's instructions read "Informed By" and never "Must Align To".
- The Feature and Epic templates have no relevant-documents slot. The Task and Spike templates do.
- The alignment subagent is mandatory only on the re-elaboration branch.

The item offers three remedies, and choosing among them is the elaboration's job:

- (a) numbered "read these documents" steps in the subagent contract
- (b) a mandatory alignment check at Gates 1 and 2
- (c) a *Documents Consulted* subsection that makes non-consultation visible at review

### Goal

A work item's Requirements and Plan visibly trace to the documents the relationships table says they must align to, and a gate reviewer can see when they don't.

### Acceptance Criteria

*Candidate criteria; refined at Gate 1.*

- [ ] The Plan subagent reads the "Must Align To" documents as well as "Informed By"
- [ ] The remedy chosen at Gate 1 from (a), (b) and (c) is implemented in `work-items/skill.md` and, if (c), every work-item template
- [ ] Verified on one real elaborate and plan pass whose gate review can see which documents were consulted

### Context

- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md)
- **Responsible Promotion, step 4: not yet.** No FEAT-003 Ideal State bullet names document consultation at elaborate and plan. The nearest are FEAT-002's "the document authority graph is enforced" and Vision's "AI reads documentation for context". Before this Epic can be elaborated, FEAT-003 needs an additive Ideal State bullet saying so, through *Re-elaborating a Work Item* (Feature gate, directing party), per *Responsible Promotion* step 5
- **Conceptual Design**: § Business Rules → *Document Alignment Direction*
- **Related**: TASK-029 (acceptance criteria cite governing rules), a neighbouring alignment discipline

---

## Plan

[Filled during planning. The epic's plan is its list of tasks plus the integration story across them.]

### Approach

*Not yet planned. Blocked first on the FEAT-003 re-elaboration named in § Context.*

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

- **2026-10-18** — DRAFT: Epic created from the scratchpad item "Documentation reference at planning and elaboration not robustly enforced" by the 2026-10-17 triage, on directing-party approval. The parent re-elaboration required by *Responsible Promotion* step 5 is still outstanding
