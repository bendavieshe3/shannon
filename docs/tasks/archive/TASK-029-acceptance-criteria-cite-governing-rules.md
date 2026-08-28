# TASK-029: Acceptance Criteria Cite Governing Rules, Not Version-Pinned References

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: — (orphan Task; no parent Epic — see § Context)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #acceptance-criteria #meta-gap #dogfood
- **Created**: 2026-08-25
- **Updated**: 2026-08-28

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

*Drafted at `/task-elaborate TASK-029` (Gate 1), 2026-08-28. Scope confirmed single-Task by the 2026-08-25 ruling (see § Ruling below).*

The doc-half — `development_guide.md`:

- [x] **AC#1** — `development_guide.md` § Code Style → *Patterns to Follow* carries the convention as a named pattern, sibling to *Source-of-truth body before derived artefacts*
- [x] **AC#2** — The pattern states the positive rule: an acceptance criterion cites the **governing rule** — a `conceptual_design.md` business rule, or the prose commitment in a Guide — as the thing it asserts
- [x] **AC#3** — The pattern names both failure forms explicitly: (a) a worked example read as a specification, and (b) a version-pinned document citation, and states why each fails (an example is illustrative and may abbreviate; a document moves and the criterion silently starts asserting the wrong thing)
- [x] **AC#4** — The pattern states the corroborating-evidence allowance: a fenced example or version-pinned reference may be cited as corroboration, never as the assertion; where an AC needs a grep-verifiable substring, the substring is drawn from the rule
- [x] **AC#5** — The pattern cites the three instances — TASK-022 AC#2, the TASK-023 prepared draft, and EPIC-010 AC#1/AC#2 — as worked precedent, matching the § Code Style house style of naming worked precedent established by *Source-of-truth body before derived artefacts*
- [x] **AC#6** — The pattern cross-references its companion AC-writing rule, `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*

The skill-half — the two-touch, per the EPIC-008 precedent:

- [x] **AC#7** — `shannon/skills/work-items/skill.md` § Process: Elaborate carries a step-adjoining soft prompt at the point acceptance criteria are drafted, in the same italicised form § Process: Plan and § Process: Review use for the meta-gap prompt, and cross-referencing the § Code Style pattern by name
- [x] **AC#8** — Source and deployed copies of the work-items skill are byte-identical after the edit (`shannon/skills/work-items/skill.md` and `.claude/skills/work-items/skill.md`)

Scope:

- [x] **AC#9** — No mandated document other than `development_guide.md` is modified; no work-item template, checker, hook, or command file is modified. Routine bookkeeping for this Task's own transitions (its file, `task_index.md`) is excluded from the guard per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*

**Note on this Task's own criteria.** These ACs are written under the convention they establish: each cites the rule or the § Code Style / § Process location that governs it, and the three instances appear as precedent rather than as the thing asserted. AC#8's file paths are structural identity, not a version-pinned citation.

### Context

- **Parent Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md) — Development Discipline. **Orphan Task**: FEAT-008's only Epic, [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md), is APPROVED and closed, and this convention is too small to warrant a new Epic. Orphan Tasks follow the Task default at all three gates per `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Orphan Tasks*: *"The absence of a parent Epic does not promote gate authority to the directing party; orphan-ness is a parentage attribute, not an authority attribute."*
- **Note — the parent Feature is DRAFT.** FEAT-008 reads DRAFT in both its body and `feature_index.md` despite EPIC-008 having been APPROVED on 2026-05-27 and its Ideal State bullets marked met. This is a known reconciliation item (SIT-026 working plan T03) and is a Feature-gate matter, so it is not resolved here. It does not block this Task, but a Task whose parent Feature is DRAFT is worth flagging rather than passing over.
- **This Task is the meta-gap routing channel firing.** FEAT-008 § Ideal State bullet 3 commits to exactly this: *"a routing channel for 'this resolved a framework-general ambiguity → route it back' so the discipline of capturing learnings is visible at the moments of action"*. The item was captured in `docs/scratchpad.md` at TASK-027's Gate 2, strengthened at EPIC-010's Gate 3 when the third instance appeared, and promoted here. The channel EPIC-008 built is what carried it.
- **Precedent for shape**: EPIC-008 landed its conventions as a **two-touch** — the doc-half in `development_guide.md` and the skill-half as step-adjoining prompts in `shannon/skills/work-items/skill.md` (TASK-007 + TASK-010), each half cross-referencing the other. A convention that only lives in a Guide is one nobody reads at the moment of action.
- **Durable record**: `docs/knowledge/meta-gap-routing-channel.md` — the Extension knowledge note describing this channel.

---

## Plan

*Drafted at `/task-plan TASK-029` (Gate 2), 2026-08-28.*

### Approach

A two-touch landing, per the EPIC-008 precedent: the rule in the Development Guide, the reminder at the moment of action in the work-items skill. Editing order follows `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts* — Guide body first, then the skill source, then the deployed copy, then verify.

### Steps

1. **`docs/development_guide.md` § Code Style → *Patterns to Follow*** — add the named pattern *Acceptance criteria cite the governing rule* immediately after *Source-of-truth body before derived artefacts*, covering AC#1–AC#6.
2. **`shannon/skills/work-items/skill.md` § Process: Elaborate** — add the step-adjoining soft prompt directly under the section heading, matching the italicised form used by § Process: Plan and § Process: Review (AC#7).
3. **Sync the deployed copy** — `.claude/skills/work-items/skill.md` (AC#8). Verified in sync before the edit.
4. **Verify** — `diff` source against deploy; `grep` the pattern name in both the Guide and the skill; `git status` the changed-file set against the AC#9 guard.
5. **Bookkeeping** — Activity Log entries, `task_index.md` status, then archive on Gate 3 approval per `conceptual_design.md` § Business Rules → *Approved Tasks Are Archived*.

### Dependencies

- `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide* — the rule permitting this Task to amend the Development Guide directly. APPROVED at Gate 1 on 2026-08-26; this Task's only blocker, now cleared.

### Risks

- **Prompt fatigue.** § Process: Elaborate gains a prompt where Plan and Review already carry one. Mitigation: the new prompt is scoped narrowly to AC drafting, not a second general meta-gap prompt, so it says something the others do not.
- **Source-vs-deploy drift.** The deployed skill copy is a derived artefact with no checker enforcing convergence (SIT-026 T13). Mitigation: step 3 is explicit and step 4 diffs. The general concern stays with T13.

---

## Implementation Notes

*2026-08-28.*

Landed in the planned editing order — Guide body, skill source, deployed copy, verify.

- **`docs/development_guide.md` § Code Style → *Patterns to Follow*** — new bullet *Acceptance criteria cite the governing rule*, placed immediately after *Source-of-truth body before derived artefacts*. Structured as: positive rule; the two failure forms as a nested list with the reason each fails; the corroborating-evidence allowance including the grep-substring case; a short paragraph naming *why* the pull toward the example exists; then the three-instance worked precedent and the cross-reference to the companion scope-guard rule.
- **`docs/development_guide.md` changelog** — new **v1.5** entry (2026-08-28), classified additive per `conceptual_design.md` § Re-reviewing → *Status semantics*; document stays APPROVED across the bump. The entry records that the amendment arrived via a work item rather than `/document-review`, naming the v1.8 rule that permits it. `**Last Reviewed**` moved to 2026-08-28.
- **`shannon/skills/work-items/skill.md` § Process: Elaborate** — step-adjoining soft prompt added directly under the section heading, in the same italicised single-paragraph form § Process: Plan and § Process: Review use, and cross-referencing the § Code Style pattern by name.
- **`.claude/skills/work-items/skill.md`** — deployed copy re-synced by direct copy. Verified in sync *before* the edit as well as after, so no pre-existing drift was masked.

The § Testing Strategy → Pre-Commit Checklist parenthetical naming the *matching soft prompts* in § Process: Plan and § Process: Review was deliberately left unchanged: those two are the meta-gap prompt, and the new Elaborate prompt is a different prompt about a different thing. Widening the parenthetical would have conflated them.

---

## Review

*Gate 3, 2026-08-28. Supervisor authority per `conceptual_design.md` § Business Rules → *Gate Authority Split* (Task gates are always supervisor authority; orphan-ness does not promote authority).*

All nine acceptance criteria verified against the working tree:

| AC | Verification |
|---|---|
| #1 | Pattern present at `development_guide.md` § Code Style → *Patterns to Follow*, immediately following *Source-of-truth body before derived artefacts* |
| #2 | Opening clause states the positive rule and names both governing-rule sources |
| #3 | Both failure forms present as a nested list, each with its reason |
| #4 | Corroborating-evidence allowance and the grep-substring clause both present |
| #5 | TASK-022 AC#2, the TASK-023 prepared draft and EPIC-010 AC#1/AC#2 all named, in the *Worked precedent* form the sibling pattern uses |
| #6 | Cross-reference to `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* present |
| #7 | Prompt present under § Process: Elaborate, matching the italicised form of the § Process: Plan and § Process: Review prompts, cross-referencing the pattern by name |
| #8 | `diff` of source against deployed copy reports identical |
| #9 | Changed set is `docs/development_guide.md`, `shannon/skills/work-items/skill.md` (plus the gitignored deployed copy) and this Task's own file and index entry. No other mandated document, template, checker, hook or command file touched |

Pre-Commit Checklist (`development_guide.md` § Testing Strategy) walked: cross-reference paths correct in both directions; no stale references introduced; dry-run of `/task-elaborate` reads coherently with the new prompt in place.

**Meta-gap check** — nothing framework-general emerged that is not already tracked. The one candidate, *source-vs-deploy drift has no checker*, is already SIT-026 T13 and is not re-raised here.

**Approved.**

---

## Activity Log

- **2026-08-25** — DRAFT: Task created by directing-party instruction, promoting the `docs/scratchpad.md` item *an illustrative example in a Guide is being read as a specification* after its third instance appeared at EPIC-010's Gate 3. Created as an **orphan Task** under FEAT-008 — EPIC-008 is APPROVED and closed, and the convention is too small to warrant a new Epic; orphan-ness does not change gate authority. Elaboration is **blocked on one framework-general ruling**: whether a Task may amend `development_guide.md`. `conceptual_design.md:163` says work items never update Guides, but EPIC-008 / TASK-007 amended `development_guide.md` three times with approval, while TASK-027 was held to the opposite reading four days ago and had to route its Guide fix through `/document-review`. Both readings cannot be right, and the answer determines this Task's scope. Surfaced to the directing party per the standing directive's *genuine divergence* clause.
- **2026-08-25** — Blocking question **resolved by directing-party ruling**: the Development Guide governs the *process* a work item executes (so a work item may refine it, riding its own gates) while the UX Guide governs the *product* (consume-only, `/document-review`). Resolution 3 of the three candidates; reconciles TASK-007 and TASK-027. Scope collapses to a **single Task** — no split — with the doc-half landing in `development_guide.md` directly. The ruling is being encoded in `conceptual_design.md` v1.8; this Task's remaining dependency is that document's Gate 1. Elaboration proceeds once v1.8 is APPROVED.
- **2026-08-26** — **Unblocked.** `conceptual_design.md` v1.8 APPROVED at Gate 1, encoding the 2026-08-25 ruling as § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*. This Task may now amend `development_guide.md` directly under the corrected rule; scope stands as a single Task with both halves. Ready for `/task-elaborate TASK-029`.
- **2026-08-28** — **ELABORATED** (Gate 1, supervisor authority): nine acceptance criteria drafted, splitting the doc-half (AC#1–#6), the skill-half (AC#7–#8) and the scope guard (AC#9). Criteria written under the convention they establish — each cites the governing rule or the § Code Style / § Process location, with the three instances appearing as precedent rather than as the assertion.
- **2026-08-28** — **PLANNED** (Gate 2, supervisor authority): two-touch approach per the EPIC-008 precedent, editing order per *Source-of-truth body before derived artefacts*. Risks recorded: prompt fatigue in § Process: Elaborate (mitigated by scoping the prompt to AC drafting rather than adding a second general meta-gap prompt), and source-vs-deploy drift (mitigated by an explicit sync step; the general concern stays with SIT-026 T13).
- **2026-08-28** — **IMPLEMENTED**: `development_guide.md` **v1.5** (additive; stays APPROVED) carries the *Acceptance criteria cite the governing rule* pattern; `shannon/skills/work-items/skill.md` § Process: Elaborate carries the step-adjoining prompt; deployed copy re-synced. First amendment of the Development Guide by a work item under the `conceptual_design.md` v1.8 rule that made it legitimate.
- **2026-08-28** — **APPROVED** (Gate 3, supervisor authority): all nine ACs verified; Pre-Commit Checklist walked; no new meta-gap. Archived per `conceptual_design.md` § Business Rules → *Approved Tasks Are Archived*.
