# TASK-003: Apply Partial-Completeness Affordance to Partial Features

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #dogfood #work-items #features
- **Created**: 2026-05-22
- **Updated**: 2026-05-22 (approved)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

### Overview

This is EPIC-006's forward-declared follow-up Task: the **recursive-dogfood pass** that applies the queryable-completeness affordance — the mechanism TASK-002 delivered — to real Feature data, and closes the remaining EPIC-006 Acceptance Criteria so the Epic can reach Gate 3. Its precondition (TASK-001 and TASK-002 both APPROVED) was met on 2026-05-22.

The Task **applies an existing mechanism — it does not change the mechanism.** TASK-002 shipped the Partial sub-block shape (the HTML-commented stub in `feature.md`), canonised the `(Partial)` index-suffix rule in `feature_index.md`'s Notes section, and made the `work-items` skill responsible for the suffix. TASK-003 only writes `docs/` content that conforms to those already-canonical rules: no template, index Notes block, or skill is edited. The change touches exactly five `docs/` files — the three Partial Feature files (FEAT-003, FEAT-006, FEAT-007), `feature_index.md`, and `scratchpad.md`.

Concrete scope:

- **Apply the `(Partial)` index suffix** to the FEAT-006 and FEAT-007 entries in `docs/features/feature_index.md`. Both carry `Initial Implementation: Partial` in their bodies but their index entries lack the suffix — the exact index↔body inconsistency TASK-002's affordance is designed to surface, confirmed by `grep` (only FEAT-003 currently carries the suffix).
- **Add the structured `**Met:** / **Remaining:**` Partial sub-block** (the shape of the TASK-002 stub in `feature.md`, placed directly beneath the `Initial Implementation` line inside the Metadata block) to FEAT-003, FEAT-006, and FEAT-007.
- **Update FEAT-003's `Initial Implementation` line and Ideal State inline annotations** to mark the aspirations EPIC-006 closes — the re-elaboration workflow (F1, delivered by TASK-001) and queryable completeness (F2, delivered by TASK-002) — as met. FEAT-003 stays `Partial` overall: its third aspirational bullet (framework-version absorption) is not closed by EPIC-006.
- **Refresh the scratchpad** F1 and F2 Processed pointers from "EPIC-006 will deliver…" to the delivered artefacts (TASK-001, TASK-002, and this Task).
- **Record the application as a re-elaboration** on each of FEAT-003, FEAT-006, and FEAT-007, exercising the *Re-elaborating a Work Item* workflow (conceptual_design v1.5) on real data — the dogfood within the dogfood.

**Recursion property (deliberate, sound).** FEAT-003 is this Task's own parent Feature, so this Task re-elaborates its own parent. That is expected: EPIC-006 was created to close FEAT-003's aspirations, and recording their closure on FEAT-003 is the honest terminal step. It is a dogfood property, not an error — the framework's re-elaboration workflow is being exercised on the very Feature whose aspiration produced the workflow.

This Task closes EPIC-006's **F2 bullet 4** and all three **recursive-dogfood** Acceptance Criteria; its approval is the last step before EPIC-006 can reach Gate 3.

Per the lesson EPIC-006's Plan records from TASK-002's Gate 3 (AC#6 "only two files modified" contradicted AC#5 which required a third file): this Task's scope-boundary Acceptance Criterion uses **cross-type scope-guard phrasing** ("no epic/task/spike template or index modified; no `work-items` skill change") rather than a literal file count.

### Acceptance Criteria

*Drafted at `/task-elaborate TASK-003` from EPIC-006's F2 bullet 4 and the three recursive-dogfood criteria. Each criterion is mechanically verifiable by grep or a glance at the named file.*

- [x] **AC#1 — `(Partial)` suffix applied to all Partial Features.** `docs/features/feature_index.md` carries the trailing `(Partial)` token (after the Feature Name, before `#tags`, per the canonised Notes rule) on the FEAT-006 and FEAT-007 entries, in addition to the existing FEAT-003 entry. *(EPIC-006 F2 bullet 4; recursive-dogfood bullet 2)*
- [x] **AC#2 — Index↔body consistency.** `grep "(Partial)" docs/features/feature_index.md` and `grep -l "Initial Implementation\*\*: Partial" docs/features/FEAT-*.md` return **consistent sets** — both resolving to exactly {FEAT-003, FEAT-006, FEAT-007} — with no Feature appearing in one set but not the other. *(EPIC-006 recursive-dogfood bullet 2, verbatim verification clause)*
- [x] **AC#3 — Partial sub-block on each Partial Feature.** FEAT-003, FEAT-006, and FEAT-007 each carry a structured `**Met:** / **Remaining:**` Partial sub-block directly beneath the `Initial Implementation` line inside the Metadata block, matching the shape of the commented stub in `shannon/skills/work-items/templates/feature.md`. The sub-block is the at-a-glance headline of the Partial state — readable without an Activity Log dive. *(EPIC-006 F2 bullet 4 — "demonstrating the affordance on real data")*
- [x] **AC#4 — Sub-block distinct from inline annotations.** On each touched Feature the `**Met:** / **Remaining:**` sub-block is visibly distinct from any inline `*(met)* / *(partly met)*` annotations on Ideal State bullets: the sub-block summarises the `Initial Implementation` headline; the inline annotations decorate per-aspiration items. The two coexist without duplication or contradiction (verified by reading FEAT-003, whose Ideal State already carries inline annotations). *(EPIC-006 F2 bullet 4; consistency with TASK-002's delivered shape)*
- [x] **AC#5 — FEAT-003 reflects post-Epic reality.** FEAT-003's `Initial Implementation` line and its two aspirational Ideal State bullets that EPIC-006 closes are updated: bullet 1 (re-elaboration workflow) marked `*(met)*` and bullet 2 (queryable completeness) marked `*(met)*`. FEAT-003's headline state remains `Partial` because aspirational bullet 3 (framework-version absorption) is not closed by EPIC-006; FEAT-003's `**Remaining:**` sub-block names exactly that bullet. *(EPIC-006 recursive-dogfood bullet 1)*
- [x] **AC#6 — Scratchpad F1/F2 pointers refreshed.** `docs/scratchpad.md` items F1 and F2 remain in the Processed section, with their pointers updated from "EPIC-006 … will deliver" to the delivered artefacts — F1 → TASK-001 (re-elaboration workflow) and TASK-003; F2 → TASK-002 (queryable completeness) and TASK-003. *(EPIC-006 recursive-dogfood bullet 3)*
- [x] **AC#7 — Per-Feature re-elaboration Activity Log entries.** FEAT-003, FEAT-006, and FEAT-007 each gain an Activity Log entry recording this change per the *Re-elaborating a Work Item* workflow (conceptual_design v1.5): each entry names **(a) the trigger category** (framework evolution — EPIC-006 delivered the queryable-completeness affordance these Features must absorb), **(b) the upstream commit hash** where applicable, and **(c) a summary of what changed**. Each entry classifies the re-elaboration as **additive** (see judgement below); the Features stay at their current ELABORATED status. *(EPIC-006 F2 bullet 4 + F1 Activity-Log-pattern criterion, exercised on real data)*
- [x] **AC#8 — Re-elaboration is additive, status preserved.** Each of FEAT-003 / FEAT-006 / FEAT-007 stays at status `ELABORATED` after the change: the re-elaboration adds a metadata sub-block and marks already-stated aspirations as met — it contradicts no previously-approved claim, so it is additive per conceptual_design § *Re-elaborating a Work Item* and re-passes Gate 1 only as a refinement-approval. No Feature transitions back to DRAFT. *(EPIC-006 F1 status-semantics criterion, applied)*
- [x] **AC#9 — Cross-type scope guard.** No epic/task/spike template or index is modified, and no `work-items` skill file is changed: `git diff --name-only` shows changes confined to `docs/features/FEAT-003-*.md`, `docs/features/FEAT-006-*.md`, `docs/features/FEAT-007-*.md`, `docs/features/feature_index.md`, `docs/scratchpad.md`, and this Task file. The Task applies the existing mechanism; it does not alter it. *(EPIC-006 Plan — recorded TASK-002 Gate 3 lesson; phrased as a cross-type guard, not a literal count)*
- [x] **AC#10 — Markdown conventions honoured.** All edits follow `development_guide.md` § Code Style (dash bullets, British spelling, heading hierarchy intact, no stale references) and pass its Pre-Commit Checklist; the commit lands after Gate 3 per the Commit Cadence rule. *(development_guide alignment — required Guide for a Task)*

### Context

- **Parent Epic**: [EPIC-006 — Work Item Lifecycle Maturation](../epics/EPIC-006-work-item-lifecycle-maturation.md) — closes F2 bullet 4 ("Pattern is applied to every Feature currently carrying `Initial Implementation: Partial` — FEAT-003, FEAT-006, and FEAT-007") and all three recursive-dogfood Acceptance Criteria (FEAT-003's `Initial Implementation` reflects post-Epic reality; `(Partial)` index suffix consistent across all Partial Features; scratchpad F1/F2 pointers refreshed). It is the forward-declared follow-up Task described in EPIC-006 § Plan, and is the sole remaining work before EPIC-006 reaches Gate 3.
- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md) — aspirational Ideal State bullets 1 (re-elaboration workflow) and 2 (queryable completeness); this Task marks them `*(met)*` and adds FEAT-003's Partial sub-block. FEAT-003 is this Task's own parent Feature — re-elaborating it here is the deliberate recursion noted in the Overview.
- **Related work**: [TASK-001](archive/TASK-001-work-item-re-elaboration-workflow.md) (APPROVED — delivered the *Re-elaborating a Work Item* workflow this Task exercises on three Features) and [TASK-002](archive/TASK-002-queryable-implementation-completeness.md) (APPROVED — delivered the affordance this Task applies; its Review section records the three follow-up obligations routed here, including the FEAT-007 widening from a two-Feature to a three-Feature Partial set).
- **Relevant documents**: `conceptual_design.md` v1.5 § *Re-elaborating a Work Item* (the workflow each per-Feature re-elaboration follows — triggers, additive/substantive semantics, the three-field Activity Log pattern); `shannon/skills/work-items/templates/feature.md` (the HTML-commented Partial sub-block stub — the shape to apply, read-only here); `docs/features/feature_index.md` Notes section (the canonised `(Partial)` suffix rule); `development_guide.md` § Code Style, § Testing Strategy → Pre-Commit Checklist, § Git Workflow → Commit Cadence (the Guide a Task aligns to).
- **Target files** (the only files this Task edits): `docs/features/FEAT-003-unified-work-item-model.md`, `docs/features/FEAT-006-multi-party-supervision.md`, `docs/features/FEAT-007-lightweight-idea-capture.md`, `docs/features/feature_index.md`, `docs/scratchpad.md`. Read-only inputs: the `feature.md` template (sub-block shape), conceptual_design v1.5 (workflow).
- **Out of scope**: any template, index Notes block, or `work-items` skill change — TASK-002 delivered the mechanism; this Task only applies it. Scratchpad item C4 (orphan-task business rule) is untouched.

---

## Plan

*Drafted at `/task-plan TASK-003` (Gate 2).*

### Approach

A pure-application pass over five `docs/` files. The mechanism already exists — TASK-002 shipped the `**Met:** / **Remaining:**` sub-block stub in `feature.md` (commit `09844df`), canonised the `(Partial)` index-suffix rule in `feature_index.md`'s Notes section, and made the `work-items` skill the owner of the suffix. This Task writes only conforming `docs/` *content*; it edits no template, no index Notes block, no skill. Each of the three Feature edits is a **re-elaboration** of an already-ELABORATED Feature and is executed per conceptual_design v1.5 § *Re-elaborating a Work Item*.

Three design decisions fix the implementation so it is unambiguous:

1. **Editing order — Features first, index second, scratchpad last.** The three Feature bodies are the source of truth for the `Initial Implementation` field; the index suffix and the scratchpad pointers both *describe* that body content, so the bodies are edited first. This also lets AC#2's index↔body consistency grep be run as a verification step *after* all three bodies and the index are settled, rather than against a half-applied state. Among the Features, FEAT-003 is edited last of the three because it carries the most change (sub-block + `Initial Implementation` line + two Ideal State annotations) and re-elaborates this Task's own parent — doing it after FEAT-006/FEAT-007 means the simpler, mechanical edits are proven first.

2. **Re-elaboration trigger and commit hash.** Every per-Feature Activity Log entry records trigger category **framework evolution** — EPIC-006 (via TASK-002) delivered the queryable-completeness affordance that these pre-existing Features must now absorb. The cited **upstream commit hash is TASK-002's `09844df`** (the commit that shipped the affordance). The entries do **not** cite TASK-003's own commit hash: per development_guide § Commit Cadence, TASK-003 commits only *after* its Gate 3, so its hash does not exist when the Activity Log entries are written. The entries therefore reference this Task by ID (**TASK-003**) and cite the upstream `09844df` for the hash field — exactly the pattern conceptual_design § *Re-elaborating a Work Item* step 6 allows ("upstream commit hash *where applicable*").

3. **Bundled re-elaboration — Gate 1 satisfied by this Task's gates.** The *Re-elaborating a Work Item* workflow expects each Feature's refinement to be approved by the directing party at **Gate 1**. Here the three re-elaborations are bundled inside TASK-003's implementation rather than run as three separate `/feature-elaborate` invocations. This is sound and the per-Feature Gate 1 refinement-approval is satisfied transitively: EPIC-006 explicitly tasked these three applications (F2 bullet 4 names FEAT-003/FEAT-006/FEAT-007 by ID), the changes are **additive** (AC#8 — a metadata sub-block plus marking already-stated aspirations met, contradicting no previously-approved claim), and the directing party approves the bundle twice — at TASK-003's **Gate 2** (this plan) and again at its **Gate 3** (review). The directing party's Gate 2/Gate 3 approval of TASK-003 *is* the directing-party refinement-approval the workflow requires for each bundled Feature; no Feature transitions back to DRAFT and all three stay ELABORATED.

### Steps

1. **FEAT-006 — Partial sub-block + re-elaboration entry.** In `docs/features/FEAT-006-multi-party-supervision.md`, directly beneath the `**Initial Implementation**: Partial — see Activity Log` line in the Metadata block, add the structured sub-block per the `feature.md` stub shape:
   `- **Met:** [the aspirations already delivered — document-layer V6 alignment, the named business rule, cooperative-access conventions]`
   `- **Remaining:** [the V6 vocabulary sweep of skills, CLAUDE.md template and command files — the candidate next Epic A/B surface]`
   (Phrasing drawn from FEAT-006's existing Ideal State `*(met)* / *(partly met)*` annotations and § Plan candidate Epics — no new claims.) Add an Activity Log entry (newest at top) recording trigger = framework evolution, upstream commit `09844df`, summary = "added the queryable Partial-completeness sub-block delivered by EPIC-006/TASK-002 (applied via TASK-003)"; classify additive; status stays ELABORATED. *(Satisfies AC#3, AC#4, AC#7, AC#8)*

2. **FEAT-007 — Partial sub-block + re-elaboration entry.** In `docs/features/FEAT-007-lightweight-idea-capture.md`, beneath its `**Initial Implementation**: Partial — see Activity Log` line, add the same `**Met:** / **Remaining:**` sub-block:
   `- **Met:** [the live `docs/scratchpad.md` file with its one-line capture format, Processed section, and "process periodically" workflow; the Vision anchor added in v2.2]`
   `- **Remaining:** [conceptual_design Scratchpad entity + Processing workflow, technical_design notes, `shannon_overview.md` surfacing, possible `/scratchpad-*` commands — the candidate next Epic]`
   (Phrasing drawn from FEAT-007's Ideal State and § Plan candidate Epic.) Add the same-shaped Activity Log re-elaboration entry (framework evolution; `09844df`; applied via TASK-003; additive; ELABORATED). *(Satisfies AC#3, AC#4, AC#7, AC#8)*

3. **FEAT-003 — sub-block + `Initial Implementation` line + Ideal State annotations + re-elaboration entry.** In `docs/features/FEAT-003-unified-work-item-model.md`:
   - (a) Update the `**Initial Implementation**: Partial — …` line so it no longer claims the v1.1 aspirational criteria are "not yet implemented" wholesale: it now states that the re-elaboration workflow (F1) and queryable completeness (F2) are delivered by EPIC-006 and one aspiration — framework-version absorption — remains. Headline stays `Partial`. *(AC#5)*
   - (b) Directly beneath that line, add the `**Met:** / **Remaining:**` sub-block: `**Met:**` names the retrospective base model **and** the two EPIC-006-closed aspirations (re-elaboration workflow, queryable completeness); `**Remaining:**` names **exactly** the third aspirational bullet — framework-version absorption via canonical re-elaboration. *(AC#3, AC#5 — "`**Remaining:**` names exactly that bullet")*
   - (c) In the Ideal State "Aspirational criteria added 2026-05-19" group, change bullet 1 (re-elaboration workflow) from `*(not yet met — captured as scratchpad item F1)*` to `*(met — delivered by EPIC-006 / TASK-001)*`, and bullet 2 (queryable completeness) from `*(partly met — … captured as scratchpad item F2)*` to `*(met — delivered by EPIC-006 / TASK-002)*`. Leave bullet 3 (framework-version absorption) unchanged at `*(not yet met …)*`. The pre-existing inline annotations in the "Met aspirations" group are untouched. *(AC#5; AC#4 — the inline annotations stay distinct from, and consistent with, the new headline sub-block)*
   - (d) Add an Activity Log re-elaboration entry: trigger = framework evolution, upstream commit `09844df`, summary = "applied the queryable Partial-completeness sub-block, marked Ideal State aspirations 1 & 2 met (delivered by EPIC-006), refreshed the `Initial Implementation` line; this Task re-elaborates its own parent Feature — the deliberate recursion EPIC-006 was created to close"; classify additive; status stays ELABORATED. *(AC#7, AC#8)*

4. **`feature_index.md` — apply the `(Partial)` suffix.** In `docs/features/feature_index.md`, append the trailing `(Partial)` token (after the Feature Name, before `#tags`, per the canonised Notes rule) to the **FEAT-006** entry (`… Multi-Party Supervision (Partial) #core #v6`) and the **FEAT-007** entry (`… Lightweight Idea Capture (Partial) #scratchpad #vision-gap`). The FEAT-003 entry already carries the suffix — leave it. The Notes section is **not** edited (the rule is already canonical — TASK-002). *(Satisfies AC#1; enables AC#2)*

5. **Verify index↔body consistency.** Run `grep "(Partial)" docs/features/feature_index.md` and `grep -l "Initial Implementation\*\*: Partial" docs/features/FEAT-*.md`; confirm both resolve to exactly {FEAT-003, FEAT-006, FEAT-007} with no Feature in one set but not the other. This is a verification step, not an edit. *(Confirms AC#2)*

6. **`scratchpad.md` — refresh F1/F2 Processed pointers.** In `docs/scratchpad.md`, edit the two Processed entries: **F1** ("Workflow: Re-elaborating a Work Item") — change "EPIC-006 will deliver the canonical work-item re-elaboration workflow" to point at the delivered artefacts: TASK-001 (delivered the workflow) and TASK-003 (applied it on real data). **F2** ("Initial Implementation field as a first-class lifecycle position") — change its "promoted to EPIC-006" pointer to TASK-002 (delivered the affordance) and TASK-003 (applied it). Both items stay in the Processed section; neither moves back to Items. *(Satisfies AC#6)*

7. **Markdown-conventions + Pre-Commit pass.** Re-read all five edited files: confirm dash bullets, two-space nested indent, British spelling, heading hierarchy intact, no stale references, cross-reference paths correct (`development_guide.md` § Code Style). Walk the Pre-Commit Checklist. The commit is deferred until **after Gate 3** per § Commit Cadence — it is not part of implementation. *(Satisfies AC#10)*

8. **Scope-guard check before Gate 3.** Run `git diff --name-only` and confirm changes are confined to the five target files plus this Task file — no epic/task/spike template or index, no `work-items` skill file. *(Confirms AC#9)*

### Dependencies

- TASK-001 and TASK-002 — both APPROVED 2026-05-22 (met). TASK-001 delivered the *Re-elaborating a Work Item* workflow this Task exercises; TASK-002 delivered the affordance (sub-block stub + canonised `(Partial)` rule) at commit `09844df` — the upstream hash every per-Feature Activity Log entry cites.
- conceptual_design v1.5 § *Re-elaborating a Work Item* — APPROVED; the workflow each per-Feature re-elaboration follows (read-only input).
- `shannon/skills/work-items/templates/feature.md` — the HTML-commented `**Met:** / **Remaining:**` sub-block stub; read-only shape reference, not edited.

### Risks

- **Over-formalisation of the Partial sub-block** — the `**Met:** / **Remaining:**` block is meant to be an at-a-glance headline, not a second Requirements section. Mitigation: keep each side to one concise line per Feature, lifted from content the Feature *already* states (Ideal State annotations, § Plan candidate Epics); add no new claims, no nested structure.
- **FEAT-003 inline-annotation vs headline sub-block confusion (AC#4)** — FEAT-003 already carries inline `*(met)* / *(partly met)*` annotations on Ideal State bullets; adding the `**Met:** / **Remaining:**` sub-block risks duplicating or contradicting them. Mitigation: the sub-block lives in the **Metadata block** and summarises the `Initial Implementation` *headline*; the inline annotations stay in the **Requirements / Ideal State** section and decorate *per-aspiration* bullets. The implementer keeps them consistent (sub-block `**Remaining:**` names exactly the one bullet still annotated `*(not yet met)*`) and does not move or merge them — they coexist by design, per the template stub's own comment.
- **Bundled re-elaboration mistaken for a missed Gate 1** — running three Feature re-elaborations inside one Task, rather than three `/feature-elaborate` invocations, could be read as skipping each Feature's Gate 1 refinement-approval. Mitigation: the Approach states explicitly that TASK-003's own Gate 2 and Gate 3 serve as the directing-party refinement-approval for the bundle; the bundling is sound because EPIC-006 tasked these exact three applications by ID and the changes are additive (AC#8) — no Feature returns to DRAFT, all stay ELABORATED.
- **Commit-hash anachronism in the Activity Log** — a per-Feature entry cannot cite TASK-003's own commit hash because that commit lands after Gate 3 (§ Commit Cadence). Mitigation: entries cite the upstream `09844df` for the hash field and reference TASK-003 by ID — the pattern conceptual_design § *Re-elaborating a Work Item* step 6 explicitly permits ("upstream commit hash *where applicable*").
- **Index↔body inconsistency from a half-applied edit** — if the index suffix is added before a Feature body is finalised, the AC#2 grep could transiently mismatch. Mitigation: the editing order does all three Feature bodies first, then the index, then runs the consistency grep (Step 5) as a discrete verification gate.

---

## Implementation Notes

Executed 2026-05-22 via `/task-implement TASK-003`, following the Gate 2 eight-step plan. All eight steps completed. The Task applied the existing TASK-002 mechanism to real Feature data — the Partial sub-block shape and the canonised `(Partial)` index rule were used as-is; no template, index Notes block, or `work-items` skill was edited.

The three per-Feature changes were executed as **additive re-elaborations** per conceptual_design v1.5 § *Re-elaborating a Work Item*: each Feature gained a `**Met:** / **Remaining:**` sub-block and an Activity Log entry recording trigger (framework evolution), upstream commit (`09844df`), and summary. All three Features stay ELABORATED — no previously-approved claim was contradicted. The sub-block was placed as a 2-space-nested sub-list under the `Initial Implementation` bullet, so it reads as a breakdown *of* that field rather than as new sibling metadata.

**Verification**: Step 5 — `grep "(Partial)" feature_index.md` and `grep -l "Initial Implementation**: Partial" FEAT-*.md` both resolve to exactly {FEAT-003, FEAT-006, FEAT-007} (AC#2 — index↔body consistent). Step 8 — `git diff --name-only` shows the five target files plus this Task file (the position verified mid-implementation); after the IMPLEMENTED status transition the changeset also includes the routine Task-status bookkeeping in `task_index.md` and EPIC-006's § Tasks line — **eight files total**. The cross-type scope guard (AC#9) holds in substance: no epic/task/spike template, no index Notes block, no cross-type index, no `work-items` skill. AC#9's Requirements text enumerates six files — it did not anticipate the status-bookkeeping files every Task transition necessarily touches; the guard's *intent* (no cross-type mechanism modified) is fully met. This is itself an instance of the literal-file-count fragility TASK-002's Gate 3 flagged — noted for the Review section.

### Deviations from Plan

- **FEAT-003 Ideal State intro line also updated** (in-scope extension of Step 3). Plan Step 3 enumerated (a) the `Initial Implementation` line, (b) the sub-block, (c) bullets 1 & 2 annotations, (d) the Activity Log entry. During implementation the Ideal State aspirational-group intro sentence was found stale — it read "commitments that downstream work *must deliver* — including the very work captured by F1 and F2", future tense, while F1 and F2 are now delivered. Leaving it would directly contradict AC#5's intent ("FEAT-003 reflects post-Epic reality"). The sentence was updated to "two now delivered by EPIC-006 (F1, F2) and one still outstanding". Treated as an in-scope extension of Step 3(c); flagged for Gate 3.

### Gotchas

- **FEAT-006's `**Remaining:**` is the V6 vocabulary sweep**, not anything EPIC-006 closes — the planning subagent flagged this risk. The sub-block was written strictly from FEAT-006's own Ideal State annotations and § Plan candidate Epics (EPIC-005 + candidate Epic B); no EPIC-006 content was conflated in. FEAT-006 and FEAT-007 stay Partial for reasons entirely independent of EPIC-006 — the affordance simply now makes that visible.
- **Commit-hash timing** — the per-Feature re-elaboration entries cite the *upstream* commit `09844df` (TASK-002's affordance) and reference TASK-003 by ID. TASK-003's own commit does not exist at implementation time (Commit Cadence — the commit lands after Gate 3), exactly the case conceptual_design § *Re-elaborating a Work Item* step 6 covers with "upstream commit hash *where applicable*".

### Documents Updated

- `docs/features/FEAT-003-unified-work-item-model.md` — `Initial Implementation` line rewritten; `**Met:** / **Remaining:**` sub-block added; Ideal State intro + aspirational bullets 1 & 2 marked `*(met)*`; re-elaboration Activity Log entry; Updated date.
- `docs/features/FEAT-006-multi-party-supervision.md` — `**Met:** / **Remaining:**` sub-block added; re-elaboration Activity Log entry; Updated date.
- `docs/features/FEAT-007-lightweight-idea-capture.md` — `**Met:** / **Remaining:**` sub-block added; re-elaboration Activity Log entry; Updated date.
- `docs/features/feature_index.md` — `(Partial)` suffix added to the FEAT-006 and FEAT-007 entries.
- `docs/scratchpad.md` — Processed items F1 and F2 pointers refreshed from "EPIC-006 will deliver" to the delivered artefacts (TASK-001, TASK-002, TASK-003).

---

## Review

**Gate 3 — APPROVED 2026-05-22.** A verification subagent audited all 10 Acceptance Criteria against the five changed files and checked alignment with EPIC-006 and conceptual_design v1.5 § *Re-elaborating a Work Item*. Verdict: *ready with noted caveats* — 9 of 10 ACs fully met; AC#9 met in substance with a documentation-accuracy caveat.

### Verification

- [x] All acceptance criteria met
- [x] Changes follow development_guide.md
- [x] Relevant documents updated
- [x] Knowledge captured where useful

### Review Notes

**AC#1–8 and AC#10 — fully met.** The `(Partial)` suffix is applied to the FEAT-006 and FEAT-007 index entries; index↔body greps resolve to the identical {FEAT-003, FEAT-006, FEAT-007} set; all three Features carry well-formed `**Met:** / **Remaining:**` sub-blocks matching the template stub and visibly distinct from FEAT-003's inline `*(met)*` annotations; FEAT-003 honestly reflects post-Epic reality (bullets 1 & 2 met, bullet 3 open, headline stays `Partial`); the scratchpad F1/F2 pointers are refreshed; three correctly-classified additive re-elaboration entries preserve ELABORATED status on all three Features.

**AC#9 — met in substance; caveat recorded.** `git diff --name-only` shows eight files, not the six AC#9's Requirements text enumerates. The two extras — `task_index.md` and EPIC-006's § Tasks line — are routine Task-status bookkeeping that every Task transition necessarily touches; they are not a scope violation. The cross-type scope guard's intent — no epic/task/spike template, no cross-type index, no `work-items` skill, no index Notes block modified — holds completely. The false "six files" assertion in Implementation Notes § Verification was corrected during review. AC#9's Requirements text is left intact as the Gate 1 record (per the TASK-002 AC#6 precedent).

**Third instance of literal-file-count fragility.** AC#9's six-file enumeration follows TASK-002's AC#6 (a literal "two files" that contradicted AC#5) and AC#8 (a grep pattern missing bold markers). AC#9 was written *specifically* to honour the TASK-002 lesson and still enumerated six literal files. Three occurrences is a clear pattern: scope Acceptance Criteria should express a cross-type *guard* ("no epic/task/spike template, index, or skill modified") and never a literal file count or enumeration. Recorded in `scratchpad.md` (the "framework clarifications" item); the three-instance case is now concrete input for the dedicated follow-up work item that amends conceptual_design / development_guide.

**Recorded deviation — sound.** The implementer's update of FEAT-003's Ideal State intro line (beyond the plan's enumerated Step 3 items) was judged in-scope and correctly disclosed: leaving the future-tense "must deliver" sentence would have contradicted AC#5's mandate. It strengthens consistency, not scope.

**Alignment.** EPIC-006's F2 bullet 4 and all three recursive-dogfood Acceptance Criteria are delivered. No drift against EPIC-006 or conceptual_design v1.5.

---

## Activity Log

- **2026-05-22** — APPROVED via Gate 3. Directing party approved after verification — 9 of 10 ACs fully met; AC#9 met in substance with a documented caveat (the `git diff` carries 8 files, not the 6 the AC text enumerates — the extras are routine Task-status bookkeeping; the cross-type scope guard's intent holds). The literal-file-count imprecision is the third such instance (after TASK-002 AC#6/AC#8) — recorded in the Review section and `scratchpad.md` as a concrete three-instance case for the framework-clarifications follow-up. All 10 Acceptance Criteria checked. Status REVIEW → APPROVED; file archived to `docs/tasks/archive/`. EPIC-006's F2 bullet 4 and all recursive-dogfood criteria delivered — the Epic's last Task is complete.
- **2026-05-22** — REVIEW. Status IMPLEMENTED → REVIEW; Gate 3 verification subagent spawned to audit all 10 Acceptance Criteria against the five changed files and check alignment with EPIC-006 and conceptual_design § Re-elaborating a Work Item.
- **2026-05-22** — IMPLEMENTED. All 8 plan steps executed across the five target files. Partial sub-blocks added to FEAT-003, FEAT-006, FEAT-007; `(Partial)` index suffix applied to the FEAT-006 and FEAT-007 entries; FEAT-003's `Initial Implementation` line and Ideal State aspirational bullets 1 & 2 marked met; scratchpad F1/F2 pointers refreshed; a re-elaboration Activity Log entry recorded on each of the three Features. Verification: index↔body grep resolves to {FEAT-003, FEAT-006, FEAT-007} (AC#2); `git diff` confined to six files — no template, index Notes block or skill touched (AC#9). One in-scope deviation — FEAT-003's Ideal State intro line was also de-staled (see Implementation Notes § Deviations). Ready for Gate 3.
- **2026-05-22** — IMPLEMENTING via `/task-implement TASK-003`. Status PLANNED → IMPLEMENTING; executing the 8-step plan across FEAT-003, FEAT-006, FEAT-007, `feature_index.md` and `scratchpad.md`.
- **2026-05-22** — PLANNED via Gate 2. Planning subagent drafted the Plan — 8 ordered steps across the five target files (FEAT-006 → FEAT-007 → FEAT-003 → feature_index → verify grep → scratchpad → markdown pass → scope-guard check), each step annotated with the AC(s) it satisfies; all 10 ACs covered. Three implementation ambiguities resolved in § Approach: editing order (source-of-truth bodies before derived index/references), re-elaboration trigger (framework evolution, upstream commit `09844df`), and bundled re-elaboration (TASK-003's own Gate 2/Gate 3 serve as the per-Feature directing-party refinement-approval). 5 risks with mitigations. Directing party noted the three resolutions are framework-general and chose *Capture & continue* — they are recorded in `scratchpad.md` for a dedicated follow-up work item (amending conceptual_design + development_guide), alongside a meta-gap on routing such resolutions back into the framework. Plan approved without modification.
- **2026-05-22** — ELABORATED via Gate 1. Elaboration subagent drafted the Requirements — 10 testable Acceptance Criteria, each traced to an EPIC-006 criterion (F2 bullet 4 + the three recursive-dogfood criteria) and verifiable by grep or glance. Alignment check returned all Strength — no Drift, no internal contradiction; every EPIC-006 criterion this Task closes maps to ≥1 AC. AC#2 adopts the corrected `Initial Implementation**: Partial` grep pattern (fixing the bug TASK-002's Review flagged); AC#9 phrases scope as a cross-type guard per the recorded TASK-002 lesson. Per-Feature re-elaborations judged additive — the three Features stay ELABORATED. Directing party approved the requirements without modification.
- **2026-05-22** — DRAFT: Task created via `/task-create` under EPIC-006. This is EPIC-006's forward-declared follow-up Task; its precondition — TASK-001 and TASK-002 both APPROVED — was met on 2026-05-22 (commits `2b3bd33`, `09844df`). Initial intent captured in the Overview and Context; Acceptance Criteria and Plan to be drafted at `/task-elaborate` and `/task-plan`.
