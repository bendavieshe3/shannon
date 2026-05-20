# TASK-002: Queryable Implementation Completeness for Features

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #templates #work-items #features
- **Created**: 2026-05-19
- **Updated**: 2026-05-20 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-006 § Plan (Gate 2). Not yet reviewed at Gate 1. Surfaces when `/task-elaborate TASK-002` is invoked.*

### Overview

Make Feature implementation completeness visible at the metadata level without an Activity Log dive. Features currently carry an `Initial Implementation: Built through Shannon | Retrospective | Partial — see Activity Log` field, but the "Partial" details are buried. Extend the feature template with a structured Partial-completeness sub-block (what is met, what is remaining) emitted only when `Initial Implementation` is Partial. Canonise the existing informal `(Partial)` suffix in `docs/features/feature_index.md` by documenting it in the index's Notes section.

The goal is at-a-glance visibility and mechanical queryability (`grep "(Partial)" feature_index.md` returns all partial Features; the Feature file's sub-block parses by humans and AI without deep reading). The affordance is deliberately scoped to Features — other work-item types (Epic, Task, Spike) capture their completeness through status; Features are the only persistent capability type where Partial-ness lives in the gap between Ideal State and current implementation, independent of lifecycle position.

**Scope boundary**: This Task delivers the template + index changes (template gains the structured sub-block as a commented stub; index Notes section canonises the `(Partial)` annotation rule). Application of the new affordance to FEAT-003 and FEAT-006 on real data — and fixing the pre-existing inconsistency where FEAT-006's index entry lacks `(Partial)` despite its body carrying `Initial Implementation: Partial` — belongs to EPIC-006's forward-declared follow-up Task, not this one.

### Acceptance Criteria

- [ ] `shannon/skills/work-items/templates/feature.md` carries a structured Partial-completeness sub-field **directly beneath the `Initial Implementation` line inside the Metadata block** (anchor: template line 9); emitted only when `Initial Implementation` is Partial (sharpened — single canonical location)
- [ ] The sub-block uses an explicit `**Met:**` / `**Remaining:**` bullet structure, **distinct from** the inline `*(met)*` / `*(partly met)*` annotations that may decorate Ideal State bullets; the two patterns coexist (sub-block summarises `Initial Implementation` headline; inline annotations decorate per-aspiration Ideal State items) (new — disambiguates from FEAT-003's existing pattern)
- [ ] The `feature.md` template carries a commented stub for the sub-block (e.g. `<!-- Partial sub-block: emit only if Initial Implementation is Partial -->`) at the canonical location, so adopters discover the affordance even when their Feature is not Partial (new — emission discoverability)
- [ ] `docs/features/feature_index.md` Notes section (lines 13-21) documents the `(Partial)` trailing suffix as canonical, including the rule that triggers its presence (sharpened — names the Notes section explicitly)
- [ ] Applying or removing the `(Partial)` suffix in `feature_index.md` is a `work-items` skill responsibility on `Initial Implementation` field changes — not a manual convention (new — closes the drift mode that produced FEAT-006's missing suffix)
- [ ] Scope boundary is explicit: only `feature.md` and `feature_index.md` are modified; `epic.md`, `task.md`, `spike.md` templates and their indexes are untouched because Epic/Task/Spike completeness is captured by status, not by an implementation-completeness field (new — verifiable scope-creep guard)
- [ ] Affordance is mechanically queryable: `grep "(Partial)" docs/features/feature_index.md` returns all partial Features; the Feature file's Partial sub-block parses by humans and AI at a glance, without reading the Activity Log
- [ ] Gate 3 verification: `grep "(Partial)" docs/features/feature_index.md` and `grep -l "Initial Implementation: Partial" docs/features/FEAT-*.md` return consistent sets (modulo this Task's deferral of the dogfood pass — pre-existing FEAT-006 inconsistency will be fixed by EPIC-006's forward-declared follow-up Task) (new — testable queryability)
- [ ] Affordance is proportionate — no new substatus, no schema migration of existing approved Features beyond the targeted dogfood application (trimmed — parenthetical moved to Overview)

### Context

- **Parent Epic**: [EPIC-006 — Work Item Lifecycle Maturation](../epics/EPIC-006-work-item-lifecycle-maturation.md), specifically the F2 Acceptance Criteria group (bullets 1-3; bullet 4 — applying the affordance to FEAT-003 and FEAT-006 — sits in the forward-declared follow-up Task)
- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md), aspirational Ideal State bullet 2 (added 2026-05-19)
- **Files in scope**:
  - `shannon/skills/work-items/templates/feature.md` — extend Metadata + Notes blocks; `Initial Implementation` field at line 9 is the canonical anchor
  - `docs/features/feature_index.md` — extend Notes section to formalise the `(Partial)` annotation; the existing line 5 entry for FEAT-003 already uses the convention informally
- **Files explicitly NOT in scope** (cross-type scope boundary): `shannon/skills/work-items/templates/epic.md`, `task.md`, `spike.md` and the corresponding indexes are untouched. Rationale: only Features are persistent capability artefacts where Partial-ness lives in the gap between Ideal State and current implementation independent of lifecycle position; Epic/Task/Spike completeness is captured by status itself
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

- **2026-05-20** — ELABORATED via Gate 1. Elaboration verified the pre-stashed Requirements against current upstream state and the actual implementation surface (`feature.md` template, `feature_index.md` Notes section, FEAT-003's existing inline `*(met)*` annotation precedent). Real upstream-data finding surfaced: FEAT-006 has `Initial Implementation: Partial` in its body but its index entry lacks the `(Partial)` suffix — pre-existing inconsistency the dogfood follow-up Task will absorb. Refinements applied:
  - 5 new Acceptance Criteria — sub-block bullet structure distinct from inline annotations; commented stub in template for emission discoverability; skill-enforced index suffix (closes the drift mode that produced FEAT-006's missing suffix); cross-type scope boundary as a verifiable AC; Gate 3 two-sided grep verification (index ↔ body consistency)
  - 3 sharpenings — single canonical sub-block location (was "Metadata or directly beneath"); explicit Notes-section anchor (lines 13-21); proportionality AC trimmed of parenthetical (moved to Overview)
  - Context: added Files-explicitly-NOT-in-scope bullet naming epic.md / task.md / spike.md with rationale
  - Overview: scope-boundary paragraph added — Task delivers template + index changes only; live application to FEAT-003 / FEAT-006 belongs to the forward-declared follow-up Task
  AC count: 4 → 9 (5 new + 3 sharpened + 1 unchanged). Scope unchanged; rigour increased. No drift against upstream. Verdict from elaboration verification: ready with minor refinements; refinements applied.
- **2026-05-19** — DRAFT: Task created via EPIC-006's planning (option-b cascading pattern). Requirements section pre-stashed; will surface when `/task-elaborate TASK-002` is invoked. Plan section deferred to `/task-plan`.
