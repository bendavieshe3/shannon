# TASK-030: Skill-Creating Epics Scope the Command Entry Point

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: — (orphan Task; no parent Epic — see § Context)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #work-items #commands #skills
- **Created**: 2026-10-17
- **Updated**: 2026-10-17

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at task creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage on supervisor promotion authority (`conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*). Full elaboration pending `/task-elaborate TASK-030`.*

### Overview

EPIC-009 decomposed the supervisor into skill skeleton → checkers → report pipeline → hooks → dogfood, but never scoped the thin `/shannon-report` command file. The skill's contract existed in `SKILL.md` prose with no invocation surface, which Shannon's Commands + Skills + Subagents architecture requires. The dogfood caught it and corrective TASK-020 fixed it. TASK-022 later shipped `/shannon-goal` skill and command together, so the lesson was applied once, but only informally: nothing in `shannon/skills/work-items/skill.md` § Process: Plan prompts for it.

The rule to codify: an Epic that adds a new skill with a slash-command surface scopes the command-layer entry point as an explicit Task or acceptance criterion.

### Acceptance Criteria

*Candidate criteria; refined at Gate 1.*

- [ ] `shannon/skills/work-items/skill.md` § Process: Plan carries a prompt that a skill-creating Epic's decomposition includes the thin command entry point, citing `technical_design.md` § System Architecture (commands delegate to skills) as the governing rule
- [ ] The prompt names EPIC-009 / TASK-020 as the worked precedent
- [ ] The deployed copy under `./.claude/skills/work-items/` is refreshed from `./shannon/`

### Context

- **Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md) — work-item workflow conventions (EPIC-007 is APPROVED and closed, so this is an orphan Task)
- **Relevant documents**: `technical_design.md` § System Architecture → *Commands*; `shannon/commands/README.md`
- **Related work**: TASK-020 (corrective `/shannon-report` command); TASK-022 (`/shannon-goal` skill + command); FEAT-008 § Plan → *Known forward work* (portability discipline and shipping-source mirror, also skill-creating-Epic conventions — EPIC-012 in PR #3). Consider cross-referencing at elaboration

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

- **2026-10-17** — DRAFT: Task created from the scratchpad item "Skill-building Epics must scope the command entry point" by the 2026-10-17 triage
