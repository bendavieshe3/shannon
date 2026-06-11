# TASK-012: Alignment Checker Definition

## Metadata

- **Status**: PLANNED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #checker #alignment #subagent #haiku
- **Created**: 2026-05-30
- **Updated**: 2026-06-11

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-012` (Gate 1).*

### Overview

Define the Alignment Checker subagent at `./.claude/skills/shannon-supervisor/checkers/alignment.md`. The Alignment Checker is the first of three specialised checker subagents per `technical_design.md` v1.2 § System Architecture → *Supervisor* — model Haiku, purpose "fast codebase scan for document-vs-implementation drift." This Task closes the Alignment-Checker third of parent Epic AC#2 (three checker subagents defined and runnable). Out of scope: the Lifecycle Checker (TASK-013), the Drift Checker (TASK-014), the report-writing pipeline that aggregates checker output (TASK-015).

### Acceptance Criteria

- **AC#1 — `checkers/alignment.md` exists with Haiku model frontmatter via the canonical `model:` field.** The file `./.claude/skills/shannon-supervisor/checkers/alignment.md` exists with explicit YAML frontmatter declaring the model via the canonical `model:` field — `model: claude-haiku-4-5-20251001` (or the current Haiku model identifier per the Phase-0 spike § 2 frontmatter convention). The Haiku choice derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table (Alignment Checker on Haiku — the "Explore agent" workload — for exploration-heavy codebase scanning) and the cost-envelope commitment at `technical_design.md` v1.2 § Cadence → *Cost note*. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* and the Phase-0 spike § 2 (frontmatter convention).

- **AC#2 — Restricted tool access codified via the canonical `allowed-tools:` frontmatter field.** The Alignment Checker's tool access is restricted via the canonical `allowed-tools:` YAML frontmatter field to Read plus restricted Bash for git operations only — e.g. `allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status)` — per the read-mostly discipline at `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control* (used to restrict supervisor skills to read-mostly tool access). No Write access, no Edit access, no shell-general Bash. Derives from `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control* and the Phase-0 spike § 2 (frontmatter convention).

- **AC#3 — Purpose and prompt body codify "document-vs-implementation drift" scope.** The checker's purpose statement and prompt body name "document-vs-implementation drift" (verbatim from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table — also rendered as "Fast codebase scan for document-vs-implementation drift" in the Purpose column) as its scope — distinct from the Lifecycle Checker (index vs source-of-truth; stuck items) and the Drift Checker (scratchpad pressure, uncommitted changes, branch lag). The verbatim phrasing matches the cascade-doc canon so the substring-grep discipline (parent Epic AC#7) tracks the canonical phrasing rather than a Task-local paraphrase. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* (the Purpose column).

- **AC#4 — Output uses the four-category finding schema.** The checker returns a structured finding fragment using the canonical four-category schema: **Drift / Gap / Internal contradiction / Strength** per `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*. Each finding cites the specific section or line being commented on (per the same source). The aggregator at TASK-015 will combine fragments from all three checkers; the Alignment Checker's contract is just to return its own fragment in the canonical shape. Derives from `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*.

- **AC#5 — Project-relative paths only.** Same portability discipline as parent Epic AC#1 (G-F extension): the checker definition uses project-relative paths (`./docs/`, `./.claude/`) — no Shannon-self-specific paths or content. Verifiable: literal grep of `alignment.md` for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path returns zero hits. The grep-target set matches TASK-011 § Plan Step 3 (post-P-1 widening) and TASK-011 Gate 3 lived evidence (commit `4135e91`). Derives from parent Epic AC#1 (G-F portability extension) and TASK-011 § Plan Step 3 lived evidence.

- **AC#6 — Scope-bounded edit: only this checker file touched.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./.claude/skills/shannon-supervisor/checkers/alignment.md` only. No other checker file is created (Tasks 13 and 14 territory); no `SKILL.md` editing (TASK-011 territory; if `SKILL.md` needs to reference the checker, that reference is a TASK-011 amendment, not a TASK-012 amendment); no `templates/` or `scripts/` content (TASK-015 and TASKs 16–17 territory); no `./shannon/skills/shannon-supervisor/checkers/alignment.md` shipping-source mirror — **explicitly deferred** to the future `/shannon-setup`-update Epic per the precedent at TASK-011 AC#6 (post-R-2 deferral clause) and scratchpad M-10 (the distribution-to-other-projects concern becomes real when a second project adopts the supervisor skill). Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*, TASK-011 AC#6 (shipping-source-mirror deferral precedent), and scratchpad M-10.

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

A single-file definition pass — write `./.claude/skills/shannon-supervisor/checkers/alignment.md` with explicit YAML frontmatter declaring the canonical `model:` field (Haiku per AC#1) and the canonical `allowed-tools:` field (restricted to Read + restricted Bash for git per AC#2), a clear purpose statement scoped to "document-vs-implementation drift" (the verbatim cascade-doc phrase per AC#3), and a prompt body that instructs the subagent to return its finding fragment in the canonical four-category schema. Apply the portability discipline from parent Epic AC#1's G-F extension throughout.

### Steps

1. **Author `checkers/alignment.md`** with explicit YAML frontmatter naming the canonical `model:` field (Haiku — `model: claude-haiku-4-5-20251001` per AC#1) and the canonical `allowed-tools:` field (`allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status)` per AC#2), purpose statement scoped to "document-vs-implementation drift" (verbatim cascade-doc phrase per AC#3), prompt body, and return-shape contract (the four-category Drift / Gap / Internal contradiction / Strength schema per AC#4). Closes AC#1, AC#2, AC#3, AC#4.
2. **Portability discipline verification.** Run literal greps against `alignment.md` for the six Shannon-self leak substrings per AC#5: `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path. Each grep must return zero hits. Grep-target set matches TASK-011 § Plan Step 3 (post-P-1 widening) and Gate 3 lived evidence. Closes AC#5.
3. **Scope-bounded-edit verification.** `ls -la ./.claude/skills/shannon-supervisor/checkers/` confirms `alignment.md` is the only file present (TASK-011 Gate 3 lived evidence: `./.claude/` is gitignored, so `git status` does not show the checker file as new — explicit `ls` is the verifying mechanism). `git status` separately confirms only the lifecycle-bookkeeping modifications (TASK-012 itself + `task_index.md`) and no other changes. Explicit absence checks: no other `checkers/*.md` (TASKs 13–14 territory); no `SKILL.md` modification (TASK-011 territory); no `templates/` or `scripts/` content (TASK-015 / TASKs 16–17 territory); no `./shannon/skills/shannon-supervisor/` mirror (deferred per AC#6). Closes AC#6.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton must exist).
- **Cascade docs**: `technical_design.md` v1.2 (frozen at APPROVED); `technology_stack.md` v1.3 (frozen at APPROVED); `conceptual_design.md` v1.7 (frozen at APPROVED).
- **Parallel-able with**: TASK-013, TASK-014 (three checkers can be authored in parallel once skeleton lands; each is a single-file definition).

### Risks

- **Model selection drift.** Easy to forget the Haiku-vs-Sonnet split and default to Sonnet uniformly. **Mitigation**: AC#1 names Haiku explicitly; the parent Epic § Plan § Risks already flags this as a verifiable Gate-3 check.
- **Cross-checker scope creep.** The Alignment Checker's scope ("document-vs-implementation drift") overlaps semantically with the Drift Checker's "scratchpad pressure / uncommitted changes / branch lag." **Mitigation**: AC#3 names the Alignment Checker's scope explicitly per the `technical_design.md` Purpose column (verbatim phrasing); cross-checker boundaries are codified at that source.

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

- **2026-06-11** — PLANNED (Gate 2 approved). Plan ratified: the prepared Plan draft (carried over from EPIC-009 Gate 2 ratification commit `87626bb` and refined at Gate 1 commit `2a0b31f` with the Step 3 lived-evidence verification refinement) is internally consistent with the Gate-1-refined Requirements after five mechanical carry-throughs applied inline at ratification. **Five carry-through refinements**: (P-1) § Approach paragraph updated to name the canonical `model:` and `allowed-tools:` YAML frontmatter fields per Gate 1 R-1/R-2 — replacing the prepared draft's "Haiku model selection, restricted tool access" wording. (P-2) Step 1 updated to name the canonical field forms with literal values (`model: claude-haiku-4-5-20251001`; `allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status)`) per Gate 1 R-1/R-2 — promotes the AC's frontmatter-field discipline from Requirements into the implementer's verifiable Step. (P-3) § Approach + Step 1 purpose phrase aligned to verbatim cascade-doc canon — "document-vs-implementation drift" per Gate 1 R-3 (replacing the prepared draft's paraphrase). (P-4) Step 2 grep-target set enumerated explicitly per Gate 1 R-4 — six targets (`FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, absolute repo path) inheriting TASK-011 § Plan Step 3 post-P-1 widening and Gate 3 lived evidence. (P-5) Risk *Cross-checker scope creep* phrase updated to verbatim cascade-doc canon per Gate 1 R-3. No Internal Contradiction. **Dependencies confirmed accurate**: TASK-011 APPROVED dependency satisfied (commit `4135e91`). Risks complete at Task-plan granularity. **No new framework-general ambiguities surfaced**; G-1 frontmatter-field-convention routing still held pending TASK-013 / TASK-014 Gate 1 review per Gate 1 decision. Status: ELABORATED → PLANNED.
- **2026-06-09** — ELABORATED (Gate 1 approved). Requirements refined from the prepared elaboration draft (carried over from EPIC-009 planning ratification commit `87626bb` on 2026-05-30). **Five AC refinements applied inline at ratification**: (R-1) AC#1 strengthened to name the canonical `model:` YAML frontmatter field with concrete model identifier (`model: claude-haiku-4-5-20251001`) per the Phase-0 spike § 2 frontmatter convention — closes Gap G-1 (frontmatter field-name underspecification: without naming the canonical key, an implementer could write a wrong key that doesn't take effect at runtime). (R-2) AC#2 strengthened to name the canonical `allowed-tools:` YAML frontmatter field with concrete restricted-Bash glob form (`allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status)`) per the same spike anchor — closes the matching half of G-1. (R-3) AC#3 verbatim phrase aligned to the cascade-doc canon: *"document-vs-implementation drift"* (per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* Purpose column) replaces the prepared draft's paraphrase "codebase vs documents drift" — closes Drift D-1 so the substring-grep discipline (parent Epic AC#7) tracks the cascade-doc canon rather than a Task-local rephrasing. (R-4) AC#5 grep-target set widened to include `~/` per TASK-011 § Plan Step 3 (post-P-1 widening) and TASK-011 Gate 3 lived evidence (commit `4135e91`) — closes Gap G-3. (R-5) AC#6 extended to explicitly defer the `./shannon/skills/shannon-supervisor/checkers/alignment.md` shipping-source mirror to the future `/shannon-setup`-update Epic per the precedent at TASK-011 AC#6 (post-R-2 deferral clause) and scratchpad M-10 — closes Gap G-2 (mirror absence implicit, not explicit). **One Plan-section refinement** applied to honour TASK-011's Gate 3 lived evidence: Step 3 (Scope-bounded-edit verification) refined from `git status`-only to `ls -la`-based verification with `git status` as secondary check — closes Gap G-4 (the `./.claude/` gitignored architecture surfaced at TASK-011 Gate 3 means `git status` does not show new files under `.claude/`; `ls` is the verifying mechanism). No Internal Contradiction. **Six Strengths preserved**: (S-1) cascade-doc citation rigour intact — every AC carries an explicit `Derives from` line per the field-report discipline; (S-2) cross-checker scope-distinction language matches sibling TASK-013 and TASK-014 verbatim (no semantic overlap or wording drift); (S-3) plain-prose substring discipline honoured at AC#4 — four-category schema labels (Drift / Gap / Internal contradiction / Strength) land as plain prose; (S-4) risk-to-AC traceability for both Risks; (S-5) honest Haiku-choice rationale citing both Checker-subagents table and § Cadence Cost note; (S-6) parent-Epic AC#2 third faithfully closed (model + tool restriction + finding schema + integration). **G-1 framework-general routing held**: the frontmatter-field underspecification may generalise across all three checker Tasks (TASK-012 / TASK-013 / TASK-014); routing to scratchpad as a candidate canonical convention is **held back** pending TASK-013 / TASK-014 Gate 1 review — if all three checker Tasks exhibit the same gap, a single canonical convention will be routed at that point rather than three repeated routings; if TASK-013 / TASK-014 inherit the R-1 / R-2 refinement cleanly, the routing is unnecessary. Prepared Plan draft carries forward to `/task-plan TASK-012` (Gate 2) — the 3-Step Plan's structure remains intact with Step 3's lived-evidence verification refinement now landed. Status: DRAFT → ELABORATED.
- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-012`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-012`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Alignment Checker Definition*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-012` (Gate 1).
