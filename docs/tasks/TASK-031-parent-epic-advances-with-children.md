# TASK-031: Parent Epic Advances Through the Iterative Zone With Its Children

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: — (orphan Task; no parent Epic — see § Context)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #work-items #lifecycle #conceptual-design
- **Created**: 2026-10-17
- **Updated**: 2026-10-17

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at task creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage on supervisor promotion authority (`conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*). Full elaboration pending `/task-elaborate TASK-031`.*

### Overview

Twice now a parent Epic sat at PLANNED while its child Tasks implemented and reached APPROVED: EPIC-009 (diagnosed 2026-07-10) and EPIC-010 eight days after its first child approved (surfaced by the second `/shannon-report` run, 2026-08-20). The question *whether* parents advance is settled: `/epic-review` requires IMPLEMENTED or REVIEW (`shannon/skills/work-items/skill.md` § Process: Review), so they do. What is not written down is *when*, and the ruling lives only in EPIC-009's Activity Log, where nobody planning the next Epic reads it. The Lifecycle checker detects the lag after the fact; nothing prevents it.

This Task merges two scratchpad items: "Do parent Epics advance to IMPLEMENTING…" and "A settled lifecycle ruling does not propagate…".

### Acceptance Criteria

*Candidate criteria; refined at Gate 1.*

- [ ] `conceptual_design.md` § Business Rules (or the unified lifecycle entry) states when a parent Epic enters IMPLEMENTING relative to its children — candidate: when its first child Task enters IMPLEMENTING — as an additive amendment
- [ ] `shannon/skills/work-items/skill.md` carries a soft prompt at child-Task transitions (§ Process: Implement and the Gate 3 approval step of § Process: Review) to check whether the parent Epic should advance
- [ ] Precedents named: EPIC-009 (2026-07-10) and EPIC-010 (2026-08-20)
- [ ] The deployed copy under `./.claude/skills/work-items/` is refreshed from `./shannon/`

### Context

- **Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md)
- **Relevant documents**: `conceptual_design.md` § Domain Model → *Work Item* lifecycle and § Business Rules; `shannon/skills/work-items/skill.md` § Process: Implement / Review; `shannon/skills/shannon-supervisor/checkers/lifecycle.md`
- **Related work**: EPIC-009 and EPIC-010 Activity Logs; `docs/knowledge/meta-gap-routing-channel.md` (a ruling recorded only in an Activity Log is invisible to later work)

---

## Plan

[Filled during planning. The "how" — approved before any implementation work begins (Gate 2).]

### Approach

[High-level approach. Which components are touched, what new pieces are introduced, what shape the change takes.]

### Steps

[Ordered implementation steps. Granular enough that someone else could execute the plan, not so granular that they describe the code itself.]

1. [Step]
2. [Step]
3. [Step]

### Dependencies

[Work or artefacts that must exist before this task can proceed.]

- [Dependency]

### Risks

[Known risks and how they'll be mitigated.]

- [Risk — mitigation]

---

## Implementation Notes

[Filled during implementation. Decisions made, deviations from plan, gotchas, learnings worth capturing as knowledge notes.]

### Deviations from Plan

- [What changed and why]

### Gotchas

- [Problem encountered — resolution]

### Documents Updated

- [Documents updated during implementation, with sections]

---

## Review

[Filled during review (Gate 3).]

### Verification

- [ ] All acceptance criteria met
- [ ] Code follows development_guide.md
- [ ] Tests added or updated, passing
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

[Findings from review. Issues found and how they were resolved.]

---

## Activity Log

[Timestamped entries recording the history. Newest at the top.]

- **2026-10-17** — DRAFT: Task created from two merged scratchpad items (parent Epic advancement; settled ruling not propagating) by the 2026-10-17 triage
