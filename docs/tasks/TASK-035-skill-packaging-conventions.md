# TASK-035: Skill Packaging Conventions: Shipping-Source Mirror and Project-Relative Paths

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #conventions #skills #portability
- **Created**: 2026-10-23
- **Updated**: 2026-10-23

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-035` (Gate 1).*

### Overview

Two decisions made during EPIC-009 govern how every Shannon skill is packaged, but both are recorded only where they were made. The *shipping-source mirror* was decided at TASK-015 Gate 1 (2026-06-27) and backfilled by TASK-019: a skill is authored in tracked `./shannon/skills/<name>/` and deployed to `./.claude/skills/<name>/`. The same decision recorded that gitignoring `./.claude/` is a Shannon-self arrangement, not a rule for adopting projects. *Project-relative paths* became Gate-3-checkable through EPIC-009 AC#1, which required `./docs/` and `./.claude/` paths inside `SKILL.md`, checker definitions and templates so the skill deploys by directory copy.

This Task lifts both into § Code Style → Patterns to Follow as framework conventions. Deployment copies the whole skill tree, hook settings fragments included, which closes route (c) of the scratchpad item on undeployed settings fragments; its route (b) stays with EPIC-011.

### Acceptance Criteria

*Each criterion asserts the governing rule it lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- [ ] **AC#1 — Shipping-source mirror stated.** § Code Style → Patterns to Follow states that a Shannon skill is authored in tracked `./shannon/skills/<name>/` and deployed to `./.claude/skills/<name>/`, and that deployment copies the whole skill tree, including hook settings fragments. Precedent named: TASK-015 Gate 1 decision and TASK-019. *Asserts* Epic AC#3.
- [ ] **AC#2 — Shannon-self qualifier.** The convention states that gitignoring `./.claude/` is a Shannon-self arrangement, not a rule for adopting projects.
- [ ] **AC#3 — Project-relative paths stated.** The same section states that paths inside a skill are project-relative (`./docs/`, `./.claude/`). Precedent named: EPIC-009 AC#1.
- [ ] **AC#4 — Version History bullet, route and classification** *(Epic AC#8)*. One bullet under `development_guide.md` § Version History → `Unreleased (EPIC-012)` names this Task, the section it amended, its route (amended by a work item rather than `/document-review`, per `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*) and its classification per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* (expected additive).
- [ ] **AC#5 — Scope guard** *(Epic AC#9)*. Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: no mandated document other than `development_guide.md`, and no work-item template, index template, command, guide under `shannon/guides/`, or skill file under `shannon/skills/`, is modified by this Task. Derived bookkeeping (this Task's file, `task_index.md`, the EPIC-012 Tasks line) is exempt.

### Context

- **Parent Epic**: [EPIC-012 — Development Conventions Surfaced Through the Supervisor Build-Out](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — Task 3 of 7; covers Epic AC#3
- **Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md)
- **Relevant documents**: `development_guide.md` § Code Style → Patterns to Follow; § Distribution (the copy-into-`.claude/` description the mirror rule must agree with); § Version History
- **Related work**: [TASK-015](./archive/TASK-015-report-writer-and-knowledge-index-updater.md) Gate 1 decision, [TASK-019](./archive/TASK-019-supervisor-shipping-source-and-backfill.md), [EPIC-009](../epics/EPIC-009-health-reporting-surface.md) AC#1; `docs/scratchpad.md` § Items entries *Shipping-source mirror convention*, *Portability discipline as a verifiable convention* and *A hook Task that wires its own hook has no prompt to deploy the shippable settings fragment* (route (c)); [EPIC-016](../epics/EPIC-016-supervisor-deployment-via-shannon-setup.md), which installs what this convention codifies

---

## Plan

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-plan TASK-035` (Gate 2).*

### Approach

Two bullets, or one bullet with two clauses, under § Code Style → Patterns to Follow. Keep the installer half (what `/shannon-setup` does) out: that is EPIC-016's. Check § CI/CD → Distribution still agrees with the mirror rule; if it does not, reconcile with one clause rather than a rewrite.

### Steps

1. Re-read `development_guide.md` as landed on master, not as any earlier Task planned it (per § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; the cross-Task case once TASK-034 has landed it), and confirm the target section's current wording.
2. Draft the mirror bullet with the whole-tree and Shannon-self clauses.
3. Draft the project-relative-paths bullet.
4. Read § CI/CD → Distribution against the new bullets; reconcile if needed.
5. Add this Task's bullet under § Version History → `Unreleased (EPIC-012)`.
6. Verify: grep each verification substring named in the ACs against the landed Guide; render the Guide with pandoc; check every new cross-reference resolves.
7. `git diff --stat` scope check against the scope-guard AC.

### Dependencies

- TASK-034 APPROVED (the Guide's landed state this Task re-reads); Tasks in EPIC-012 run one at a time in Epic order

### Risks

- **Drifts into installer design** — the bullets say where a skill lives and what deployment copies, not how `/shannon-setup` does it (EPIC-016).
- **Reads as a rule that every project ignore `./.claude/`** — the Shannon-self qualifier (AC#2) is the guard.

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
- [ ] Follows development_guide.md
- [ ] Verification substrings grep-checked against the landed Guide
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

- *None yet.*

---

## Activity Log

- **2026-10-23** — DRAFT: Task created during `/epic-plan EPIC-012` (Gate 2 pending) via Cascading Preparation. Prepared elaboration draft (Requirements) and prepared plan draft (Plan) stashed, marked "Prepared during EPIC-012 planning, not yet reviewed".
