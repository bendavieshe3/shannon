# EPIC-009: Health Reporting Surface

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Created**: 2026-05-30
- **Updated**: 2026-05-30
- **Tags**: #supervisor #phase-2 #skill #hooks #reporting

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Prepared during FEAT-009 planning, not yet reviewed. Surfaces at `/epic-elaborate EPIC-009` (Gate 1).*

### Overview

EPIC-009 delivers the **first operational supervisor** — the `/shannon-report` skill at `./.claude/skills/shannon-supervisor/`, three specialised checker subagents (Alignment / Lifecycle / Drift), a dated report writing pipeline to `./docs/supervisor/report-YYYY-MM-DD.md`, a PreToolUse hook that write-guards against writes outside the supervisor scope, and a PostToolUse hook that audit-logs supervisor operations. The Epic is the foundation on which Phases 3 and 4 build: Phase 3's `/shannon-goal` reuses the report-writing pipeline; Phase 4's headless invocation runs this same skill.

The Epic delivers against FEAT-009 § Ideal State bullets *Cadence-driven operation* (interactive half), *Three-checker fan-out*, *Five Claude Code hook integration points* (PreToolUse and PostToolUse halves), *Cost envelope honoured*, and *Portability to non-Shannon-self projects* (the skill's self-contained packaging discipline starts here). Out of scope for this Epic: autonomous headless invocation (EPIC-011); `/shannon-goal` (EPIC-010); SessionStart / preCompact / Stop hooks (EPIC-010 carries SessionStart and preCompact; Stop hook is allocated to EPIC-011 as its completion-check semantics fit autonomous runs naturally).

### Acceptance Criteria

*Each criterion names a verifiable outcome — the exact location and shape of the text or artefact the implementing Task(s) will land.*

- **AC#1 — Skill directory layout matches the technical_design contract.** The supervisor skill exists at `./.claude/skills/shannon-supervisor/` with the four subdirectories named at `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Skill directory layout*: `SKILL.md` (supervisor logic + slash-command contracts), `templates/` (report templates — header, finding sections, footer), `checkers/` (definitions for the three checker subagents), `scripts/` (helper scripts — git log parsers, index validators). Verifiable: directory tree exists; `SKILL.md` carries the supervisor's self-identification line per `technical_design.md` v1.2 § API Design → *Skill Invocation Pattern*.

- **AC#2 — Three checker subagents defined and runnable.** The Alignment / Lifecycle / Drift checkers exist as definitions under `./.claude/skills/shannon-supervisor/checkers/`, each with the model selection per `technical_design.md` v1.2 § System Architecture → *Supervisor*: Alignment Checker on Haiku, Lifecycle Checker on Sonnet, Drift Checker on Haiku. Each checker is invokable as a subagent from the `/shannon-report` skill and returns a structured finding fragment using the canonical four-category schema (Drift / Gap / Internal contradiction / Strength) per `technical_design.md` v1.2 § Key Algorithms → *Document Alignment Check*. Verifiable: three checker definition files exist; each carries explicit model frontmatter; a `/shannon-report` invocation spawns all three.

- **AC#3 — First report writes successfully to `docs/supervisor/`.** A first end-to-end `/shannon-report` invocation against this repository (Shannon-self dogfood) produces a valid report at `./docs/supervisor/report-2026-MM-DD.md` (date of the run) using the convention from `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*. The report follows the hybrid presentation default per `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation* (diagnostic header — counts — followed by one or two narrative findings). The report is indexed in `knowledge_index.md` with Type marked as *Supervisor Report*. Verifiable: file exists at the dated path; index entry exists; the report's structure matches the hybrid-default shape.

- **AC#4 — PreToolUse hook blocks writes outside `docs/supervisor/`.** The supervisor scope's PreToolUse hook (per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration*) refuses any write whose target path is outside `./docs/supervisor/` (or the project's configured `report_directory` per `technical_design.md` v1.2 § Data Model → *Supervisor Configuration*). The hook returns exit code 2 (blocking) per the Phase-0 spike § 1 contract. Verifiable: an attempted write to (e.g.) `./docs/scratchpad.md` under a supervisor-scoped invocation is blocked with a specific error naming the scope; an attempted write to `./docs/supervisor/report-XXXX-XX-XX.md` proceeds.

- **AC#5 — PostToolUse hook audit-logs supervisor operations.** The supervisor scope's PostToolUse hook records each tool invocation (Bash, Edit, Write) the supervisor performs, with timestamp and arguments. The audit log location is named in `SKILL.md`. Verifiable: after a `/shannon-report` run, the audit log contains entries for the run's tool invocations.

- **AC#6 — Supervisor Configuration file convention established.** The supervisor skill at `./.claude/skills/shannon-supervisor/` honours the configuration-file convention codified at `technical_design.md` v1.2 § Data Model → *Supervisor Configuration*: if `./.claude/shannon-supervisor.json` is absent, all fields take the supervisor-authority defaults (Task gates always supervisor; Epic and Spike gates supervisor by default; report directory `docs/supervisor`); if present, the file's named fields override defaults uniformly across the project. The first dogfood run does not create the configuration file (Shannon-self does not reserve any gate authority for the directing party at this Epic) but the supervisor skill must handle both presence and absence gracefully without crashing on a missing file. Verifiable: an invocation with no configuration file present succeeds using defaults (matching the AC#3 dogfood); an invocation with a sample file present honours the override fields. Closes Gap G-B surfaced at FEAT-009 Gate 2.

- **AC#7 — Plain-prose substring discipline honoured for any verbatim phrases.** Any verbatim phrase the ACs commit to grep-verifying (e.g. the report's hybrid-presentation diagnostic-header format, the four-category schema labels) lands as plain prose — no Markdown formatting (backticks, italic `*`, bold `**`) interposing between substring characters that would break substring matching. This applies the scratchpad lesson surfaced by TASK-009's backtick-fix Deviation (2026-05-25). Verifiable: each verbatim phrase passes a literal grep on the file it lands in.

- **AC#8 — Cross-type scope-guard phrasing applied to any scope-asserting ACs.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*, any AC in this Epic whose failure mode is "an unintended file changed" uses cross-type-guard phrasing rather than a literal file count or fixed file list. This rule applies retrospectively at Gate 1 review: any AC failing the failure-mode test is rephrased before approval.

- **AC#9 — All amendments to mandated documents are additive; supervisor skill addition is net-new.** The supervisor skill at `./.claude/skills/shannon-supervisor/` is a net-new addition (no document amendments required to instantiate it). Any related amendments to existing documents (e.g. `knowledge_index.md` Notes section adding a "Supervisor Report" subtype description) are additive per `conceptual_design.md` § Re-elaborating → *Status semantics*.

### Context

- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md)
- **Vision**: § Core Principles #5 *Continuous Health Vigilance* (primary); § Key Features *Supervisor Role*
- **Conceptual Design**: § Glossary → *Supervisor*; § Business Rules → *Gate Authority Split* (sets the supervisor's authority surface); § Domain Model → *Knowledge Note* (Supervisor Report subtype)
- **Technology Stack**: § Supervisor Tooling (the five committed primitives — Hooks, Subagents, Headless mode + external scheduler, Worktree isolation, Skill frontmatter control; EPIC-009 exercises Hooks, Subagents, Skill frontmatter)
- **Technical Design**: § System Architecture → *Supervisor* (skill directory layout, three-checker fan-out, hook integration); § Data Model → *Supervisor Report Files*, *Supervisor Configuration*, *Cadence State*; § API Design → *Supervisor Verbs* (the `/shannon-report` contract)
- **Development Guide**: § Commit Cadence → *Supervisor cadence runs* (one commit per run); § Push Cadence (third trigger applies once EPIC-011 ships autonomous runs — for EPIC-009's interactive `/shannon-report` the standard per-gate cadence applies)
- **UX Guide**: § Command Surface → *Supervisor Commands*; § Interaction Patterns → *Supervisor Report Presentation* (hybrid default); § Interaction Patterns → *Supervisor-Approved Gate Notification* (relevant once delegated approvals begin; EPIC-009 establishes the reporting surface only)
- **Phase-0 Spike**: § 1 (Hooks reference); § 2 (Subagents); § 3 (Slash Commands); § 4 (Skills Discovery & Packaging)
- **Sibling Epics**: EPIC-010 (Phase 3) depends on this Epic's report-writing pipeline; EPIC-011 (Phase 4) depends on this Epic's skill structure

---

## Plan

*Prepared during FEAT-009 planning, not yet reviewed. Surfaces at `/epic-plan EPIC-009` (Gate 2).*

### Approach

Decompose into Tasks along the natural editing boundary — skill skeleton first (including configuration-file presence/absence handling per AC#6), three checker definitions (parallel-able once the skeleton lands), report writer + index update next, then the two hooks, then the end-to-end dogfood run. The first end-to-end run is its own Task (rather than a verification step on the hook Task) because the report writes a real file to `./docs/supervisor/`, gets indexed in `knowledge_index.md`, and rides the supervisor-batch commit cadence (per `development_guide.md` v1.4 § Commit Cadence → *Supervisor cadence runs*) — these are user-visible artefacts that warrant explicit Gate 3 review against AC#3 and AC#7.

The skill is built **self-contained from the outset** per FEAT-009's Risk *Supervisor skill portability not exercised until first non-Shannon-self deployment* — any path reference inside `SKILL.md` or the checker definitions uses project-relative paths (`./docs/`, `./.claude/`) rather than Shannon-self specifics. This is the discipline that makes the eventual non-Shannon-self deployment a directory copy.

### Tasks

*Task candidates — descriptive titles from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Created as DRAFT Tasks at `/epic-implement EPIC-009`, not at this nested cascade level.*

1. **Skill skeleton + frontmatter + configuration-file handling** — Create `./.claude/skills/shannon-supervisor/SKILL.md` with the supervisor's self-identification line, the four-subdirectory layout (`templates/`, `checkers/`, `scripts/`), the `/shannon-report` slash-command contract per `technical_design.md` v1.2 § System Architecture → *Supervisor*, and the configuration-file presence/absence handling per AC#6 (absent → defaults; present → field-level override; missing file is not an error).
2. **Alignment Checker definition** — Define the Alignment Checker subagent at `./.claude/skills/shannon-supervisor/checkers/alignment.md` with Haiku model selection, restricted tool access (Read + restricted Bash for git), and the four-category finding-schema return shape.
3. **Lifecycle Checker definition** — Define the Lifecycle Checker subagent at `./.claude/skills/shannon-supervisor/checkers/lifecycle.md` with Sonnet model selection (per the synthesis-heavy workload), Read access plus index-validation tool access, four-category return shape.
4. **Drift Checker definition** — Define the Drift Checker subagent at `./.claude/skills/shannon-supervisor/checkers/drift.md` with Haiku model selection, Read + Bash(git status / log) access, four-category return shape.
5. **Report writer + knowledge_index updater** — Implement the report-writing pipeline that aggregates the three checkers' finding fragments into a single hybrid-presentation report at `./docs/supervisor/report-YYYY-MM-DD.md` and adds an entry to `knowledge_index.md` under Type *Supervisor Report*.
6. **PreToolUse write-guard hook** — Implement the PreToolUse hook that refuses writes outside the supervisor's configured `report_directory` (default `docs/supervisor/`) with a specific error message naming the scope.
7. **PostToolUse audit-logging hook** — Implement the PostToolUse hook that records timestamp + tool + arguments for each supervisor operation to the audit log location named in `SKILL.md`.
8. **First end-to-end dogfood report run + commit** — Invoke `/shannon-report` against the Shannon-self repository; verify the resulting report at `./docs/supervisor/report-YYYY-MM-DD.md` satisfies AC#3 and AC#7; commit per `development_guide.md` v1.4 § Commit Cadence (standard per-gate cadence applies for interactive `/shannon-report` runs); update `knowledge_index.md`.

### Dependencies

**Depends on**: FEAT-009 PLANNED (this Epic's parent must reach Gate 2 before this Epic's elaboration begins); the five committed primitives at `technology_stack.md` v1.3 § Supervisor Tooling (all production-ready per the Phase-0 spike).

**Depended on by**: EPIC-010 (Synthesis and Reports) — reuses the report-writing pipeline; EPIC-011 (Autonomic Invocation) — invokes the `/shannon-report` skill in headless mode.

### Risks

- **Checker model-selection drift.** The three checkers have specific model assignments per `technical_design.md` v1.2 (Haiku / Sonnet / Haiku); a sloppy implementation could uniformly assign Sonnet, breaking the cost envelope. **Mitigation**: model selection is a verifiable AC (AC#2); Gate 3 reads each checker's frontmatter.
- **First report writing dogfood revealing report-shape gaps.** The hybrid presentation default (per `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*) is specified at the ux_guide level but has not been exercised live. The first report may surface shape ambiguities (e.g. how the diagnostic header counts findings when zero findings exist — the scratchpad M-2 zero-findings degenerate-case item, deferred to EPIC-010). **Mitigation**: AC#3 verifies against the hybrid-default shape; if shape gaps surface, surface them as framework-general ambiguities per `development_guide.md:114` and route to EPIC-010 elaboration (the natural home for the zero-findings degenerate case).
- **PreToolUse hook over-restrictive.** A write-guard that refuses *too* much (e.g. blocking the `knowledge_index.md` update that AC#5's report writer needs) breaks the report-writing pipeline. **Mitigation**: AC#4 names the scope explicitly (`docs/supervisor/` and the configured `report_directory`); AC#3's end-to-end dogfood verifies the writer can update both the report file and `knowledge_index.md`.

---

## Implementation Notes

*Filled during implementation. Cross-task decisions and learnings that don't belong to a single task.*

### Cross-Task Decisions

- *None yet.*

### Documents Updated

- *None yet.*

---

## Review

*Filled at Gate 3.*

### Verification

- [ ] All tasks APPROVED
- [ ] Epic acceptance criteria met
- [ ] Parent feature updated with epic outcome
- [ ] Relevant documents updated and approved

### Review Notes

*Filled at Gate 3.*

---

## Activity Log

- **2026-05-30** — DRAFT: Epic stub created with **prepared elaboration draft** (Requirements section) and **prepared plan draft** (Plan section) during FEAT-009 planning (Gate 2). Phase 2 of the spike-inherited phase structure. Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations* and `conceptual_design.md` § Re-elaborating a Work Item (adjacent). When the directing party runs `/epic-elaborate EPIC-009`, the prepared elaboration surfaces for Gate 1 review; when they run `/epic-plan EPIC-009`, the prepared plan surfaces for Gate 2 review. AC#6 (Supervisor Configuration file convention) added at FEAT-009 Gate 2 to close inline Gap G-B (configuration file creation pattern not in any Epic AC); Task 1 expanded correspondingly. Descriptive title (*Health Reporting Surface*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Full elaboration pending `/epic-elaborate EPIC-009` (Gate 1).
