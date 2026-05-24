# TASK-007: Amend development_guide.md with New Conventions and Version History Entry

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #conventions
- **Created**: 2026-05-24
- **Updated**: 2026-05-24 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at `/task-create` 2026-05-24; full Requirements drafted at `/task-elaborate TASK-007` 2026-05-24 — anchors confirmed against the live `development_guide.md` v1.2 (Last Reviewed / Approved 2026-05-16).*

### Overview

This is **Task 1 of EPIC-008** — the `development_guide.md` amendments that codify three dev-discipline conventions surfaced during EPIC-005 / EPIC-006 dogfooding, plus the Version History entry recording the additive bump `v1.2 → v1.3`. Task 2 of EPIC-008 (the `work-items` skill soft prompts that mirror the AC#3 meta-gap checklist line at Gate 2 and Gate 3) follows this Task and must rebase if EPIC-007's skill-prompt Task lands first in the shared `work-items/skill.md` edit zone — but that sequencing concern does not affect this Task.

The four amendments and their confirmed homes in the current file:

- **EPIC-008 AC#1 — Editing-order convention.** A new bullet under § Code Style → Patterns to Follow (currently three bullets at lines 76–78: *Self-contained templates*, *Explicit skill invocation*, *Single source of truth per concept*), naming the source-of-truth-body-before-derived-index/references-then-verify rule, enumerating *derived artefacts* explicitly (work-item index entries, parent Tasks-line entries, cross-references by path or ID), citing TASK-003 as the worked precedent, and carrying a cross-reference to EPIC-007 AC#4's scope-guard rule (the companion edit-discipline / AC-writing pair).
- **EPIC-008 AC#2 — Push Cadence directive.** A new `### Push Cadence` subsection under § Git Workflow, sibling to the existing Commit Cadence subsection (lines 138–145) and inserted between Commit Cadence and Pull Requests (currently at line 147). Names two triggers (after every Gate 3 approval; at session end), defines "session end" inline, and cross-references Commit Cadence so the two read as a pair.
- **EPIC-008 AC#3a — Meta-gap routing-channel checklist line.** A new checklist item appended to § Testing Strategy → Pre-Commit Checklist (currently four items at lines 109–112: viewer-render, no stale references, cross-references-as-paths, mental dry-run) carrying the verbatim trigger phrasing required by EPIC-008 AC#3, and carrying a forward cross-reference to the matching `work-items` skill prompts that EPIC-008 Task 2 will land.
- **EPIC-008 AC#4 — Version History entry recording the additive amendment.** A new `### 2026-05-?? - v1.3` entry inserted at the top of § Version History (above the existing `### 2026-05-16 - v1.2` entry at line 179, mirroring the file's existing most-recent-first ordering — see v1.2 above v1.1 above v1.0 at lines 179, 188, 193), naming EPIC-008 by ID, enumerating the three substantive amendments by section anchor, classifying the bump as "additive amendment per conceptual_design § Re-reviewing → *Status semantics*", and recording the new Approved date. The Status field at the top of the file (currently `**Status**: APPROVED`, lines 3–5) stays APPROVED and gets its Last Reviewed / Approved dates updated to the implementation date.

**Definitive location decisions resolved at EPIC-008 Plan** (implementing Task may override if a better home emerges, recording rationale in Implementation Notes):

- AC#1 editing-order → **§ Code Style → Patterns to Follow**, new bullet appended to the existing three.
- AC#3a meta-gap checklist → **§ Testing Strategy → Pre-Commit Checklist**, new checklist item appended to the existing four.

EPIC-008's Plan also definitively resolves Push Cadence as a new `### Push Cadence` heading sibling to `### Commit Cadence` (not a paragraph inside Commit Cadence). The Version History entry's home (above the v1.2 entry) is determined by the file's existing chronological convention rather than a Plan decision.

**Out of scope for this Task** (handled elsewhere per EPIC-008's Plan):

- EPIC-008 AC#3b — soft prompts in `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2) and § Process: Review (Gate 3). Lands in EPIC-008's Task 2.
- EPIC-008 AC#5 inbound half — the skill prompts referencing the new Pre-Commit Checklist line by section anchor. Lands in EPIC-008's Task 2 as the converse of this Task's outbound cross-reference.
- EPIC-008 AC#6 (scratchpad bookkeeping) and AC#7 (recursive-dogfood knowledge note) — both Gate-3 review work for the Epic as a whole, not implementing-Task scope.
- The converse of the AC#1 ↔ EPIC-007 AC#4 cross-reference (the inbound half landing in `conceptual_design.md` § Business Rules pointing back at the editing-order bullet) — landed by EPIC-007's `conceptual_design` amendment Task per EPIC-007 AC#6.

**Commit and push timing for this Task itself.** Per `development_guide.md` § Commit Cadence (the very rule being extended), this Task commits after Gate 3, not mid-implementation. Per the about-to-be-ratified Push Cadence directive this Task itself lands, the post-Gate-3 commit also triggers a push (Gate 3 approval being one of the two named push triggers).

### Acceptance Criteria

*Drafted at `/task-elaborate TASK-007` from EPIC-008 AC#1, AC#2, AC#3a, AC#4, AC#5. Each criterion names a verifiable outcome — the section, the surrounding anchor, and the required wording where AC text demands it. Closes EPIC-008 AC#1 (AC1–AC2 below), AC#2 (AC3), AC#3a (AC4), AC#4 (AC5 + AC9), AC#5 outbound half (AC6–AC8); AC10 covers additivity verification; AC11 covers the scope-boundary guard; AC12 covers the no-commit-mid-implementation rule.*

- [ ] **AC1 — Editing-order bullet lands at § Code Style → Patterns to Follow.** A fourth bullet is appended to the existing list (currently *Self-contained templates / Explicit skill invocation / Single source of truth per concept* at lines 76–78 of v1.2). The bullet's bold lead is a name for the convention (e.g. **Source-of-truth body before derived artefacts**); the prose names the rule using the phrasing *"source-of-truth body before derived index / references, then verify"* verbatim (per EPIC-008 AC#1's verifiable test); enumerates *derived artefacts* explicitly with three named examples — **work-item index entries**, **parent Tasks-line entries** (i.e. the line in a parent work item's § Tasks list naming the child), and **cross-references that name the source-of-truth artefact by path or ID**; specifies the verification step as re-reading and (where applicable) a `grep` of the derived state; cites **TASK-003** as the worked precedent.

- [ ] **AC2 — Editing-order bullet carries the cross-Epic forward reference to EPIC-007 AC#4.** The AC1 bullet's text references EPIC-007 AC#4's scope-guard rule as the companion edit-discipline / AC-writing convention, naming the anchor as `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (the title EPIC-007's Plan resolved). Because that anchor does not exist in `conceptual_design.md` at this Task's landing time (EPIC-007's `conceptual_design` amendment Task is sequenced independently), the reference lands as permitted by EPIC-008's risk-mitigation: the bullet carries an inline verifiable HTML comment of the shape `<!-- anchor will be created by EPIC-007's implementing Task per EPIC-007 AC#4 -->` so the forward-only state is visible. If EPIC-007's `conceptual_design` Task has already landed by this Task's implementation, the implementer may drop the comment and verify the anchor resolves; either path is acceptable provided Implementation Notes records which.

- [ ] **AC3 — Push Cadence subsection lands under § Git Workflow as sibling to Commit Cadence.** A new `### Push Cadence` heading is inserted under § Git Workflow between the existing `### Commit Cadence` subsection (lines 138–145 of v1.2) and the existing `### Pull Requests` subsection (line 147). The subsection text states the framework's default ("push local commits to the remote") with two named triggers in bullet form: **(a) after every Gate 3 approval** (paired with the Commit Cadence Gate-3 trigger, so commit-then-push is a single motion) and **(b) at session end**. *Session end* is defined inline using the verbatim wording: *"before the implementer or directing party stops a working session for the day or hands off to another agent — i.e. before any pause long enough that local commits would otherwise sit unsynced through the gap"* (per EPIC-008 AC#2). Pre-Gate-3 pushes are permitted but not required. The subsection cross-references Commit Cadence by name so the two subsections read as a pair (e.g. "See *Commit Cadence* above — the two cadences are paired").

- [ ] **AC4 — Meta-gap routing-channel checklist item lands at § Testing Strategy → Pre-Commit Checklist.** A new checklist item is appended to the existing four-item list (lines 109–112 of v1.2). The item's text uses the verbatim trigger phrasing required by EPIC-008 AC#3: *"framework-general ambiguity surfaced during this work — a convention, workflow gap, or rule clarification that future work items would otherwise re-derive"*. The full item reads in the shape: *"Did this work resolve a framework-general ambiguity surfaced during this work — a convention, workflow gap, or rule clarification that future work items would otherwise re-derive? If yes, capture it in `scratchpad.md` for promotion or open a follow-up work item against the relevant mandated document."* The item carries a forward cross-reference to the matching soft prompts in `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2) and § Process: Review (Gate 3), to be landed by EPIC-008 Task 2. The cross-reference lands as a parenthetical citing the file path plus section anchors.

- [ ] **AC5 — Version History entry `v1.2 → v1.3` lands at the top of § Version History.** A new `### YYYY-MM-DD - v1.3` entry (date = implementation date) is inserted at the top of § Version History, above the existing `### 2026-05-16 - v1.2` entry at line 179, preserving the file's most-recent-first ordering (precedent: v1.2 above v1.1 above v1.0 at lines 179, 188, 193). The entry contains the four required elements per EPIC-008 AC#4: **(i) names EPIC-008 by ID** as the source ("Per EPIC-008 …" or equivalent); **(ii) lists each substantive amendment by its section anchor** (§ Code Style → Patterns to Follow new bullet — editing-order convention; § Git Workflow → Push Cadence new subsection; § Testing Strategy → Pre-Commit Checklist new checklist item); **(iii) explicitly classifies the bump as additive** per `conceptual_design.md` § Re-reviewing → *Status semantics*; **(iv) records the new Approved date** matching the file's top-of-file Approved date update. The entry follows the formatting precedent of the existing v1.2 entry — date header, bulleted change list, and a `Status: APPROVED (YYYY-MM-DD)` trailing line.

- [ ] **AC6 — Push Cadence ↔ Commit Cadence cross-reference is explicit and bidirectional.** The new Push Cadence subsection (AC3) references Commit Cadence by name. Reciprocally, the existing Commit Cadence subsection gets a single inline addition — a closing sentence or parenthetical — pointing at the new Push Cadence subsection so the pair is symmetric. The bidirectionality is a single small additive edit to Commit Cadence prose, additive per § Re-reviewing → *Status semantics* (does not contradict the existing Commit Cadence claims; only adds a sibling pointer).

- [ ] **AC7 — Pre-Commit Checklist line → `work-items` skill prompts cross-reference is named.** The cross-reference inside AC4's new checklist item names the target file path (`shannon/skills/work-items/skill.md`) and the two section anchors (§ Process: Plan and § Process: Review). The cross-reference is forward (the skill prompts land in EPIC-008 Task 2). No verifiable-anchor comment is required because Task 2 is intra-Epic and inside the directing party's planned sequence; if Task 2 has not landed at this Task's Gate 3, the cross-reference is permitted to land pointing at the named-but-not-yet-present anchors, with the same treatment as a cross-Epic forward reference (a brief comment naming the intra-Epic dependency is allowed but not required).

- [ ] **AC8 — Editing-order bullet → EPIC-007 AC#4 scope-guard cross-reference is documented.** The outbound cross-reference at AC2 is the third leg of EPIC-008 AC#5's outbound-cross-references requirement. Its handling (forward-only with a verifiable comment if EPIC-007's `conceptual_design` Task has not landed; live link if it has) is covered by AC2 above. AC8 simply records that the cross-reference exists at the editing-order bullet, in either form, so the Gate 3 reviewer has an explicit verification point.

- [ ] **AC9 — Top-of-file metadata is updated to v1.3.** The `**Status**: APPROVED` line at the top of the file (line 3 of v1.2) stays APPROVED; the `**Last Reviewed**` and `**Approved**` dates (currently `2026-05-16`, lines 4–5) are updated to the implementation date matching AC5's Version History entry. The file does not transition to DRAFT at any point during this Task (per EPIC-008 AC#4 — additive amendments do not require DRAFT transition).

- [ ] **AC10 — Additivity verification performed and recorded.** Per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* (lines 249–254): an amendment is *additive* iff it does not contradict existing approved claims. The implementing Task verifies — by reading each new piece of prose (AC1 editing-order bullet, AC3 Push Cadence subsection, AC4 Pre-Commit checklist item, AC5 Version History entry, AC6 Commit Cadence cross-reference addition, AC9 metadata refresh) against the existing prose of the same sections — that no new prose contradicts any existing approved claim. The verification is recorded in Implementation Notes as a single sentence per amendment (e.g. "AC3 Push Cadence — additive: existing Commit Cadence is silent on push frequency; new subsection adds claims, does not revise existing ones"). If any amendment turns out non-additive (unexpected), the Task pauses and the implementer flags the contradiction to the directing party rather than landing silently.

- [ ] **AC11 — Scope is bounded; no out-of-scope file modified.** This Task modifies exactly the following files: `docs/development_guide.md` (the substantive amendments per AC1–AC9); `docs/tasks/TASK-007-amend-development-guide-new-conventions.md` (Implementation Notes, Review, Activity Log — the standard work-item bookkeeping); `docs/tasks/task_index.md` (status transitions and the Tasks list entry — standard bookkeeping); `docs/epics/EPIC-008-development-conventions-from-dogfooding.md` (the Plan → Tasks entry for this Task, updated to reflect APPROVED; the Plan paragraph already names this Task by ID so no other edit is required). **No other file is modified.** Specifically out of scope: any file under `shannon/skills/` (Task 2's territory); any file under `.claude/` (Task 2's re-sync territory); `docs/conceptual_design.md` (EPIC-007's territory); any work-item template under `shannon/skills/*/templates/`; any other mandated document (`vision.md`, `technology_stack.md`, `conceptual_design.md`, `technical_design.md`, `ux_guide.md`); `docs/scratchpad.md` (Gate 3 review work); `docs/knowledge/` (Gate 3 review work). This AC is phrased as a cross-type guard per EPIC-007 AC#4's about-to-be-codified scope-boundary rule rather than as a literal file count — the precedent is the three-instance fragility pattern in TASK-002 / TASK-003 Reviews; the rule's substance pre-dates its ratification by EPIC-007.

- [ ] **AC12 — Implementation does not commit mid-implementation.** Per `development_guide.md` § Commit Cadence (the very rule this Task extends), the implementer does not commit until Gate 3 approval. Pre-Gate-3 experimentation is fine — multiple in-progress diffs are expected — but no `git commit` runs before Gate 3 approval lands. The Gate-3 commit also triggers a push per the new Push Cadence subsection (AC3 trigger (a)). This AC governs the Task's own execution, not its output; verified at Gate 3 by checking `git log` for any pre-Gate-3 commit on this Task's diff range.

### Context

- **Parent Epic**: [EPIC-008 — Development Conventions Surfaced Through Dogfooding](../epics/EPIC-008-development-conventions-from-dogfooding.md) — this is Task 1 of 2; closes EPIC-008 AC#1 (AC1–AC2), AC#2 (AC3), AC#3a (AC4), AC#4 (AC5 + AC9), AC#5 outbound half (AC6–AC8). EPIC-008 AC#3b is Task 2; EPIC-008 AC#5 inbound half is also Task 2; EPIC-008 AC#6 (scratchpad bookkeeping) and AC#7 (recursive-dogfood knowledge note) are Gate-3 review work for the Epic.
- **Parent Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md) — Ideal State bullets 2 ("Development disciplines surfaced during framework use are promoted into ratified `development_guide` rules via canonical work-item workflows") and 3 ("framework provides a routing channel for [resolved framework-general ambiguity → route it back]") anchor EPIC-008; this Task delivers the `development_guide.md` half of bullets 2 and 3.
- **Mandated document amended**: `docs/development_guide.md` v1.2 (APPROVED 2026-05-16). Confirmed anchor points: § Code Style → Patterns to Follow (lines 74–78, three existing bullets); § Git Workflow → Commit Cadence (lines 138–145) with § Pull Requests at line 147; § Testing Strategy → Pre-Commit Checklist (lines 105–112, four existing items); § Version History (line 177 onward; top entry `### 2026-05-16 - v1.2` at line 179, chronological convention most-recent-first). Top-of-file metadata at lines 3–5 (`Status: APPROVED`, `Last Reviewed: 2026-05-16`, `Approved: 2026-05-16`).
- **Additivity reference**: `docs/conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* (lines 249–254) — defines additive amendment as content that does not contradict existing approved claims; document stays APPROVED through the edit. AC10 enacts this test.
- **Cross-Epic forward reference target**: EPIC-007 AC#4 names the anchor home as `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (a new entry to be landed by EPIC-007's `conceptual_design` amendment Task). The anchor does not exist at this Task's landing time. AC2 handles the forward-only state per EPIC-008's risk-mitigation rule.
- **Sibling Task (EPIC-008 Task 2)**: not yet created; follows this Task strictly; will add the matching `work-items` skill prompts at § Process: Plan and § Process: Review and re-sync `.claude/skills/work-items/`. AC4's forward cross-reference resolves when Task 2 lands.
- **Cross-Epic siblings (EPIC-007 Tasks 1 and 2)**: EPIC-007 Task 1 amends `conceptual_design.md` — different file, can run in parallel with this Task without collision. EPIC-007 Task 2 amends `shannon/skills/work-items/skill.md` — collides with EPIC-008 Task 2 (not with this Task); not relevant here.
- **Relevant Guide for a Task (Informed By)**: `docs/development_guide.md` itself — somewhat circular (this Task amends it), but the existing Markdown conventions (§ Code Style → Markdown, lines 54–59), the Pre-Commit Checklist (lines 105–112), and Commit Cadence (lines 138–145) govern this Task's own execution.
- **Source artefacts** (the scratchpad items and prior session experience that motivate the conventions): the three scratchpad items addressed by EPIC-008 — *"Framework clarifications buried in TASK-003's Plan"* sub-item (a) editing-order; *"Meta-gap: no channel for feeding framework-general resolutions back"*; *"Push-frequency directive for development_guide"* — plus TASK-003 as the editing-order worked precedent.

---

## Plan

*Drafted at `/task-plan TASK-007` (Gate 2).*

### Approach

[Filled during planning.]

### Steps

1. [Step]
2. [Step]
3. [Step]

### Dependencies

- EPIC-008 PLANNED (met).
- `development_guide.md` v1.2 APPROVED (met — the document being additively amended).
- No dependency on EPIC-008 Task 2 or EPIC-007 — this Task can proceed independently.

### Risks

- [Risk — mitigation]

---

## Implementation Notes

[Filled during implementation.]

### Deviations from Plan

- [What changed and why]

### Gotchas

- [Problem encountered — resolution]

### Documents Updated

- [Documents updated during implementation, with sections]

---

## Review

[Filled during review (Gate 3).]

### Verification

- [ ] All acceptance criteria met
- [ ] Changes follow development_guide.md
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

[Findings from review. Issues found and how they were resolved.]

---

## Activity Log

- **2026-05-24** — ELABORATED via Gate 1. Elaboration subagent grounded each AC in the actual current `development_guide.md` v1.2 (Last Reviewed / Approved 2026-05-16). Confirmed anchor points: § Code Style → Patterns to Follow at lines 76–78 (three existing bullets; AC#1 appends fourth); § Git Workflow → Commit Cadence at 138–145 followed by Pull Requests at 147 (AC#2 inserts `### Push Cadence` heading between); § Testing Strategy → Pre-Commit Checklist at 109–112 (four existing items; AC#3a appends fifth); § Version History top entry at 179 (most-recent-first; AC#4 inserts `v1.3` above). EPIC-008 Plan's definitive location decisions match the file's reality at every point. 12 testable ACs drafted (AC1–AC12), traced 1:1 to EPIC-008 ACs: AC1–AC2 → EPIC-008 AC#1 (editing-order bullet substance + cross-Epic forward reference); AC3 → AC#2 (Push Cadence subsection); AC4 → AC#3a (meta-gap checklist line with verbatim trigger phrasing); AC5 + AC9 → AC#4 (Version History entry + top-of-file metadata refresh); AC6–AC8 → AC#5 outbound cross-references (Push Cadence ↔ Commit Cadence bidirectional, Pre-Commit Checklist → skill prompts forward, editing-order ↔ EPIC-007 AC#4 cross-Epic); AC10 covers additivity verification; AC11 covers cross-type scope boundary; AC12 covers no-commit-mid-implementation. Cross-Epic forward reference (AC2) enacts EPIC-008 Plan Risk 7 directly — inline HTML comment naming "anchor will be created by EPIC-007's implementing Task per EPIC-007 AC#4" so forward-only state is visible. One small Gap surfaced and captured as AC6: EPIC-008 AC#5's Push Cadence ↔ Commit Cadence pair needs the reciprocal Commit Cadence → Push Cadence direction; adds tiny additive edit to existing Commit Cadence prose. Otherwise all Strength — no Drift, no internal contradiction. Directing party approved without modification.
- **2026-05-24** — DRAFT: Task created via `/task-create` under EPIC-008 as Task 1 of 2 (the `development_guide.md` amendments half). EPIC-008's Plan already resolved definitive location decisions (AC#1 → § Code Style → Patterns to Follow new bullet; AC#3a → § Testing Strategy → Pre-Commit Checklist new line) and noted out-of-scope items (AC#3b skill prompts → Task 2; AC#6 scratchpad bookkeeping + AC#7 recursive-dogfood record → Gate 3 review). Initial intent captured in the Overview; Acceptance Criteria and Plan to be drafted at `/task-elaborate` and `/task-plan`. This Task is independent of EPIC-007's implementing Tasks (different mandated doc) and so can proceed in parallel with EPIC-007 Task 1; it is also independent of the cross-Epic `work-items/skill.md` sequencing concern (that lands in Task 2).
