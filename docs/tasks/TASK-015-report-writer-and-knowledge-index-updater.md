# TASK-015: Report Writer and Knowledge Index Updater

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #report-writer #templates #knowledge-index #hybrid-presentation
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-015` (Gate 1).*

### Overview

Implement the report-writing pipeline that aggregates the three checkers' finding fragments into a single dated report at `./docs/supervisor/report-YYYY-MM-DD.md` and indexes that report in `./docs/knowledge_index.md` under Type *Supervisor Report*. The pipeline is the core of EPIC-009's user-visible output — the dated report is the supervisor's durable artefact per `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*. The report's presentation follows the hybrid default per `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*: a diagnostic header (counts) followed by a one- or two-finding narrative body. This Task closes the writer/index-updater half of parent Epic AC#3 (first report written successfully); the dogfood verification of that AC is TASK-018's scope. Out of scope: the three checker definitions themselves (TASKs 12–14); the two hooks (TASKs 16–17); the dogfood run that verifies the pipeline end-to-end (TASK-018); the zero-findings degenerate case (EPIC-010 territory per parent Epic § Overview's Out-of-scope statement).

### Acceptance Criteria

- **AC#1 — Report templates exist under `./.claude/skills/shannon-supervisor/templates/`.** The `templates/` subdirectory created by TASK-011 is populated with the three template fragments named at `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Skill directory layout*: a header template (run date, checker counts, push lag — the diagnostic-header half of the hybrid default), a finding-section template (per-finding shape using the four-category schema with section/line citation), and a footer template (closing prose). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Skill directory layout* and `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*.

- **AC#2 — Report-writing pipeline codified in `SKILL.md` references the templates.** `SKILL.md` (created by TASK-011 with the `/shannon-report` contract) gains a § Report Pipeline section that codifies the aggregation flow: spawn the three checkers (per TASKs 12–14), collect their finding fragments, instantiate header + finding sections + footer templates into a single Markdown body, write to `./docs/supervisor/report-YYYY-MM-DD.md`. The pipeline must honour same-day-suffix handling (`report-YYYY-MM-DD-2.md` for a second run on the same date) per `technical_design.md` v1.2 § Data Model → *Supervisor Report Files* ("Reports are never overwritten"). Derives from `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*.

- **AC#3 — Hybrid-presentation default lands in the report shape.** The instantiated report follows the hybrid default per `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*: a diagnostic header naming counts of findings, stuck items, push lag, followed by a one- or two-finding narrative body. Diagnostic-only and conversational-only presentations are valid customisations but the framework default is hybrid; this Task lands the hybrid default in the templates. Derives from `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*.

- **AC#4 — `knowledge_index.md` entry written under Type *Supervisor Report*.** The pipeline writes an entry into `./docs/knowledge_index.md` for each report it produces, with the Type field reading *Supervisor Report* (per `conceptual_design.md` v1.7 § Domain Model → *Knowledge Note* — Supervisor Report is a Knowledge Note subtype). The entry references the report by relative path. The PreToolUse hook (TASK-016) must permit this write — it is the explicit exception named at parent Epic AC#4 (R-3). Derives from `conceptual_design.md` § Domain Model → *Knowledge Note* and `technical_design.md` v1.2 § Data Model → *Supervisor Report Files* ("indexed in `knowledge_index.md` like any other note").

- **AC#5 — Project-relative paths throughout.** Same portability discipline as parent Epic AC#1 (G-F extension): templates and any pipeline prose in `SKILL.md` use project-relative paths only. Verifiable: literal grep of `templates/*.md` plus the new `SKILL.md` § Report Pipeline section for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension).

- **AC#6 — Plain-prose substring discipline honoured.** Any verbatim phrase the templates commit to grep-verifying (the four-category schema labels, the hybrid diagnostic-header format) lands as plain prose — no Markdown formatting interposing between substring characters. Per parent Epic AC#7. Derives from parent Epic AC#7 and the scratchpad TASK-009 lesson (2026-05-25).

- **AC#7 — Scope-bounded edit per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task modifies templates under `./.claude/skills/shannon-supervisor/templates/`, extends `./.claude/skills/shannon-supervisor/SKILL.md` (TASK-011's source-of-truth body) with the § Report Pipeline section, and writes through to `./docs/knowledge_index.md`. It does **not** modify any checker definition under `checkers/`; does **not** modify any hook configuration (TASKs 16–17 territory); does **not** write to `./docs/supervisor/` (TASK-018's dogfood run is the first writer to that path). Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — Task 5 of 8; closes the writer/index half of EPIC-009 AC#3; AC#3's first-report dogfood verification is TASK-018's scope.
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Hybrid report presentation by default*; § Measurable Targets *Phase 2 adoption* (the first-report artefact is the Measurable Target's evidence — landed by TASK-018 against this Task's pipeline).
- **Sibling Task** (predecessor): TASK-011 (Skeleton — `SKILL.md` and `templates/` directory must exist); TASKs 12–14 (checker definitions — the pipeline aggregates their fragments).
- **Sibling Tasks** (downstream): TASK-016 (PreToolUse hook — must permit the `knowledge_index.md` write per AC#4); TASK-018 (Dogfood run — first end-to-end exercise).
- **Technical Design**: § Data Model → *Supervisor Report Files* (AC#2 and AC#4 source — same-day-suffix handling, knowledge_index integration); § System Architecture → *Supervisor* → *Skill directory layout* (AC#1 source); § Key Algorithms → *Document Alignment Check* → *Finding schema* (the four-category schema the per-finding template instantiates).
- **UX Guide**: § Interaction Patterns → *Supervisor Report Presentation* (AC#3 source — hybrid default).
- **Conceptual Design**: § Domain Model → *Knowledge Note* (AC#4 source — Supervisor Report subtype); § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#7 source).
- **Development Guide**: § Supervisor Report Files (the dogfood-specific commitment that reports are committed, not gitignored — relevant context for the pipeline's output).
- **Scratchpad**: M-2 (zero-findings degenerate-case presentation pattern — explicitly deferred to EPIC-010 per parent Epic § Overview; this Task does not implement zero-findings handling).

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-015` (Gate 2).*

### Approach

Follow the editing-order convention at `development_guide.md` v1.4 § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*: the templates and the `SKILL.md` § Report Pipeline section are source-of-truth bodies; the runtime output (dated report + knowledge_index entry) is derived. Edit in this order: (1) author header template, (2) author finding-section template, (3) author footer template, (4) extend `SKILL.md` with the § Report Pipeline section that references the templates and codifies the aggregation flow + same-day-suffix handling + knowledge_index integration. The dogfood verification of the pipeline lands at TASK-018, not here.

### Steps

1. **Author the three templates under `./.claude/skills/shannon-supervisor/templates/`**: header, finding-section, footer. Use plain prose for any substrings the templates commit to grep-verifying (per AC#6). Closes AC#1, AC#3 (template-side), AC#6.
2. **Extend `SKILL.md` with the § Report Pipeline section** referencing the three templates, codifying the aggregation flow (spawn checkers → collect fragments → instantiate templates → write to `./docs/supervisor/report-YYYY-MM-DD.md` with same-day-suffix handling), and naming the `knowledge_index.md` write step. Closes AC#2, AC#3 (pipeline-side), AC#4.
3. **Portability discipline verification.** Literal greps against the new templates and `SKILL.md` § Report Pipeline for Shannon-self leaks. Closes AC#5.
4. **Scope-bounded-diff verification.** `git status` confirms only `templates/*.md` and `SKILL.md` (with its new § Report Pipeline section) are modified — no `checkers/*`, no `settings.json`, no `./docs/supervisor/` writes (TASK-018 territory). Closes AC#7.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton); TASKs 12–14 elaborated (the checker contracts must be stable so the pipeline knows what fragment shapes to aggregate — APPROVED is helpful but not strictly required, since the aggregation contract is the four-category schema either way).
- **Depended on by**: TASK-016 (PreToolUse hook's `knowledge_index.md` exception per AC#4 is what allows this Task's writer to function at runtime); TASK-018 (dogfood run exercises this pipeline end-to-end).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `ux_guide.md` v1.2 (APPROVED — AC#3 source); `conceptual_design.md` v1.7 (APPROVED); `development_guide.md` v1.4 (APPROVED).

### Risks

- **Hybrid-presentation default ambiguity at template level.** The ux_guide example shows the shape but the template needs to be the shape, not a tutorial. **Mitigation**: AC#3 names the hybrid shape explicitly; first dogfood (TASK-018) verifies against the rendered output.
- **Same-day-suffix collision logic missing.** A second `/shannon-report` invocation on the same date would overwrite the first without the suffix logic. **Mitigation**: AC#2 names same-day-suffix handling explicitly per `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*.
- **`knowledge_index.md` write conflicting with PreToolUse hook.** TASK-016's hook must permit this write as the explicit exception per parent Epic AC#4 R-3. **Mitigation**: AC#4 of this Task names the dependency; AC#4 of TASK-016 names the reciprocal exception; both Tasks' Gate 3 verifications cross-check.

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

- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-015`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-015`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Report Writer and Knowledge Index Updater*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-015` (Gate 1).
