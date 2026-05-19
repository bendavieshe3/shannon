# TASK-002: Queryable Implementation Completeness for Features

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #templates #work-items #features
- **Created**: 2026-05-19
- **Updated**: 2026-05-19

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-006 § Plan (Gate 2). Not yet reviewed at Gate 1. Surfaces when `/task-elaborate TASK-002` is invoked.*

### Overview

Make Feature implementation completeness visible at the metadata level without an Activity Log dive. Features currently carry an `Initial Implementation: Built through Shannon | Retrospective | Partial — see Activity Log` field, but the "Partial" details are buried. Extend the feature template with a structured Partial-completeness sub-block (what is met, what is remaining) emitted only when `Initial Implementation` is Partial. Canonise the existing informal `(Partial)` suffix in `docs/features/feature_index.md` by documenting it in the index's Notes section.

The goal is at-a-glance visibility and mechanical queryability (`grep "(Partial)" feature_index.md` returns all partial Features; the Feature file's sub-block parses by humans and AI without deep reading). The affordance is deliberately scoped to Features — other work-item types (Epic, Task, Spike) capture their completeness through status; Features are the only persistent capability type where Partial-ness lives in the gap between Ideal State and current implementation, independent of lifecycle position.

### Acceptance Criteria

- [ ] `shannon/skills/work-items/templates/feature.md` carries a structured Partial-completeness sub-field under Metadata or directly beneath `Initial Implementation` (line 9); the sub-field names met vs remaining items; it is emitted only when `Initial Implementation` is Partial
- [ ] `docs/features/feature_index.md` Notes block documents the `(Partial)` trailing suffix as canonical (currently informal — only FEAT-003 carries it)
- [ ] Affordance is mechanically queryable: `grep "(Partial)" docs/features/feature_index.md` returns all partial Features; the Feature file's Partial sub-block parses by humans and AI at a glance, without reading the Activity Log
- [ ] Affordance is proportionate — no new substatus, no schema migration of existing approved Features beyond the targeted dogfood application (the dogfood pass to FEAT-003 and FEAT-006 happens in the follow-up Task forward-declared in EPIC-006, not this Task)

### Context

- **Parent Epic**: [EPIC-006 — Work Item Lifecycle Maturation](../epics/EPIC-006-work-item-lifecycle-maturation.md), specifically the F2 Acceptance Criteria group (bullets 1-3; bullet 4 — applying the affordance to FEAT-003 and FEAT-006 — sits in the forward-declared follow-up Task)
- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md), aspirational Ideal State bullet 2 (added 2026-05-19)
- **Files in scope**:
  - `shannon/skills/work-items/templates/feature.md` — extend Metadata + Notes blocks; `Initial Implementation` field at line 9 is the canonical anchor
  - `docs/features/feature_index.md` — extend Notes section to formalise the `(Partial)` annotation; the existing line 5 entry for FEAT-003 already uses the convention informally
- **Scope boundary**: Tasks, Epics, Spikes are out of scope — their completeness is captured by status, not by a Feature-style Partial field
- **Related scratchpad item (out of scope, captured for awareness)**: C4 (orphan task business rule) — if a future evolution extends a Partial-style affordance to Tasks, C4 may surface. Not relevant to this Task

---

## Plan

*To be filled during `/task-plan TASK-002` (Gate 2).*

### Approach

*Filled during planning.*

### Steps

*Filled during planning.*

### Dependencies

*Filled during planning. Anticipated: none inside EPIC-006 — proceeds in parallel with TASK-001.*

### Risks

*Filled during planning. Anticipated:*

- Over-formalisation — the goal is at-a-glance visibility, not a new substatus system. A structured sub-field + canonised index annotation is likely the proportionate answer
- Template/index drift if `feature.md` and `feature_index.md` are edited separately — keep changes together in one review surface

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-19** — DRAFT: Task created via EPIC-006's planning (option-b cascading pattern). Requirements section pre-stashed; will surface when `/task-elaborate TASK-002` is invoked. Plan section deferred to `/task-plan`.
