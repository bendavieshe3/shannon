# TASK-034: Cross-Task Editing Order

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #conventions #editing-order
- **Created**: 2026-10-23
- **Updated**: 2026-10-23

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-034` (Gate 1).*

### Overview

§ Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts* governs the order of edits inside one Task's diff. It says nothing about the case where a downstream Task's source-of-truth body is an upstream Task's: TASK-015 extended the `SKILL.md` TASK-011 created, and TASK-017 extended the `settings.json` TASK-016 first touched. EPIC-009 handled both Task-locally, inside the stubs, and routed the general case to the scratchpad (M-8).

This Task states the cross-Task case: the downstream Task re-reads the upstream Task's landed body before editing, and its scope check is a diff against that landed state rather than against the upstream Task's plan. It runs second because EPIC-012 is itself a live instance of the case: every later Task edits the Guide body its predecessor just landed.

### Acceptance Criteria

*Each criterion asserts the governing rule it lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- [ ] **AC#1 — Cross-Task case stated.** § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts* is extended (or gains a sibling bullet) for the case where a downstream Task's source-of-truth body is an upstream Task's: the downstream Task re-reads the upstream Task's landed body before editing, and its scope check is a diff against that landed state, not against the upstream Task's plan. *Asserts* Epic AC#2.
- [ ] **AC#2 — Precedents named in the body.** TASK-015 / TASK-011 and TASK-017 / TASK-016.
- [ ] **AC#3 — Version History bullet, route and classification** *(Epic AC#8)*. One bullet under `development_guide.md` § Version History → `Unreleased (EPIC-012)` names this Task, the section it amended, its route (amended by a work item rather than `/document-review`, per `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*) and its classification per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* (expected additive: the existing within-Task rule is untouched).
- [ ] **AC#4 — Scope guard** *(Epic AC#9)*. Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: no mandated document other than `development_guide.md`, and no work-item template, index template, command, guide under `shannon/guides/`, or skill file under `shannon/skills/`, is modified by this Task. Derived bookkeeping (this Task's file, `task_index.md`, the EPIC-012 Tasks line) is exempt.

### Context

- **Parent Epic**: [EPIC-012 — Development Conventions Surfaced Through the Supervisor Build-Out](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — Task 2 of 7; covers Epic AC#2
- **Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md)
- **Relevant documents**: `development_guide.md` § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; § Version History
- **Related work**: [TASK-011](./archive/TASK-011-supervisor-skill-skeleton.md), [TASK-015](./archive/TASK-015-report-writer-and-knowledge-index-updater.md), [TASK-016](./archive/TASK-016-pretooluse-write-guard-hook.md), [TASK-017](./archive/TASK-017-posttooluse-audit-logging-hook.md); EPIC-009 § Activity Log 2026-05-30 (finding G-1 and the M-8 routing); `docs/scratchpad.md` § Items entry *Cross-Task editing-order discipline*

---

## Plan

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-plan TASK-034` (Gate 2).*

### Approach

Prefer extending the existing bullet with one sub-clause over a new sibling, since the cross-Task case is the same rule applied across a Task boundary. Decide at Gate 1; either satisfies AC#1.

### Steps

1. Re-read `development_guide.md` as landed on master, not as any earlier Task planned it (per § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; this Task is itself the first downstream Task in the chain, so it applies the rule it is about to write), and confirm the target section's current wording.
2. Draft the cross-Task clause; name both precedents.
3. Add this Task's bullet under § Version History → `Unreleased (EPIC-012)`.
4. Verify: grep each verification substring named in the ACs against the landed Guide; render the Guide with pandoc; check every new cross-reference resolves.
5. `git diff --stat` scope check against the scope-guard AC.

### Dependencies

- TASK-033 APPROVED (the Guide's landed state this Task re-reads); Tasks in EPIC-012 run one at a time in Epic order

### Risks

- **Duplicates the existing bullet** — state only what the cross-Task case adds (the re-read and the landed-state diff), and leave the within-Task wording alone.
- **The rule could also want a skill prompt** (e.g. at `work-items` § Process: Plan). Not planned: AC#4 bars skill edits here; if the Gate 1 review wants one, route it to the scratchpad.

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
