# TASK-038: Placeholder Syntax for Machine-Filled Templates

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #conventions #templates #supervisor
- **Created**: 2026-10-23
- **Updated**: 2026-10-23

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-038` (Gate 1).*

### Overview

§ Code Style → Template Structure says "Placeholders use square brackets". The three supervisor templates under `shannon/skills/shannon-supervisor/templates/` (`header.md`, `finding-section.md`, `footer.md`) use `{{SLOT}}`. The divergence shipped through EPIC-009 Gate 3 unnoticed and surfaced at TASK-028 Gate 1 (2026-08-21), which kept the local style rather than introduce a third inside a template it was already editing.

The distinction may be real: the supervisor templates are filled by a pipeline, the work-item and document templates by a person. This Task's Gate 1 records, as a directing-party decision, whether the Guide sanctions `{{SLOT}}` for pipeline-filled slots and keeps `[Placeholder]` for person-filled ones, or the supervisor templates converge on square brackets.

### Acceptance Criteria

*Each criterion asserts the governing rule it lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- [ ] **AC#1 — One placeholder rule, decided at Gate 1.** § Code Style → Template Structure states one rule that every slot placeholder in the shipped templates under `shannon/skills/` satisfies. Gate 1 records which route as a directing-party decision: (a) sanction `{{SLOT}}` for slots a pipeline fills and keep `[Placeholder]` for slots a person fills; or (b) converge the supervisor templates on square brackets. *Recommendation*: (a), which matches the shipped templates, marks a real difference in who fills the slot, and needs no template edit. *Asserts* Epic AC#6.
- [ ] **AC#2 — Non-slot tokens handled.** Link targets (`EPIC-XXX-slug.md`) and value masks (`#XXXXXX`) are not slot placeholders; the rule either names them as exempt or covers them.
- [ ] **AC#3 — Precedent named.** The supervisor templates and TASK-028 Gate 1.
- [ ] **AC#4 — Sweep passes.** A sweep of every template under `shannon/skills/` finds no slot placeholder that breaks the rule. If route (b) is chosen, the three supervisor templates and every `SKILL.md` step that names a `{{...}}` slot are converged in this Task, and the deployed copies under `./.claude/skills/shannon-supervisor/` are re-copied from `./shannon/`.
- [ ] **AC#5 — Version History bullet, route and classification** *(Epic AC#8)*. One bullet under `development_guide.md` § Version History → `Unreleased (EPIC-012)` names this Task, the section it amended, its route (amended by a work item rather than `/document-review`, per `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*) and its classification per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* (expected additive under route (a); under route (b) the template edits are listed too).
- [ ] **AC#6 — Scope guard** *(Epic AC#9)*. Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: no mandated document other than `development_guide.md`, and no work-item template, index template, command, guide under `shannon/guides/`, or skill file under `shannon/skills/` other than the supervisor templates and `SKILL.md` slot references under route (b), is modified by this Task. Derived bookkeeping (this Task's file, `task_index.md`, the EPIC-012 Tasks line) is exempt.

### Context

- **Parent Epic**: [EPIC-012 — Development Conventions Surfaced Through the Supervisor Build-Out](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — Task 6 of 7; covers Epic AC#6
- **Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md)
- **Relevant documents**: `development_guide.md` § Code Style → Template Structure; `shannon/skills/shannon-supervisor/templates/*.md` and `SKILL.md` § Report Pipeline (read; edited only under route (b)); § Version History
- **Related work**: [TASK-028](./archive/TASK-028-per-category-finding-counts-in-report-header.md) Gate 1; [EPIC-009](../epics/EPIC-009-health-reporting-surface.md) (where the templates shipped); `docs/scratchpad.md` § Items entry *Supervisor templates use `{{SLOT}}` against the codified `[Placeholder]` convention*

---

## Plan

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-plan TASK-038` (Gate 2).*

### Approach

Under route (a), amend the Template Structure bullet to name both forms by who fills the slot, and exempt link targets and value masks. Under route (b), converge the three templates and the `SKILL.md` references, then re-copy to `./.claude/`. Run the sweep either way.

### Steps

1. Re-read `development_guide.md` as landed on master, not as any earlier Task planned it (per § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; the cross-Task case once TASK-034 has landed it), and confirm the target section's current wording.
2. Record the Gate 1 route decision in this file.
3. Amend § Code Style → Template Structure for the chosen route, with the non-slot exemption and precedents.
4. Under route (b) only: converge the supervisor templates and `SKILL.md` slot references; re-copy to `./.claude/skills/shannon-supervisor/`.
5. Sweep every template under `shannon/skills/` for slot placeholders against the rule.
6. Add this Task's bullet under § Version History → `Unreleased (EPIC-012)`.
7. Verify: grep each verification substring named in the ACs against the landed Guide; render the Guide with pandoc; check every new cross-reference resolves.
8. `git diff --stat` scope check against the scope-guard AC.

### Dependencies

- TASK-037 APPROVED (the Guide's landed state this Task re-reads); Tasks in EPIC-012 run one at a time in Epic order

### Risks

- **Decision stalls** — the Task runs sixth so only TASK-039 waits on it; the recommendation is on the page.
- **Route (b) breaks the report pipeline** — the pipeline fills slots by name; any convergence changes `SKILL.md` and the templates together, and the Task dogfoods one `/shannon-report` run before Gate 3.
- **False positives in the sweep** — link targets and value masks are exempted by AC#2.

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
