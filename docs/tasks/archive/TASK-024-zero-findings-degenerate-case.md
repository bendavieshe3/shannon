# TASK-024: Zero-Findings Degenerate-Case Presentation

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #presentation #zero-findings
- **Created**: 2026-07-18
- **Updated**: 2026-08-02

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated and approved at Gate 1 on 2026-08-02 (DRAFT → ELABORATED).*

### Overview

Land the zero-findings positively-stated diagnostic so a clean supervisor run reads "3 checkers ran cleanly; nothing surfaced" rather than a blank or bare-zero report — letting the directing party distinguish a healthy quiet run from a silently broken supervisor. Replaces the explicit deferral at `SKILL.md` § Report Pipeline step 3. Closes scratchpad M-2 and satisfies FEAT-009 § User Stories → *Honest Failure Modes — Supervisor Finds Nothing*.

### Acceptance Criteria

- [ ] **AC#1 — Zero-findings presentation lands at `SKILL.md` § Report Pipeline.** The current "The zero-findings degenerate case … is out of scope here and handled by a future Epic" clause at step 3 is replaced with the explicit positively-stated diagnostic. The replacement is **in place within step 3** — the Flow is not renumbered — so the by-number cross-references at § /shannon-goal (Flow step 1), § Read-only reuse (Flow steps 2–6), and § Presentation (Flow-step-2, Flow step 3) remain valid; re-verify all four sites after the edit. *Derives from* parent EPIC-010 AC#5; `SKILL.md` § Report Pipeline step 3 (current deferral).
- [ ] **AC#2 — Positively-stated, failure-distinguishable phrasing.** A clean run presents an affirmative "checkers ran cleanly; nothing surfaced"-style diagnostic, distinguishable from a silent failure. *Derives from* parent EPIC-010 AC#5; FEAT-009 § User Stories → *Honest Failure Modes — Supervisor Finds Nothing*.
- [ ] **AC#3 — Header template renders sensibly at zero counts.** `templates/header.md` at `{{FINDING_COUNT}} = 0` carries the "ran cleanly" signal via the checker-success note rather than reading as an error. *Derives from* parent EPIC-010 AC#5; EPIC-009 `templates/header.md`.
- [ ] **AC#4 — Pattern lands in `SKILL.md`/template prose; any ux_guide home is routed to `/document-review`, not performed here.** The zero-findings pattern lands in `SKILL.md` § Report Pipeline / template prose (the compliant path EPIC-010 AC#5 already names — "otherwise it lives in `SKILL.md` template prose"). If it also warrants a framework-level home in `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*, that amendment is **routed to `/document-review`** — guides are not updated by work items (`conceptual_design.md` § Business Rules → *Work Items Consume Guides*; work-items skill § Work Item ↔ Document Relationships Key rule) and ux_guide is APPROVED v1.2. TASK-024 does **not** edit `ux_guide.md`. Any such amendment is additive (doc stays APPROVED; Version History entry added at the `/document-review` pass, per `conceptual_design.md` § Re-reviewing → *Status semantics*). *Derives from* parent EPIC-010 AC#5; `conceptual_design.md` § Business Rules → *Work Items Consume Guides* + § Re-reviewing (additive).
- [ ] **AC#5 — Plain-prose discipline + scope-bounded edit.** Grep-verified phrases as plain prose (parent AC#7); edits `SKILL.md` § Report Pipeline (+ header-template prose) only; `ux_guide.md` is out of edit scope (any framework-level home is routed to `/document-review`, not performed here) — no checker, hook, command, goal-skill, guide, or other skill modified (cross-type-guard, parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary…Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § User Stories → *Honest Failure Modes — Supervisor Finds Nothing*
- **Relevant documents**: `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation* (alignment reference only — a framework-level home for the pattern is routed via `/document-review` if warranted, not edited by this Task); `conceptual_design.md` § Business Rules → *Work Items Consume Guides*
- **Related work**: scratchpad M-2; EPIC-009 `SKILL.md` § Report Pipeline + `templates/header.md`

---

## Plan

*Reconciled and approved at Gate 2 on 2026-08-02 (ELABORATED → PLANNED). Small, single-surface Task (the ux_guide-editing branch was removed at Gate 1); plan reconciled directly against the 5 corrected ACs rather than via a planning subagent.*

### Approach

Replace the deferral clause **in place within § Report Pipeline Flow step 3** (no renumber) with the positively-stated zero-findings diagnostic, authored in the tracked `./shannon/` source and deployed to `./.claude/` with a `diff`-confirm, per the source-before-deploy editing order. Confirm `templates/header.md` already renders the ran-cleanly signal at zero counts (`Checkers run: {{CHECKERS_SUCCEEDED}} of 3`, `{{FINDING_COUNT}}=0`) — adjust only its prose if genuinely needed, no structural change. **No `ux_guide.md` edit**: if a framework-level home is warranted it is routed to `/document-review` (already captured in scratchpad). Verified by plain-prose grep, a Flow-non-renumber re-check of the four by-number cross-references, and a `git diff` scope check before commit.

### Steps

1. Rewrite `SKILL.md` § Report Pipeline step 3 zero-findings handling.
2. Verify `templates/header.md` zero-count rendering; adjust prose if needed.
3. Decide whether a `ux_guide` framework-level home is warranted; if yes, **route to `/document-review`** (TASK-024 does not edit `ux_guide.md`) and record the routing — do not edit the Guide inline.
4. Deploy to `./.claude/`; `diff`.
5. Plain-prose grep.
6. `git diff` scope check (SKILL.md + header-template prose only; no `ux_guide.md`, no Flow renumber).

### Dependencies

- **EPIC-009 APPROVED** (Report Pipeline + header template — the surfaces this Task edits/confirms). Independent of the hooks (TASK-025/026) and the goal-skill (TASK-022, done).
- **Editing order** — follows TASK-022/023 (both APPROVED) in the `SKILL.md` edit chain; edits Flow step 3 content, so the no-renumber constraint (AC#1) protects the cross-references those Tasks introduced.

**AC coverage**: AC#1→steps 1+6 (in-place rewrite + no-renumber check); AC#2→step 1 (positive phrasing); AC#3→step 2 (template confirm); AC#4→step 3 (route, not edit); AC#5→steps 5+6 (plain-prose grep + scope/`git diff`).

### Risks

- Cross-file inconsistency (SKILL.md ↔ header template) — mitigated by landing both touched surfaces in one Gate-3 cycle and re-verifying the zero-count render.
- Implementer edits `ux_guide.md` inline (the rule violation Gate 1 removed) — mitigated by AC#4/AC#5 routing any framework-level home to `/document-review` and the step-6 `git diff` confirming `ux_guide.md` is untouched.
- Zero-findings handling landed as a *new* numbered Flow step, stranding the by-number cross-references — mitigated by AC#1's in-place-within-step-3 constraint and the step-6 no-renumber check.

---

## Implementation Notes

*Filled during implementation (2026-08-02).*

### Deviations from Plan

- *None.* The deferral clause was replaced **in place within Flow step 3** — no new numbered step, no renumber — exactly as AC#1 constrains. The Flow remains 1–6 and all four by-number cross-references (§ /shannon-goal "Flow step 1", § Read-only reuse "Flow steps 2–6", § Presentation "Flow-step-2"/"Flow step 3") were re-verified present after the edit.

### Gotchas

- **AC#3 required no template change — confirmation only.** `templates/header.md` already renders the ran-cleanly signal at zero counts (`Checkers run: {{CHECKERS_SUCCEEDED}} of 3` reads "3 of 3" on a healthy run; `Findings: {{FINDING_COUNT}}` renders the literal `0`, never blank). The step-3 prose now explicitly ties the zero-findings body line to that header note, so the two surfaces reinforce the same "checked vs silently failed" signal rather than duplicating it. No `templates/` file was touched.
- **AC#4 satisfied by *not* acting.** The pattern landed in `SKILL.md` prose (the compliant path); `ux_guide.md` was deliberately left untouched, with its framework-level home routed to `/document-review` via the scratchpad cluster at Gate 1. Verified `ux_guide.md` is absent from the diff.

### Documents Updated

- `shannon/skills/shannon-supervisor/SKILL.md` — § Report Pipeline Flow step 3: replaced the "out of scope … future Epic" deferral clause with the positively-stated zero-findings diagnostic ("3 checkers ran cleanly; nothing surfaced"), tied to the header's checker-success note. Deployed to `./.claude/`, `diff`-confirmed byte-identical.
- No mandated document, template, checker, hook, script, command, guide, or other skill modified (AC#5 cross-type guard held; no Flow renumber).

---

## Review

*Filled during review (Gate 3).*

### Verification

- [x] All acceptance criteria met — all 5 (AC#1–AC#5) independently re-derived MET by the Gate 3 verification subagent
- [x] Code follows development_guide.md — source-before-deploy editing order; Markdown-only, in-place edit, no code
- [x] Tests added or updated, passing — for a prose deliverable: deferral-clause-gone grep, 3 plain-prose key-phrase greps, Flow-non-renumber + 4-cross-ref check, deploy `diff` (empty), and `git diff` scope check, all run before commit
- [x] Relevant documents updated — `SKILL.md` § Report Pipeline step 3; `templates/header.md` confirmed needing no change; `ux_guide.md` framework-level home routed to `/document-review` (not edited)
- [x] Knowledge captured where useful — the clean-vs-silent-failure distinction is now documented in the pipeline itself, and the genuine `ux_guide` gap is captured in the scratchpad `/document-review ux_guide.md` cluster

### Review Notes

Gate 3 verified by an independent verification subagent (implementer-cannot-self-approve): all 5 ACs re-derived MET against committed source (`8a12937`). The two ways this Task could have gone wrong were both checked and came back clean — the Flow was **not** renumbered (still 1–6, all four by-number cross-references from TASK-022/023 resolve), and `ux_guide.md` was **not** edited (absent from the commit's changed-file list; framework-level home routed to `/document-review`). Deploy byte-identical to source; the rewritten step 3 is internally consistent (states no finding section is instantiated at zero findings, consistent with step 5's assemble-and-write). No PARTIAL/NOT MET, no uncovered defects. Recommendation APPROVE; directing party approved 2026-08-02. Closes EPIC-010 AC#5 and scratchpad M-2.

---

## Activity Log

- **2026-08-02** — APPROVED (Gate 3 approved). Independent verification subagent re-derived all 5 ACs as MET against committed source `8a12937` (implementer-cannot-self-approve): both critical risks verified clean — the Flow was not renumbered (still 1–6, all four TASK-022/023 by-number cross-references resolve) and `ux_guide.md` was not edited (absent from the commit; framework-level home routed to `/document-review`); deploy byte-identical; rewritten step 3 internally consistent. No defects. Closes EPIC-010 AC#5 and the long-standing scratchpad M-2 (zero-findings degenerate case, deferred since FEAT-009 elaboration). File archived to `./docs/tasks/archive/` (links kept in the prevailing `../` convention per the open scratchpad broken-archive-link item); `task_index.md` updated. Status: REVIEW → APPROVED.
- **2026-08-02** — IMPLEMENTED. Executed the 6-step plan in a single pass (gateless zone). **AC#1**: the "out of scope … future Epic" deferral clause at § Report Pipeline Flow step 3 replaced in place with the positively-stated zero-findings diagnostic (grep confirms the deferral clause count is now 0); Flow verified still 1–6 with all four by-number cross-references intact (no renumber). **AC#2**: the clean-run body reads "3 checkers ran cleanly; nothing surfaced" and explicitly distinguishes "checked and found nothing" from a supervisor that silently failed to check. **AC#3**: `templates/header.md` confirmed to already carry the ran-cleanly signal at zero counts — no template change, the step-3 prose now ties the body line to the header's `Checkers run: {{CHECKERS_SUCCEEDED}} of 3` note. **AC#4**: `ux_guide.md` deliberately not edited (framework-level home routed to `/document-review` at Gate 1); confirmed absent from the diff. **AC#5**: all four key phrases land as plain prose via `grep -F`; `git diff` shows only `SKILL.md` on the tracked side — no template, checker, hook, command, guide, or other skill. Deploy byte-identical. Closes EPIC-010 AC#5 and scratchpad M-2. Documentation-only prose, so grep + deploy-diff + scope check is the complete verification (no runtime surface to dogfood). Status: PLANNED → IMPLEMENTED. Ready for Gate 3 via `/task-review TASK-024`.
- **2026-08-02** — PLANNED (Gate 2 approved). Plan reconciled directly against the 5 corrected ACs (single-surface Task after Gate 1 removed the ux_guide-editing branch; no planning subagent). The Approach was corrected to drop the "land a ux_guide amendment" language (now routed to `/document-review`) and to name the in-place-within-step-3 / source-before-deploy discipline; Dependencies gained the editing-order note; an explicit AC-coverage map added (all 5 ACs → steps). Plan step 3 and Risks were already reconciled at Gate 1. Directing party authorised commit-plan-implement as a batch. Status: ELABORATED → PLANNED.
- **2026-08-02** — ELABORATED (Gate 1 approved). Verification pass on the prepared draft against source. Confirmed sound and left untouched: **AC#1** (the step-3 deferral-clause quote is exact and correctly located); **AC#2** (the FEAT-009 § User Stories → *Honest Failure Modes — Supervisor Finds Nothing* anchor exists verbatim, line 93); **AC#3** (holds without a template restructure — `templates/header.md`'s `Checkers run: {{CHECKERS_SUCCEEDED}} of 3` note already carries the ran-cleanly signal at zero counts, and `{{FINDING_COUNT}}` renders `0`, never blank); the cross-type-guard phrasing of AC#5; all EPIC-010 AC#5/#7/#8 and scratchpad-M-2 derivations. **One substantive fix — AC#4 rule violation removed**: the draft directed this **Task** to "additively amend `ux_guide.md`", but a Task may not update a Guide (work-items skill § Work Item ↔ Document Relationships Key rule; `conceptual_design.md` § Business Rules → *Work Items Consume Guides*, which states "Tasks only consume documents; they do not update them"). Independently confirmed `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation* does **not** already cover zero-findings, so the amendment would be genuine — the tension is live, not moot. AC#4 re-scoped so the pattern lands in `SKILL.md`/template prose (the compliant path EPIC-010 AC#5 already names) and any framework-level `ux_guide` home is **routed to `/document-review`**, not performed inline; `ux_guide` removed from AC#5's edit scope with "guide" added to the cross-type guard; Plan step 3 + Risks reconciled to match. **Structural guard added to AC#1**: the step-3 edit must be in-place (no Flow renumber) so TASK-022/023's by-number cross-references (Flow step 1 / steps 2–6 / step 2 / step 3) stay valid. **Parent note**: the defect originates in EPIC-010 AC#5's passive "is documented in ux_guide.md… if needed" phrasing, which the draft made active; the Task-level routing fix resolves it without reopening the PLANNED Epic. Directing-party disposition: the genuine `ux_guide` zero-findings gap routed to `scratchpad.md` for the accumulating `/document-review ux_guide.md` pass. Status: DRAFT → ELABORATED.
- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#5; closes scratchpad item M-2 (zero-findings degenerate case, deferred from FEAT-009 elaboration). Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-024` (Gate 1) and `/task-plan TASK-024` (Gate 2).
