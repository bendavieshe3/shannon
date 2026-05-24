# EPIC-008: Development Conventions Surfaced Through Dogfooding

## Metadata

- **Status**: ELABORATED
- **Type**: Epic
- **Parent**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Created**: 2026-05-24
- **Updated**: 2026-05-24 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Elaborated at `/epic-elaborate EPIC-008` (2026-05-24) — refinement pass on detailed initial-intent captured at `/epic-create` the same day. Gate 1 pending directing-party approval.*

### Overview

This Epic is the **dev-discipline half** of the EPIC-005 / EPIC-006 dogfooding harvest — sibling to [EPIC-007](EPIC-007-work-item-conventions-from-dogfooding.md) under [FEAT-003](../features/FEAT-003-unified-work-item-model.md) which covers the work-item-conventions half. Three framework-clarification items surfaced during use need promotion into `development_guide.md` (plus soft prompts in the `work-items` skill where the discipline meets work-item planning / review):

1. **Editing order** — when an edit touches a source-of-truth body and one or more derived indexes / references / bookkeeping artefacts, edit the body first, then the derived artefacts, then verify by re-reading and (where applicable) a `grep` of the derived state. *Derived artefacts* explicitly include work-item index entries, parent work-item Tasks-line entries, and any cross-reference that names the source-of-truth artefact by path or ID. Surfaced as the buried-in-TASK-003-Plan ambiguity (sub-item a) — the implementer reasoned about this ad-hoc during TASK-003 planning; the rule deserves to be a convention rather than re-derived each time. *(→ `development_guide` § Code Style — implementing Task chooses sub-section.)*
2. **Push Cadence directive** — `development_guide` § Git Workflow has Commit Cadence (commit-after-Gate convention) but is silent on push frequency. The local↔remote sync point was ad-hoc through the EPIC-005 / EPIC-006 sessions and the directing party had to ask "are we pushing?" multiple times. *(→ `development_guide` § Git Workflow → Push Cadence subsection sibling to Commit Cadence.)*
3. **Meta-gap routing channel** — work items routinely resolve framework-general ambiguities during planning / implementation, but nothing prompts the implementer to notice and route the resolution to a mandated doc, knowledge note, or scratchpad item for future promotion. The mechanisms exist (re-review, re-elaborate, scratchpad); the missing piece is the *discipline / prompt* at the moments of action. *(→ two-touch: `development_guide` checklist line + `work-items` skill soft prompts at Plan / Review — see AC#3.)*

The Epic is the **upstream-from-implementation** half of the dogfooding harvest. The split was made on the directing party's call (2026-05-24): *"acknowledge the split now and pay the upfront cost to prevent more cost/re-work later — future learnings will compound when Shannon is used on real projects beyond dogfooding itself."*

The Epic has a **recursive-dogfood character** of a specific, narrow kind: AC#3 codifies the meta-gap routing channel (the previously-missing channel by which framework-general resolutions flow from work-item work into framework rules), and the Epic itself was promoted via that very kind of resolution-routing (the three items reached this Epic through scratchpad capture during EPIC-005 / EPIC-006 sessions and EPIC-007's pre-split elaboration — i.e. via the same mechanism the channel is designed to make routine). EPIC-008 and EPIC-007 are the first two formal exercises of that channel. AC#7 records this durably; it is a *record* of recursion, not an additional layer of recursion.

### Acceptance Criteria

*Each criterion names a verifiable outcome — the exact location and shape of the text the implementing Task(s) will land in `development_guide.md` and/or the `work-items` skill.*

- **AC#1 — Editing order convention** *(item 1)*. `development_guide.md` § Code Style → Patterns to Follow (or a new sibling subsection — implementing Task decides) gains a named convention: when an edit touches a source-of-truth body and one or more derived indexes / references / bookkeeping artefacts, edit the body first, then the derived artefacts, then verify by re-reading and (where applicable) by a `grep` of the derived state. *Derived artefacts* are named explicitly with examples (work-item index entries, parent work-item Tasks-line entries, cross-references that name the source body by path or ID). The convention cites TASK-003 as the worked precedent. Verifiable: the convention text exists with a stable anchor and names *"source-of-truth body before derived index / references, then verify"* in those terms, with the derived-artefacts examples explicit.

- **AC#2 — Push Cadence directive added** *(item 2)*. `development_guide.md` § Git Workflow gains a **Push Cadence** subsection sibling to the existing **Commit Cadence** subsection. The directive states when local commits should reach the remote: at minimum, push (a) after every Gate 3 approval (paired with the Commit Cadence trigger) and (b) at session end. *Session end* is defined inline as "before the implementer or directing party stops a working session for the day or hands off to another agent — i.e. before any pause long enough that local commits would otherwise sit unsynced through the gap"; pre-Gate-3 pushes are permitted but not required. The wording cross-references Commit Cadence so the two read as a pair. Verifiable: a "Push Cadence" heading exists under § Git Workflow with the two named triggers, an inline definition of "session end", and a cross-reference to Commit Cadence.

- **AC#3 — Meta-gap routing channel established (lightweight, two-touch)** *(item 3)*. The previously-missing routing channel is operationalised in two places at the lightest weight that closes the gap:
  - **(a)** `development_guide.md` § Testing Strategy → Pre-Commit Checklist (or a new "Plan / Review Checklist" subsection if the implementing Task judges Pre-Commit the wrong home) gains a single checklist line of the shape: *"Did this work resolve a framework-general ambiguity — a convention, workflow gap, or rule clarification that future work items would otherwise re-derive? If yes, capture it in `scratchpad.md` for promotion or open a follow-up work item against the relevant mandated document."*
  - **(b)** `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2) and § Process: Review (Gate 3) each gain a one-line soft prompt mirroring (a) — phrased as guidance to the implementing subagent, not a blocking check.
  - The two halves cross-reference each other (the `development_guide` checklist line names the skill prompts by file path and section; the skill prompts reference the `development_guide` checklist line by section anchor).
  - **Trigger phrasing** — both halves use the same trigger phrase: *"framework-general ambiguity surfaced during this work — a convention, workflow gap, or rule clarification that future work items would otherwise re-derive."* The phrasing covers the three observed surfacing modes: (i) implementer notices the ambiguity in their own reasoning while drafting (TASK-003 editing-order pattern); (ii) directing party flags a missing convention in feedback (push-cadence pattern); (iii) review uncovers a recurring shape that previous work items also tripped on (cross-type scope-guard pattern, handled by EPIC-007). Known blind spots — ambiguities that resolve silently inside the implementer's reasoning without a textual artefact, and ambiguities recognised only retrospectively several work items later — are acceptable residual risks at this lightweight resolution; deeper instrumentation is forward work beyond this Epic.
  - **Rationale**: the lightest viable resolution. The guide line is the canonical convention; the skill prompt makes the convention reach the implementer at the moment of relevance without ceremony. A dedicated Workflow in `conceptual_design` was considered and rejected as disproportionate.

  Verifiable: both (a) and (b) exist at the named locations; both name the same trigger condition using the exact phrasing above; both cross-reference each other.

- **AC#4 — All amendments to `development_guide` are additive; doc stays APPROVED**. Per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics*, every amendment landed by this Epic is treated as additive (non-contradictory addition to existing approved claims). `development_guide.md` stays APPROVED through every amending Task — does not transition to DRAFT. The amendments get a Version History entry recording the additive amendment, the EPIC-008 citation, and the version bump (e.g. `v1.2 → v1.3`). Verifiable: post-Epic, `development_guide.md` Status field reads APPROVED with Last Reviewed and Approved dates updated; carries an EPIC-008-citing Version History entry.

- **AC#5 — Cross-references between the new conventions are explicit**. Required cross-references:
  - AC#2's Push Cadence cross-references Commit Cadence in `development_guide.md` (sibling subsections).
  - AC#3's (a) checklist line cross-references the skill prompts at (b) by file path and section anchor; the skill prompts reference the checklist back by section anchor.
  - AC#1's editing-order convention cross-references EPIC-007's AC#4 cross-type scope-guard convention as a companion edit-discipline / AC-writing rule across the FEAT-003 / FEAT-008 split. EPIC-007's AC#6 names the converse cross-reference (its scope-guard rule pointing to the editing-order convention). Both directions resolve at implementation time: the editing-order text in `development_guide.md` § Code Style names the scope-guard rule in `conceptual_design.md` by section anchor, and vice versa.

  Verifiable: each named cross-reference exists at both ends; section anchors resolve.

- **AC#6 — Scratchpad bookkeeping**. At Gate 3, the scratchpad source items addressed by this Epic move from § Items to § Processed:
  - *"Framework clarifications buried in TASK-003's Plan"* sub-item **(a) editing order** is addressed by this Epic; sub-items (b) commit-hash timing and (c) bundled re-elaboration are addressed by EPIC-007. The scratchpad item is a single line covering all three sub-items, so it cannot be split. The bookkeeping rule: **whichever of EPIC-007 / EPIC-008 reaches Gate 3 second performs the move to § Processed, with a pointer naming both Epics**. If only EPIC-008 has reached Gate 3 (EPIC-007 still in flight), the item stays in § Items with an inline annotation: *"Partial closure: sub-item (a) addressed by EPIC-008 APPROVED [date]; sub-items (b), (c) pending under EPIC-007."* The mirror rule is in EPIC-007 AC#7 — the two ACs are deliberately co-authored so the second-approver always performs the move regardless of which Epic that is.
  - *"Meta-gap: no channel for feeding framework-general resolutions back into the framework"* — addressed entirely by this Epic; moves to § Processed at this Epic's Gate 3 with an EPIC-008-citing pointer.
  - *"Push-frequency directive for development_guide"* — addressed entirely by this Epic; moves to § Processed at this Epic's Gate 3 with an EPIC-008-citing pointer.

  Verifiable: post-Epic, *"Meta-gap"* and *"Push-frequency"* live in § Processed; § Items no longer contains them. *"Framework clarifications"* moves only if EPIC-007 is also APPROVED; otherwise stays with the partial-closure annotation.

- **AC#7 — Recursive-dogfood record**. The recursive-dogfood character of the EPIC-007 / EPIC-008 pair (as framed in the Overview — AC#3 codifies the channel; both Epics were promoted via the same kind of resolution-routing the channel is designed to make routine) is captured durably at approval:
  - `development_guide.md` § Version History entry for the amending bump explicitly names EPIC-008 as the Epic that established the routing channel (AC#3) and notes EPIC-007 as the contemporaneous sibling exercise.
  - A short knowledge note is created in `docs/knowledge/` classified as an **Extension** of `development_guide.md` (specifically extending the new Plan / Review Checklist line at AC#3(a) and the new Push Cadence subsection at AC#2 — i.e. elaborating the channel-and-cadence pair the mandated doc now ratifies; per `knowledge_index.md` § Notes, *Extension* is the right classification when a note elaborates a mandated-doc section, as distinct from *Implementation Details* which captures project-specific *how-we-do-X*). The note records: (i) the previously-missing channel and its codification at AC#3; (ii) EPIC-007 and EPIC-008 as the first two exercises of the channel; (iii) cross-references to the new `development_guide` checklist line, the new `work-items` skill prompts, EPIC-007, and EPIC-008.

  Verifiable: the Version History entry exists and names EPIC-008 by ID; the knowledge note exists, is indexed in `knowledge_index.md` under **Extensions**, is classified as extending `development_guide.md`, and carries the named cross-references.

### Context

- **Anchor**: Vision v2.3 § Core Principles #3 *Knowledge Accumulates* (primary — knowledge gathered during work goes somewhere durable) and #4 *Adaptive Coherence* (secondary — lessons flow back into framework rules, upstream direction). **FEAT-008 § Ideal State** anchors this Epic explicitly: bullet 2 ("Development disciplines surfaced during framework use are promoted into ratified `development_guide` rules via canonical work-item workflows") is the substantive mandate (AC#1, AC#2 deliver against this); bullet 3 ("framework provides a routing channel for [resolved framework-general ambiguity → route it back]") is what AC#3 establishes mechanically. FEAT-008 Ideal State bullet 1 (the existing retrospective conventions) is the *base* this Epic additively extends — not in scope to amend. Bullet 4 (real-project use surfacing dev / test / build / CI disciplines) is *forward* — out of scope for this Epic but is precisely what the channel codified by AC#3 enables.
- **Sibling Epic**: [EPIC-007 — Work-Item Conventions Surfaced Through Dogfooding](EPIC-007-work-item-conventions-from-dogfooding.md) — the work-item-workflow half (items 2 commit-hash, 3 bundled re-elaboration, 6 naming convention, 7 AC scope-guard) under FEAT-003. AC#5 and AC#6 of EPIC-008 deliberately mirror AC#6 and AC#7 of EPIC-007 to coordinate the two-Epic edits.
- **Scratchpad source items** (per AC#6): "Framework clarifications buried in TASK-003's Plan" sub-item (a) editing order; "Meta-gap: no channel for feeding framework-general resolutions back"; "Push-frequency directive for development_guide". *(All three confirmed present in `docs/scratchpad.md` § Items at elaboration time.)*
- **Touched documents** (expected): `docs/development_guide.md` (additive amendments to § Code Style for AC#1, § Git Workflow for AC#2, § Testing Strategy or new Plan/Review Checklist for AC#3, § Version History entry for AC#4); `shannon/skills/work-items/skill.md` (soft prompts at § Process: Plan (Gate 2) and § Process: Review (Gate 3) for AC#3); `docs/scratchpad.md` (three scratchpad items moved Items → Processed, contingent on AC#6 conditions); `docs/knowledge/` (one new Extension knowledge note recording the recursive-dogfood record, per AC#7); `docs/knowledge/knowledge_index.md` (one entry under Extensions for the new note).

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

- **2026-05-24** — ELABORATED via Gate 1. Refinement pass by elaboration subagent on the detailed initial-intent drafted at `/epic-create`. Refinements: (1) Overview's recursive-dogfood claim tightened — original "first two formal exercises of that channel" risked overclaiming since the channel doesn't yet exist at this Epic's creation (AC#3 is what creates it); the refined framing is honest — both Epics reached here via the same kind of resolution-routing the channel is designed to formalise, and AC#7 is a **record** of that recursion, not an additional layer. (2) AC#1 made *derived artefacts* explicit with examples (work-item index entries, parent Tasks-line entries, cross-references by path or ID). (3) AC#2 added an inline definition of "session end" — no soft terms remain. (4) AC#3 trigger phrasing now verbatim-shared between the checklist line and skill prompts; three observed surfacing modes enumerated (implementer-notice / directing-party-flag / cross-work-item-recurrence); residual blind spots (silent resolution; only-retrospectively-recognised) named honestly as acceptable at this lightweight resolution. (5) AC#5 cross-references with EPIC-007 AC#6 verified bidirectional by reading the sibling. (6) AC#6 scratchpad-coordination is deterministic — verbatim partial-closure annotation; "whichever Epic approves second performs the move" rule explicit. (7) AC#7 knowledge note classification picked definitively: **Extension** (citing `knowledge_index.md`'s own taxonomy; Implementation Details ruled out with reasoning). Alignment: FEAT-008 § Ideal State bullets 2 and 3 substantively delivered; bullet 4 correctly forward (and is exactly what AC#3's channel enables). Findings: all Strength + one minor non-blocking Gap (no coordination signal for which Epic approves first — acceptable as sequential through the same directing party; flagged for Gate 2 planning). Directing party approved without modification.
- **2026-05-24** — DRAFT: Epic created via `/epic-create` under FEAT-008. The dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest — items 1 (editing order), 4 (meta-gap channel), 5 (push cadence). Created as part of a structural split from the original single-Epic EPIC-007: work-item-workflow learnings stay in EPIC-007 (re-scoped and renamed `EPIC-007-work-item-conventions-from-dogfooding.md`) under FEAT-003; dev / git / process discipline learnings move here under the new FEAT-008. Anchored at Vision v2.3 § Core Principles #3 *Knowledge Accumulates* (primary) and #4 *Adaptive Coherence* (secondary), with FEAT-008 § Ideal State bullets 2 and 3 as the Feature-level anchor. The Epic both codifies the meta-gap routing channel (AC#3) and exercises it (its own three items routed via the framework's own work-item workflow). Full Requirements elaboration pending `/epic-elaborate EPIC-008`.
