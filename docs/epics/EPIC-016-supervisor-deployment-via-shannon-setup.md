# EPIC-016: Supervisor Deployment via /shannon-setup

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Created**: 2026-10-18
- **Updated**: 2026-10-18
- **Tags**: #supervisor #setup #portability #deploy

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Initial intent captured at Epic creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage on directing-party approval (Ben, 2026-10-18). Epic promotion needs that approval under `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*. Not yet reviewed; full elaboration pending `/epic-elaborate EPIC-016` (Gate 1).*

### Overview

`/shannon-setup` copies `shannon/skills/` wholesale (`project-setup/skill.md`), so the supervisor's files reach a new project. The rest of what makes it work does not:

- the hook registrations merged into `.claude/settings.json`
- `./.claude/shannon-supervisor.json` (gate-authority ceilings, report directory)
- the targeted `.gitignore` entry for the PostToolUse audit log
- the *Supervisor Report* knowledge-note subtype in the project's knowledge index

FEAT-009's portability commitment is that copying the skill delivers the capability without modification. Today that holds only for a project whose maintainer wires the rest by hand.

This came out of the 2026-10-17 triage as the second halves of two FEAT-008 items (audit-log convention, shipping-source mirror) that EPIC-012 codifies at the convention level. This Epic is the installer half.

### Goal

Running `/shannon-setup` in a fresh project yields a supervisor that runs `/shannon-report`, fires its shipped hooks, and keeps its audit log out of version control, with no hand wiring.

### Acceptance Criteria

*Candidate criteria; refined at Gate 1.*

- [ ] `/shannon-setup` merges the shipped hook snippets (`shannon-supervisor/hooks/*.settings.json`) into the project's `.claude/settings.json` without clobbering existing entries
- [ ] It writes a default `./.claude/shannon-supervisor.json` per `technical_design.md` § Data Model → *Supervisor Configuration*
- [ ] It adds the audit-log ignore entry, following the convention EPIC-012 ratifies
- [ ] Verified by deploying into a scratch project and running `/shannon-report` there

### Context

- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md). Ideal State *Portability to non-Shannon-self projects* already aspires to this (*Responsible Promotion* step 4: yes)
- **Also touches**: FEAT-001 (Easy to Set Up) through `project-setup/skill.md`; EPIC-001 (Basic Installation, DRAFT) doesn't cover the supervisor
- **Depends on**: EPIC-012 (FEAT-008 development conventions, PR #3) for the audit-log and shipping-source conventions; EPIC-011 for the hook set it should install (PreCompact and Stop are pending there)
- **Technical Design**: § Data Model → *Supervisor Configuration*; § System Architecture → *Supervisor* → *Hook integration*

---

## Plan

[Filled during planning. The epic's plan is its list of tasks plus the integration story across them.]

### Approach

*Not yet planned. Sequence after EPIC-011, so the installer ships the complete hook set once.*

### Tasks

*None yet; identified at Gate 2 (`/epic-plan`).*

### Dependencies

[Other epics, features, or external work this epic depends on, or that depends on it.]

**Depends on**: [Other work or external dependencies]

**Depended on by**: [Other epics or features]

### Risks

- [Risk — mitigation]

---

## Implementation Notes

[Filled during implementation. Cross-task decisions and learnings that don't belong to a single task.]

### Cross-Task Decisions

- [Decision and rationale]

### Documents Updated

- [Documents updated by this epic, with sections]

---

## Review

[Filled during review (Gate 3).]

### Verification

- [ ] All tasks APPROVED
- [ ] Epic acceptance criteria met
- [ ] Parent feature updated with epic outcome
- [ ] Relevant documents updated and approved

### Review Notes

[Findings from review. Outcomes worth reflecting back into the parent feature or the mandated documents.]

---

## Activity Log

[Timestamped entries recording the history. Newest at the top.]

- **2026-10-18** — DRAFT: Epic created by the 2026-10-17 triage from the installer halves of two FEAT-008 scratchpad items (audit-log convention; shipping-source mirror), on directing-party approval
