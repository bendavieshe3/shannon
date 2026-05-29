# TASK-014: Drift Checker Definition

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #checker #drift #subagent #haiku
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-014` (Gate 1).*

### Overview

Define the Drift Checker subagent at `./.claude/skills/shannon-supervisor/checkers/drift.md`. The Drift Checker is the third of three specialised checker subagents per `technical_design.md` v1.2 § System Architecture → *Supervisor* — model Haiku, purpose "scratchpad pressure, uncommitted changes, branch lag." This Task closes the Drift-Checker third of parent Epic AC#2 (three checker subagents defined and runnable). Out of scope: the Alignment Checker (TASK-012), the Lifecycle Checker (TASK-013), the report-writing pipeline (TASK-015).

### Acceptance Criteria

- **AC#1 — `checkers/drift.md` exists with Haiku model frontmatter.** The file `./.claude/skills/shannon-supervisor/checkers/drift.md` exists with explicit frontmatter naming Haiku as the model. The Haiku choice derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table (Drift Checker on Haiku — exploration-heavy scanning across scratchpad, git history, and branch state, no synthesis required) and the cost-envelope commitment at `technical_design.md` v1.2 § Cadence → *Cost note* ("Haiku for exploration-heavy checkers"). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents*.

- **AC#2 — Tool access codified: Read plus restricted Bash for git status / log.** The Drift Checker's tool access is Read (for scratchpad and any other file the scan touches) plus restricted Bash scoped to read-only git invocations (`Bash(git status)`, `Bash(git log)`, `Bash(git diff)`, `Bash(git branch)`). No Write, no Edit, no general Bash. Derives from `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control*.

- **AC#3 — Purpose and prompt body codify three concrete drift scopes.** The checker's purpose statement and prompt body name three concrete scopes per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table column *Purpose*: (a) scratchpad pressure (count and age of items in `./docs/scratchpad.md` § Items; per `development_guide.md` v1.4 § Testing Strategy → Pre-Commit Checklist, scratchpad items are a routing channel and accumulating pressure is itself a finding); (b) uncommitted changes (a working tree with substantial uncommitted state is drift); (c) branch lag (local commits unsynced to the remote — per `development_guide.md` v1.4 § Push Cadence, the third push trigger being unmet is itself a drift signal). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* (the Purpose column) and `development_guide.md` v1.4 § Push Cadence.

- **AC#4 — Output uses the four-category finding schema.** Same return-shape contract as TASK-012 AC#4 and TASK-013 AC#4 — the canonical Drift / Gap / Internal contradiction / Strength schema per `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*. Derives from `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*.

- **AC#5 — Project-relative paths only.** Same portability discipline as parent Epic AC#1 (G-F extension). Verifiable: literal grep of `drift.md` for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension).

- **AC#6 — Scope-bounded edit: only this checker file touched.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./.claude/skills/shannon-supervisor/checkers/drift.md` only. No other checker file; no `SKILL.md` editing; no `templates/` or `scripts/` content. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — Task 4 of 8; closes one third of EPIC-009 AC#2 (the Drift Checker third).
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Three-checker fan-out*.
- **Sibling Task** (predecessor): TASK-011 (Skeleton).
- **Sibling Tasks** (peers): TASK-012 (Alignment Checker), TASK-013 (Lifecycle Checker).
- **Technical Design**: § System Architecture → *Supervisor* → *Checker subagents* (model + purpose); § Key Algorithms → *Document Alignment Check* → *Finding schema*; § Cadence → *Cost note*.
- **Development Guide**: § Push Cadence (AC#3 (c) source — branch lag as drift signal); § Testing Strategy → Pre-Commit Checklist (AC#3 (a) source — scratchpad as routing channel).
- **Technology Stack**: § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control*.
- **Conceptual Design**: § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#6 source).
- **Phase-0 Spike**: § 2 (Subagents).

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-014` (Gate 2).*

### Approach

A single-file definition pass — write `./.claude/skills/shannon-supervisor/checkers/drift.md` with explicit Haiku model selection, Read + restricted Bash(git) tool access, purpose scoped to three concrete drift jobs (scratchpad pressure, uncommitted changes, branch lag), and prompt body that returns findings in the canonical four-category schema.

### Steps

1. **Author `checkers/drift.md`** with model frontmatter (Haiku), tool access (Read + Bash for git status/log/diff/branch), purpose (three concrete scopes), prompt body, return-shape contract (four-category schema). Closes AC#1, AC#2, AC#3, AC#4.
2. **Portability discipline verification.** Literal greps for Shannon-self leaks. Closes AC#5.
3. **Scope-bounded-diff verification.** `git status` confirms only `checkers/drift.md` added. Closes AC#6.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `development_guide.md` v1.4 (APPROVED — AC#3 source); `technology_stack.md` v1.3 (APPROVED); `conceptual_design.md` v1.7 (APPROVED).
- **Parallel-able with**: TASK-012, TASK-013.

### Risks

- **Bash scope creep.** Easy to grant general `Bash` rather than the restricted git-only allow-list. **Mitigation**: AC#2 enumerates the allowed git invocations; the parent Epic AC#4's PreToolUse hook (Task 6 territory) is the runtime second line of defence.
- **Drift Checker scope collision with Alignment Checker.** Both checkers touch "drift" semantically. **Mitigation**: AC#3 names this checker's scope as scratchpad-pressure / uncommitted-changes / branch-lag (operational drift) — distinct from the Alignment Checker's codebase-vs-documents drift (semantic alignment).

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

*Filled at Gate 3.*

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

- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-014`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-014`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Drift Checker Definition*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-014` (Gate 1).
