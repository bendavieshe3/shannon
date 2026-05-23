# EPIC-007: Work-Item Conventions Surfaced Through Dogfooding

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Created**: 2026-05-24
- **Updated**: 2026-05-24 (re-scoped)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Initial intent captured at `/epic-create`; elaborated at `/epic-elaborate EPIC-007` then re-scoped 2026-05-24 to the work-item-conventions half of the dogfooding harvest (see Activity Log) — sibling [EPIC-008](EPIC-008-development-conventions-from-dogfooding.md) covers the dev-discipline half.*

### Overview

This Epic promotes the **work-item-workflow** half of the EPIC-005 / EPIC-006 dogfooding harvest into ratified rules in `conceptual_design.md` (with companion soft prompts in the `work-items` skill where the convention meets work-item planning). Four work-item-specific clarifications surfaced during use need promotion:

1. **Commit-hash timing in re-elaboration Activity Log entries** — a re-elaboration entry cannot cite its own work item's commit hash because the commit lands after Gate 3; cite the upstream hash and reference the work item by ID. *(→ clarify `conceptual_design` § Re-elaborating a Work Item step 6's existing "where applicable" phrase; from TASK-003 Plan § Approach + Implementation Notes.)*
2. **Bundled re-elaboration** — multiple Feature re-elaborations run inside one Task's implementation, with the Task's own Gate 2 / Gate 3 serving as the per-Feature directing-party refinement-approval. The workflow is currently silent on this; the pattern is sound, additive, and exercised live by TASK-003. *(→ additive clause in `conceptual_design` § Re-elaborating a Work Item.)*
3. **Naming convention — no opaque plan-letter labels for Tasks**. Plan-time letter placeholders (TASK-A / TASK-B / TASK-C) should never propagate past the moment real IDs are allocated; the descriptive title plus real ID is the name; ordering is expressed by position language ("the first Task", "the verification Task"). *(→ rule in `conceptual_design` work-item naming + planning-time prompt in the `work-items` skill.)*
4. **Cross-type scope-guard AC convention — three-instance fragility pattern**. TASK-002 AC#6 ("only two files modified") contradicted AC#5 (which required a third); TASK-002 AC#8's example grep was mis-worded; TASK-003 AC#9 enumerated six files when the diff carried eight. Three occurrences is a pattern: scope ACs use a cross-type *guard*, never a literal count or fixed file list. *(→ AC-writing rule in `conceptual_design` + planning-time prompt in the `work-items` skill; rule explicitly distinguishes scope-assertion ACs from edit-target ACs.)*

The Epic is one half of a paired structural promotion. Its sibling [EPIC-008](EPIC-008-development-conventions-from-dogfooding.md) under [FEAT-008](../features/FEAT-008-development-discipline.md) covers the dev-discipline half — editing-order convention, push-cadence directive, and the meta-gap routing channel that future learnings flow through. The split was made on the directing party's call (2026-05-24): *"best to acknowledge the split now and pay the upfront cost to prevent more cost/re-work later — future learnings will compound when Shannon is used on real projects beyond dogfooding itself."* FEAT-003 was re-elaborated 2026-05-24 (additive) to add Ideal State bullet 4, the explicit anchor for "work-item conventions accumulated through framework use are promoted into the mandated documents via the canonical work-item workflow."

### Acceptance Criteria

*Each criterion names a verifiable outcome — the exact location and shape of the text the implementing Task(s) will land in `conceptual_design.md` and/or the `work-items` skill.*

- **AC#1 — Commit-hash timing clarified in re-elaboration workflow** *(item 1)*. `conceptual_design.md` § Re-elaborating a Work Item step 6 ("Activity Log entry … (b) upstream commit hash where applicable") gains an explicit clarification — either inline at step 6 or as an adjoining note — stating that when the re-elaboration is bundled inside a Task whose own commit lands after Gate 3, the entry cites the *upstream* commit hash (the hash that delivered the change being absorbed) and references the bundling work item by ID. The new prose names the TASK-003 case explicitly as the worked example. Verifiable: the text "upstream commit hash" remains, accompanied by a sentence that resolves the previously-ambiguous "where applicable" for the bundled-Task case.

- **AC#2 — Bundled re-elaboration clause added to re-elaboration workflow** *(item 2)*. `conceptual_design.md` § Re-elaborating a Work Item gains an additive sub-clause — either in the *Flow* (e.g. a new step 7 or a note on step 5) or in *Status semantics* — naming bundled re-elaboration as a valid pattern: multiple work-item re-elaborations may be applied inside a single Task's implementation, with the Task's own Gate 2 and Gate 3 serving as the per-item directing-party refinement-approval; this is permitted only when the bundle is additive and the parent (Epic or Task) explicitly enumerates the work items by ID. The clause cross-references AC#1's commit-hash clarification (these two items co-occur in TASK-003's worked example). Verifiable: the new clause exists, names "bundled re-elaboration", and explicitly cross-references the commit-hash text from AC#1.

- **AC#3 — Naming convention against opaque plan-letter Task labels** *(item 3)*. `conceptual_design.md` work-item naming (in the *Work Item* entity description or as a business rule) gains a one-line convention: *"Child work items in Epic plans are named by descriptive title (and by real ID once allocated) — never by opaque plan-letter labels (TASK-A, TASK-B). Ordering, when relevant, is expressed by position language ('the first Task', 'the verification Task')."* A companion prompt is added to `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2) at the Epic-planning branch, instructing the planning subagent to use descriptive titles from the outset rather than letter placeholders. Verifiable: the convention exists in `conceptual_design`; the skill prompt exists at the named location.

- **AC#4 — Cross-type scope-guard AC convention** *(item 4)*. `conceptual_design.md` gains a work-item AC-writing rule (in *Business Rules* or as a new sub-section under § Key Workflows referring to AC writing) stating:

  > **Scope-boundary ACs use a cross-type guard, not a literal file count.** When an Acceptance Criterion expresses scope (what is *not* touched), phrase it as a guard against changes to other types or layers — e.g. "no epic/task/spike template, index, or skill modified". Do **not** enumerate a literal file count or a fixed file list as the scope assertion — Task transitions necessarily touch routine bookkeeping files (work-item index entries, parent work-item Tasks line) that literal counts cannot anticipate.
  >
  > Acceptance Criteria *may* name target files when describing edit-target intent (e.g. "the FEAT-XXX file gains a sub-block"). The rule applies only when the AC's purpose is to assert what is *out of scope*. The distinguishing test: if the AC's failure mode is "an unintended file changed", it is a scope-guard AC and must use the cross-type guard form.

  The rule cites the TASK-002 AC#6, TASK-002 AC#8, and TASK-003 AC#9 three-instance pattern as the worked precedent. A companion prompt is added to `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2) reminding the planning subagent to use cross-type guard phrasing for scope ACs. Verifiable: the rule's precise wording distinguishing edit-target naming from scope assertion appears in `conceptual_design`; the three-instance precedent is cited; the skill prompt exists.

- **AC#5 — All amendments to `conceptual_design` are additive; doc stays APPROVED.** Per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics*, every amendment landed by this Epic is treated as additive (non-contradictory addition to existing approved claims). `conceptual_design.md` stays APPROVED through every amending Task — does not transition to DRAFT. The amendments get a Version History entry recording the additive amendment, the EPIC-007 citation, and the version bump (e.g. `v1.5 → v1.6`). Verifiable: post-Epic, `conceptual_design.md` Status field reads APPROVED with Last Reviewed and Approved dates updated; carries an EPIC-007-citing Version History entry.

- **AC#6 — Cross-references between the new conventions are explicit**. Required cross-references:
  - AC#2's bundled re-elaboration clause cross-references AC#1's commit-hash clarification (these co-occur in TASK-003's worked example).
  - AC#3's naming convention in `conceptual_design` and the planning prompt in the `work-items` skill cross-reference each other by file path / section anchor.
  - AC#4's scope-guard rule in `conceptual_design` and the corresponding skill prompt cross-reference each other.
  - Where applicable, AC#4's scope-guard rule cross-references EPIC-008's editing-order convention (companion AC-writing / edit-discipline rules across the FEAT-003 / FEAT-008 split).

  Verifiable: each named cross-reference exists.

- **AC#7 — Scratchpad bookkeeping**. At Gate 3, the scratchpad source items addressed by this Epic move from § Items to § Processed:
  - *"Framework clarifications buried in TASK-003's Plan"* sub-items **(b) commit-hash timing** and **(c) bundled re-elaboration** are addressed; sub-item (a) editing-order is addressed by EPIC-008. The item moves to Processed only after both EPIC-007 and EPIC-008 reach Gate 3 — whichever Epic approves second performs the move, with pointer to both Epics. If only EPIC-007 has approved at its Gate 3, the item stays in § Items with an annotation noting partial closure by EPIC-007 (sub-items b, c).
  - *"Naming convention: avoid opaque plan-letter labels"* — addressed entirely by this Epic; moves to Processed at this Epic's Gate 3 with an EPIC-007-citing pointer.
  - Item 4 (cross-type scope-guard) lives in archived TASK-002 / TASK-003 Reviews, not in a discrete scratchpad item; its archived-Review home is the historical record and is not moved.

  Verifiable: post-Epic, *"Naming convention"* lives in § Processed; § Items no longer contains it. *"Framework clarifications"* moves only if EPIC-008 is also APPROVED; otherwise stays in § Items with the partial-closure annotation.

### Context

- **Anchor**: Vision v2.3 § Core Principles #4 *Adaptive Coherence* (upstream direction — lessons flow back into framework rules); **FEAT-003 § Ideal State bullet 4** (added 2026-05-24 via FEAT-003 re-elaboration) anchors this Epic explicitly. The Gate-1 *Anchor Gap* finding from the original (pre-split) elaboration is closed by FEAT-003's re-elaboration; the *parent-fit Drift* finding (items 1, 5 fit FEAT-003 loosely) is resolved by the EPIC-007 / EPIC-008 split.
- **Sibling Epic**: [EPIC-008 — Development Conventions Surfaced Through Dogfooding](EPIC-008-development-conventions-from-dogfooding.md) — the dev-discipline half (editing-order, push-cadence, meta-gap routing channel) under [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md).
- **Scratchpad source items** (per AC#7): "Framework clarifications buried in TASK-003's Plan" sub-items (b) and (c); "Naming convention: avoid opaque plan-letter labels".
- **Archived-Task Review source items**: TASK-002 Review (AC#6 / AC#8 literal-count caveats); TASK-003 Review ("Third instance of literal-file-count fragility") — the precedent for AC#4.
- **Touched documents** (expected): `docs/conceptual_design.md` (additive amendments to § Re-elaborating a Work Item for AC#1 / AC#2, work-item naming for AC#3, AC-writing rule for AC#4, § Version History entry); `shannon/skills/work-items/skill.md` (planning prompts for AC#3 and AC#4).

---

## Plan

*To be filled during `/epic-plan EPIC-007` (Gate 2). Likely 1–2 Tasks: a `conceptual_design` amendment Task covering AC#1–AC#4 (plus AC#5 additivity + AC#6 cross-references), and a `work-items` skill prompt Task (or folded into the conceptual_design Task) covering the planning-prompt halves of AC#3 and AC#4.*

### Approach

*Filled during planning.*

### Tasks

*Filled during planning.*

### Dependencies

**Depends on**: Vision v2.3 (met); FEAT-003 § Ideal State bullet 4 added 2026-05-24 re-elaboration (met — the explicit anchor); `conceptual_design.md` v1.5 (met — the document this Epic additively amends); `work-items` skill (met). All EPIC-005 and EPIC-006 child Tasks APPROVED — the source Reviews and Plans this Epic harvests from are stable.

**Depended on by**: future sessions that would otherwise re-derive these work-item conventions; potentially EPIC-008 (cross-references between AC#4's scope-guard rule and EPIC-008's editing-order convention).

### Risks

*Filled during planning. Anticipated areas:*

- Over-formalisation of small rules into heavyweight prose. Mitigation: each rule gets a sentence or paragraph, not a chapter.
- Re-review cascade — additive amendments to `conceptual_design` may trigger alignment-check cascades to lower-authority documents (technical_design, guides). Mitigation: keep amendments truly additive so cascade alignment is automatic.
- Cross-Epic coordination on scratchpad bookkeeping (AC#7) — EPIC-007 and EPIC-008 share one scratchpad source item. Mitigation: whichever Epic approves second performs the move with pointer to both.

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-24** — Re-scoped: trimmed from seven items to four; sibling EPIC-008 created under new FEAT-008. The original elaboration (in flight 2026-05-23 / 2026-05-24) produced 11 ACs spanning seven items across both work-item and dev-discipline territory. The directing party identified an architectural improvement: *"acknowledge the split now and pay the upfront cost to prevent more cost/re-work later — future learnings will compound when Shannon is used on real projects beyond dogfooding itself."* The split: items 2 (commit-hash), 3 (bundled re-elaboration), 6 (naming convention), 7 (AC scope-guard) stay here under FEAT-003 — renumbered AC#1–AC#4 (cross-cutting ACs renumbered AC#5–AC#7). Items 1 (editing-order), 4 (meta-gap channel), 5 (push-cadence) move to EPIC-008 under FEAT-008. The file was renamed `EPIC-007-framework-conventions-from-dogfooding.md` → `EPIC-007-work-item-conventions-from-dogfooding.md`. FEAT-003 was re-elaborated 2026-05-24 (additive) to add Ideal State bullet 4 — the explicit anchor for this Epic's work-item-conventions promotion (closing the Gate-1 *Anchor Gap* finding from the original elaboration). The pre-split elaboration's *parent-fit Drift* finding (items 1, 5 fit FEAT-003 loosely) is resolved by the split.
- **2026-05-24** — DRAFT: Epic created via `/epic-create` under FEAT-003 (original scope: seven framework-clarification items captured during EPIC-005 / EPIC-006 dogfooding). Original anchor: Vision v2.3 § Core Principles #4 *Adaptive Coherence* (upstream direction). Originally titled "Framework Conventions Surfaced Through Dogfooding"; re-scoped and renamed 2026-05-24.
