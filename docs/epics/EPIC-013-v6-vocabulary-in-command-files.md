# EPIC-013: V6 Vocabulary in Command Files

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Created**: 2026-10-18
- **Updated**: 2026-10-18
- **Tags**: #v6 #framework #commands

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Initial intent captured at Epic creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage on directing-party approval (Ben, 2026-10-18). Epic promotion needs that approval under `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*. Not yet reviewed; full elaboration pending `/epic-elaborate EPIC-013` (Gate 1).*

### Overview

EPIC-005 brought the three skills and the CLAUDE.md template into V6 vocabulary (directing party, supervisor, implementer). The 26 command files in `shannon/commands/` were left out, and they still read as if one human approves every gate: each `*-elaborate`, `*-plan` and `*-review` command says "Gate N requires explicit user approval". That contradicts *Gate Authority Split*, under which the supervisor approves Task gates and, by default, Epic and Spike gates. The commands also carry no self-approval-refusal language, which FEAT-006 Ideal State bullet 3 asks of "skills and commands".

The two `PLAN-PENDING` lines in `epic-plan.md` and `feature-plan.md` were already fixed directly by the triage PR. Out of scope: changing what any command does. These are wording changes in thin files that delegate to skills.

### Goal

Every command file names gate authority as *Gate Authority Split* assigns it, and none implies the implementer may approve its own work.

### Acceptance Criteria

*Candidate criteria; refined at Gate 1.*

- [ ] Each command's gate sentence names the authority the gate actually carries (directing party, or supervisor within the configurable ceiling), citing `conceptual_design.md` § Business Rules → *Gate Authority Split* as the governing rule
- [ ] Commands that trigger a gate carry the self-approval refusal the skills already state (FEAT-006 Ideal State bullet 3)
- [ ] `shannon/commands/README.md` matches
- [ ] A grep over `shannon/commands/` finds no "explicit user approval" left, and `rg "\buser\b" shannon/commands/` returns only intentional "human reader" occurrences (FEAT-006 § Plan success criterion)
- [ ] Deployed copies under `./.claude/commands/` are refreshed from `./shannon/`

### Context

- **Parent Feature**: [FEAT-006 — Multi-Party Supervision](../features/FEAT-006-multi-party-supervision.md). Ideal State bullets 1 and 3 both name the command files as the remaining surface, so the parent already aspires to this work (`conceptual_design.md` § Key Workflows → *Responsible Promotion* step 4: yes)
- **Precedent**: [EPIC-005](EPIC-005-v6-skills-and-claude-template.md), the same propagation for skills and the CLAUDE.md template
- **Conceptual Design**: § Business Rules → *Gate Authority Split*; *Supervisor Distinct From Implementer*
- **Technical Design**: § System Architecture → *Commands* (thin entry points)

---

## Plan

[Filled during planning. The epic's plan is its list of tasks plus the integration story across them.]

### Approach

*Not yet planned. Likely a single mechanical pass, split by work-item type if Gate 2 prefers smaller diffs.*

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

- **2026-10-18** — DRAFT: Epic created from the scratchpad item "V6 propagation Epic under FEAT-006" by the 2026-10-17 triage, on directing-party approval
