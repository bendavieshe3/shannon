# TASK-013: Lifecycle Checker Definition

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #checker #lifecycle #subagent #sonnet
- **Created**: 2026-05-30
- **Updated**: 2026-06-22

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-013` (Gate 1).*

### Overview

Define the Lifecycle Checker subagent at `./.claude/skills/shannon-supervisor/checkers/lifecycle.md`. The Lifecycle Checker is the second of three specialised checker subagents per `technical_design.md` v1.2 § System Architecture → *Supervisor* — model **Sonnet** (the synthesis-heavy workload — the only checker that earns the more expensive model under the cost-envelope commitment), purpose "audit work-item indexes; detect stuck or stale items; cross-check index state against source-of-truth bodies." This Task closes the Lifecycle-Checker third of parent Epic AC#2 (three checker subagents defined and runnable). Out of scope: the Alignment Checker (TASK-012), the Drift Checker (TASK-014), the report-writing pipeline (TASK-015).

### Acceptance Criteria

- **AC#1 — `checkers/lifecycle.md` exists with Sonnet model frontmatter via the canonical `model:` field.** The file `./.claude/skills/shannon-supervisor/checkers/lifecycle.md` exists with explicit YAML frontmatter declaring the model via the canonical `model:` field — `model: claude-sonnet-4-6` (or the current Sonnet model identifier per the Phase-0 spike § 2 frontmatter convention and the lived precedent at TASK-012 AC#1 R-1). The Sonnet choice derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table — the only checker on Sonnet, justified by the synthesis-heavy workload (cross-checking index state against source-of-truth bodies is judgement-heavy, not exploration-heavy) and the cost-envelope commitment at `technical_design.md` v1.2 § Cadence → *Cost note* ("Sonnet reserved for the synthesis step"). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents*, `technical_design.md` v1.2 § Cadence → *Cost note*, the Phase-0 spike § 2 (frontmatter convention), and TASK-012 AC#1 R-1 (canonical `model:` field precedent).

- **AC#2 — Restricted tool access codified via the canonical `allowed-tools:` frontmatter field — Read plus index-validation only.** The Lifecycle Checker's tool access is restricted via the canonical `allowed-tools:` YAML frontmatter field to Read plus any index-validation helper script invocations the checker needs — e.g. `allowed-tools: Read` if no scripts are required at this Task's scope (the `scripts/` directory is empty until later Tasks per TASK-011 AC#1), or extended to name a specific `Bash(./.claude/skills/shannon-supervisor/scripts/<helper>:*)` glob if a helper exists. No Write access, no Edit access, no shell-general Bash, no `Bash(git *)` — the git-history surface is the Drift Checker's, not Lifecycle's. Derives from `technology_stack.md` v1.3 § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control*, the Phase-0 spike § 2 (frontmatter convention), and TASK-012 AC#2 R-2 (canonical `allowed-tools:` field precedent).

- **AC#3 — Purpose and prompt body codify "Audit work-item indexes; detect stuck or stale items; cross-check index state against source-of-truth bodies" scope.** The checker's purpose statement and prompt body name the verbatim phrase from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* table Purpose column — "Audit work-item indexes; detect stuck or stale items; cross-check index state against source-of-truth bodies" — as its scope. Distinct from the Alignment Checker (document-vs-implementation drift) and the Drift Checker (scratchpad pressure, uncommitted changes, branch lag). The prompt body operationalises the three implicit scopes: (a) audit work-item indexes (`feature_index.md`, `epic_index.md`, `task_index.md`, `spike_index.md`, `knowledge_index.md`); (b) detect stuck or stale items (e.g. ELABORATED items idle past a threshold); (c) cross-check index state against source-of-truth bodies — per the *Source-of-truth body before derived artefacts* convention at `development_guide.md` v1.4 § Code Style → Patterns to Follow, the body is authoritative; if the body and index disagree, the body wins and the index is reported as drift. The verbatim Purpose-column phrasing matches the cascade-doc canon so the substring-grep discipline (parent Epic AC#7) tracks the canonical phrasing rather than a Task-local paraphrase. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Checker subagents* (the Purpose column, verbatim) and `development_guide.md` v1.4 § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*.

- **AC#4 — Output uses the four-category finding schema.** Same return-shape contract as TASK-012 AC#4 — the canonical Drift / Gap / Internal contradiction / Strength schema per `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*. Each finding cites the specific work item, index entry, or section being commented on. Derives from `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check* → *Finding schema*.

- **AC#5 — Project-relative paths only.** Same portability discipline as parent Epic AC#1 (G-F extension). Verifiable: literal grep of `lifecycle.md` for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path returns zero hits. The grep-target set matches TASK-011 § Plan Step 3 (post-P-1 widening), TASK-011 Gate 3 lived evidence (commit `4135e91`), and TASK-012 Gate 3 lived evidence (commit `76b869b`). Derives from parent Epic AC#1 (G-F portability extension), TASK-011 § Plan Step 3, and TASK-012 AC#5 R-4 precedent.

- **AC#6 — Scope-bounded edit: only this checker file touched.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./.claude/skills/shannon-supervisor/checkers/lifecycle.md` only. No other checker file is created (TASK-012 territory landed; TASK-014 territory reserved); no `SKILL.md` editing (TASK-011 territory; if `SKILL.md` needs to reference the checker, that reference is a TASK-011 amendment, not a TASK-013 amendment); no `templates/` or `scripts/` content (TASK-015 and TASKs 16–17 territory); no `./shannon/skills/shannon-supervisor/checkers/lifecycle.md` shipping-source mirror — **explicitly deferred** to the future `/shannon-setup`-update Epic per the precedent at TASK-011 AC#6 (post-R-2 deferral clause), TASK-012 AC#6 (lived precedent), and scratchpad M-10. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*, TASK-011 AC#6 + TASK-012 AC#6 (shipping-source-mirror deferral precedent), and scratchpad M-10.

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
3. **Scope-bounded-edit verification.** `ls -la ./.claude/skills/shannon-supervisor/checkers/` confirms `lifecycle.md` is present (alongside the APPROVED `alignment.md` from TASK-012). `git status` separately confirms only the lifecycle-bookkeeping modifications (TASK-013 itself + `task_index.md`) and no other changes. Explicit absence checks: no `drift.md` (TASK-014 territory); no `SKILL.md` modification (TASK-011 territory); no `templates/` or `scripts/` content (TASK-015 / TASKs 16–17 territory); no `./shannon/skills/shannon-supervisor/` mirror (deferred per AC#6). Closes AC#6.

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

- **2026-06-22** — ELABORATED (Gate 1 approved). Requirements refined from the prepared elaboration draft (carried over from EPIC-009 planning ratification commit `87626bb` on 2026-05-30). **Five AC refinements applied inline at ratification, mirroring TASK-012 Gate 1 precedent** (commit `2a0b31f`): (R-1) AC#1 strengthened to name the canonical `model:` YAML frontmatter field with concrete model identifier (`model: claude-sonnet-4-6`) per the Phase-0 spike § 2 frontmatter convention and TASK-012 AC#1 R-1 precedent — closes Gap G-1. (R-2) AC#2 strengthened to name the canonical `allowed-tools:` YAML frontmatter field with concrete restricted-Read form (`allowed-tools: Read`, extensible to a scripts glob if a helper exists) — closes Gap G-2; the Lifecycle Checker's tool access is **narrower than the Alignment Checker's** (no `Bash(git *)`) because the git-history surface is the Drift Checker's, not Lifecycle's. (R-3) AC#3 lead-in aligned to the verbatim cascade-doc Purpose-column phrase "Audit work-item indexes; detect stuck or stale items; cross-check index state against source-of-truth bodies" per `technical_design.md` v1.2 — closes Drift D-1 so the substring-grep discipline (parent Epic AC#7) tracks the cascade-doc canon. The three operationalised sub-scopes (audit indexes / stuck items / body-vs-index cross-check) remain explicit, with the *Source-of-truth body before derived artefacts* rule named as the body-vs-index resolution rule (body wins, index reported as drift). (R-4) AC#5 grep-target set widened to include `~/` per TASK-011 § Plan Step 3 (post-P-1 widening), TASK-011 Gate 3 lived evidence (commit `4135e91`), and TASK-012 Gate 3 lived evidence (commit `76b869b`) — closes Gap G-3. (R-5) AC#6 extended to explicitly defer the `./shannon/skills/shannon-supervisor/checkers/lifecycle.md` shipping-source mirror to the future `/shannon-setup`-update Epic per the precedent at TASK-011 AC#6, TASK-012 AC#6, and scratchpad M-10 — closes Gap G-4. **One Plan-section refinement** applied to honour TASK-011 + TASK-012 Gate 3 lived evidence: Step 3 (Scope-bounded-edit verification) refined from `git status`-only to `ls -la`-based verification with `git status` as secondary check — the `./.claude/` gitignored architecture means `git status` does not show new files under `.claude/`; `ls` is the verifying mechanism — closes Gap G-5. No Internal Contradiction. **Six Strengths preserved**: cascade-doc citation rigour intact; honest Sonnet-vs-Haiku model rationale citing both Checker-subagents table and § Cadence Cost note; body-vs-index authority rule correctly invoked with substantive resolution (body wins); cross-checker scope-distinction integrity preserved against TASK-012 (verbatim "document-vs-implementation drift") and TASK-014 (verbatim "scratchpad pressure, uncommitted changes, branch lag"); plain-prose substring discipline at AC#4; risk-to-AC traceability. **Held G-1 routing promoted to scratchpad**: TASK-013's prepared draft exhibits the same canonical-frontmatter-field gaps as TASK-012's pre-Gate-1 draft — two independent Tasks under the same Epic, both prepared in the same Cascading-Preparation batch, both surfacing the same canonical-field underspecification at Gate 1. Two-Task datapoint is sufficient signal for canonical-convention routing; TASK-014 will confirm rather than triangulate. New scratchpad item *Canonical-frontmatter-field naming for supervisor subagents* added with candidate routes (`work-items` skill § Process: Plan note for skill / subagent frontmatter ACs; or `technical_design.md` § System Architecture extension). **No further new framework-general ambiguities surfaced.** Prepared Plan draft carries forward to `/task-plan TASK-013` (Gate 2) — the 3-Step Plan's structure remains intact with Step 3's lived-evidence verification refinement now landed. Status: DRAFT → ELABORATED.
- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-013`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-013`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Lifecycle Checker Definition*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-013` (Gate 1).
