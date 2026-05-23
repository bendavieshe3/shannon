# EPIC-008: Development Conventions Surfaced Through Dogfooding

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Created**: 2026-05-24
- **Updated**: 2026-05-24

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Initial intent captured at `/epic-create`. Full elaboration pending `/epic-elaborate EPIC-008`.*

### Overview

This Epic is the **dev-discipline half** of the EPIC-005 / EPIC-006 dogfooding harvest — sibling to [EPIC-007](EPIC-007-work-item-conventions-from-dogfooding.md) under [FEAT-003](../features/FEAT-003-unified-work-item-model.md) which covers the work-item-conventions half. Three framework-clarification items surfaced during use need promotion into `development_guide.md` (plus soft prompts in the `work-items` skill where the discipline meets work-item planning / review):

1. **Editing order** — when an edit touches a source-of-truth body and one or more derived indexes/references, edit the body first, then the derived artefacts, then verify by re-reading and (where applicable) a `grep` of the derived state. Surfaced as the buried-in-TASK-003-Plan ambiguity (sub-item a) — the implementer reasoned about this ad-hoc during TASK-003 planning; the rule deserves to be a convention rather than re-derived each time. *(→ `development_guide` § Code Style or new sibling — implementing Task decides.)*
2. **Push Cadence directive** — `development_guide` § Git Workflow has Commit Cadence (commit-after-Gate convention) but is silent on push frequency. The local↔remote sync point was ad-hoc through the EPIC-005 / EPIC-006 sessions and the directing party had to ask "are we pushing?" multiple times. *(→ `development_guide` § Git Workflow → Push Cadence subsection sibling to Commit Cadence.)*
3. **Meta-gap routing channel** — work items routinely resolve framework-general ambiguities during planning / implementation, but nothing prompts the implementer to notice and route the resolution to a mandated doc, knowledge note, or scratchpad item for future promotion. The mechanisms exist (re-review, re-elaborate, scratchpad); the missing piece is the *discipline / prompt* at the moments of action. *(→ two-touch: `development_guide` checklist line + `work-items` skill soft prompts at Plan / Review — see AC#3.)*

The Epic is the **upstream-from-implementation** half of the dogfooding harvest. The split was made on the directing party's call (2026-05-24): *"acknowledge the split now and pay the upfront cost to prevent more cost/re-work later — future learnings will compound when Shannon is used on real projects beyond dogfooding itself."*

The Epic has a **recursive-dogfood character**: AC#3 codifies the meta-gap routing channel (the previously-missing channel by which captured lessons flow into framework rules), and the Epic itself is one of the first two formal exercises of that channel (the other being EPIC-007). Together the two Epics demonstrate the channel works.

### Acceptance Criteria

*Each criterion names a verifiable outcome — the exact location and shape of the text the implementing Task(s) will land in `development_guide.md` and/or the `work-items` skill.*

- **AC#1 — Editing order convention** *(item 1)*. `development_guide.md` § Code Style → Patterns to Follow (or a new sibling subsection — implementing Task decides) gains a named convention: when an edit touches a source-of-truth body and one or more derived indexes / references, edit the body first, then the derived artefacts, then verify by re-reading and (where applicable) by a `grep` of the derived state. Citation tag references TASK-003 as the first exercise. Verifiable: the convention text exists with a stable anchor and names "source-of-truth body before derived index/references, then verify" in those terms.

- **AC#2 — Push Cadence directive added** *(item 2)*. `development_guide.md` § Git Workflow gains a **Push Cadence** subsection sibling to the existing **Commit Cadence** subsection. The directive states when local commits should reach the remote: at minimum, push after every Gate 3 approval (paired with the Commit Cadence trigger) and at session end; pre-Gate-3 pushes are permitted but not required. The wording cross-references Commit Cadence so the two read as a pair. Verifiable: a "Push Cadence" heading exists under § Git Workflow with a stated trigger that pairs with the Commit Cadence trigger.

- **AC#3 — Meta-gap routing channel established (lightweight, two-touch)** *(item 3)*. The previously-missing routing channel is operationalised in two places at the lightest weight that closes the gap:
  - **(a)** `development_guide.md` § Testing Strategy → Pre-Commit Checklist (or a new "Plan / Review Checklist" subsection if the implementing Task judges Pre-Commit the wrong home) gains a single checklist line of the shape: *"Did this work resolve a framework-general ambiguity (a convention, workflow gap, or rule clarification not specific to this work item)? If yes, capture it in `scratchpad.md` for promotion or open a follow-up work item against the relevant mandated document."*
  - **(b)** `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2) and § Process: Review (Gate 3) each gain a one-line soft prompt mirroring (a) — phrased as guidance to the implementing subagent, not a blocking check.
  - The two halves cross-reference each other (the `development_guide` checklist line names the skill prompts by file path; the skill prompts reference the `development_guide` checklist).
  - **Rationale**: the lightest viable resolution. The guide line is the canonical convention; the skill prompt makes the convention reach the implementer at the moment of relevance without ceremony. A dedicated Workflow in `conceptual_design` was considered and rejected as disproportionate.

  Verifiable: both (a) and (b) exist at the named locations; both name the same trigger condition ("framework-general ambiguity surfaced during this work").

- **AC#4 — All amendments to `development_guide` are additive; doc stays APPROVED**. Per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics*, every amendment landed by this Epic is treated as additive (non-contradictory addition to existing approved claims). `development_guide.md` stays APPROVED through every amending Task — does not transition to DRAFT. The amendments get a Version History entry recording the additive amendment, the EPIC-008 citation, and the version bump (e.g. `v1.2 → v1.3`). Verifiable: post-Epic, `development_guide.md` Status field reads APPROVED with Last Reviewed and Approved dates updated; carries an EPIC-008-citing Version History entry.

- **AC#5 — Cross-references between the new conventions are explicit**. Required cross-references:
  - AC#2's Push Cadence cross-references Commit Cadence in `development_guide.md` (sibling subsections).
  - AC#3's (a) checklist line cross-references the skill prompts at (b) by file path; the skill prompts reference the checklist back.
  - Where applicable, AC#1's editing-order convention cross-references EPIC-007's AC#4 cross-type scope-guard convention (companion edit-discipline / AC-writing rules across the FEAT-003 / FEAT-008 split).

  Verifiable: each named cross-reference exists.

- **AC#6 — Scratchpad bookkeeping**. At Gate 3, the scratchpad source items addressed by this Epic move from § Items to § Processed:
  - *"Framework clarifications buried in TASK-003's Plan"* sub-item **(a) editing order** is addressed; sub-items (b) and (c) are addressed by EPIC-007. The item moves to Processed only after both EPIC-007 and EPIC-008 reach Gate 3 — whichever Epic approves second performs the move, with pointer to both Epics. If only EPIC-008 has approved at its Gate 3, the item stays in § Items with an annotation noting partial closure by EPIC-008 (sub-item a).
  - *"Meta-gap: no channel for feeding framework-general resolutions back into the framework"* — addressed entirely by this Epic; moves to Processed at this Epic's Gate 3 with an EPIC-008-citing pointer.
  - *"Push-frequency directive for development_guide"* — addressed entirely by this Epic; moves to Processed at this Epic's Gate 3 with an EPIC-008-citing pointer.

  Verifiable: post-Epic, *"Meta-gap"* and *"Push-frequency"* live in § Processed; § Items no longer contains them. *"Framework clarifications"* moves only if EPIC-007 is also APPROVED; otherwise stays with the partial-closure annotation.

- **AC#7 — Recursive-dogfood record**. This Epic codifies the meta-gap routing channel (AC#3) AND is one of the first two formal exercises of that channel (the other being EPIC-007). This fact is captured durably at approval:
  - `development_guide.md` § Version History entry for the amending bump explicitly names EPIC-008 as the Epic that established the routing channel (AC#3) and notes EPIC-007 as the contemporaneous sibling.
  - A short knowledge note is created (`docs/knowledge/`, classified *Implementation Details* or *Extension*) recording the recursive-dogfood character of the EPIC-007 / EPIC-008 pair — that EPIC-008 establishes the channel and both Epics are the first to be routed through it. The note cross-references the new `development_guide` checklist line, the new skill prompts, EPIC-007, and EPIC-008.

  Verifiable: the Version History entry exists and names EPIC-008 by ID; the knowledge note exists, is indexed in `knowledge_index.md`, and carries the named cross-references.

### Context

- **Anchor**: Vision v2.3 § Core Principles #3 *Knowledge Accumulates* (knowledge gathered during work goes somewhere durable) and #4 *Adaptive Coherence* (lessons flow back into framework rules — upstream direction). **FEAT-008 § Ideal State** anchors this Epic explicitly: bullet 2 ("Development disciplines surfaced during framework use are promoted into ratified `development_guide` rules via canonical work-item workflows") is the Epic's mandate; bullet 3 ("framework provides a routing channel for ...") is what AC#3 establishes.
- **Sibling Epic**: [EPIC-007 — Work-Item Conventions Surfaced Through Dogfooding](EPIC-007-work-item-conventions-from-dogfooding.md) — the work-item-workflow half (items 2 commit-hash, 3 bundled re-elaboration, 6 naming convention, 7 AC scope-guard) under FEAT-003.
- **Scratchpad source items** (per AC#6): "Framework clarifications buried in TASK-003's Plan" sub-item (a); "Meta-gap: no channel for feeding framework-general resolutions back"; "Push-frequency directive for development_guide".
- **Touched documents** (expected): `docs/development_guide.md` (additive amendments to § Code Style for AC#1, § Git Workflow for AC#2, § Testing Strategy or new Plan/Review Checklist for AC#3, § Version History entry); `shannon/skills/work-items/skill.md` (soft prompts at § Process: Plan and § Process: Review for AC#3); `docs/scratchpad.md` (three scratchpad items moved Items → Processed, contingent on AC#6); `docs/knowledge/` (one new knowledge note recording recursive-dogfood, per AC#7).

---

## Plan

*To be filled during `/epic-plan EPIC-008` (Gate 2). Likely 1–2 Tasks: a `development_guide` amendment Task (AC#1, AC#2, AC#3a, AC#4, AC#5) and a `work-items` skill prompt Task (AC#3b) — or both folded into one Task. AC#6 (scratchpad bookkeeping) and AC#7 (recursive-dogfood record) ride in Gate 3 review.*

### Approach

*Filled during planning.*

### Tasks

*Filled during planning.*

### Dependencies

**Depends on**: FEAT-008 created (met as of this Epic's creation); `development_guide.md` v1.2 (met — the document this Epic additively amends); `work-items` skill (met); `conceptual_design.md` § Re-elaborating a Work Item v1.5 (met — the channel through which this Epic itself was promoted).

**Depended on by**: future development-discipline Epics that surface dev / test / build / CI conventions from real-project use; EPIC-007 may cross-reference AC#1's editing-order convention from its own AC#4 scope-guard convention.

### Risks

*Filled during planning. Anticipated areas:*

- Meta-gap shape ambiguity — checklist vs skill prompt vs both. Mitigation: the two-touch recommendation is named in AC#3; revisit at planning if needed.
- Over-formalisation — three lightweight clarifications becoming heavyweight prose. Mitigation: each gets a sentence or paragraph, not a chapter.
- Re-review cascade — additive amendment to `development_guide` may trigger alignment cascades. Mitigation: keep amendments truly additive.
- Cross-Epic coordination on scratchpad bookkeeping (AC#6) — EPIC-007 and EPIC-008 share one scratchpad source item ("Framework clarifications"). Mitigation: whichever Epic approves second performs the move with pointer to both.

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-24** — DRAFT: Epic created via `/epic-create` under FEAT-008. The dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest — items 1 (editing order), 4 (meta-gap channel), 5 (push cadence). Created as part of a structural split from the original single-Epic EPIC-007: work-item-workflow learnings stay in EPIC-007 (re-scoped and renamed `EPIC-007-work-item-conventions-from-dogfooding.md`) under FEAT-003; dev / git / process discipline learnings move here under the new FEAT-008. Anchored at Vision v2.3 § Core Principles #3 *Knowledge Accumulates* (primary) and #4 *Adaptive Coherence* (secondary), with FEAT-008 § Ideal State bullets 2 and 3 as the Feature-level anchor. The Epic both codifies the meta-gap routing channel (AC#3) and exercises it (its own three items routed via the framework's own work-item workflow). Full Requirements elaboration pending `/epic-elaborate EPIC-008`.
