# TASK-001: Re-elaborating a Work Item — Workflow and Skill Extension

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #conceptual-design #work-items #v6
- **Created**: 2026-05-19
- **Updated**: 2026-05-19 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-006 § Plan (Gate 2). Not yet reviewed at Gate 1. Surfaces when `/task-elaborate TASK-001` is invoked.*

### Overview

Ratify the canonical re-elaboration workflow for work items. Add a *Re-elaborating a Work Item* section to `docs/conceptual_design.md` § Key Workflows, modelled on the existing *Re-reviewing an APPROVED Mandated Document* workflow (lines 227-256). Extend `shannon/skills/work-items/skill.md` § Process: Elaborate to recognise re-elaboration as a first-class branch, so that `/feature-elaborate` (or `/epic-elaborate`, `/task-elaborate`, `/spike-elaborate`) on an already-ELABORATED work item enters the re-elaboration flow rather than failing or silently re-running.

Closes the gap conceptual_design v1.4 § Responsible Promotion step 5 explicitly flagged: *"canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap."*

**Scope boundary**: This Task delivers the canonical workflow text and the skill extension. Live application of the new workflow to FEAT-003 and FEAT-006 (recursive dogfood) belongs to EPIC-006's forward-declared follow-up Task, not this one.

### Acceptance Criteria

- [ ] `docs/conceptual_design.md` § Key Workflows contains a *Re-elaborating a Work Item* workflow with parallel sub-section ordering matching *Re-reviewing an APPROVED Mandated Document*: **Goal / Triggers / Flow (numbered) / Status semantics / Rules applied** (sharpened — reviewers can mechanically check parity)
- [ ] Triggers explicitly enumerate upstream cascade, downstream gap, framework evolution (paralleling but adapted from the document re-review triggers)
- [ ] Status semantics distinguish additive re-elaboration (work item stays at current status) from substantive re-elaboration (work item transitions back to DRAFT); substantive re-elaboration's gate re-pass rules are explicit — at minimum naming which gates re-pass and which prior approvals are preserved (sharpened)
- [ ] Status semantics enumerate behaviour for **each non-DRAFT status** (ELABORATED, PLANNED, IMPLEMENTING, IMPLEMENTED, REVIEW, APPROVED) under both additive and substantive re-elaboration — naming which gates re-pass and which prior approvals are preserved at each status (new — closes the asymmetry with documents which have only one post-DRAFT status)
- [ ] Workflow text explicitly confirms applicability across all four work-item types (Feature, Epic, Task, Spike), noting any type-specific deviations (e.g. Spikes standalone vs hierarchical parents; Features have no upstream work-item parent; orphan Tasks) (new — prevents implicit cross-type semantics)
- [ ] The workflow's Flow step that produces structured findings names the canonical four-category schema (Drift / Gap / Internal contradiction / Strength), matching *Re-reviewing an APPROVED Mandated Document* step 3 (new — parity with canonical document re-review pattern)
- [ ] `shannon/skills/work-items/skill.md` § Process: Elaborate gains an explicit re-elaboration branch (sibling to the DRAFT → ELABORATED path); the existing § Failure Modes "Wrong status for verb" entry (line 273) updated so `*-elaborate` on a non-DRAFT work item enters re-elaboration rather than erroring
- [ ] The Activity Log entry pattern for re-elaboration is documented in the workflow, naming three required fields: **(a) trigger category, (b) upstream commit hash where applicable, (c) summary of what changed** — matching the precedent set by FEAT-003's 2026-05-19 entry (sharpened)

### Context

- **Parent Epic**: [EPIC-006 — Work Item Lifecycle Maturation](../epics/EPIC-006-work-item-lifecycle-maturation.md), specifically the F1 Acceptance Criteria group
- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md), aspirational Ideal State bullet 1 (added 2026-05-19)
- **Precedent pattern**: `conceptual_design.md` § *Re-reviewing an APPROVED Mandated Document* (lines 227-256) — same shape, adapted from documents to work items
- **Related workflow**: `conceptual_design.md` § *Responsible Promotion* (lines 258-285) — this Task closes the gap step 5 of that workflow flags
- **Files in scope**:
  - `docs/conceptual_design.md` (add new workflow + version bump; also remove the "canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap" parenthetical from § Responsible Promotion step 5 at line 279, since this Task ratifies it)
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

- **2026-05-19** — ELABORATED via Gate 1. Elaboration verified the pre-stashed Requirements against current upstream state (precedent workflow at conceptual_design.md lines 227-256; work-items skill § Process: Elaborate at lines 120-153; § Failure Modes at line 273). Refinements applied:
  - 3 new Acceptance Criteria — four-category schema parity in the Flow step (matching the document re-review precedent); per-status enumeration across the six non-DRAFT statuses (closes the asymmetry with documents which have only one post-DRAFT status); cross-type applicability statement (prevents implicit Feature / Epic / Task / Spike semantics)
  - 3 sharpenings — parallel sub-section ordering specified for parity-checking (AC#1); explicit gate re-pass rules in the substantive case (AC#3); three named Activity-Log fields for the workflow's documented pattern (AC#8)
  - Scope boundary added to Overview: this Task delivers canonical text only; live application to FEAT-003 / FEAT-006 belongs to EPIC-006's forward-declared follow-up Task
  - Context Files-in-scope: added note that the "(not yet ratified)" parenthetical at conceptual_design line 279 will be removed by this Task
  No drift against upstream; all cited line ranges and commit hashes still resolve. Verdict from elaboration verification: ready with minor refinements; refinements applied.
- **2026-05-19** — DRAFT: Task created via EPIC-006's planning (option-b cascading pattern). Requirements section pre-stashed; will surface when `/task-elaborate TASK-001` is invoked. Plan section deferred to `/task-plan`.
