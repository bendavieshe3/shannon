# EPIC-012: Development Conventions Surfaced Through the Supervisor Build-Out

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Created**: 2026-10-18
- **Updated**: 2026-10-18
- **Tags**: #framework #conventions #development-guide

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Prepared during FEAT-008 planning, not yet reviewed. Surfaces at `/epic-elaborate EPIC-012` (Gate 1).*

### Overview

EPIC-012 is the second dogfooding harvest under FEAT-008, and the sibling of [EPIC-008](EPIC-008-development-conventions-from-dogfooding.md). EPIC-008 promoted the conventions surfaced by EPIC-005 / EPIC-006; this Epic promotes the conventions surfaced while building the supervisor (FEAT-009, EPIC-009 and EPIC-010). Each one is sitting in `docs/scratchpad.md` § Items with `development_guide.md` as its candidate route, and FEAT-008 § Plan → *Known forward work* names six of them. One more has surfaced since FEAT-008's Gate 1, and the Feature's own Ideal State carries one half-met criterion. That makes eight:

1. **§ Testing Strategy has no Test Level for shipped executables.** The section opens "Shannon has no unit tests because Shannon has no units", but TASK-016, TASK-017 and TASK-025 each unit-tested a hook script before commit, citing a discipline the section does not describe. This is the item that makes FEAT-008 Ideal State bullet 1 read *met, with one section stale*.
2. **Cross-Task editing order.** *Source-of-truth body before derived artefacts* covers one Task's diff. It says nothing about a downstream Task that extends an upstream Task's source-of-truth body (TASK-015 extending TASK-011's `SKILL.md`; TASK-017 extending the `settings.json` TASK-016 first touched).
3. **Project-relative paths in skills.** EPIC-009 AC#1 made portability Gate-3-checkable by requiring `./docs/` and `./.claude/` paths inside `SKILL.md`, checker definitions and templates. The convention is EPIC-009-local; it applies to every Shannon skill.
4. **Shipping-source mirror for skills.** A skill is authored in tracked `./shannon/skills/` and deployed to `./.claude/skills/`. Decided at TASK-015 Gate 1 (2026-06-27) and backfilled by TASK-019, but not codified. The same decision recorded that gitignoring `./.claude/` is Shannon-self-specific, not a general-codebase rule.
5. **Supervisor audit log not named in § Supervisor Report Files.** The section names reports and the state file but not `./.claude/skills/shannon-supervisor/audit.log` or its committed status.
6. **Verification substrings land in plain prose.** Markdown formatting between the characters of a substring breaks the verbatim-grep tests that ACs rely on (caught at TASK-009 Step 7).
7. **Placeholder syntax for machine-filled templates.** The three supervisor templates use `{{SLOT}}`; § Code Style → *Template Structure* says placeholders use square brackets. Surfaced at TASK-028 Gate 1, after FEAT-008's Gate 1.
8. **Precedent named for each new convention.** FEAT-008 Ideal State bullet 5 is met in practice by every convention added since bootstrapping, but the Guide does not state it as a requirement of its own format.

With all eight landed, FEAT-008 Ideal State bullets 1 and 5 move to *met*, and the Feature's only open bullet is the forward-looking one about real-project use.

**Out of scope**:

- The installer halves of items 4 and 5: `/shannon-setup` deploying the whole skill tree, hook registrations and a targeted ignore for the audit log into a new project. Those belong to [EPIC-016](EPIC-016-supervisor-deployment-via-shannon-setup.md) (Supervisor Deployment via /shannon-setup, FEAT-009), which depends on the conventions this Epic ratifies.
- The scratchpad item *A hook Task that wires its own hook has no prompt to deploy the shippable settings fragment*. Its most durable route, a source-vs-deploy comparison in the Drift Checker, was folded into [EPIC-011](EPIC-011-autonomic-invocation.md) (Autonomic Invocation) by the 2026-10-17 scratchpad triage. If item 4's mirror convention is written so that deploying a skill includes its settings fragments, the convention covers route (c) of that item; the implementing Task records whether it did.
- Any `technical_design.md` change, including the open question of grouping transient supervisor artefact locations under § Data Model.

### Goal

`development_guide.md` describes how Shannon is actually built and tested, including the conventions the supervisor build-out settled, and every convention added since bootstrapping names the precedent that produced it.

### Acceptance Criteria

*Each criterion asserts the governing rule the implementing Task lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- **AC#1 — § Testing Strategy covers shipped executables** *(item 1)*. The section no longer claims Shannon has no units. It gains a Test Level for shipped executables (hook scripts and any other script a skill ships): the script is exercised directly against its inputs before commit, and the Task records how. The three existing Test Levels stay, scoped to templates and prompts. Worked precedent named: TASK-016, TASK-017, TASK-025. Verifiable: the "no units" sentence is gone or scoped; a named Test Level for shipped executables exists; the three Tasks are cited.

- **AC#2 — Cross-Task editing order** *(item 2)*. § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts* is extended (or gains a sibling bullet) for the case where a downstream Task's source-of-truth body is an upstream Task's: the downstream Task re-reads the upstream Task's landed body before editing, and its scope check is a diff against that landed state rather than against the upstream Task's plan. Worked precedent named: TASK-015 / TASK-011 and TASK-017 / TASK-016. Verifiable: the cross-Task case is stated under the existing convention with both precedents named.

- **AC#3 — Skill packaging conventions** *(items 3 and 4)*. § Code Style → Patterns to Follow gains the convention that a Shannon skill is authored in tracked `./shannon/skills/<name>/` and deployed to `./.claude/skills/<name>/`, where deployment copies the whole skill tree (including hook settings fragments); and that paths inside a skill are project-relative (`./docs/`, `./.claude/`). The convention states that gitignoring `./.claude/` is a Shannon-self arrangement, not a rule for adopting projects. Worked precedent named: TASK-015 Gate 1 decision and TASK-019 (mirror); EPIC-009 AC#1 (paths). Verifiable: both rules are stated with their precedents; the Shannon-self qualifier is present.

- **AC#4 — Audit log named in § Supervisor Report Files** *(item 5, Guide half)*. § Git Workflow → Supervisor Report Files names the PostToolUse audit log alongside reports and the state file, with its location and committed status (not committed: operational telemetry). Worked precedent named: EPIC-009 AC#5, TASK-017. Verifiable: the bullet exists and names both location and status.

- **AC#5 — Verification substrings land in plain prose** *(item 6)*. § Code Style → Patterns to Follow gains the convention that text an AC will verify by substring lands without Markdown formatting interposed between its characters. Worked precedent named: TASK-009 Step 7. Verifiable: the convention exists and names its precedent.

- **AC#6 — Placeholder syntax by who fills the slot** *(item 7)*. § Code Style → Template Structure states the placeholder rule for machine-filled templates: either it sanctions `{{SLOT}}` for slots a pipeline fills and keeps `[Placeholder]` for slots a person fills, or the supervisor templates converge on square brackets. The implementing Task's Gate 1 records which, as a directing-party decision. Worked precedent named: the supervisor templates and TASK-028 Gate 1. Verifiable: the Guide states one rule that the shipped templates under `shannon/skills/` all satisfy.

- **AC#7 — Precedent is a stated requirement** *(item 8)*. The Guide states, once, that a convention added after bootstrapping names the worked precedent that produced it, and that bootstrapping conventions are exempt per `conceptual_design.md` § Business Rules → *Retrospective Features*. Verifiable: the statement exists at the head of § Code Style → Patterns to Follow (or wherever the implementing Task judges it governs every section), and every post-bootstrapping convention in the Guide satisfies it, including those this Epic adds.

- **AC#8 — Amendments ride the work items, and are additive**. Each amendment lands inside its implementing Task's own gates per `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*, with no separate `/document-review`. Each is classified additive per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics*, except AC#1, which retracts an approved claim ("no units") and is therefore checked against the substantive-revision rule by its Task at Gate 1. `development_guide.md` § Version History names the Task and states the route for each entry. Verifiable: one Version History entry per amending Task, each naming its route and classification.

- **AC#9 — Scope guard**. No work-item template, index template, command, or `technical_design.md` section is modified by this Epic. Skill files under `shannon/skills/` are touched only where AC#6 converges supervisor templates or where a convention needs a step-adjoining skill prompt (the EPIC-008 two-touch precedent), and each such touch is named in its Task's Plan.

- **AC#10 — Scratchpad and Feature bookkeeping**. At this Epic's Gate 3, the scratchpad items addressed here move from § Items to § Processed with an EPIC-012 pointer; FEAT-008 Ideal State bullets 1 and 5 are re-marked *met*, Metadata → Remaining is rewritten, and § Plan → *Known forward work* drops the items this Epic delivered.

### Context

- **Parent Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md) — this Epic delivers Ideal State bullets 1 and 5 and the six items under § Plan → *Known forward work*
- **Sibling Epic** (precedent): [EPIC-008 — Development Conventions Surfaced Through Dogfooding](EPIC-008-development-conventions-from-dogfooding.md) — same shape, earlier harvest
- **Vision**: § Core Principles #4 *Adaptive Coherence* ("Knowledge accumulates so the same investigation never happens twice")
- **Conceptual Design**: § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*; *Retrospective Features*; *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*; § Re-reviewing an APPROVED Mandated Document → *Status semantics*
- **Development Guide**: § Testing Strategy; § Code Style → Template Structure and Patterns to Follow; § Git Workflow → Supervisor Report Files; § Version History
- **Source items**: `docs/scratchpad.md` § Items — the eight entries named in the Overview

---

## Plan

*Prepared during FEAT-008 planning, not yet reviewed. Surfaces at `/epic-plan EPIC-012` (Gate 2).*

### Approach

One Task per convention, each amending `development_guide.md` inside its own gates, with two exceptions where items share a home: the two skill-packaging rules (items 3 and 4) land together, and the precedent requirement (item 8) lands last because it is checked against every convention, including the ones this Epic adds.

Ordering:

1. The Testing Strategy Task goes first. It is the only item that makes a FEAT-008 claim false today, and it is the one that may be a substantive revision rather than an additive one.
2. The cross-Task editing-order Task goes second, because every later Task in this Epic edits the same source-of-truth body its predecessor just edited. The Epic is a live instance of the case the convention covers, so the convention should be in place before the chain runs.
3. The packaging, audit-log, plain-prose and placeholder Tasks follow in any order.
4. The precedent-requirement Task goes last and doubles as the Epic's sweep: it checks every post-bootstrapping convention for a named precedent.

Each Task bumps `development_guide.md` by one minor version (v1.5 → v1.6 and onward) and writes its own Version History entry, so the record of who amended what stays per-Task. If the directing party prefers one bump for the whole Epic, the Tasks can stage their entries and the final Task folds them into one; the choice is made at this Epic's Gate 2.

### Tasks

*Task candidates, with descriptive titles from the outset. IDs are allocated when the Tasks are created at `/epic-plan EPIC-012`.*

1. **Testing Strategy covers shipped executables** — AC#1
2. **Cross-Task editing order** — AC#2
3. **Skill packaging conventions: shipping-source mirror and project-relative paths** — AC#3
4. **Audit log named in Supervisor Report Files** — AC#4
5. **Verification substrings land in plain prose** — AC#5
6. **Placeholder syntax for machine-filled templates** — AC#6 (carries a directing-party decision at its Gate 1)
7. **Precedent named for every post-bootstrapping convention** — AC#7, plus the AC#10 bookkeeping sweep

### Dependencies

**Depends on**: `development_guide.md` v1.5 APPROVED; `conceptual_design.md` v1.8 (the authority rule that lets these Tasks amend the Guide).

**Depended on by**: [EPIC-016](EPIC-016-supervisor-deployment-via-shannon-setup.md) (Supervisor Deployment via /shannon-setup), which installs what AC#3 and AC#4 codify. EPIC-011 (Autonomic Invocation) amends `development_guide.md` too (its AC#5 scheduler section). Whichever Epic implements second re-reads the Guide's landed state first, per AC#2.

### Risks

- **AC#1 is a retraction, not an addition.** Removing "Shannon has no units" contradicts an approved claim. *Mitigation*: the Task decides at its Gate 1 whether the change is additive (scoping the sentence to templates and prompts) or substantive (retracting it), and follows `conceptual_design.md` § Re-reviewing → *Status semantics* for whichever it is.
- **Seven sequential edits to one document.** Version-number collisions and stale reads are likely if Tasks overlap. *Mitigation*: Tasks run one at a time in the order above; AC#2 lands early so the rest follow it.
- **Convention creep.** Eight conventions in one pass could bloat § Code Style → Patterns to Follow. *Mitigation*: each Task states its rule in the fewest words that carry it, and the final Task checks the section still reads as a list of rules rather than a log.
- **Placeholder decision stalls.** AC#6 needs a directing-party call. *Mitigation*: the Task carries a recommendation (sanction `{{SLOT}}` for machine-filled slots, which matches the shipped templates and needs no template edit) and can run late in the order.

---

## Implementation Notes

*Filled during implementation.*

### Cross-Task Decisions

- *None yet.*

### Documents Updated

- *None yet.*

---

## Review

*Filled during review (Gate 3).*

### Verification

- [ ] All tasks APPROVED
- [ ] Epic acceptance criteria met
- [ ] Parent feature updated with epic outcome
- [ ] Relevant documents updated and approved

### Review Notes

- *None yet.*

---

## Activity Log

- **2026-10-18** — DRAFT: Epic created during `/feature-plan FEAT-008` (Gate 2, approved 2026-10-19) via Cascading Preparation. Prepared elaboration draft (Requirements) and prepared plan draft (Plan) stashed, marked "Prepared during FEAT-008 planning, not yet reviewed". Source: the six items in FEAT-008 § Plan → *Known forward work*, plus the `{{SLOT}}` placeholder item (surfaced at TASK-028 Gate 1) and FEAT-008 Ideal State bullet 5.
