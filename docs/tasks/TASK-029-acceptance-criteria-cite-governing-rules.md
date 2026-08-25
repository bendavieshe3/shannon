# TASK-029: Acceptance Criteria Cite Governing Rules, Not Version-Pinned References

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: — (orphan Task; no parent Epic — see § Context)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #acceptance-criteria #meta-gap #dogfood
- **Created**: 2026-08-25
- **Updated**: 2026-08-25

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at task creation, promoted from `docs/scratchpad.md` by directing-party instruction 2026-08-25. Full elaboration pending `/task-elaborate TASK-029` — and blocked on one authority question, see § Open Question.*

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

*Drafted at `/task-elaborate TASK-029`. Scope depends on the § Open Question below.*

Expected shape — the doc-half:

- [ ] `development_guide.md` § Code Style → *Patterns to Follow* carries the convention as a named pattern, sibling to *Source-of-truth body before derived artefacts*
- [ ] The convention names both failure forms (illustrative example; version-pinned citation) and states the corroborating-evidence allowance
- [ ] Cites the three instances as worked precedent, per the § Code Style house style established by the editing-order convention

Expected shape — the skill-half (mirrors EPIC-008's two-touch pattern):

- [ ] `shannon/skills/work-items/skill.md` § Process: Elaborate carries a step-adjoining prompt at the moment acceptance criteria are drafted, the way § Process: Plan and § Process: Review already carry the meta-gap prompt
- [ ] Source and deployed copy re-synced
- [ ] No mandated document other than `development_guide.md` modified; no template, checker, hook, or command file touched

### Open Question — blocks elaboration

**May a Task amend `development_guide.md`?** `conceptual_design.md:163` § Business Rules → *Work Items Consume Guides* says no, without qualification: *"The Development Guide and UX Guide are reference material. Work items consume them; they are not updated by work items. Updates to guides happen through `/document-create` or `/document-review` flows."* `:165` reinforces it: *"Tasks only consume documents; they do not update them."*

But **EPIC-008 / TASK-007 amended `development_guide.md` three times** — the editing-order convention at `:79`, the Push Cadence subsection at `:149`, and the meta-gap Pre-Commit Checklist line at `:114` — all APPROVED 2026-05-27, and all recorded in FEAT-008 § Ideal State as delivered *by a Task*. Meanwhile TASK-027 was held to the opposite reading four days ago: it could not correct `ux_guide.md`'s self-contradicting example and had to route the fix to `/document-review`, which is why `ux_guide.md` v1.4 exists as a separate gate.

Both readings cannot be right. The three candidate resolutions:

1. **The rule means what it says; TASK-007 was a violation.** This Task splits: the convention lands via `/document-review development_guide.md`, and the Task covers only the skill-half.
2. **The rule governs *authority*, not *hands*.** A Task may carry out a Guide edit once the directing party has ratified the content at a gate; what it may not do is decide the amendment unilaterally. TASK-007 and TASK-027 are then both correct, and the rule needs rewording to say so.
3. **The rule distinguishes the two Guides.** Nothing in the text supports this, but the lived practice does — `development_guide.md` has been amended by Tasks; `ux_guide.md` has not.

This is a framework-general ruling with a live inconsistency behind it, so it is surfaced to the directing party rather than decided by the supervisor. **It determines this Task's scope**, so elaboration waits on it.

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
