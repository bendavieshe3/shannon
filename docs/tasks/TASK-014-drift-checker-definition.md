# TASK-014: Drift Checker Definition

## Metadata

- **Status**: PLANNED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #checker #drift #subagent #haiku
- **Created**: 2026-05-30
- **Updated**: 2026-06-27

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-014` (Gate 1).*

### Overview

Define the Drift Checker subagent at `./.claude/skills/shannon-supervisor/checkers/drift.md`. The Drift Checker is the third of three specialised checker subagents per `technical_design.md` v1.2 § System Architecture → *Supervisor* — model Haiku, purpose "scratchpad pressure, uncommitted changes, branch lag." This Task closes the Drift-Checker third of parent Epic AC#2 (three checker subagents defined and runnable). Out of scope: the Alignment Checker (TASK-012), the Lifecycle Checker (TASK-013), the report-writing pipeline (TASK-015).

### Acceptance Criteria

- **AC#1 — `checkers/drift.md` exists with Haiku model frontmatter via the canonical `model:` field.** The file `./.claude/skills/shannon-supervisor/checkers/drift.md` exists with explicit YAML frontmatter declaring the model via the canonical `model:` field — `model: claude-haiku-4-5-20251001` (or the current Haiku model identifier per the Phase-0 spike § 2 frontmatter convention and the lived precedent at TASK-012 AC#1 R-1 / TASK-013 AC#1). The Haiku choice derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table (Drift Checker on Haiku — exploration-heavy scanning across scratchpad, git history, and branch state, no synthesis required) and the cost-envelope commitment at `technical_design.md` v1.2 § Cadence → *Cost note* ("Haiku for exploration-heavy checkers"). Same model and canonical field as the Alignment Checker (TASK-012); contrast the Lifecycle Checker (TASK-013), the only checker on Sonnet. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents*, `technical_design.md` v1.2 § Cadence → *Cost note*, the Phase-0 spike § 2 (frontmatter convention), and TASK-012 AC#1 R-1 (canonical `model:` field precedent).

- **AC#2 — Tool access codified via the canonical `allowed-tools:` frontmatter field — Read plus restricted git Bash including branch.** The Drift Checker's tool access is restricted via the canonical `allowed-tools:` YAML frontmatter field to Read (for scratchpad and any other file the scan touches) plus restricted Bash scoped to read-only git invocations — `allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status), Bash(git branch:*)`. This is the same restricted-git form as the Alignment Checker (TASK-012 AC#2 R-2) **extended with `Bash(git branch:*)`** because branch lag (AC#3 (c)) is uniquely the Drift Checker's scope and requires branch/remote-state inspection. No Write, no Edit, no general Bash. Derives from `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control*, the Phase-0 spike § 2 (frontmatter convention), and TASK-012 AC#2 R-2 (canonical `allowed-tools:` field precedent).

- **AC#3 — Purpose and prompt body codify "Scratchpad pressure, uncommitted changes, branch lag" as three concrete drift scopes.** The checker's purpose statement and prompt body name the verbatim phrase from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table Purpose column — "Scratchpad pressure, uncommitted changes, branch lag" — as its scope, operationalised into three concrete scopes: (a) scratchpad pressure (count and age of items in `./docs/scratchpad.md` § Items; per `development_guide.md` v1.4 § Testing Strategy → Pre-Commit Checklist, scratchpad items are a routing channel and accumulating pressure is itself a finding); (b) uncommitted changes (a working tree with substantial uncommitted state is drift); (c) branch lag (local commits unsynced to the remote — per `development_guide.md` v1.4 § Push Cadence, the third push trigger being unmet is itself a drift signal). Distinct from the Alignment Checker (document-vs-implementation drift) and the Lifecycle Checker (index-vs-body, stuck or stale items). The verbatim Purpose-column phrasing matches the cascade-doc canon so the substring-grep discipline (parent Epic AC#7) tracks the canonical phrasing rather than a Task-local paraphrase. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* (the Purpose column, verbatim) and `development_guide.md` v1.4 § Push Cadence.

- **AC#4 — Output uses the four-category finding schema.** Same return-shape contract as TASK-012 AC#4 and TASK-013 AC#4 — the canonical Drift / Gap / Internal contradiction / Strength schema per `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*. Derives from `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*.

- **AC#5 — Project-relative paths only.** Same portability discipline as parent Epic AC#1 (G-F extension). Verifiable: literal grep of `drift.md` for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path returns zero hits. The grep-target set matches TASK-011 § Plan Step 3 (post-P-1 widening), TASK-012 Gate 3 lived evidence (commit `76b869b`), and TASK-013 Gate 3 lived evidence (commit `97b9b9d`). Derives from parent Epic AC#1 (G-F portability extension), TASK-011 § Plan Step 3, and TASK-012 AC#5 R-4 / TASK-013 AC#5 precedent.

- **AC#6 — Scope-bounded edit: only this checker file touched.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./.claude/skills/shannon-supervisor/checkers/drift.md` only. No other checker file is created (TASK-012 and TASK-013 territory landed); no `SKILL.md` editing (TASK-011 territory; if `SKILL.md` needs to reference the checker, that reference is a TASK-011 amendment, not a TASK-014 amendment); no `templates/` or `scripts/` content (TASK-015 and TASKs 16–17 territory); no `./shannon/skills/shannon-supervisor/checkers/drift.md` shipping-source mirror — **explicitly deferred** to the future `/shannon-setup`-update Epic per the precedent at TASK-011 AC#6 (post-R-2 deferral clause), TASK-012 AC#6, TASK-013 AC#6 (lived precedent), and scratchpad M-10. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*, TASK-011/012/013 AC#6 (shipping-source-mirror deferral precedent), and scratchpad M-10.

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

A single-file definition pass — write `./.claude/skills/shannon-supervisor/checkers/drift.md` with explicit YAML frontmatter declaring the canonical `model:` field (Haiku per AC#1 — same model and field as the Alignment Checker; contrast the Sonnet-only Lifecycle Checker) and the canonical `allowed-tools:` field (Read + restricted git per AC#2, **extended with `Bash(git branch:*)`** for branch-lag inspection), a clear purpose statement scoped to the verbatim cascade-doc phrase "Scratchpad pressure, uncommitted changes, branch lag" (per AC#3) operationalised into its three concrete sub-scopes, and a prompt body that instructs the subagent to return its finding fragment in the canonical four-category schema. Apply the portability discipline from parent Epic AC#1's G-F extension throughout.

### Steps

1. **Author `checkers/drift.md`** with explicit YAML frontmatter naming the canonical `model:` field (Haiku — `model: claude-haiku-4-5-20251001` per AC#1) and the canonical `allowed-tools:` field (`allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status), Bash(git branch:*)` per AC#2 — restricted git extended with `Bash(git branch:*)`, no Write/Edit/general Bash), purpose statement scoped to the verbatim cascade-doc phrase "Scratchpad pressure, uncommitted changes, branch lag" (per AC#3) operationalised into the three sub-scopes (scratchpad pressure / uncommitted changes / branch lag, with their `development_guide.md` § Push Cadence + § Pre-Commit Checklist anchors), prompt body, and return-shape contract (the four-category Drift / Gap / Internal contradiction / Strength schema per AC#4). Closes AC#1, AC#2, AC#3, AC#4.
2. **Portability discipline verification.** Run literal greps against `drift.md` for the six Shannon-self leak substrings per AC#5: `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path. Each grep must return zero hits. Grep-target set matches TASK-011 § Plan Step 3 (post-P-1 widening), TASK-012 Gate 3 lived evidence, and TASK-013 Gate 3 lived evidence (third consecutive clean 0-hit pass expected). Closes AC#5.
3. **Scope-bounded-edit verification.** `ls -la ./.claude/skills/shannon-supervisor/checkers/` confirms `drift.md` is present alongside the APPROVED `alignment.md` (TASK-012) and `lifecycle.md` (TASK-013). `git status` separately confirms only the lifecycle-bookkeeping modifications (TASK-014 itself + `task_index.md`) and no other changes — the `./.claude/` gitignored architecture means `git status` does not show the new checker file; `ls` is the verifying mechanism (TASK-011/012/013 Gate 3 lived evidence). Explicit absence checks: no `SKILL.md` modification (TASK-011 territory); no `templates/` or `scripts/` content (TASK-015 / TASKs 16–17 territory); no `./shannon/skills/shannon-supervisor/` mirror (deferred per AC#6). Closes AC#6.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `development_guide.md` v1.4 (APPROVED — AC#3 source); `technology_stack.md` v1.3 (APPROVED); `conceptual_design.md` v1.7 (APPROVED).
- **Parallel-able with**: TASK-012, TASK-013.

### Risks

- **Bash scope creep.** Easy to grant general `Bash` rather than the restricted git-only allow-list. **Mitigation**: AC#2 enumerates the allowed git invocations; the parent Epic AC#4's PreToolUse hook (Task 6 territory) is the runtime second line of defence.
- **Drift Checker scope collision with Alignment Checker.** Both checkers touch "drift" semantically. **Mitigation**: AC#3 names this checker's scope by the verbatim cascade-doc Purpose phrase "Scratchpad pressure, uncommitted changes, branch lag" (operational drift) — distinct from the Alignment Checker's "document-vs-implementation drift" (semantic alignment, named verbatim per TASK-012 AC#3) and the Lifecycle Checker's index-vs-body / stuck-or-stale-items scope. Cross-checker boundaries are codified at each checker's verbatim Purpose-column source.

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

- **2026-06-27** — PLANNED (Gate 2 approved). Plan ratified: the prepared Plan draft (carried over from EPIC-009 Gate 2 ratification commit `87626bb`, refined at Gate 1 commit `d84026c` with the Step 3 lived-evidence verification refinement) is internally consistent with the Gate-1-refined Requirements after five mechanical carry-throughs applied inline at ratification, mirroring TASK-012 (commit `dc75b6a`) and TASK-013 (commit `7bf4880`) Gate 2 precedent. **Five carry-through refinements**: (P-1) § Approach paragraph updated to name the canonical `model:` and `allowed-tools:` YAML frontmatter fields per Gate 1 R-1/R-2 — replacing the prepared draft's "Haiku model selection, Read + restricted Bash(git) tool access" wording; the `Bash(git branch:*)` extension is called out as the Drift-unique addition for branch-lag inspection. (P-2) Step 1 updated to name the canonical field forms with literal values (`model: claude-haiku-4-5-20251001`; `allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status), Bash(git branch:*)`) per Gate 1 R-1/R-2. (P-3) § Approach + Step 1 purpose phrase aligned to verbatim cascade-doc canon — "Scratchpad pressure, uncommitted changes, branch lag" per Gate 1 R-3 (`technical_design.md` v1.2 line 91, capitalised, no Oxford "and"), replacing the prepared draft's lowercased paraphrase; the three operationalised sub-scopes retained with their `development_guide.md` anchors. (P-4) Step 2 grep-target set enumerated explicitly per Gate 1 R-4 — six targets (`FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, absolute repo path) inheriting TASK-011 § Plan Step 3 post-P-1 widening and TASK-012/013 Gate 3 lived evidence. (P-5) Risk *Drift Checker scope collision* mitigation updated to name the Alignment Checker's scope by the verbatim "document-vs-implementation drift" canon (per TASK-012 AC#3) and the Lifecycle Checker's index-vs-body scope — replacing the prepared draft's "codebase-vs-documents drift" paraphrase. No Internal Contradiction. **Dependencies confirmed accurate**: TASK-011 APPROVED dependency satisfied (commit `4135e91`); cascade docs frozen at APPROVED. Risks complete at Task-plan granularity. **No new framework-general ambiguities surfaced** — the G-1 frontmatter-field convention is settled across all three checkers (scratchpad item at `5dbc5ac` stands as the canonical record). Status: ELABORATED → PLANNED.
- **2026-06-27** — ELABORATED (Gate 1 approved). Requirements refined from the prepared elaboration draft (carried over from EPIC-009 planning ratification commit `87626bb` on 2026-05-30). **Five AC refinements applied inline at ratification, mirroring TASK-012 (commit `2a0b31f`) and TASK-013 (commit `5dbc5ac`) Gate 1 precedent** — the third and final checker Task, confirming the now-settled canonical-frontmatter-field convention rather than re-triangulating it: (R-1) AC#1 strengthened to name the canonical `model:` YAML frontmatter field with concrete model identifier (`model: claude-haiku-4-5-20251001`) per the Phase-0 spike § 2 frontmatter convention and TASK-012/013 precedent — same Haiku model and canonical field as the Alignment Checker; contrast the Sonnet-only Lifecycle Checker. (R-2) AC#2 strengthened to name the canonical `allowed-tools:` YAML frontmatter field with concrete restricted-git form (`allowed-tools: Read, Bash(git log:*), Bash(git diff:*), Bash(git status), Bash(git branch:*)`) — the Alignment Checker's restricted-git form **extended with `Bash(git branch:*)`** because branch lag (AC#3 (c)) is uniquely the Drift Checker's scope and requires branch/remote-state inspection. (R-3) AC#3 lead-in aligned to the verbatim cascade-doc Purpose-column phrase "Scratchpad pressure, uncommitted changes, branch lag" per `technical_design.md` v1.2 line 91 (capitalised, no Oxford "and" — confirmed against the source, not the sibling files' lowercased "...and branch lag" paraphrase) — closes the substring-grep alignment so parent Epic AC#7 tracks the cascade-doc canon. The three operationalised sub-scopes (scratchpad pressure / uncommitted changes / branch lag) remain explicit with their `development_guide.md` § Push Cadence + § Pre-Commit Checklist anchors. (R-4) AC#5 grep-target set widened to include `~/` per TASK-011 § Plan Step 3 (post-P-1 widening), TASK-012 Gate 3 lived evidence (commit `76b869b`), and TASK-013 Gate 3 lived evidence (commit `97b9b9d`). (R-5) AC#6 extended to explicitly defer the `./shannon/skills/shannon-supervisor/checkers/drift.md` shipping-source mirror to the future `/shannon-setup`-update Epic per TASK-011/012/013 AC#6 and scratchpad M-10. **One Plan-section refinement** applied to honour TASK-011/012/013 Gate 3 lived evidence: Step 3 refined from `git status`-only ("Scope-bounded-diff verification") to `ls -la`-based verification with `git status` as secondary check — the `./.claude/` gitignored architecture means `git status` does not show new files under `.claude/`; `ls` is the verifying mechanism. No Internal Contradiction. **Strengths preserved**: cascade-doc citation rigour intact (every AC carries a `Derives from` line); honest Haiku-choice rationale citing both the Checker-subagents table and § Cadence Cost note; cross-checker scope-distinction integrity preserved against TASK-012 (verbatim "document-vs-implementation drift") and TASK-013 (index-vs-body, stuck or stale items); plain-prose substring discipline at AC#4; risk-to-AC traceability; the branch-lag-requires-`git branch` tool-access rationale made explicit. **G-1 routing settled**: TASK-014 is the third checker Task and exhibits the same canonical-frontmatter-field discipline as TASK-012 and TASK-013 — the convention promoted to scratchpad at TASK-013 Gate 1 (`5dbc5ac`) is now confirmed across all three checkers; no further routing needed (the scratchpad item stands as the canonical record). **No new framework-general ambiguities surfaced.** Prepared Plan draft carries forward to `/task-plan TASK-014` (Gate 2) — the 3-Step Plan's structure remains intact with Step 3's lived-evidence verification refinement now landed. Status: DRAFT → ELABORATED.
- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-014`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-014`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Drift Checker Definition*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-014` (Gate 1).
