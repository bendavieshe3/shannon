# TASK-032: Archived Tasks Keep Working Parent Links

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: — (orphan Task; no parent Epic — see § Context)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #work-items #archive #cross-references
- **Created**: 2026-10-17
- **Updated**: 2026-10-17

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at task creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage on supervisor promotion authority (`conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*). Full elaboration pending `/task-elaborate TASK-032`.*

### Overview

Task files link their parent as `../epics/…` and `../features/…`. On APPROVED they move one level deeper to `docs/tasks/archive/`, where those links resolve to non-existent `docs/tasks/epics/` and `docs/tasks/features/`. The archive step in `shannon/skills/work-items/skill.md` § Process: Review updates the index link but never rewrites body links for the new depth. All 28 archived Tasks are affected, about 103 links (TASK-001 is half-fixed). Navigation-only, but it is a real broken cross-reference a drift check will flag.

### Acceptance Criteria

*Candidate criteria; refined at Gate 1.*

- [ ] The archive step in `shannon/skills/work-items/skill.md` § Process: Review rewrites a Task body's `../` relative links to `../../` when the file moves to `./docs/tasks/archive/`
- [ ] A one-pass sweep fixes every archived Task's relative links; a link check over `docs/tasks/archive/` reports zero broken relative links afterwards
- [ ] The sweep is confirmed with the directing party before it runs, per CLAUDE.md (bulk edit across 28 files)
- [ ] The deployed copy under `./.claude/skills/work-items/` is refreshed from `./shannon/`

### Context

- **Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md) — `conceptual_design.md` § Business Rules → *Approved Tasks Are Archived*
- **Relevant documents**: `shannon/skills/work-items/skill.md` § Process: Review (archive step); `development_guide.md` § Testing Strategy → Pre-Commit Checklist (cross-reference link check)
- **Related work**: TASK-022 (archived matching the broken convention deliberately, pending a systemic fix)

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

- **2026-10-17** — DRAFT: Task created from the scratchpad item "Archived Tasks carry broken relative links" by the 2026-10-17 triage. Scope widened from TASK-001…021 to all 28 archived Tasks, as checked at triage
