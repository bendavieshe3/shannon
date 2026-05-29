# TASK-013: Lifecycle Checker Definition

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #checker #lifecycle #subagent #sonnet
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-013` (Gate 1).*

### Overview

Define the Lifecycle Checker subagent at `./.claude/skills/shannon-supervisor/checkers/lifecycle.md`. The Lifecycle Checker is the second of three specialised checker subagents per `technical_design.md` v1.2 § System Architecture → *Supervisor* — model **Sonnet** (the synthesis-heavy workload — the only checker that earns the more expensive model under the cost-envelope commitment), purpose "audit work-item indexes; detect stuck or stale items; cross-check index state against source-of-truth bodies." This Task closes the Lifecycle-Checker third of parent Epic AC#2 (three checker subagents defined and runnable). Out of scope: the Alignment Checker (TASK-012), the Drift Checker (TASK-014), the report-writing pipeline (TASK-015).

### Acceptance Criteria

- **AC#1 — `checkers/lifecycle.md` exists with Sonnet model frontmatter.** The file `./.claude/skills/shannon-supervisor/checkers/lifecycle.md` exists with explicit frontmatter (or equivalent inline declaration) naming Sonnet as the model. The Sonnet choice derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table — the only checker on Sonnet, justified by the synthesis-heavy workload (cross-checking index state against source-of-truth bodies is judgement-heavy, not exploration-heavy). The choice is anchored by the cost-envelope commitment at `technical_design.md` v1.2 § Cadence → *Cost note* ("Sonnet reserved for the synthesis step"). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents*.

- **AC#2 — Tool access codified: Read plus index-validation.** The Lifecycle Checker's tool access is Read access (for reading work-item files, indexes, and mandated-document bodies) plus any index-validation helper script invocations the checker needs. No Write access, no Edit access, no shell-general Bash. Derives from `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control*.

- **AC#3 — Purpose and prompt body codify "index vs source-of-truth bodies; stuck items" scope.** The checker's purpose statement and prompt body name three concrete scopes per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table column *Purpose*: (a) audit work-item indexes (`feature_index.md`, `epic_index.md`, `task_index.md`, `spike_index.md`, `knowledge_index.md`); (b) detect stuck or stale items (e.g. ELABORATED items idle past a threshold); (c) cross-check index state against source-of-truth bodies (per the *Source-of-truth body before derived artefacts* convention at `development_guide.md` v1.4 § Code Style → Patterns to Follow — the body is authoritative; if the body and index disagree, the body wins and the index is reported as drift). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* (the Purpose column) and `development_guide.md` v1.4 § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*.

- **AC#4 — Output uses the four-category finding schema.** Same return-shape contract as TASK-012 AC#4 — the canonical Drift / Gap / Internal contradiction / Strength schema per `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*. Each finding cites the specific work item, index entry, or section being commented on. Derives from `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*.

- **AC#5 — Project-relative paths only.** Same portability discipline as parent Epic AC#1 (G-F extension). Verifiable: literal grep of `lifecycle.md` for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension).

- **AC#6 — Scope-bounded edit: only this checker file touched.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./.claude/skills/shannon-supervisor/checkers/lifecycle.md` only. No other checker file is created; no `SKILL.md` editing; no `templates/` or `scripts/` content. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — Task 3 of 8; closes one third of EPIC-009 AC#2 (the Lifecycle Checker third).
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Three-checker fan-out*; § Ideal State *Cost envelope honoured* (Sonnet choice for this checker is the cost-envelope's synthesis allowance).
- **Sibling Task** (predecessor): TASK-011 (Skeleton).
- **Sibling Tasks** (peers): TASK-012 (Alignment Checker), TASK-014 (Drift Checker).
- **Technical Design**: § System Architecture → *Supervisor* → *Checker subagents* (model + purpose); § Key Algorithms → *Document Alignment Check* → *Finding schema*; § Cadence → *Cost note* (Sonnet reserved for synthesis — justifies the model choice).
- **Development Guide**: § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts* (AC#3 source — the body-vs-index authority rule the checker enforces).
- **Technology Stack**: § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control*.
- **Conceptual Design**: § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#6 source).
- **Phase-0 Spike**: § 2 (Subagents).

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-013` (Gate 2).*

### Approach

A single-file definition pass — write `./.claude/skills/shannon-supervisor/checkers/lifecycle.md` with explicit Sonnet model selection, Read + index-validation tool access, purpose scoped to the three concrete index-checking jobs, and prompt body that instructs the subagent to return findings in the canonical four-category schema. The checker's prompt body should explicitly invoke the *Source-of-truth body before derived artefacts* rule when reporting body-vs-index disagreement.

### Steps

1. **Author `checkers/lifecycle.md`** with model frontmatter (Sonnet), tool-access (Read + index validation), purpose (three concrete scopes), prompt body invoking the body-vs-index authority rule, return-shape contract (four-category schema). Closes AC#1, AC#2, AC#3, AC#4.
2. **Portability discipline verification.** Literal greps for Shannon-self leaks. Closes AC#5.
3. **Scope-bounded-diff verification.** `git status` confirms only `checkers/lifecycle.md` added. Closes AC#6.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `technology_stack.md` v1.3 (APPROVED); `development_guide.md` v1.4 (APPROVED — AC#3 source); `conceptual_design.md` v1.7 (APPROVED).
- **Parallel-able with**: TASK-012, TASK-014.

### Risks

- **Sonnet-vs-Haiku confusion at implementation.** Easy to default to Haiku to save cost. **Mitigation**: AC#1 names Sonnet explicitly and ties to the cost-envelope's synthesis allowance.
- **Body-vs-index rule not deeply internalised in prompt body.** A weak prompt body could leave the checker reporting body-vs-index disagreement symmetrically rather than naming the body as authoritative. **Mitigation**: AC#3 explicitly names the *Source-of-truth body before derived artefacts* convention as the resolution rule for body-vs-index disagreement.

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

- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-013`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-013`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Lifecycle Checker Definition*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-013` (Gate 1).
