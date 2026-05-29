# TASK-012: Alignment Checker Definition

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #checker #alignment #subagent #haiku
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-012` (Gate 1).*

### Overview

Define the Alignment Checker subagent at `./.claude/skills/shannon-supervisor/checkers/alignment.md`. The Alignment Checker is the first of three specialised checker subagents per `technical_design.md` v1.2 § System Architecture → *Supervisor* — model Haiku, purpose "fast codebase scan for document-vs-implementation drift." This Task closes the Alignment-Checker third of parent Epic AC#2 (three checker subagents defined and runnable). Out of scope: the Lifecycle Checker (TASK-013), the Drift Checker (TASK-014), the report-writing pipeline that aggregates checker output (TASK-015).

### Acceptance Criteria

- **AC#1 — `checkers/alignment.md` exists with Haiku model frontmatter.** The file `./.claude/skills/shannon-supervisor/checkers/alignment.md` exists with explicit frontmatter (or equivalent inline declaration) naming Haiku as the model. The Haiku choice derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table (Alignment Checker on Haiku — the "Explore agent" workload — for exploration-heavy codebase scanning) and the cost-envelope commitment at `technical_design.md` v1.2 § Cadence → *Cost note*. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents*.

- **AC#2 — Restricted tool access codified.** The Alignment Checker's tool access is restricted to Read plus restricted Bash for git operations only (e.g. `Bash(git log)`, `Bash(git diff)`, `Bash(git status)`) per the read-mostly discipline at `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control* (used to restrict supervisor skills to read-mostly tool access). No Write access, no Edit access, no shell-general Bash. Derives from `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control*.

- **AC#3 — Purpose and prompt body codify "codebase vs documents drift" scope.** The checker's purpose statement and prompt body name "codebase vs documents drift" as its scope — distinct from the Lifecycle Checker (index vs source-of-truth; stuck items) and the Drift Checker (scratchpad pressure, uncommitted changes, branch lag). Per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table column *Purpose*. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* (the Purpose column).

- **AC#4 — Output uses the four-category finding schema.** The checker returns a structured finding fragment using the canonical four-category schema: **Drift / Gap / Internal contradiction / Strength** per `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*. Each finding cites the specific section or line being commented on (per the same source). The aggregator at TASK-015 will combine fragments from all three checkers; the Alignment Checker's contract is just to return its own fragment in the canonical shape. Derives from `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*.

- **AC#5 — Project-relative paths only.** Same portability discipline as parent Epic AC#1 (G-F extension): the checker definition uses project-relative paths (`./docs/`, `./.claude/`) — no Shannon-self-specific paths or content. Verifiable: literal grep of `alignment.md` for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension).

- **AC#6 — Scope-bounded edit: only this checker file touched.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./.claude/skills/shannon-supervisor/checkers/alignment.md` only. No other checker file is created (Tasks 13 and 14 territory); no `SKILL.md` editing (TASK-011 territory; if `SKILL.md` needs to reference the checker, that reference is a Task-011 amendment, not a Task-012 amendment); no `templates/` or `scripts/` content. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — Task 2 of 8; closes one third of EPIC-009 AC#2 (the Alignment Checker third).
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Three-checker fan-out* (this Task delivers one of the three).
- **Sibling Task** (predecessor): TASK-011 (Skeleton) — must exist so `./.claude/skills/shannon-supervisor/checkers/` is in place.
- **Sibling Tasks** (peers): TASK-013 (Lifecycle Checker), TASK-014 (Drift Checker) — three checker definitions parallel-able once TASK-011 has landed the skeleton.
- **Technical Design**: § System Architecture → *Supervisor* → *Checker subagents* (model + purpose); § Key Algorithms → *Document Alignment Check* → *Finding schema* (four-category return shape).
- **Technology Stack**: § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control* (the primitive controlling model selection and tool restriction).
- **Conceptual Design**: § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#6 source).
- **Phase-0 Spike**: § 2 (Subagents — model selection and tool restriction patterns).

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-012` (Gate 2).*

### Approach

A single-file definition pass — write `./.claude/skills/shannon-supervisor/checkers/alignment.md` with explicit Haiku model selection, restricted tool access, a clear purpose statement scoped to codebase-vs-documents drift, and a prompt body that instructs the subagent to return its finding fragment in the canonical four-category schema. Apply the portability discipline from parent Epic AC#1's G-F extension throughout.

### Steps

1. **Author `checkers/alignment.md`** with model frontmatter (Haiku), tool-access restriction (Read + restricted Bash for git), purpose ("codebase vs documents drift"), prompt body, and return-shape contract (four-category schema). Closes AC#1, AC#2, AC#3, AC#4.
2. **Portability discipline verification.** Run literal greps against the file for the Shannon-self leak substrings. Closes AC#5.
3. **Scope-bounded-diff verification.** `git status` confirms only `checkers/alignment.md` added. Closes AC#6.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton must exist).
- **Cascade docs**: `technical_design.md` v1.2 (frozen at APPROVED); `technology_stack.md` v1.3 (frozen at APPROVED); `conceptual_design.md` v1.7 (frozen at APPROVED).
- **Parallel-able with**: TASK-013, TASK-014 (three checkers can be authored in parallel once skeleton lands; each is a single-file definition).

### Risks

- **Model selection drift.** Easy to forget the Haiku-vs-Sonnet split and default to Sonnet uniformly. **Mitigation**: AC#1 names Haiku explicitly; the parent Epic § Plan § Risks already flags this as a verifiable Gate-3 check.
- **Cross-checker scope creep.** The Alignment Checker's scope ("codebase vs documents drift") overlaps semantically with the Drift Checker's "scratchpad pressure / uncommitted changes / branch lag." **Mitigation**: AC#3 names the Alignment Checker's scope explicitly per the `technical_design.md` Purpose column; cross-checker boundaries are codified at that source.

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

- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-012`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-012`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Alignment Checker Definition*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-012` (Gate 1).
