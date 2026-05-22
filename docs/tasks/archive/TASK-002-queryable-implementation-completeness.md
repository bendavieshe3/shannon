# TASK-002: Queryable Implementation Completeness for Features

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #templates #work-items #features
- **Created**: 2026-05-19
- **Updated**: 2026-05-22 (approved)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-006 § Plan (Gate 2). Not yet reviewed at Gate 1. Surfaces when `/task-elaborate TASK-002` is invoked.*

### Overview

Make Feature implementation completeness visible at the metadata level without an Activity Log dive. Features currently carry an `Initial Implementation: Built through Shannon | Retrospective | Partial — see Activity Log` field, but the "Partial" details are buried. Extend the feature template with a structured Partial-completeness sub-block (what is met, what is remaining) emitted only when `Initial Implementation` is Partial. Canonise the existing informal `(Partial)` suffix in `docs/features/feature_index.md` by documenting it in the index's Notes section.

The goal is at-a-glance visibility and mechanical queryability (`grep "(Partial)" feature_index.md` returns all partial Features; the Feature file's sub-block parses by humans and AI without deep reading). The affordance is deliberately scoped to Features — other work-item types (Epic, Task, Spike) capture their completeness through status; Features are the only persistent capability type where Partial-ness lives in the gap between Ideal State and current implementation, independent of lifecycle position.

**Scope boundary**: This Task delivers the template + index changes (template gains the structured sub-block as a commented stub; index Notes section canonises the `(Partial)` annotation rule). Application of the new affordance to FEAT-003 and FEAT-006 on real data — and fixing the pre-existing inconsistency where FEAT-006's index entry lacks `(Partial)` despite its body carrying `Initial Implementation: Partial` — belongs to EPIC-006's forward-declared follow-up Task, not this one.

### Acceptance Criteria

- [x] `shannon/skills/work-items/templates/feature.md` carries a structured Partial-completeness sub-field **directly beneath the `Initial Implementation` line inside the Metadata block** (anchor: template line 9); emitted only when `Initial Implementation` is Partial (sharpened — single canonical location)
- [x] The sub-block uses an explicit `**Met:**` / `**Remaining:**` bullet structure, **distinct from** the inline `*(met)*` / `*(partly met)*` annotations that may decorate Ideal State bullets; the two patterns coexist (sub-block summarises `Initial Implementation` headline; inline annotations decorate per-aspiration Ideal State items) (new — disambiguates from FEAT-003's existing pattern)
- [x] The `feature.md` template carries a commented stub for the sub-block (e.g. `<!-- Partial sub-block: emit only if Initial Implementation is Partial -->`) at the canonical location, so adopters discover the affordance even when their Feature is not Partial (new — emission discoverability)
- [x] `docs/features/feature_index.md` Notes section (lines 13-21) documents the `(Partial)` trailing suffix as canonical, including the rule that triggers its presence (sharpened — names the Notes section explicitly)
- [x] Applying or removing the `(Partial)` suffix in `feature_index.md` is a `work-items` skill responsibility on `Initial Implementation` field changes — not a manual convention (new — closes the drift mode that produced FEAT-006's missing suffix)
- [x] Scope boundary is explicit: only `feature.md` and `feature_index.md` are modified; `epic.md`, `task.md`, `spike.md` templates and their indexes are untouched because Epic/Task/Spike completeness is captured by status, not by an implementation-completeness field (new — verifiable scope-creep guard)
- [x] Affordance is mechanically queryable: `grep "(Partial)" docs/features/feature_index.md` returns all partial Features; the Feature file's Partial sub-block parses by humans and AI at a glance, without reading the Activity Log
- [x] Gate 3 verification: `grep "(Partial)" docs/features/feature_index.md` and `grep -l "Initial Implementation: Partial" docs/features/FEAT-*.md` return consistent sets (modulo this Task's deferral of the dogfood pass — pre-existing FEAT-006 inconsistency will be fixed by EPIC-006's forward-declared follow-up Task) (new — testable queryability)
- [x] Affordance is proportionate — no new substatus, no schema migration of existing approved Features beyond the targeted dogfood application (trimmed — parenthetical moved to Overview)

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

Implemented 2026-05-22 via `/task-implement TASK-002` in a single session, following the Gate 2 four-step plan (template → index → skill → consistency pass). The Task ships the *mechanism* for queryable Partial completeness; application to real Features is deferred to EPIC-006's forward-declared follow-up Task per the Overview scope boundary.

**Step 1 — feature template** (`shannon/skills/work-items/templates/feature.md`): inserted an HTML-commented Partial-completeness sub-block stub directly beneath the `Initial Implementation` metadata line. The stub shows the `**Met:** / **Remaining:**` bullet shape and explicitly names its non-overlap with the inline `*(met)* / *(partly met)*` Ideal State annotations. Decision: kept the affordance as an HTML comment only (not an always-visible blockquote line) — the template is a source artefact edited as raw Markdown, so the comment is discoverable to whoever instantiates a Feature; an extra blockquote sentence was considered and rejected as disproportionate (AC#9). Covers AC#1–3.

**Step 2 — feature index** (`docs/features/feature_index.md`): added a **Partial suffix** bullet to the Notes section canonising `(Partial)` as a trailing token present iff the body's `Initial Implementation` field reads `Partial`, maintained by the `work-items` skill. Also updated the **Format** line to `… Feature Name [(Partial)] #tags` so the documented format matches the canonical convention. Covers AC#4 and the index-side half of AC#5.

**Step 3 — work-items skill** (`shannon/skills/work-items/skill.md`): placement chosen — primary rule under § Process: Create step 7 (*Update Index*), with a reconciliation cross-reference appended to § Failure Modes (*Index out of sync*). Rationale: step 7 is the skill's index-maintenance home and the rule is phrased to cover create / re-elaboration / Epic-closeout; the Failure Modes entry frames the FEAT-006-style missing-suffix bug as exactly an index-out-of-sync condition, which is the drift mode AC#5 closes. Matches plan option (a) (note + reference) over option (b) (Failure-Modes-only), chosen for the active-responsibility framing AC#5 requires. Covers AC#5.

**Step 4 — cross-file consistency pass**: `Initial Implementation`, `Partial`, and `(Partial)` appear with identical capitalisation and punctuation across all three files. `git diff --stat` confirms exactly four files changed — `feature_index.md`, this Task file, `skill.md`, `feature.md` template — none of them `epic.md` / `task.md` / `spike.md` or their indexes (AC#6). `grep "(Partial)" docs/features/feature_index.md` returns FEAT-003 (AC#7). No new statuses or schema migrations (AC#9).

**Deployed-copy sync**: `.claude/skills/work-items/skill.md` and `.claude/skills/work-items/templates/feature.md` re-synced from `shannon/` source via `cp` (the `.claude/` tree is gitignored and is the copy Claude Code actually loads).

**Findings surfaced during implementation** (for Gate 3 and the EPIC-006 follow-up Task — not fixed here, as application is out of scope):

1. **FEAT-007 is also Partial.** A `grep` of the `Initial Implementation` field shows *three* Features carry `Partial`: FEAT-003, FEAT-006, **and FEAT-007** (Lightweight Idea Capture). EPIC-006 (Acceptance Criteria, F2 bullet 4) and this Task's own Context name only "FEAT-003 and FEAT-006" as the Partial set. FEAT-007's `feature_index.md` entry also lacks the `(Partial)` suffix. The forward-declared follow-up Task must widen its dogfood scope from two Features to three; EPIC-006's F2 bullet 4 and recursive-dogfood criteria are now understated. This is a genuine drift the new affordance is designed to catch — flagged for the directing party.

2. **AC#8's example grep is slightly mis-worded.** AC#8 cites `grep -l "Initial Implementation: Partial" docs/features/FEAT-*.md`, but the field name is bold in the actual files (`**Initial Implementation**: Partial`), so that literal pattern matches nothing. The working pattern is `grep -l "Initial Implementation\*\*: Partial"`. The AC's *intent* — index ↔ body consistency — is unaffected; only the example command needs the bold markers. Minor; noted for Gate 3.

**Gate 3 state of AC#8**: `grep "(Partial)" feature_index.md` → {FEAT-003}; the body-Partial set → {FEAT-003, FEAT-006, FEAT-007}. The sets differ by FEAT-006 *and* FEAT-007. AC#8 anticipated the FEAT-006 deferral only; FEAT-007 is the newly-discovered case. Both differences are resolved by the EPIC-006 follow-up Task, not by this Task.

---

## Review

**Gate 3 — APPROVED 2026-05-22.** A verification subagent audited all 9 Acceptance Criteria against the three changed files (`feature.md` template, `feature_index.md`, `work-items` skill) and checked alignment with EPIC-006 and FEAT-003. Verdict: *ready with noted caveats* — the mechanism this Task was scoped to deliver is fully and correctly implemented; every AC's intent is met.

**AC results**: AC#1–5, 7, 9 fully met. AC#6 and AC#8 met in *intent* but only partially demonstrable as *worded* — both trace to defects in the AC text written at Gate 1, not to the implementation. AC wording is left intact as the Gate 1 historical record; corrections are owed to EPIC-006.

**Caveat 1 — AC#6 internal contradiction.** AC#6 reads "only `feature.md` and `feature_index.md` are modified", but AC#5 requires a `work-items` skill change and the Gate 2 Plan names three in-scope files. The two ACs cannot both be literally true; the contradiction passed Gate 1 and Gate 2 unflagged. The cross-type scope guard AC#6 actually intended — *no epic/task/spike template or index modified* — is fully satisfied (`git diff --stat` confirms). AC#6 should be re-worded to a cross-type-guard phrasing. Does not warrant iterating TASK-002.

**Caveat 2 — AC#8 + FEAT-007 drift.** The index↔body consistency check cannot pass cleanly today: the `(Partial)` index suffix is on {FEAT-003}; the body-Partial set is {FEAT-003, FEAT-006, FEAT-007}. AC#8 anticipated the FEAT-006 deferral only — FEAT-007 (Lightweight Idea Capture) is a third Partial Feature no planning artefact had accounted for. EPIC-006 F2 bullet 4 and the forward-declared follow-up Task both name only "FEAT-003 and FEAT-006"; that scope must widen to three Features. Additionally AC#8's example command `grep -l "Initial Implementation: Partial"` matches nothing — the field name is bold (`**Initial Implementation**`); the working pattern needs `\*\*`.

**Strengths**: three-file terminological consistency (`Initial Implementation` / `Partial` / `(Partial)` identical across template, index and skill, with mutual cross-references); honest defect disclosure in Implementation Notes (FEAT-007 and the AC#8 grep surfaced proactively and routed to the correct owner); scope discipline — the cross-type guard held exactly. The new affordance caught the FEAT-007 drift on its first use: the dogfood worked as designed.

**Follow-up obligations recorded against EPIC-006** (the Epic's own Gate 3 must verify these are closed):

1. EPIC-006 F2 bullet 4 and the recursive-dogfood criteria re-elaborated to name three Partial Features, not two.
2. The forward-declared follow-up Task applies the affordance to FEAT-003, FEAT-006 *and* FEAT-007 — fixing the missing `(Partial)` index suffix on FEAT-006 and FEAT-007.
3. AC#6 wording defect and AC#8 example-grep defect acknowledged (historical — TASK-002's ACs remain as the Gate 1 record; the corrections live in EPIC-006).

---

## Activity Log

- **2026-05-22** — APPROVED via Gate 3. Directing party approved, accepting the two documented caveats (AC#6 wording contradiction; AC#8 / FEAT-007 drift) — both routed to EPIC-006 as follow-up obligations, neither warranting iteration on this Task. All 9 Acceptance Criteria checked. Status REVIEW → APPROVED; file archived to `docs/tasks/archive/`. Mechanism for queryable Partial completeness delivered (EPIC-006 F2 bullets 1-3). See Review section.
- **2026-05-22** — REVIEW. Status IMPLEMENTED → REVIEW; Gate 3 verification subagent spawned to audit all 9 Acceptance Criteria against the three changed files and check alignment with EPIC-006 and FEAT-003.
- **2026-05-22** — IMPLEMENTED. Four-step plan executed across three files (`feature.md` template stub, `feature_index.md` Notes + Format line, `work-items` skill enforcement) plus deployed-copy sync. All 9 Acceptance Criteria addressed at the mechanism level. Two findings surfaced for the EPIC-006 follow-up Task: FEAT-007 is also Partial (the Partial set is three Features, not the two EPIC-006 names), and AC#8's example grep needs bold markers around the field name. See Implementation Notes. Ready for Gate 3.
- **2026-05-22** — IMPLEMENTING via `/task-implement TASK-002`. Status PLANNED → IMPLEMENTING; executing the four-step plan (template stub → index Notes → skill enforcement → cross-file consistency pass).
- **2026-05-21** — PLANNED via Gate 2. Plan section populated: template → index → skill ordering, each later edit citing the earlier as already-canonical (avoids forward references). Four ordered steps across three files: (1) feature template gets HTML-commented stub for Partial sub-block beneath line 9; (2) feature_index Notes section appends bullet documenting `(Partial)` as canonical with the "iff body has Initial Implementation: Partial" rule; (3) work-items skill gains enforcement language with placement choice recorded in Implementation Notes; (4) cross-file consistency pass with mental grep verification and scope-boundary check. Four risks captured with mitigations tied to numbered steps (over-formalisation, three-file drift, skill placement ambiguity, inline annotation confusion). Each step explicitly annotated with the AC(s) it covers; no Plan gaps against the 9 Acceptance Criteria. Subagent verdict: ready for Gate 2 approval. Approved by directing party 2026-05-21.
- **2026-05-20** — ELABORATED via Gate 1. Elaboration verified the pre-stashed Requirements against current upstream state and the actual implementation surface (`feature.md` template, `feature_index.md` Notes section, FEAT-003's existing inline `*(met)*` annotation precedent). Real upstream-data finding surfaced: FEAT-006 has `Initial Implementation: Partial` in its body but its index entry lacks the `(Partial)` suffix — pre-existing inconsistency the dogfood follow-up Task will absorb. Refinements applied:
  - 5 new Acceptance Criteria — sub-block bullet structure distinct from inline annotations; commented stub in template for emission discoverability; skill-enforced index suffix (closes the drift mode that produced FEAT-006's missing suffix); cross-type scope boundary as a verifiable AC; Gate 3 two-sided grep verification (index ↔ body consistency)
  - 3 sharpenings — single canonical sub-block location (was "Metadata or directly beneath"); explicit Notes-section anchor (lines 13-21); proportionality AC trimmed of parenthetical (moved to Overview)
  - Context: added Files-explicitly-NOT-in-scope bullet naming epic.md / task.md / spike.md with rationale
  - Overview: scope-boundary paragraph added — Task delivers template + index changes only; live application to FEAT-003 / FEAT-006 belongs to the forward-declared follow-up Task
  AC count: 4 → 9 (5 new + 3 sharpened + 1 unchanged). Scope unchanged; rigour increased. No drift against upstream. Verdict from elaboration verification: ready with minor refinements; refinements applied.
- **2026-05-19** — DRAFT: Task created via EPIC-006's planning (option-b cascading pattern). Requirements section pre-stashed; will surface when `/task-elaborate TASK-002` is invoked. Plan section deferred to `/task-plan`.
