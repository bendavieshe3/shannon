# TASK-036: Audit Log Named in Supervisor Report Files

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #conventions #supervisor #audit-log
- **Created**: 2026-10-23
- **Updated**: 2026-10-23

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-036` (Gate 1).*

### Overview

§ Git Workflow → Supervisor Report Files names the commit status of supervisor reports, same-day suffix files and the optional state file, but not the PostToolUse audit log at `./.claude/skills/shannon-supervisor/audit.log`, which EPIC-009 AC#5 and TASK-017 placed and `SKILL.md` § Hook Integration describes. Any project adopting the supervisor needs to know where the log lives and that it is not committed.

This Task adds the audit log to the section. It is not committed in any project, because it is operational telemetry. In Shannon the blanket `.claude/` ignore covers it; a project that tracks `.claude/` needs a targeted ignore, which EPIC-016 installs.

### Acceptance Criteria

*Each criterion asserts the governing rule it lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- [ ] **AC#1 — Audit log bullet.** § Git Workflow → Supervisor Report Files names the PostToolUse audit log alongside reports and the state file, with its location (`./.claude/skills/shannon-supervisor/audit.log`) and committed status: not committed in any project, because it is operational telemetry. *Asserts* Epic AC#4.
- [ ] **AC#2 — How the status holds outside Shannon.** The bullet says that in Shannon the blanket `.claude/` ignore covers the log, and that a project tracking `.claude/` needs a targeted ignore, which EPIC-016 installs.
- [ ] **AC#3 — Precedent named.** EPIC-009 AC#5 and TASK-017.
- [ ] **AC#4 — Version History bullet, route and classification** *(Epic AC#8)*. One bullet under `development_guide.md` § Version History → `Unreleased (EPIC-012)` names this Task, the section it amended, its route (amended by a work item rather than `/document-review`, per `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*) and its classification per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* (expected additive).
- [ ] **AC#5 — Scope guard** *(Epic AC#9)*. Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: no mandated document other than `development_guide.md`, and no work-item template, index template, command, guide under `shannon/guides/`, or skill file under `shannon/skills/`, is modified by this Task. Derived bookkeeping (this Task's file, `task_index.md`, the EPIC-012 Tasks line) is exempt.

### Context

- **Parent Epic**: [EPIC-012 — Development Conventions Surfaced Through the Supervisor Build-Out](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — Task 4 of 7; covers Epic AC#4 (the Guide half of item 5)
- **Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md)
- **Relevant documents**: `development_guide.md` § Git Workflow → Supervisor Report Files; `shannon/skills/shannon-supervisor/SKILL.md` § Hook Integration (read only, for the location); § Version History
- **Related work**: [TASK-017](./archive/TASK-017-posttooluse-audit-logging-hook.md), [EPIC-009](../epics/EPIC-009-health-reporting-surface.md) AC#5; [EPIC-016](../epics/EPIC-016-supervisor-deployment-via-shannon-setup.md) (the targeted-ignore installer half); `docs/scratchpad.md` § Items entry *Supervisor audit-log convention not codified at framework level*

---

## Plan

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-plan TASK-036` (Gate 2).*

### Approach

One bullet, sibling to *Optional state file is gitignored*. Take the path from `SKILL.md` as landed, so the Guide and the skill agree.

### Steps

1. Re-read `development_guide.md` as landed on master, not as any earlier Task planned it (per § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; the cross-Task case once TASK-034 has landed it), and confirm the target section's current wording.
2. Confirm the audit log path in `shannon/skills/shannon-supervisor/SKILL.md` § Hook Integration.
3. Add the audit-log bullet with its status, the outside-Shannon clause and its precedents.
4. Add this Task's bullet under § Version History → `Unreleased (EPIC-012)`.
5. Verify: grep each verification substring named in the ACs against the landed Guide; render the Guide with pandoc; check every new cross-reference resolves.
6. `git diff --stat` scope check against the scope-guard AC.

### Dependencies

- TASK-035 APPROVED (the Guide's landed state this Task re-reads); Tasks in EPIC-012 run one at a time in Epic order; TASK-035's mirror convention is the context the outside-Shannon clause leans on

### Risks

- **Path drift between Guide and skill** — Step 2 reads the path from the skill rather than from the Epic text.
- **Touches `technical_design.md` § Data Model** — out of scope by Epic decision; the grouping question stays in the scratchpad.

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
