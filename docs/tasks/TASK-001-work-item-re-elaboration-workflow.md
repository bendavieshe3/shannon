# TASK-001: Re-elaborating a Work Item — Workflow and Skill Extension

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #conceptual-design #work-items #v6
- **Created**: 2026-05-19
- **Updated**: 2026-05-19

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-006 § Plan (Gate 2). Not yet reviewed at Gate 1. Surfaces when `/task-elaborate TASK-001` is invoked.*

### Overview

Ratify the canonical re-elaboration workflow for work items. Add a *Re-elaborating a Work Item* section to `docs/conceptual_design.md` § Key Workflows, modelled on the existing *Re-reviewing an APPROVED Mandated Document* workflow (lines 227-256). Extend `shannon/skills/work-items/skill.md` § Process: Elaborate to recognise re-elaboration as a first-class branch, so that `/feature-elaborate` (or `/epic-elaborate`, `/task-elaborate`, `/spike-elaborate`) on an already-ELABORATED work item enters the re-elaboration flow rather than failing or silently re-running.

Closes the gap conceptual_design v1.4 § Responsible Promotion step 5 explicitly flagged: *"canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap."*

### Acceptance Criteria

- [ ] `docs/conceptual_design.md` § Key Workflows contains a *Re-elaborating a Work Item* workflow with Triggers / Flow / Status semantics / Rules applied sub-sections, matching the structure of *Re-reviewing an APPROVED Mandated Document*
- [ ] Triggers explicitly enumerate upstream cascade, downstream gap, framework evolution (paralleling but adapted from the document re-review triggers)
- [ ] Status semantics distinguish additive re-elaboration (work item stays at current status) from substantive re-elaboration (work item transitions back to DRAFT and re-passes Gate 1); rules cover the full ELABORATED → APPROVED span, not just ELABORATED
- [ ] `shannon/skills/work-items/skill.md` § Process: Elaborate gains an explicit re-elaboration branch (sibling to the DRAFT → ELABORATED path); the existing § Failure Modes "Wrong status for verb" entry updated so `*-elaborate` on a non-DRAFT work item enters re-elaboration rather than erroring
- [ ] The Activity Log entry pattern for re-elaboration is documented in the workflow, matching the precedent set by FEAT-003's 2026-05-19 entry (trigger, upstream commit, what changed)

### Context

- **Parent Epic**: [EPIC-006 — Work Item Lifecycle Maturation](../epics/EPIC-006-work-item-lifecycle-maturation.md), specifically the F1 Acceptance Criteria group
- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md), aspirational Ideal State bullet 1 (added 2026-05-19)
- **Precedent pattern**: `conceptual_design.md` § *Re-reviewing an APPROVED Mandated Document* (lines 227-256) — same shape, adapted from documents to work items
- **Related workflow**: `conceptual_design.md` § *Responsible Promotion* (lines 258-285) — this Task closes the gap step 5 of that workflow flags
- **Files in scope**:
  - `docs/conceptual_design.md` (add new workflow + version bump)
  - `shannon/skills/work-items/skill.md` (§ Process: Elaborate ~lines 120-153 and § Failure Modes ~lines 271-276 — re-elaboration as first-class branch)
- **Prior dogfood**: FEAT-006's re-elaboration (commit `211ebea`) and FEAT-003's re-elaboration (commit `e2198bc`) were ad-hoc applications of this not-yet-canonical workflow. The shape that worked there is the candidate canonical shape

---

## Plan

*To be filled during `/task-plan TASK-001` (Gate 2).*

### Approach

*Filled during planning.*

### Steps

*Filled during planning.*

### Dependencies

*Filled during planning. Anticipated: none inside EPIC-006 — proceeds in parallel with TASK-002.*

### Risks

*Filled during planning. Anticipated:*

- Protocol overload — re-elaboration must be an explicit sibling branch, not an overload of the DRAFT → ELABORATED flow
- Workflow asymmetry with documents — work items have a richer status set than documents (ELABORATED → APPROVED span) so the additive-vs-substantive mapping is not 1:1; needs explicit status-transition rules per case

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-19** — DRAFT: Task created via EPIC-006's planning (option-b cascading pattern). Requirements section pre-stashed; will surface when `/task-elaborate TASK-001` is invoked. Plan section deferred to `/task-plan`.
