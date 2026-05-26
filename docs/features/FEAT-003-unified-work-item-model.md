# FEAT-003: Unified Work Item Model

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Unified Work Item Model"
- **Initial Implementation**: Partial — the unified model itself is retrospective (templates, skill, commands predate this Feature). Of four aspirational criteria (three added 2026-05-19, one added 2026-05-24): three now met (re-elaboration workflow via EPIC-006 / TASK-001; queryable completeness via EPIC-006 / TASK-002; upstream lessons-into-framework-rules via EPIC-007 / TASK-008 doc amendments + TASK-009 skill prompts, APPROVED 2026-05-27), one remaining (framework-version absorption). See Met / Remaining below.
  - **Met:** The retrospective unified model — four work-item types on one status lifecycle, with shared templates, skill, and commands — plus three aspirational criteria: the *Re-elaborating a Work Item* workflow (EPIC-006 / TASK-001) and queryable implementation completeness (EPIC-006 / TASK-002), and upstream lessons-into-framework-rules (EPIC-007 / TASK-008 doc amendments at `conceptual_design.md` v1.6 + TASK-009 skill prompts at `work-items/skill.md`, APPROVED 2026-05-27).
  - **Remaining:** One aspirational criterion — framework-version absorption: framework changes (new attributes, workflows, status-model evolution) absorbed by existing work-item files via canonical re-elaboration, so adopters never recreate work items to accommodate framework evolution.
- **Created**: 2026-05-18
- **Updated**: 2026-05-24 (re-elaborated)

---

## Requirements

### Overview

Shannon represents all work — features, epics, tasks, and spikes — using a single status lifecycle and a single file structure. A directing party who learns the task lifecycle knows the spike lifecycle; templates, skills, and commands all enforce the uniformity. The model deliberately excludes per-type lifecycle variants because variance is the enemy of context predictability.

This is the second foundational capability: it makes work tracking learnable in one pass. Without it, the framework would have four overlapping mental models instead of one.

### Ideal State

*Met aspirations (initial retrospective scope):*

- Four work item types — Feature, Epic, Task, Spike — share one status sequence (`DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`) *(met)*
- Every work item file has the same shape: Metadata, Requirements, Plan, Activity Log (plus type-specific sections) *(met)*
- Every work item type supports the same five lifecycle verbs (`create`, `elaborate`, `plan`, `implement`, `review`) *(met)*
- The hierarchy (Feature → Epic → Task; Spike standalone) is enforced by templates and skills *(met)*
- Status transitions are made through the `work-items` skill rather than direct file edits *(met)*
- Indexes (`feature_index.md`, `epic_index.md`, `task_index.md`, `spike_index.md`) reflect lifecycle state for navigation *(met)*
- Tasks may be orphans (no Epic) when the work has no obvious parent *(partly met — affordance exists, no business rule sanctions it; captured as scratchpad item C4)*

*Aspirational criteria added through ongoing re-elaborations following Vision v2.3 § Adaptive Coherence. Bullets 1 and 2 delivered by EPIC-006 (F1, F2); bullet 3 (framework-version absorption) outstanding; bullet 4 (upstream lessons-into-framework-rules, added 2026-05-24) addressed by EPIC-007:*

- Work items can be re-elaborated when upstream artefacts evolve — a canonical workflow describes the trigger and steps, analogous to the *Re-reviewing an APPROVED Mandated Document* workflow for documents *(met — delivered by EPIC-006 / TASK-001)*
- Implementation completeness of a work item is queryable at the metadata level: a Feature's "Initial Implementation" field (Built through Shannon / Retrospective / Partial) is surfaced visibly rather than buried in the Activity Log, so adopters can identify partially-built capabilities at a glance *(met — delivered by EPIC-006 / TASK-002)*
- Framework changes affecting work items (new attributes, new workflows, status model evolution) are absorbed by existing work-item files via canonical re-elaboration; adopters never have to recreate work items from scratch to accommodate framework evolution *(not yet met — depends on the work-item re-elaboration workflow above)*
- Work-item conventions accumulated through framework use — re-elaboration mechanics, AC writing patterns, naming discipline — are promoted into the mandated documents (primarily `conceptual_design`) and the relevant skills via the canonical work-item workflow. The upstream direction of *Adaptive Coherence*: lessons flow back into framework rules rather than being lost or re-derived. *(met — delivered by EPIC-007 / TASK-008 doc amendments at `conceptual_design.md` § Re-elaborating + § Domain Model + § Business Rules + TASK-009 skill prompts at `work-items/skill.md` § Process: Plan; APPROVED 2026-05-27)*

### User Stories

#### Learning the Model Once

**As a** directing party,
**I want** the same lifecycle to apply to every kind of work item,
**So that** I learn the framework once instead of four times.

#### Tracking Mixed Work

**As a** directing party,
**I want** features, epics, tasks, and spikes to coexist in one navigable structure,
**So that** strategic and atomic work are both visible without separate systems.

#### Promoting Ad-Hoc Work

**As a** directing party,
**I want** orphan tasks for one-off fixes,
**So that** I'm not forced to invent an Epic for trivial work.

### Context

- **Vision**: § Key Features ("Unified Work Item Model")
- **Conceptual Design**: *Work Item*, *Feature*, *Epic*, *Task*, *Spike* entities; *Unified Status Lifecycle* and *Spike Output Is Knowledge* business rules; all three Key Workflows
- **Technical Design**: § Data Model (file/path mapping per type), § API Design (lifecycle verbs)
- **Project files**: `shannon/skills/work-items/templates/*` (feature.md, epic.md, task.md, spike.md and their indexes), `shannon/skills/work-items/skill.md`, 20 `[type]-[verb]` commands under `shannon/commands/`

---

## Plan

### Epics

- [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md) — APPROVED — Work Item Lifecycle Maturation: Re-elaboration + Queryable Completeness (closed scratchpad items F1 and F2; fulfilled aspirational Ideal State bullets 1 and 2 added 2026-05-19; bullet 3, framework-version absorption, remains open)
- [EPIC-007](../epics/EPIC-007-work-item-conventions-from-dogfooding.md) — APPROVED — Work-Item Conventions Surfaced Through Dogfooding (promoted four work-item-workflow clarifications — commit-hash timing in re-elaboration, bundled re-elaboration, no opaque plan-letter labels, AC scope-guard convention — into ratified rules in `conceptual_design` v1.6 + `work-items` skill; fulfilled aspirational Ideal State bullet 4; sibling to EPIC-008 under FEAT-008 covering the dev-discipline half)

*Candidate future Epic: name an explicit business rule for orphan tasks (currently captured as scratchpad item C4).*

### Dependencies

**Depends on**: FEAT-002 (Mandated Project Documentation) — work items consume mandated documents as context

**Depended on by**: FEAT-004 (Three Quality Gates) — the gates are tied to lifecycle transitions; FEAT-005 (Knowledge Base) — spike output produces knowledge notes; FEAT-006 (Multi-Party Supervision) — supervision happens *at* lifecycle transitions

### Risks

- **Model rigidity** — Forcing all four types into one lifecycle may pinch when a future work item type (e.g. "retrospective", "incident") doesn't fit. Mitigation: the model is documented in conceptual_design, not load-bearing in code, so it can be revised with a doc review pass

---

## Success Metrics

- **Vocabulary uniformity** — All four work item types use the same status names consistently across files, indexes, and AI prose (no `*-PENDING` style drift)
- **Verb pattern adoption** — Every type has the five verbs implemented as commands
- **Index accuracy** — Indexes reflect current status without manual sync drift

---

## Activity Log

- **2026-05-24** — Re-elaborated (additive). **Trigger**: downstream gap — EPIC-007 elaboration (in flight 2026-05-24; not yet committed) surfaced that no Feature's Ideal State explicitly anchored "work-item conventions accumulated through framework use are promoted into the mandated documents." Vision § Adaptive Coherence covered it at principle level but no Feature instantiated it; per *Responsible Promotion*, EPIC-007 could not claim FEAT-003 as parent without an explicit anchor. **Change**: added fourth aspirational Ideal State bullet (upstream lessons-into-framework-rules — addressed by EPIC-007); intro updated from "two delivered, one outstanding" to four-bullet structure; `Initial Implementation` line and sub-block `Remaining` updated to reflect 4-bullet structure (2 met, 2 remaining). The directing party also identified an architectural split: dev-discipline learnings move to new FEAT-008 (created 2026-05-24); FEAT-003's bullet 4 specifically anchors the work-item-conventions half. **Additive** — no previously-approved claim contradicted; FEAT-003 stays ELABORATED. **Commit hash**: trigger is in-flight EPIC-007 (no upstream commit yet); referenced by Epic ID — exactly the case EPIC-007's AC#1 will codify (an honest dogfood: this entry is itself an instance of the commit-hash-timing case the upcoming convention names).
- **2026-05-22** — Re-elaborated (additive). **Trigger**: framework evolution — EPIC-006 (via TASK-001 and TASK-002, commit `09844df`) delivered the *Re-elaborating a Work Item* workflow and the queryable Partial-completeness affordance — the aspirations this Feature named on 2026-05-19. **Change**: added the `**Met:** / **Remaining:**` sub-block beneath the `Initial Implementation` line; updated the `Initial Implementation` line and Ideal State aspirational bullets 1 (re-elaboration workflow) and 2 (queryable completeness) to `*(met)*`; bullet 3 (framework-version absorption) remains the sole open aspiration, so FEAT-003 stays `Partial`. Applied via TASK-003 — this Task re-elaborates its own parent Feature, the deliberate recursion EPIC-006 was created to close. Additive — no previously-approved claim contradicted; status stays ELABORATED.
- **2026-05-19** — Re-elaborated following Vision v2.3 § Adaptive Coherence (commit `7c117d4`) and conceptual_design v1.4 § Responsible Promotion (commit `0411ea8`). Three aspirational Ideal State criteria added — work-item re-elaboration workflow (F1), queryable implementation completeness (F2), and framework-version absorption — that the existing capability does not yet fulfil. Initial Implementation field changed from "Retrospective" to "Partial" to reflect that aspiration now exceeds current implementation. This re-elaboration was the upstream prerequisite for creating an Epic to address F1 + F2, per the Responsible Promotion workflow.
- **2026-05-18** — ELABORATED: Feature created retrospectively. Work item types, lifecycle, templates, skill, and 20 commands were built during the Shannon v4 refactor (commit `6852b29`). This Feature codifies the capability for future evolution.
