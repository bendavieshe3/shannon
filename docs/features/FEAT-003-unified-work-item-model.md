# FEAT-003: Unified Work Item Model

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Unified Work Item Model"
- **Initial Implementation**: Retrospective (predates this Feature's creation)
- **Created**: 2026-05-18
- **Updated**: 2026-05-18

---

## Requirements

### Overview

Shannon represents all work — features, epics, tasks, and spikes — using a single status lifecycle and a single file structure. A directing party who learns the task lifecycle knows the spike lifecycle; templates, skills, and commands all enforce the uniformity. The model deliberately excludes per-type lifecycle variants because variance is the enemy of context predictability.

This is the second foundational capability: it makes work tracking learnable in one pass. Without it, the framework would have four overlapping mental models instead of one.

### Ideal State

- Four work item types — Feature, Epic, Task, Spike — share one status sequence (`DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`)
- Every work item file has the same shape: Metadata, Requirements, Plan, Activity Log (plus type-specific sections)
- Every work item type supports the same five lifecycle verbs (`create`, `elaborate`, `plan`, `implement`, `review`)
- The hierarchy (Feature → Epic → Task; Spike standalone) is enforced by templates and skills
- Status transitions are made through the `work-items` skill rather than direct file edits
- Indexes (`feature_index.md`, `epic_index.md`, `task_index.md`, `spike_index.md`) reflect lifecycle state for navigation
- Tasks may be orphans (no Epic) when the work has no obvious parent

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

*None yet — the model is established. Candidate future Epic: name an explicit business rule for orphan tasks (currently captured as scratchpad item C4).*

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

- **2026-05-18** — ELABORATED: Feature created retrospectively. Work item types, lifecycle, templates, skill, and 20 commands were built during the Shannon v4 refactor (commit `6852b29`). This Feature codifies the capability for future evolution.
