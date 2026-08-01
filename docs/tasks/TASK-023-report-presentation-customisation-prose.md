# TASK-023: Report-Presentation Customisation Prose

## Metadata

- **Status**: IMPLEMENTED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #presentation #documentation
- **Created**: 2026-07-18
- **Updated**: 2026-08-01

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated and approved at Gate 1 on 2026-08-01 (DRAFT → ELABORATED).*

### Overview

Add prose to `SKILL.md` documenting the diagnostic-only and conversational-only report-presentation customisations, defaulting to the hybrid shape EPIC-009 already shipped, and documenting that the SessionStart injection (TASK-025) uses the same terse three-count style (drift / stuck / push-lag counts, per EPIC-010 AC#3) as the report's diagnostic header, noting the leading count differs (drift-category count for SessionStart vs total findings in the report header). This is the reconciled, narrowed residual of EPIC-010 AC#2 — additive documentation only; the hybrid default itself was shipped by EPIC-009 TASK-015 and is not re-implemented here. Out of scope: any template/pipeline behaviour change; the SessionStart hook implementation (TASK-025).

### Acceptance Criteria

- [ ] **AC#1 — Customisation prose lands in `SKILL.md`.** Prose (near § Report Pipeline) documents the diagnostic-only and conversational-only customisations and names hybrid as the default. *Derives from* parent EPIC-010 AC#2(a); `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*.
- [ ] **AC#2 — SessionStart reuse documented.** `SKILL.md` states that the SessionStart terse injection presents the same terse three-count *style* as the report's hybrid diagnostic header — its counts are drift count, stuck items count, push lag count (per EPIC-010 AC#3). It notes explicitly that the SessionStart summary's leading count is the **Drift-category** count, whereas the report header's leading slot in `templates/header.md` is **total findings** (`{{FINDING_COUNT}}`); the two shapes share the terse form but differ in the first count. *Derives from* parent EPIC-010 AC#2(b) and AC#3.
- [ ] **AC#3 — No feature behaviour changed; hybrid default untouched.** The Task adds documentation only — it does not modify `templates/` or renumber the § Report Pipeline Flow steps (the `/shannon-goal` § Read-only reuse cross-references "Flow step 1" / "Flow steps 2–6" by number; TASK-024 and TASK-026 also anchor to Flow step numbers). Customisation prose lands as a paragraph or sub-heading, not as a new numbered Flow step. *Derives from* EPIC-009 § Report Pipeline (shipped); `conceptual_design.md` § Re-reviewing (additive).
- [ ] **AC#4 — Plain-prose discipline + scope-bounded edit.** Grep-verified phrases land as plain prose (parent AC#7); the Task edits `SKILL.md` prose only — no template, checker, hook, command, or other skill modified (cross-type-guard, parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary…Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Hybrid report presentation by default*
- **Relevant documents**: `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*
- **Related work**: EPIC-009 TASK-015 (shipped hybrid default); sibling TASK-025 (SessionStart reuses the documented shape)

---

## Plan

*Reconciled and approved at Gate 2 on 2026-08-02 (ELABORATED → PLANNED). Small enough that the plan was reconciled directly against the 4 Gate-1-corrected ACs rather than via a planning subagent.*

### Approach

A small **additive** `SKILL.md` prose change, authored in the tracked `./shannon/` source and deployed to `./.claude/` with a `diff`-confirm, per the *Source-of-truth body before derived artefacts* editing order. The prose lands **near § Report Pipeline as a paragraph or sub-heading — not as a new numbered Flow step** — so the by-number cross-references TASK-022 introduced ("Flow step 1" / "steps 2–6", also anchored by TASK-024/026) stay intact. No executable deliverable, no template or Flow-behaviour change; verified by plain-prose grep and a `git diff` scope check before commit.

### Steps

1. Add the customisation prose near § Report Pipeline (paragraph/sub-heading, not a Flow step): name **hybrid** as the shipped default and document **diagnostic-only** and **conversational-only** as valid project-level customisations, consistent with `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation* (AC#1).
2. Add the SessionStart-reuse prose (AC#2), keeping the two triples distinct: the report header (`templates/header.md`) leads with **total findings** (`{{FINDING_COUNT}}`), while the SessionStart summary leads with the **Drift-category** count — same terse three-count style (… / stuck / push-lag), different leading count (per EPIC-010 AC#3).
3. Deploy `SKILL.md` to `./.claude/`; `diff` source↔deploy to confirm byte-identical (AC#4 deploy).
4. Plain-prose grep of the landed verbatim phrases — the customisation terms and both count-triples — confirming each lands as plain prose with no markup interposing (AC#4, parent AC#7).
5. `git diff` scope-bounded verification (AC#3, AC#4): only `SKILL.md` (tracked side) changed; **no `templates/` change and no Flow step renumbered**; no checker, hook, script, command, mandated document, or other skill touched (cross-type guard).

### Dependencies

- **EPIC-009 APPROVED** (hybrid default + `templates/header.md` shipped — the shapes this prose documents).
- **Editing order** — follows TASK-022 (APPROVED) in the `SKILL.md` edit chain; precedes TASK-024/026 (which also edit `SKILL.md`). Documents the shape sibling **TASK-025** (SessionStart hook) later reuses, so it should land before TASK-025 is implemented.

### Risks

- Prose could drift from the shipped shapes — mitigated by quoting `templates/header.md` for the *report header* triple (findings / stuck / push-lag) and EPIC-010 AC#3 for the *SessionStart summary* triple (drift / stuck / push-lag), keeping the two shapes distinct rather than conflated.
- Prose accidentally renumbers or restructures the § Report Pipeline Flow, breaking TASK-022's by-number cross-references — mitigated by AC#3 (paragraph/sub-heading, not a Flow step) and the step-5 `git diff` check.
- `SKILL.md` edit collision with sibling Tasks — mitigated by editing-order sequencing (TASK-022 done; 023 before 024/026).

---

## Implementation Notes

*Filled during implementation (2026-08-02).*

### Deviations from Plan

- *None.* The prose landed exactly as planned — a new `### Presentation` sub-heading appended after the § Report Pipeline Flow (between the "only paths this pipeline writes" line and § Hook Integration), not as a numbered Flow step. The Flow remains 1–6 and TASK-022's "Flow step 1" / "steps 2–6" cross-references stay resolvable.

### Gotchas

- The two count-triples are deliberately written with `·` separators and the exact `templates/header.md` labels (Findings · Stuck or stale items · Push lag) for the report header, versus EPIC-010 AC#3's triple (Drift · stuck items · push lag) for the SessionStart summary — so a future reader sees the shared terse *style* and the differing leading count at a glance. This is the conflation the Gate-1 pass fixed; the prose is written to make the distinction unmissable rather than blur it.

### Documents Updated

- `shannon/skills/shannon-supervisor/SKILL.md` — added a `### Presentation` sub-heading under § Report Pipeline documenting the hybrid default + the diagnostic-only / conversational-only customisations (AC#1) and the SessionStart terse-style reuse with the two distinct count-triples (AC#2). Deployed to `./.claude/`, `diff`-confirmed byte-identical.
- No mandated document, template, checker, hook, script, command, or other skill modified (AC#3/AC#4 cross-type guard held; no `templates/` change, no Flow renumber).

---

## Review

*Filled during review (Gate 3).*

### Verification

- [ ] All acceptance criteria met
- [ ] Code follows development_guide.md
- [ ] Tests added or updated, passing
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

*Filled at Gate 3.*

---

## Activity Log

- **2026-08-02** — IMPLEMENTED. Executed the 5-step plan in a single pass (gateless zone). Added a `### Presentation` sub-heading under § Report Pipeline in `SKILL.md`: **AC#1** — names hybrid as the shipped default and documents diagnostic-only / conversational-only as valid project-level customisations, citing `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*; **AC#2** — documents the SessionStart terse-style reuse, keeping the two count-triples distinct (report header leads with total findings `{{FINDING_COUNT}}`; SessionStart summary leads with the Drift-category count; shared terse form, different leading count). Deployed to `./.claude/`, `diff` byte-identical. **AC#4**: all five key phrases (hybrid by default, diagnostic-only, conversational-only, leads with total findings, leads with the Drift-category count) confirmed to land as plain prose via `grep -F`. **AC#3**: Flow steps verified still numbered 1–6 (no renumber; TASK-022's four Flow-step cross-references remain resolvable), `templates/` untouched, `git diff` shows only `SKILL.md` on the tracked side — no checker, hook, script, command, mandated document, or other skill changed. Documentation-only prose, so grep + deploy-diff + scope check is the complete verification (no runtime surface to dogfood). Status: PLANNED → IMPLEMENTED. Ready for Gate 3 via `/task-review TASK-023`.
- **2026-08-02** — PLANNED (Gate 2 approved). Plan reconciled directly against the 4 Gate-1-corrected ACs (proportionate to a prose-only Task; no planning subagent). The prepared 5-step draft was already close; reconciliation named the source-before-deploy editing order in the Approach, made the paragraph/sub-heading-not-a-Flow-step constraint explicit (step 1 + AC#3), split the SessionStart-reuse step to keep the two count-triples distinct (step 2), and folded the Flow-renumbering guard into step 5's scope check. Added the second Risk (prose accidentally renumbering the Flow, breaking TASK-022's by-number cross-references). All 4 ACs map to steps (AC#1→1, AC#2→2, AC#3→1+5, AC#4→3+4+5). Directing party authorised commit-plan-implement as a batch. Status: ELABORATED → PLANNED.
- **2026-08-01** — ELABORATED (Gate 1 approved). Verification pass on the prepared draft against source. Confirmed sound and left untouched: **AC#1** (the diagnostic-only / conversational-only / hybrid-default distinction is verbatim in `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*, line 223 — not an invented distinction); **AC#4** (cross-type-guard scope phrasing complies); the (a)/(b) derivation mapping to EPIC-010 AC#2 is real; version citation v1.2 correct; landing site "near § Report Pipeline" survives TASK-022's `/shannon-goal` insertion. **One substantive fix — AC#2 conflation corrected**: the draft said SessionStart "reuses the hybrid/terse header-counts shape (drift / stuck / push-lag)", but the shipped `templates/header.md` leads with **total findings** (`{{FINDING_COUNT}}`), not drift; the drift/stuck/push-lag triple is the *SessionStart summary* shape (EPIC-010 AC#3), a sibling of the header shape, not the header itself. AC#2 (and the Overview + Plan Risk) rewritten to keep the two triples distinct — same terse style, different leading count — so the implemented prose cannot misstate the shipped template. **Structural guard added to AC#3**: TASK-022 introduced by-number cross-references to "Flow step 1"/"steps 2–6" in § Report Pipeline (TASK-024/026 also anchor to Flow step numbers), so the customisation prose must land as a paragraph/sub-heading, not a renumbered Flow step. **Parent note**: EPIC-010 AC#2's "reuses the shipped hybrid default" is loose against AC#3's different lead count, but it is defensible as reusing the presentation *approach*; not reverting the PLANNED parent — the Task-level fix removes the actual risk. Status: DRAFT → ELABORATED.
- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#2 (the narrowed customisation-docs residual after old Plan Task 2 was retired — EPIC-009 already shipped the hybrid default). Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-023` (Gate 1) and `/task-plan TASK-023` (Gate 2).
