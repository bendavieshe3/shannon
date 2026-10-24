# TASK-037: Verification Substrings Land in Plain Prose

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #conventions #acceptance-criteria
- **Created**: 2026-10-23
- **Updated**: 2026-10-23

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-037` (Gate 1).*

### Overview

Acceptance criteria often verify a landing by grepping for a verbatim substring. Markdown formatting between the substring's characters (backticks, `*`, `**`) breaks the match. TASK-009 Step 7 caught it when a three-item list of Task labels landed with each label in backticks and failed its verbatim grep. Since then the same rule has been re-derived Epic by Epic: EPIC-009 AC#7 and EPIC-011 AC#8 each restate it locally.

This Task makes it one convention in § Code Style → Patterns to Follow, so Epics stop restating it.

### Acceptance Criteria

*Each criterion asserts the governing rule it lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- [ ] **AC#1 — Plain-prose convention stated.** § Code Style → Patterns to Follow states that text an acceptance criterion will verify by substring lands without Markdown formatting interposed between its characters. *Asserts* Epic AC#5.
- [ ] **AC#2 — Precedent named.** TASK-009 Step 7, and the Epic-local restatements at EPIC-009 AC#7 and EPIC-011 AC#8 (the repeated re-derivation this convention ends).
- [ ] **AC#3 — The convention's own wording passes its rule.** Any substring this Task's ACs grep for lands in plain prose.
- [ ] **AC#4 — Version History bullet, route and classification** *(Epic AC#8)*. One bullet under `development_guide.md` § Version History → `Unreleased (EPIC-012)` names this Task, the section it amended, its route (amended by a work item rather than `/document-review`, per `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*) and its classification per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* (expected additive).
- [ ] **AC#5 — Scope guard** *(Epic AC#9)*. Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: no mandated document other than `development_guide.md`, and no work-item template, index template, command, guide under `shannon/guides/`, or skill file under `shannon/skills/`, is modified by this Task. Derived bookkeeping (this Task's file, `task_index.md`, the EPIC-012 Tasks line) is exempt.

### Context

- **Parent Epic**: [EPIC-012 — Development Conventions Surfaced Through the Supervisor Build-Out](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — Task 5 of 7; covers Epic AC#5
- **Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md)
- **Relevant documents**: `development_guide.md` § Code Style → Patterns to Follow (sibling to *Acceptance criteria cite the governing rule*, which already says to draw grep substrings from the rule); § Version History
- **Related work**: [TASK-009](./archive/TASK-009-add-work-items-skill-prompts-and-resync-claude.md) Step 7; [EPIC-009](../epics/EPIC-009-health-reporting-surface.md) AC#7; [EPIC-011](../epics/EPIC-011-autonomic-invocation.md) AC#8; `docs/scratchpad.md` § Items entry *Verbatim-phrasing grep tests require plain-prose substring landings*

---

## Plan

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-plan TASK-037` (Gate 2).*

### Approach

One short bullet next to *Acceptance criteria cite the governing rule*, which it complements: that bullet says where a verification substring comes from, this one says how it lands. Cross-reference between them rather than restating.

### Steps

1. Re-read `development_guide.md` as landed on master, not as any earlier Task planned it (per § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; the cross-Task case once TASK-034 has landed it), and confirm the target section's current wording.
2. Draft the bullet with its precedents and a cross-reference to *Acceptance criteria cite the governing rule*.
3. Add this Task's bullet under § Version History → `Unreleased (EPIC-012)`.
4. Verify: grep each verification substring named in the ACs against the landed Guide; render the Guide with pandoc; check every new cross-reference resolves.
5. `git diff --stat` scope check against the scope-guard AC.

### Dependencies

- TASK-036 APPROVED (the Guide's landed state this Task re-reads); Tasks in EPIC-012 run one at a time in Epic order

### Risks

- **EPIC-011's local restatement goes stale** — EPIC-011 AC#8 is not edited here (it is another Epic's Requirements); EPIC-011's own elaboration can point at the new convention.
- **A skill prompt at plan time** was the scratchpad's alternative route. Not planned (AC#5); if wanted, route it to the scratchpad.

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
