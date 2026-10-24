# TASK-033: Testing Strategy Covers Shipped Executables

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md)
- **Feature**: [FEAT-008](../features/FEAT-008-development-discipline.md)
- **Tags**: #framework #development-guide #testing #conventions
- **Created**: 2026-10-23
- **Updated**: 2026-10-24

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-012 planning; reviewed and refined at `/task-elaborate TASK-033` on 2026-10-24. Gate 1 pending.*

### Overview

`development_guide.md` § Testing Strategy opens "Shannon has no unit tests because Shannon has no units", and its three Test Levels (template review, deployed exercise, dogfood pass) all address templates and prompts. That stopped being the whole truth when the supervisor shipped executable hook scripts: TASK-016 (PreToolUse write-guard), TASK-017 (PostToolUse audit log) and TASK-025 (SessionStart health summary) each exercised a script directly against its inputs before commit, citing a discipline the section does not describe. Four sibling claims rest on the same premise: § Build and Run → Test, § Git Workflow → Commits, § Testing Strategy → Instrumentation and § CI/CD → Pipeline Stages.

This Task gives the Guide a Test Level for shipped executables and reconciles the four sibling claims with it. It is the Epic's first Task because it is the only item that makes a FEAT-008 claim false today (Ideal State bullet 1, *met, with one section stale*), and the only one that may be a substantive revision rather than an additive one.

### Acceptance Criteria

*Each criterion asserts the governing rule it lands, per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule*. Locations are section paths, not line numbers.*

- [ ] **AC#1 — The "no units" claim is scoped or gone.** The sentence "Shannon has no unit tests because Shannon has no units" no longer stands unqualified in § Testing Strategy: it is either removed or scoped to templates and prompts. *Asserts* Epic AC#1.
- [ ] **AC#2 — A named Test Level for shipped executables.** § Testing Strategy → Test Levels gains a level for shipped executables (hook scripts and any other script a skill ships). The level states three things: (a) before commit, the script is run directly against controlled inputs (environment variables, the hook event JSON on stdin, fixture files, a temporary output path), so the test does not depend on or touch live project state; (b) the Task's acceptance criteria enumerate the cases, each with its expected exit code, output or side effect; (c) the Task records the cases run and their results in its Implementation Notes or Activity Log. The three existing levels stay, scoped to templates and prompts. Worked precedent named in the body: TASK-016, TASK-017, TASK-025.
- [ ] **AC#3 — Checklist and What to Test carry the level.** § Testing Strategy → What to Test gains a line for shipped executables, and § Testing Strategy → Pre-Commit Checklist gains an item: if a shipped executable changed, its cases were run and passed. The checklist's opening ("Before committing template, command, or skill changes") covers the script either way, because scripts ship inside skills.
- [ ] **AC#4 — Sibling claims reconciled.** Each of § Build and Run → Test, § Git Workflow → Commits, § Testing Strategy → Instrumentation and § CI/CD → Pipeline Stages is either rewritten, or keeps its "no test suite" claim with an added clause naming the new Test Level (shipped-executable tests are run by hand, not as an automated suite). None contradicts the new level. § Git Workflow → Commits in particular says "No commit hooks" because there is no test suite; its clause also makes clear that it means Git commit hooks, not the Claude Code hooks the supervisor ships, since the two now share a name in the Guide.
- [ ] **AC#5 — Classification decided at Gate 1.** This Task's Gate 1 records whether the change is additive (scoping) or substantive (retraction), per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics* ("When uncertain, treat as substantive"). *Recommendation*: additive. Scoping the sentence to templates and prompts leaves the approved claim true of what it was written about, and adds a level for what it was not; the claim has in fact been inaccurate since TASK-016 shipped (2026-06-27), so the edit corrects drift rather than reversing a decision. *Counter-case*: read literally, "Shannon has no units" is an approved claim the edit contradicts, and the rule says to treat uncertainty as substantive. If substantive, this Task closes its own major version (v2.0) at Gate 3 instead of staging under `Unreleased`, per EPIC-012 § Plan → Approach → *Exception*.
- [ ] **AC#6 — Version History bullet, route and classification** *(Epic AC#8)*. One bullet under `development_guide.md` § Version History → `Unreleased (EPIC-012)` names this Task, the section it amended, its route (amended by a work item rather than `/document-review`, per `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*) and its classification per `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics*, including the Gate 1 decision from AC#5. This Task opens the `Unreleased (EPIC-012)` heading.
- [ ] **AC#7 — Scope guard** *(Epic AC#9)*. Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: no mandated document other than `development_guide.md`, and no work-item template, index template, command, guide under `shannon/guides/`, or skill file under `shannon/skills/`, is modified by this Task. Derived bookkeeping (this Task's file, `task_index.md`, the EPIC-012 Tasks line) is exempt.

### Context

- **Parent Epic**: [EPIC-012 — Development Conventions Surfaced Through the Supervisor Build-Out](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — Task 1 of 7; covers Epic AC#1, and opens the Epic's `Unreleased` Version History heading
- **Feature**: [FEAT-008 — Development Discipline](../features/FEAT-008-development-discipline.md)
- **Relevant documents**: `development_guide.md` § Build and Run, § Testing Strategy (opening, Test Levels, What to Test, Pre-Commit Checklist, Instrumentation), § Git Workflow → Commits, § CI/CD → Pipeline Stages, § Version History; `conceptual_design.md` § Re-reviewing an APPROVED Mandated Document → *Status semantics*
- **Related work**: [TASK-016](./archive/TASK-016-pretooluse-write-guard-hook.md), [TASK-017](./archive/TASK-017-posttooluse-audit-logging-hook.md), [TASK-025](./archive/TASK-025-sessionstart-health-summary-hook.md) (the three precedents; read each one's record of how its script was exercised); `docs/scratchpad.md` § Items entry *`development_guide.md` § Testing Strategy claims Shannon has no units*

---

## Plan

*Prepared during EPIC-012 planning, not yet reviewed. Surfaces at `/task-plan TASK-033` (Gate 2).*

### Approach

Scope the opening sentence to templates and prompts, add one Test Level, and add a short clause to each sibling claim. Draw the Test Level's wording from what the three precedent Tasks actually did (run the script against crafted hook-event JSON on stdin, check the output and exit code), stated as a rule, not as a copy of any one Task's test log.

### Steps

1. Re-read `development_guide.md` as landed on master, not as any earlier Task planned it (per § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; the cross-Task case is not yet codified, but this is the Epic's first Task, so the landed state is the v1.5 Guide), and confirm the target section's current wording.
2. Read the three precedent Tasks' test records and extract the common discipline.
3. Scope the § Testing Strategy opening sentence; add the shipped-executables Test Level with its precedents.
4. Add the What to Test line and the Pre-Commit Checklist item (AC#3).
5. Add the scoping clause (or rewrite) at § Build and Run → Test, § Git Workflow → Commits (with the Git-hooks disambiguation), § Testing Strategy → Instrumentation and § CI/CD → Pipeline Stages.
6. Add this Task's bullet under § Version History → `Unreleased (EPIC-012)` (this Task opens the heading at the top of § Version History).
7. Verify: grep each verification substring named in the ACs against the landed Guide; render the Guide with pandoc; check every new cross-reference resolves.
8. `git diff --stat` scope check against the scope-guard AC.

### Dependencies

- EPIC-012 PLANNED (Gate 2)
- `development_guide.md` v1.5 APPROVED

### Risks

- **Additive vs substantive misjudged** — the Gate 1 decision is recorded explicitly (AC#5), with the cautious-path rule quoted; a substantive call changes this Task's versioning, not its content.
- **The level reads as a mandate for an automated suite** — the scoping clause says the tests are run by hand; the level adds no build step and no automated runner.
- **Out-of-scope gap nearby**: the scripts depend on `bash` and `jq`, which no mandated document names. Not this Task's to fix (AC#7); it sits in `docs/scratchpad.md` § Items.

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
- [ ] Follows development_guide.md
- [ ] Verification substrings grep-checked against the landed Guide
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

- *None yet.*

---

## Activity Log

- **2026-10-23** — DRAFT: Task created during `/epic-plan EPIC-012` (Gate 2 pending) via Cascading Preparation. Prepared elaboration draft (Requirements) and prepared plan draft (Plan) stashed, marked "Prepared during EPIC-012 planning, not yet reviewed".
- **2026-10-24** — DRAFT (elaboration pass, Gate 1 pending): Prepared Requirements reviewed at `/task-elaborate TASK-033` against EPIC-012 (PLANNED), FEAT-008, `development_guide.md` v1.5, `conceptual_design.md` § Re-reviewing → *Status semantics*, and the three precedent Tasks. Findings (Drift / Gap / Internal contradiction / Strength). **Gap**: AC#2 said only that "the Task records how"; it now states what the precedents actually did (controlled inputs, cases enumerated in ACs with expected results, results recorded), checked against TASK-016 AC#6 (five cases), TASK-017 Step 4 (8/8, temporary log path) and TASK-025 Step 4 (fixtures). **Gap**: the Pre-Commit Checklist and What to Test had no line for shipped executables; new AC#3. **Gap**: § Git Workflow → Commits says "No commit hooks", which now reads ambiguously next to the supervisor's Claude Code hooks; AC#4 asks its clause to disambiguate. **Strength**: the four sibling claims named by Epic AC#1 are the only "no test suite" claims in the Guide; § Code Style's "almost no code" already allows for scripts and needs no change. **Out of scope, already routed**: CLAUDE.md's "Markdown-only" and "no runtime" lines sit with the 2026-10-23 scratchpad item on the hook scripts' `bash`/`jq` runtime. AC#5 now gives the counter-case to the additive recommendation. ACs renumbered (seven). Status stays DRAFT; Gate 1 not given.
