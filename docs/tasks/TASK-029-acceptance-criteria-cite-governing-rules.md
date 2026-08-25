# TASK-029: Acceptance Criteria Cite Governing Rules, Not Version-Pinned References

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: — (orphan Task; no parent Epic — see § Context)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #acceptance-criteria #meta-gap #dogfood
- **Created**: 2026-08-25
- **Updated**: 2026-08-26

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at task creation, promoted from `docs/scratchpad.md` by directing-party instruction 2026-08-25. Unblocked by `conceptual_design.md` v1.8 (APPROVED 2026-08-26); full elaboration pending `/task-elaborate TASK-029`.*

### Overview

Three shipped defects across two Epics share one cause: **an artefact bound itself to a version-pinned or illustrative reference instead of to the rule that governs it.**

| # | Artefact | What it bound to | What went wrong |
|---|---|---|---|
| 1 | TASK-022 AC#2 | *"the ratified example at `ux_guide.md` v1.2"* | The example was illustrative and abbreviated — three promotion targets, not four. Copying it verbatim imported the abbreviation as shipped behaviour. Corrected by TASK-027. |
| 2 | TASK-023 prepared draft | An abbreviated report-header example in the same Guide | Derived the wrong report-header shape. Recorded in `ux_guide.md` v1.3's changelog as the evidence that the example mis-taught. |
| 3 | EPIC-010 AC#1 / AC#2 | *"`ux_guide.md` v1.2 § Command Surface"* | The Guide reached v1.4. Read literally at EPIC-010's Gate 3, AC#1 demanded the exact output shape TASK-027 had just corrected away from. Passed only because verification was performed against current v1.4 and the citation recorded as superseded. |

The first two are the narrow form — *a worked example is not a specification*. The third generalises it: a **version-pinned document citation** fails the same way, because documents move and the criterion silently starts asserting the wrong thing. In every case a governing rule existed and was stable — `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority* has said the same four things throughout.

The mechanism is worth naming, because it is not carelessness. A worked example is *testable* and Guide prose usually is not, so an implementer drafting acceptance criteria reaches for the example precisely because it makes a verifiable AC. The convention has to give them something else to reach for.

### Proposed convention

An acceptance criterion cites the **governing rule** — a `conceptual_design.md` business rule, or the prose commitment in a Guide. A fenced example or a version-pinned document reference may be cited as **corroborating evidence**, never as the thing the criterion asserts. Where an AC needs a grep-verifiable substring, the substring is drawn from the rule, not from an illustration of it.

### Acceptance Criteria

*Drafted at `/task-elaborate TASK-029`. Scope confirmed single-Task by the 2026-08-25 ruling (see § Ruling below); full elaboration still pending the verb.*

Expected shape — the doc-half:

- [ ] `development_guide.md` § Code Style → *Patterns to Follow* carries the convention as a named pattern, sibling to *Source-of-truth body before derived artefacts*
- [ ] The convention names both failure forms (illustrative example; version-pinned citation) and states the corroborating-evidence allowance
- [ ] Cites the three instances as worked precedent, per the § Code Style house style established by the editing-order convention

Expected shape — the skill-half (mirrors EPIC-008's two-touch pattern):

- [ ] `shannon/skills/work-items/skill.md` § Process: Elaborate carries a step-adjoining prompt at the moment acceptance criteria are drafted, the way § Process: Plan and § Process: Review already carry the meta-gap prompt
- [ ] Source and deployed copy re-synced
- [ ] No mandated document other than `development_guide.md` modified; no template, checker, hook, or command file touched

### Ruling — resolved 2026-08-25

**Question was:** may a Task amend `development_guide.md`, given `conceptual_design.md:163` said work items never update Guides while EPIC-008 / TASK-007 did exactly that with approval?

**Directing-party ruling (2026-08-25):** the two Guides are **not the same kind of document**. *"The Development Guide decides the process and the UX Guide decides the product, so they aren't the same."* A work item **executes** the development process, so refining the Development Guide when it discovers a process convention is part of doing the work — the amendment rides the work item's own gates. The UX Guide defines the **product**, which a work item must not unilaterally redefine — that stays `/document-review` only. This is resolution 3 of the three candidates, and it makes both precedents correct: TASK-007's `development_guide.md` amendments were legitimate; TASK-027's `ux_guide.md` routing was also correct.

**The ruling is encoded** in `conceptual_design.md` **v1.8** (APPROVED 2026-08-26) (§ Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*, renamed and rewritten from *Work Items Consume Guides*; the *Higher Work Items May Update Mid-Level Docs* rule carved out to match). Substantive re-review, **APPROVED at Gate 1 on 2026-08-26**. **This Task is unblocked** — it elaborates and implements under the corrected rule, and the doc-half lands in `development_guide.md` **via this Task**, no split.

**Consequence for scope: TASK-029 is a single Task, not a split.** Both halves — the `development_guide.md` § Code Style convention and the `work-items/skill.md` § Process: Elaborate prompt — land through this Task's own lifecycle. The recursion is worth stating: the convention *"cite the governing rule, not a version-pinned reference"* could not be written to cite `conceptual_design.md`'s Guide-authority rule until that rule was itself made correct — the Task's own thesis, exercised on the Task's own dependency.

### Context

- **Parent Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md) — Development Discipline. **Orphan Task**: FEAT-008's only Epic, [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md), is APPROVED and closed, and this convention is too small to warrant a new Epic. Orphan Tasks follow the Task default at all three gates per `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Orphan Tasks*: *"The absence of a parent Epic does not promote gate authority to the directing party; orphan-ness is a parentage attribute, not an authority attribute."*
- **Note — the parent Feature is DRAFT.** FEAT-008 reads DRAFT in both its body and `feature_index.md` despite EPIC-008 having been APPROVED on 2026-05-27 and its Ideal State bullets marked met. This is a known reconciliation item (SIT-026 working plan T03) and is a Feature-gate matter, so it is not resolved here. It does not block this Task, but a Task whose parent Feature is DRAFT is worth flagging rather than passing over.
- **This Task is the meta-gap routing channel firing.** FEAT-008 § Ideal State bullet 3 commits to exactly this: *"a routing channel for 'this resolved a framework-general ambiguity → route it back' so the discipline of capturing learnings is visible at the moments of action"*. The item was captured in `docs/scratchpad.md` at TASK-027's Gate 2, strengthened at EPIC-010's Gate 3 when the third instance appeared, and promoted here. The channel EPIC-008 built is what carried it.
- **Precedent for shape**: EPIC-008 landed its conventions as a **two-touch** — the doc-half in `development_guide.md` and the skill-half as step-adjoining prompts in `shannon/skills/work-items/skill.md` (TASK-007 + TASK-010), each half cross-referencing the other. A convention that only lives in a Guide is one nobody reads at the moment of action.
- **Durable record**: `docs/knowledge/meta-gap-routing-channel.md` — the Extension knowledge note describing this channel.

---

## Plan

*Drafted at `/task-plan TASK-029` (Gate 2).*

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review.*

---

## Activity Log

- **2026-08-25** — DRAFT: Task created by directing-party instruction, promoting the `docs/scratchpad.md` item *an illustrative example in a Guide is being read as a specification* after its third instance appeared at EPIC-010's Gate 3. Created as an **orphan Task** under FEAT-008 — EPIC-008 is APPROVED and closed, and the convention is too small to warrant a new Epic; orphan-ness does not change gate authority. Elaboration is **blocked on one framework-general ruling**: whether a Task may amend `development_guide.md`. `conceptual_design.md:163` says work items never update Guides, but EPIC-008 / TASK-007 amended `development_guide.md` three times with approval, while TASK-027 was held to the opposite reading four days ago and had to route its Guide fix through `/document-review`. Both readings cannot be right, and the answer determines this Task's scope. Surfaced to the directing party per the standing directive's *genuine divergence* clause.
- **2026-08-25** — Blocking question **resolved by directing-party ruling**: the Development Guide governs the *process* a work item executes (so a work item may refine it, riding its own gates) while the UX Guide governs the *product* (consume-only, `/document-review`). Resolution 3 of the three candidates; reconciles TASK-007 and TASK-027. Scope collapses to a **single Task** — no split — with the doc-half landing in `development_guide.md` directly. The ruling is being encoded in `conceptual_design.md` v1.8; this Task's remaining dependency is that document's Gate 1. Elaboration proceeds once v1.8 is APPROVED.
- **2026-08-26** — **Unblocked.** `conceptual_design.md` v1.8 APPROVED at Gate 1, encoding the 2026-08-25 ruling as § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*. This Task may now amend `development_guide.md` directly under the corrected rule; scope stands as a single Task with both halves. Ready for `/task-elaborate TASK-029`.
