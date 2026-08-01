# TASK-024: Zero-Findings Degenerate-Case Presentation

## Metadata

- **Status**: ELABORATED
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

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-plan TASK-024` (Gate 2).*

### Approach

Replace the deferral clause with the zero-findings diagnostic; confirm the header template's zero-count rendering; land a ux_guide amendment only if a framework-level home is genuinely warranted.

### Steps

1. Rewrite `SKILL.md` § Report Pipeline step 3 zero-findings handling.
2. Verify `templates/header.md` zero-count rendering; adjust prose if needed.
3. Decide whether a `ux_guide` framework-level home is warranted; if yes, **route to `/document-review`** (TASK-024 does not edit `ux_guide.md`) and record the routing — do not edit the Guide inline.
4. Deploy to `./.claude/`; `diff`.
5. Plain-prose grep.
6. `git diff` scope check (SKILL.md + header-template prose only; no `ux_guide.md`, no Flow renumber).

### Dependencies

- EPIC-009 APPROVED (Report Pipeline + header template). Independent of hooks/goal-skill.

### Risks

- Cross-file inconsistency (SKILL.md ↔ header template) — mitigated by landing both touched surfaces in one Gate-3 cycle and re-verifying the zero-count render.
- Implementer edits `ux_guide.md` inline (the rule violation Gate 1 removed) — mitigated by AC#4/AC#5 routing any framework-level home to `/document-review` and the step-6 `git diff` confirming `ux_guide.md` is untouched.
- Zero-findings handling landed as a *new* numbered Flow step, stranding the by-number cross-references — mitigated by AC#1's in-place-within-step-3 constraint and the step-6 no-renumber check.

---

## Implementation Notes

*Filled during implementation.*

### Deviations from Plan

- *None yet.*

### Gotchas

- *None yet.*

### Documents Updated

- *None yet.*

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

- **2026-08-02** — ELABORATED (Gate 1 approved). Verification pass on the prepared draft against source. Confirmed sound and left untouched: **AC#1** (the step-3 deferral-clause quote is exact and correctly located); **AC#2** (the FEAT-009 § User Stories → *Honest Failure Modes — Supervisor Finds Nothing* anchor exists verbatim, line 93); **AC#3** (holds without a template restructure — `templates/header.md`'s `Checkers run: {{CHECKERS_SUCCEEDED}} of 3` note already carries the ran-cleanly signal at zero counts, and `{{FINDING_COUNT}}` renders `0`, never blank); the cross-type-guard phrasing of AC#5; all EPIC-010 AC#5/#7/#8 and scratchpad-M-2 derivations. **One substantive fix — AC#4 rule violation removed**: the draft directed this **Task** to "additively amend `ux_guide.md`", but a Task may not update a Guide (work-items skill § Work Item ↔ Document Relationships Key rule; `conceptual_design.md` § Business Rules → *Work Items Consume Guides*, which states "Tasks only consume documents; they do not update them"). Independently confirmed `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation* does **not** already cover zero-findings, so the amendment would be genuine — the tension is live, not moot. AC#4 re-scoped so the pattern lands in `SKILL.md`/template prose (the compliant path EPIC-010 AC#5 already names) and any framework-level `ux_guide` home is **routed to `/document-review`**, not performed inline; `ux_guide` removed from AC#5's edit scope with "guide" added to the cross-type guard; Plan step 3 + Risks reconciled to match. **Structural guard added to AC#1**: the step-3 edit must be in-place (no Flow renumber) so TASK-022/023's by-number cross-references (Flow step 1 / steps 2–6 / step 2 / step 3) stay valid. **Parent note**: the defect originates in EPIC-010 AC#5's passive "is documented in ux_guide.md… if needed" phrasing, which the draft made active; the Task-level routing fix resolves it without reopening the PLANNED Epic. Directing-party disposition: the genuine `ux_guide` zero-findings gap routed to `scratchpad.md` for the accumulating `/document-review ux_guide.md` pass. Status: DRAFT → ELABORATED.
- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#5; closes scratchpad item M-2 (zero-findings degenerate case, deferred from FEAT-009 elaboration). Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-024` (Gate 1) and `/task-plan TASK-024` (Gate 2).
