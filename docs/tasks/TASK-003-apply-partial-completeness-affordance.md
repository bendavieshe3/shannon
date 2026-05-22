# TASK-003: Apply Partial-Completeness Affordance to Partial Features

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #dogfood #work-items #features
- **Created**: 2026-05-22
- **Updated**: 2026-05-22 (elaborated)

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

- [ ] **AC#1 — `(Partial)` suffix applied to all Partial Features.** `docs/features/feature_index.md` carries the trailing `(Partial)` token (after the Feature Name, before `#tags`, per the canonised Notes rule) on the FEAT-006 and FEAT-007 entries, in addition to the existing FEAT-003 entry. *(EPIC-006 F2 bullet 4; recursive-dogfood bullet 2)*
- [ ] **AC#2 — Index↔body consistency.** `grep "(Partial)" docs/features/feature_index.md` and `grep -l "Initial Implementation\*\*: Partial" docs/features/FEAT-*.md` return **consistent sets** — both resolving to exactly {FEAT-003, FEAT-006, FEAT-007} — with no Feature appearing in one set but not the other. *(EPIC-006 recursive-dogfood bullet 2, verbatim verification clause)*
- [ ] **AC#3 — Partial sub-block on each Partial Feature.** FEAT-003, FEAT-006, and FEAT-007 each carry a structured `**Met:** / **Remaining:**` Partial sub-block directly beneath the `Initial Implementation` line inside the Metadata block, matching the shape of the commented stub in `shannon/skills/work-items/templates/feature.md`. The sub-block is the at-a-glance headline of the Partial state — readable without an Activity Log dive. *(EPIC-006 F2 bullet 4 — "demonstrating the affordance on real data")*
- [ ] **AC#4 — Sub-block distinct from inline annotations.** On each touched Feature the `**Met:** / **Remaining:**` sub-block is visibly distinct from any inline `*(met)* / *(partly met)*` annotations on Ideal State bullets: the sub-block summarises the `Initial Implementation` headline; the inline annotations decorate per-aspiration items. The two coexist without duplication or contradiction (verified by reading FEAT-003, whose Ideal State already carries inline annotations). *(EPIC-006 F2 bullet 4; consistency with TASK-002's delivered shape)*
- [ ] **AC#5 — FEAT-003 reflects post-Epic reality.** FEAT-003's `Initial Implementation` line and its two aspirational Ideal State bullets that EPIC-006 closes are updated: bullet 1 (re-elaboration workflow) marked `*(met)*` and bullet 2 (queryable completeness) marked `*(met)*`. FEAT-003's headline state remains `Partial` because aspirational bullet 3 (framework-version absorption) is not closed by EPIC-006; FEAT-003's `**Remaining:**` sub-block names exactly that bullet. *(EPIC-006 recursive-dogfood bullet 1)*
- [ ] **AC#6 — Scratchpad F1/F2 pointers refreshed.** `docs/scratchpad.md` items F1 and F2 remain in the Processed section, with their pointers updated from "EPIC-006 … will deliver" to the delivered artefacts — F1 → TASK-001 (re-elaboration workflow) and TASK-003; F2 → TASK-002 (queryable completeness) and TASK-003. *(EPIC-006 recursive-dogfood bullet 3)*
- [ ] **AC#7 — Per-Feature re-elaboration Activity Log entries.** FEAT-003, FEAT-006, and FEAT-007 each gain an Activity Log entry recording this change per the *Re-elaborating a Work Item* workflow (conceptual_design v1.5): each entry names **(a) the trigger category** (framework evolution — EPIC-006 delivered the queryable-completeness affordance these Features must absorb), **(b) the upstream commit hash** where applicable, and **(c) a summary of what changed**. Each entry classifies the re-elaboration as **additive** (see judgement below); the Features stay at their current ELABORATED status. *(EPIC-006 F2 bullet 4 + F1 Activity-Log-pattern criterion, exercised on real data)*
- [ ] **AC#8 — Re-elaboration is additive, status preserved.** Each of FEAT-003 / FEAT-006 / FEAT-007 stays at status `ELABORATED` after the change: the re-elaboration adds a metadata sub-block and marks already-stated aspirations as met — it contradicts no previously-approved claim, so it is additive per conceptual_design § *Re-elaborating a Work Item* and re-passes Gate 1 only as a refinement-approval. No Feature transitions back to DRAFT. *(EPIC-006 F1 status-semantics criterion, applied)*
- [ ] **AC#9 — Cross-type scope guard.** No epic/task/spike template or index is modified, and no `work-items` skill file is changed: `git diff --name-only` shows changes confined to `docs/features/FEAT-003-*.md`, `docs/features/FEAT-006-*.md`, `docs/features/FEAT-007-*.md`, `docs/features/feature_index.md`, `docs/scratchpad.md`, and this Task file. The Task applies the existing mechanism; it does not alter it. *(EPIC-006 Plan — recorded TASK-002 Gate 3 lesson; phrased as a cross-type guard, not a literal count)*
- [ ] **AC#10 — Markdown conventions honoured.** All edits follow `development_guide.md` § Code Style (dash bullets, British spelling, heading hierarchy intact, no stale references) and pass its Pre-Commit Checklist; the commit lands after Gate 3 per the Commit Cadence rule. *(development_guide alignment — required Guide for a Task)*

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

[Filled during planning.]

### Steps

1. [Step]
2. [Step]
3. [Step]

### Dependencies

- TASK-001 and TASK-002 — both APPROVED 2026-05-22 (met)

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

- **2026-05-22** — ELABORATED via Gate 1. Elaboration subagent drafted the Requirements — 10 testable Acceptance Criteria, each traced to an EPIC-006 criterion (F2 bullet 4 + the three recursive-dogfood criteria) and verifiable by grep or glance. Alignment check returned all Strength — no Drift, no internal contradiction; every EPIC-006 criterion this Task closes maps to ≥1 AC. AC#2 adopts the corrected `Initial Implementation**: Partial` grep pattern (fixing the bug TASK-002's Review flagged); AC#9 phrases scope as a cross-type guard per the recorded TASK-002 lesson. Per-Feature re-elaborations judged additive — the three Features stay ELABORATED. Directing party approved the requirements without modification.
- **2026-05-22** — DRAFT: Task created via `/task-create` under EPIC-006. This is EPIC-006's forward-declared follow-up Task; its precondition — TASK-001 and TASK-002 both APPROVED — was met on 2026-05-22 (commits `2b3bd33`, `09844df`). Initial intent captured in the Overview and Context; Acceptance Criteria and Plan to be drafted at `/task-elaborate` and `/task-plan`.
