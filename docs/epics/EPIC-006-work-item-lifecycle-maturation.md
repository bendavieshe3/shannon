# EPIC-006: Work Item Lifecycle Maturation (Re-elaboration + Queryable Completeness)

## Metadata

- **Status**: ELABORATED
- **Type**: Epic
- **Parent**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Created**: 2026-05-19
- **Updated**: 2026-05-19 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

### Overview

Close two aspirational gaps in FEAT-003's Ideal State (added 2026-05-19 in the re-elaboration following Vision v2.3 § Adaptive Coherence). Both gaps surfaced during framework use and were captured in the scratchpad as F1 and F2 (both now Processed, pointing at this Epic):

1. **Re-elaboration workflow for work items** (F1) — Conceptual_design v1.3 canonised *Re-reviewing an APPROVED Mandated Document* for documents. The analogous pattern for *work items* — re-elaborating an ELABORATED Feature/Epic/Task after upstream evolution — was simulated ad-hoc during the FEAT-006 and FEAT-003 re-elaborations but has no canonical workflow. The `work-items` skill's `Process: Elaborate` currently assumes DRAFT → ELABORATED only; running `/feature-elaborate` on an already-ELABORATED Feature has undefined behaviour.

2. **Queryable implementation completeness** (F2) — `feature.md` template carries an `Initial Implementation` field (Built through Shannon | Retrospective | Partial — see Activity Log) at template line 9, and `feature_index.md` already annotates partial Features with a trailing `(Partial)` suffix (FEAT-003 line 5). The "Partial" state is the only one whose meaning is not self-contained — its details require an Activity Log dive. FEAT-003 aspires to surface that meaning at the metadata level so adopters can identify partially-built capabilities at a glance.

The Epic bundles these because both touch the same review surface (conceptual_design § Key Workflows + work-item templates + `work-items` skill) and the same conceptual area (lifecycle and metadata of work items). Splitting them would force coordination on overlapping paragraphs across two Epics.

### Goal

Adopters of Shannon can re-elaborate any work item through a canonical workflow when upstream artefacts evolve, and can identify the implementation completeness of any Feature without reading its Activity Log.

### Acceptance Criteria

**F1 — Work-item re-elaboration workflow:**

- [ ] `docs/conceptual_design.md` § Key Workflows contains a canonical **Re-elaborating a Work Item** workflow, modelled on the existing *Re-reviewing an APPROVED Mandated Document* workflow (lines 227–256): triggers, flow, status semantics (additive vs substantive), rules applied
- [ ] Triggers cover at least: upstream cascade (parent re-elaborated), downstream gap (a planned epic/task reveals an unstated parent aspiration), framework evolution (new attribute or workflow that pre-existing work items must absorb)
- [ ] Status semantics are explicit: additive re-elaboration keeps the work item at its current status (ELABORATED or beyond); substantive re-elaboration transitions back to DRAFT and re-passes Gate 1
- [ ] `shannon/skills/work-items/skill.md` § Process: Elaborate recognises re-elaboration as a first-class branch — invoking `*-elaborate` on a non-DRAFT work item enters the re-elaboration flow instead of failing or silently re-running, and the existing failure-mode entry "Wrong status for verb" (line 273) is updated accordingly
- [ ] The Activity Log entry pattern for re-elaboration matches the precedent set by FEAT-003's 2026-05-19 entry (records trigger, upstream commit, what changed)

**F2 — Queryable implementation completeness:**

- [ ] `feature.md` template surfaces "Partial" completeness beyond the existing `Initial Implementation` field — minimum: a structured sub-field naming what is met and what remains (no Activity Log dive required for the headline state)
- [ ] `feature_index.md` annotation pattern is canonised (currently informal — only FEAT-003 carries `(Partial)`); either documented in the template's Notes section or replaced with a stronger affordance, with consistency applied across the existing seven Features
- [ ] The chosen affordance is queryable mechanically (grep, glance) — proportionate to the goal, not a new substatus system
- [ ] Pattern is applied to FEAT-003 and FEAT-006, both currently Partial, demonstrating the affordance on real data

**Recursive dogfood:**

- [ ] FEAT-003's `Initial Implementation` line reflects post-Epic reality (Partial bullets that this Epic closes are marked met)
- [ ] Scratchpad items F1 and F2 remain in Processed with updated pointers to the delivered artefacts; if scope shifts, scratchpad is updated accordingly

### Context

- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md), specifically the three aspirational Ideal State bullets added 2026-05-19 (lines 37–39). This Epic addresses bullets 1 (re-elaboration workflow) and 2 (queryable completeness); bullet 3 (framework-version absorption) depends on the workflow this Epic creates and may be exercised — but not formally closed — by it.
- **Vision** [v2.3]: § Core Principles #4 *Adaptive Coherence* (line 41) — specifically the "drift caught early and resolved through canonical re-review and re-elaboration workflows" and "framework evolution propagates to existing artefacts" commitments. This Epic operationalises both for work items.
- **Conceptual Design** [v1.4]:
  - § *Re-reviewing an APPROVED Mandated Document* (lines 227–256) — the precedent pattern to mirror for work items
  - § *Responsible Promotion* (lines 258–285) — the workflow that produced this Epic; step 5 explicitly flags "canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap" (line 279), which F1 closes
- **Implementation surface**:
  - `shannon/skills/work-items/skill.md` — § *Process: Elaborate* (lines 120–153) extended with a re-elaboration branch; § *Failure Modes* (lines 271–276) updated
  - `shannon/skills/work-items/templates/feature.md` — `Initial Implementation` field (line 9) extended or supplemented for queryable Partial state
  - `shannon/skills/work-items/templates/{epic,task,spike}.md` — confirm consistency; re-elaboration applies to all four types even though the metadata surfacing is Feature-specific
  - `docs/features/feature_index.md` — formalise or replace the `(Partial)` annotation pattern (currently only FEAT-003, line 5)
- **Related scratchpad**: F1 and F2 are Processed (lines 36–37 of `docs/scratchpad.md`). C4 (orphan task business rule, line 15) remains active and may interact with F2 if the surfacing pattern extends to Tasks, but is out of scope for this Epic.

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

- **Over-formalisation of F2** — the goal is at-a-glance visibility, not a new substatus system. Mitigation: keep the queryability mechanism proportionate (a structured sub-field + the existing index annotation is likely sufficient)
- **Recursive scope** — this Epic's outputs are themselves changes to the framework that may surface further gaps (e.g. orphan-task rule C4 may become entangled if surfacing extends to Tasks). Mitigation: hold scope to F1 + F2; capture spillover in scratchpad
- **Tension with the existing `Process: Elaborate` protocol** — the skill currently assumes DRAFT → ELABORATED only; adding a re-elaboration branch must not break the canonical first-time-elaborate flow or its Gate 1 semantics. Mitigation: re-elaboration is an explicit sibling branch, not an overload of the existing path
- **Workflow asymmetry with documents** — document re-review distinguishes additive vs substantive; work items have a richer status set (ELABORATED through APPROVED) so the mapping is not 1:1. Mitigation: explicitly define status transitions for each case in the new workflow

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-19** — ELABORATED via Gate 1. Directing party approved the drafted Requirements without modification. The elaboration surfaced one minor staleness in the DRAFT (F1/F2 stated as "currently active" — already in Processed), refined Acceptance Criteria into three explicit groups (F1, F2, recursive-dogfood), and expanded Risks with two concrete tensions (protocol overload, workflow asymmetry with documents). Verdict from the elaboration subagent: ready for Gate 1.
- **2026-05-19** — Requirements drafted via `/epic-elaborate EPIC-006`. Goal, Acceptance Criteria (split into F1 / F2 / recursive-dogfood groups), and Context populated. Risks lifted forward from Plan section to surface anticipated trade-offs at Gate 1. Awaiting directing-party approval to transition DRAFT → ELABORATED.
- **2026-05-19** — DRAFT: Epic created via `/epic-create` under FEAT-003 following the Responsible Promotion workflow (conceptual_design v1.4 §). FEAT-003 was re-elaborated upstream (commit `e2198bc`) to add aspirational criteria the Epic now fulfils; without that re-elaboration this Epic would not have traced to an upstream commitment. Captures F1 (work-item re-elaboration workflow) and F2 (queryable implementation completeness) as a bundled unit since both touch the same review surface.
