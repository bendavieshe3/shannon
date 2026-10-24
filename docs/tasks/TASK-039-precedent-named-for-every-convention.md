# TASK-039: Precedent Named for Every Post-Bootstrapping Convention

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #conventions #precedent #sweep
- **Created**: 2026-10-23
- **Updated**: 2026-10-23

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-039` (Gate 1).*

### Overview

FEAT-008 Ideal State bullet 5 asks that each convention name the precedent that produced it. Every convention added to § Code Style → Patterns to Follow since bootstrapping does, but not uniformly elsewhere: Push Cadence, Multi-Agent Coordination and the supervisor sections of § Git Workflow name their precedent only in § Version History. The Guide does not state precedent-naming as a requirement of its own format.

This Task states the requirement once, then sweeps the Guide, including the six conventions this Epic just added, and backfills the § Git Workflow conventions. As the Epic's last Task it also folds the `Unreleased (EPIC-012)` Version History heading into one dated version.

### Acceptance Criteria

*Each criterion asserts the governing rule it lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- [ ] **AC#1 — Requirement stated once.** The Guide states, once, that a convention added after bootstrapping names the worked precedent that produced it, at the head of § Code Style → Patterns to Follow or wherever this Task judges it governs every section. Bootstrapping conventions (those present at v1.1, 2026-05-15) are exempt as FEAT-008's retrospective base, per `conceptual_design.md` § Business Rules → *Retrospective Features*. A convention satisfies the rule when its body names the work item that produced it; a § Version History entry alone does not. *Asserts* Epic AC#7.
- [ ] **AC#2 — Sweep and backfill.** Every post-bootstrapping convention body in the Guide names its precedent, including those TASK-033 to TASK-038 added and the § Git Workflow conventions under Epic item 8 (Push Cadence, Multi-Agent Coordination, the supervisor sections), which this Task backfills. The sweep's list of conventions checked is recorded in Implementation Notes.
- [ ] **AC#3 — Patterns to Follow still reads as rules.** After the sweep, § Code Style → Patterns to Follow reads as a list of rules rather than a log (Epic Risk *Convention creep*); any bullet that grew a history is trimmed to its rule plus one precedent line.
- [ ] **AC#4 — One Guide version for the Epic.** The `Unreleased (EPIC-012)` heading is folded into one `### YYYY-MM-DD - v1.N` entry, where v1.N is the next minor number after the Guide's landed version at merge time (the next major's first minor if TASK-033 took v2.0), keeping every Task's bullet, this Task's own included. The entry names every amending Task, its route and its classification, and closes with a Status line. `**Last Reviewed**` is updated. No `Unreleased` heading remains. *Asserts* Epic AC#8's single-bump option.
- [ ] **AC#5 — Scope guard** *(Epic AC#9)*. Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: no mandated document other than `development_guide.md`, and no work-item template, index template, command, guide under `shannon/guides/`, or skill file under `shannon/skills/`, is modified by this Task. Derived bookkeeping (this Task's file, `task_index.md`, the EPIC-012 Tasks line) is exempt.

### Context

- **Parent Epic**: [EPIC-012 — Development Conventions Surfaced Through the Supervisor Build-Out](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — Task 7 of 7; covers Epic AC#7, and folds the Epic's `Unreleased` heading into its one Guide version
- **Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md)
- **Relevant documents**: `development_guide.md` (whole document: the sweep), § Code Style → Patterns to Follow, § Git Workflow → Push Cadence / Multi-Agent Coordination / Commit Cadence → *Supervisor cadence runs* / Supervisor Report Files, § Version History (v1.1 is the bootstrapping cut-off); `conceptual_design.md` § Business Rules → *Retrospective Features*
- **Related work**: Every Version History entry from v1.2 onward (to find what each convention's precedent is); TASK-033 to TASK-038; FEAT-008 § Ideal State bullet 5 and § Success Metrics → *Precedent density*

---

## Plan

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-plan TASK-039` (Gate 2).*

### Approach

State the rule in one short bullet at the head of § Code Style → Patterns to Follow, scoped to the whole Guide. Then walk the Guide section by section against the v1.1 baseline: anything added later is in scope, and its precedent comes from the Version History entry that added it. Backfill a short "Precedent:" clause where one is missing. Fold the Version History last, after rebasing on master so the number is right. AC#10 bookkeeping (scratchpad, FEAT-008) is not this Task's; it runs at `/epic-review EPIC-012`.

### Steps

1. Re-read `development_guide.md` as landed on master, not as any earlier Task planned it (per § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; the cross-Task case once TASK-034 has landed it), and confirm the target section's current wording.
2. Diff the Guide against its v1.1 state to list every post-bootstrapping convention.
3. State the precedent requirement with its bootstrapping exemption.
4. Backfill missing precedents in the § Git Workflow conventions and anywhere else the sweep finds one; record the checked list in Implementation Notes.
5. Trim § Code Style → Patterns to Follow if any bullet reads as a log.
6. Add this Task's bullet under § Version History → `Unreleased (EPIC-012)`.
7. Rebase on master; fold `Unreleased (EPIC-012)` into the next version number; update `**Last Reviewed**`.
8. Verify: grep each verification substring named in the ACs against the landed Guide; render the Guide with pandoc; check every new cross-reference resolves.
9. `git diff --stat` scope check against the scope-guard AC.

### Dependencies

- TASK-038 APPROVED (the Guide's landed state this Task re-reads); Tasks in EPIC-012 run one at a time in Epic order; TASK-033 to TASK-038 all APPROVED, so the sweep covers what they added

### Risks

- **v1.1 baseline ambiguous** — read the Guide at the v1.1 commit from git history rather than inferring the baseline from Version History prose.
- **Version collision with EPIC-011** — rebase immediately before the fold; whichever Epic merges its version second takes the next number.
- **Backfill turns into rewrite** — the backfill adds a precedent clause only; it changes no rule.

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
