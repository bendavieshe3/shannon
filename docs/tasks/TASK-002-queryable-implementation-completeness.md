# TASK-002: Queryable Implementation Completeness for Features

## Metadata

- **Status**: PLANNED
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #templates #work-items #features
- **Created**: 2026-05-19
- **Updated**: 2026-05-21 (planned)

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

### Approach

The work splits across three files in one cohesive change set: the feature template (`shannon/skills/work-items/templates/feature.md`), the feature index (`docs/features/feature_index.md` Notes section), and the work-items skill (`shannon/skills/work-items/skill.md`). Ordering is template → index → skill: the template defines the *shape* of the Partial sub-block (AC#1–3) which the index Notes section then references when canonising the `(Partial)` suffix (AC#4), which the skill in turn enforces as a derived rule on `Initial Implementation` changes (AC#5). Editing in this order means each later edit can cite the earlier one as already-canonical; reversing the order would force forward references to text that doesn't yet exist.

Each file edit is small (under ~20 lines) and locally verifiable. All three edits stage together so the pre-commit Markdown dry-run (`development_guide.md` § Pre-Commit Checklist) sees one consistent picture. Per the same guide's Commit Cadence rule, the commit lands after Gate 3 review, not mid-implementation.

### Steps

1. **Template edit — Metadata block** (`shannon/skills/work-items/templates/feature.md`, immediately after line 9's `Initial Implementation` bullet, before the `Created` bullet): insert an HTML-commented stub for the Partial sub-block, e.g. `<!-- If Initial Implementation is Partial, emit a sub-block here: **Met:** <bullets>, **Remaining:** <bullets>. Summarises the headline; distinct from inline *(met)* / *(partly met)* annotations on Ideal State bullets. -->`. Covers AC#1 (canonical location: directly beneath line 9), AC#2 (names the bullet structure and disambiguates from inline annotations), AC#3 (commented stub for emission discoverability). Verify by re-reading lines 5–17 to confirm the stub sits between `Initial Implementation` and the existing Retrospective Features callout without breaking the metadata list.

2. **Index edit — Notes section** (`docs/features/feature_index.md`, lines 13–21 Notes block): append a new sub-bullet under Notes documenting that `(Partial)` is a canonical trailing suffix on the Feature Name token, present iff the Feature's body carries `Initial Implementation: Partial`, and that the suffix is maintained by the `work-items` skill (forward-reference to the skill change in step 3). Covers AC#4 (explicit Notes-section anchor) and the index-side half of AC#5. Use a dash bullet matching the existing Notes formatting (Development Guide § Markdown — dash bullets, British spelling). Verify by re-reading the Notes section to confirm the new bullet sits coherently with the existing **Format**/**Status**/**Activity**/**When to update** bullets.

3. **Skill edit — Initial Implementation enforcement** (`shannon/skills/work-items/skill.md`): add a short sub-section (or bullet under an existing process step) stating that on any Feature `Initial Implementation` field change (during `create`, `elaborate`, or `implement`), the skill must update `docs/features/feature_index.md` to add or remove the `(Partial)` trailing suffix on that Feature's entry to keep index and body consistent. Land it adjacent to existing index-update language — most naturally as a new note under § Process: Create step 7 (Update Index) and again referenced under § Process: Elaborate step 4 (where Initial Implementation may be set from DRAFT) — or, more compactly, as a new bullet under § Failure Modes' index-out-of-sync entry. Choose the placement that reads most naturally on re-read; record the choice in Implementation Notes. Covers AC#5 (skill enforcement) and feeds AC#8 (Gate 3 two-sided grep consistency).

4. **Cross-file consistency pass** (no edit, verification only): re-read the three edited regions in sequence to confirm the template stub language, the index Notes language, and the skill enforcement language use consistent terminology — specifically the strings `Initial Implementation`, `Partial`, and `(Partial)` should appear with identical capitalisation and punctuation across all three files. Confirm AC#6 (scope boundary): `epic.md`, `task.md`, `spike.md`, `epic_index.md`, `task_index.md`, `spike_index.md` remain untouched. Confirm AC#7 (mechanical queryability) by mentally executing `grep "(Partial)" docs/features/feature_index.md` against the post-edit Notes text and the existing line 5 FEAT-003 entry. AC#9 (proportionality) is verified by inspection: no new statuses, no schema migrations beyond the three targeted files.

### Dependencies

- **None blocking inside EPIC-006** — proceeds in parallel with TASK-001 (different files, no overlap).
- **Pre-existing FEAT-006 index inconsistency** is acknowledged but explicitly out of scope per the Overview's scope boundary; the dogfood pass (applying the new affordance to FEAT-003 and FEAT-006 and fixing FEAT-006's missing `(Partial)` suffix) belongs to EPIC-006's forward-declared follow-up Task. This Task ships the *mechanism*, not the *application*.

### Risks

- **Over-formalisation** — the goal is at-a-glance visibility, not a new substatus system. The structured sub-block + canonised index annotation + skill enforcement is the proportionate answer; resist adding schema, validation, or a separate query command.
- **Template/index/skill drift** — three files changing together. Mitigation: edit in the stated order, then run the cross-file consistency pass (step 4) before committing.
- **Skill placement ambiguity** (AC#5) — the work-items skill currently has no language about `Initial Implementation` at all, so the new enforcement language could land in several places (§ Process: Create, § Process: Elaborate, § Failure Modes). Mitigation: choose at implementation time and record the placement choice in Implementation Notes so reviewers can sanity-check at Gate 3.
- **Inline annotation confusion** — FEAT-003 already uses inline `*(met)*` / `*(partly met)*` annotations on Ideal State bullets. AC#2 requires the new sub-block to be visibly distinct. Mitigation: the stub's comment text explicitly names both patterns and their non-overlap.

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-21** — PLANNED via Gate 2. Plan section populated: template → index → skill ordering, each later edit citing the earlier as already-canonical (avoids forward references). Four ordered steps across three files: (1) feature template gets HTML-commented stub for Partial sub-block beneath line 9; (2) feature_index Notes section appends bullet documenting `(Partial)` as canonical with the "iff body has Initial Implementation: Partial" rule; (3) work-items skill gains enforcement language with placement choice recorded in Implementation Notes; (4) cross-file consistency pass with mental grep verification and scope-boundary check. Four risks captured with mitigations tied to numbered steps (over-formalisation, three-file drift, skill placement ambiguity, inline annotation confusion). Each step explicitly annotated with the AC(s) it covers; no Plan gaps against the 9 Acceptance Criteria. Subagent verdict: ready for Gate 2 approval. Approved by directing party 2026-05-21.
- **2026-05-20** — ELABORATED via Gate 1. Elaboration verified the pre-stashed Requirements against current upstream state and the actual implementation surface (`feature.md` template, `feature_index.md` Notes section, FEAT-003's existing inline `*(met)*` annotation precedent). Real upstream-data finding surfaced: FEAT-006 has `Initial Implementation: Partial` in its body but its index entry lacks the `(Partial)` suffix — pre-existing inconsistency the dogfood follow-up Task will absorb. Refinements applied:
  - 5 new Acceptance Criteria — sub-block bullet structure distinct from inline annotations; commented stub in template for emission discoverability; skill-enforced index suffix (closes the drift mode that produced FEAT-006's missing suffix); cross-type scope boundary as a verifiable AC; Gate 3 two-sided grep verification (index ↔ body consistency)
  - 3 sharpenings — single canonical sub-block location (was "Metadata or directly beneath"); explicit Notes-section anchor (lines 13-21); proportionality AC trimmed of parenthetical (moved to Overview)
  - Context: added Files-explicitly-NOT-in-scope bullet naming epic.md / task.md / spike.md with rationale
  - Overview: scope-boundary paragraph added — Task delivers template + index changes only; live application to FEAT-003 / FEAT-006 belongs to the forward-declared follow-up Task
  AC count: 4 → 9 (5 new + 3 sharpened + 1 unchanged). Scope unchanged; rigour increased. No drift against upstream. Verdict from elaboration verification: ready with minor refinements; refinements applied.
- **2026-05-19** — DRAFT: Task created via EPIC-006's planning (option-b cascading pattern). Requirements section pre-stashed; will surface when `/task-elaborate TASK-002` is invoked. Plan section deferred to `/task-plan`.
