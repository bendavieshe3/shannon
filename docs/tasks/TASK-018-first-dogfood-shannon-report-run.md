# TASK-018: First Dogfood `/shannon-report` Run

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #dogfood #report #knowledge-index #commit #shannon-self
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-018` (Gate 1).*

### Overview

The closing Task of EPIC-009: invoke `/shannon-report` against the Shannon-self repository, verify the resulting artefacts satisfy parent Epic AC#3, AC#5, AC#7, update `./docs/knowledge_index.md`, and commit per the standard per-gate cadence per parent Epic R-1 (the cadence-language fix at Gate 1 — interactive `/shannon-report` runs follow the default per-gate cadence, not the supervisor-batch cadence which is EPIC-011 territory). This Task is the end-to-end exercise of every prior Task in EPIC-009: TASK-011's skill skeleton + `/shannon-report` contract; TASKs 12–14's three checkers fan-out; TASK-015's report writer + index updater; TASK-016's PreToolUse write-guard (verified by an attempted out-of-scope write being blocked); TASK-017's PostToolUse audit log (verified by entries accumulating). Out of scope: autonomous headless invocation (EPIC-011 — supervisor-batch cadence applies there, not here); the zero-findings degenerate case (EPIC-010 — deferred per parent Epic § Overview); subsequent dogfood runs beyond the first.

### Acceptance Criteria

- **AC#1 — `/shannon-report` invocation produces a valid dated report.** Running `/shannon-report` against this repository (Shannon-self dogfood) produces a file at `./docs/supervisor/report-2026-MM-DD.md` (date of the run) per `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*. The report's content is what TASK-015's pipeline produced; the structural shape follows the hybrid-presentation default per `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation* (diagnostic header followed by one or two narrative findings). Closes the dogfood half of parent Epic AC#3.

- **AC#2 — `knowledge_index.md` entry written for the report.** The dogfood run's report is indexed in `./docs/knowledge_index.md` with Type marked *Supervisor Report* per `conceptual_design.md` v1.7 § Domain Model → *Knowledge Note*. The entry's path reference resolves to the dated report file. Closes the index half of parent Epic AC#3. Derives from `conceptual_design.md` v1.7 § Domain Model → *Knowledge Note* (Supervisor Report subtype) and `technical_design.md` v1.2 § Data Model → *Supervisor Report Files* ("indexed in `knowledge_index.md` like any other note").

- **AC#3 — Audit log contains entries naming the run's tool invocations.** The audit log at the path TASK-017 codified (under `./.claude/skills/shannon-supervisor/`) contains entries for the dogfood run's tool invocations (the checkers' Read + Bash(git) calls, the report writer's Write to `./docs/supervisor/`, the index updater's Edit on `./docs/knowledge_index.md`). This is the audit-log evidence check tied to the first dogfood run per the parent Epic AC#3 R-5 amendment. Closes the audit-log half of parent Epic AC#3 (R-5 amendment) and the dogfood half of parent Epic AC#5. Derives from parent Epic AC#3 (R-5 amendment) and AC#5 (R-2 amendment).

- **AC#4 — Out-of-scope write attempt is blocked by the PreToolUse hook.** A documented negative-test write attempt — e.g. attempting to write `./docs/scratchpad.md` from within the supervisor-scoped invocation — is blocked by the PreToolUse hook from TASK-016 with exit code 2 and the scope-specific error message. The in-scope writes (to `./docs/supervisor/` and `./docs/knowledge_index.md`) succeed. Closes the hook-verification half of parent Epic AC#4. Derives from parent Epic AC#4 (PreToolUse hook scope).

- **AC#5 — Verbatim phrases pass plain-prose grep.** The report and the `knowledge_index.md` entry pass plain-prose substring discipline per parent Epic AC#7: any verbatim phrase the templates committed to (the four-category schema labels, the hybrid diagnostic-header format) lands without Markdown formatting interposing between substring characters. Verifiable: literal greps against the run's output for the canonical schema labels and header format return matches. Closes parent Epic AC#7's dogfood-verification half. Derives from parent Epic AC#7.

- **AC#6 — Standard per-gate commit cadence applied.** A single commit lands at Gate 3 approval of this Task per `development_guide.md` v1.4 § Commit Cadence — the standard per-gate cadence applies for interactive `/shannon-report` invocations per parent Epic R-1 (the supervisor-batch cadence is autonomous-only and EPIC-011 territory). The commit captures: the report file, the `knowledge_index.md` update, any work-item bookkeeping (this Task's status transition, archive move, parent Epic Activity Log update). Derives from `development_guide.md` v1.4 § Commit Cadence and parent Epic R-1.

- **AC#7 — Scope-bounded edit per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task's diff covers the dated report file under `./docs/supervisor/`, the `./docs/knowledge_index.md` index entry, this Task's own file (status/Activity Log), `./docs/tasks/task_index.md` (status transition), parent Epic Activity Log update at `./docs/epics/EPIC-009-health-reporting-surface.md`. It does **not** modify any skill body (TASKs 11, 15 territory); does **not** modify any checker definition (TASKs 12–14 territory); does **not** modify any hook configuration (TASKs 16–17 territory); does **not** modify any mandated document. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — Task 8 of 8 (the closing dogfood Task); closes parent Epic AC#3 (dogfood half), AC#4 (hook-verification half), AC#5 (audit-log half), AC#7 (verbatim grep half), and is the primary acceptance evidence for the Epic's first end-to-end run.
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Success Metrics → *Phase 2 adoption* (this Task's report is the Measurable Target's first evidence — "Shannon-self project produces at least one `docs/supervisor/report-YYYY-MM-DD.md`").
- **Sibling Tasks** (predecessors): All of TASKs 11–17 must be APPROVED — this Task exercises every component they delivered.
- **Technical Design**: § Data Model → *Supervisor Report Files* (AC#1, AC#2 source); § System Architecture → *Supervisor* → *Hook integration* (AC#3, AC#4 source).
- **UX Guide**: § Interaction Patterns → *Supervisor Report Presentation* (AC#1 source — hybrid-presentation shape).
- **Conceptual Design**: § Domain Model → *Knowledge Note* (AC#2 source — Supervisor Report subtype); § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#7 source).
- **Development Guide**: § Commit Cadence (AC#6 source — standard per-gate cadence for interactive runs per parent Epic R-1).
- **Parent Epic Activity Log**: R-1 (cadence-language fix — interactive runs use default per-gate cadence, not supervisor-batch); R-2 (audit-log location under `./.claude/skills/shannon-supervisor/`); R-3 (PreToolUse `knowledge_index.md` exception); R-5 (audit-log evidence check tied to first dogfood) — all of which this Task verifies.

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-018` (Gate 2).*

### Approach

This is the end-to-end exercise Task — its plan is mostly execution and verification, not construction. Apply the editing-order convention indirectly (the run produces source-of-truth artefacts in a specific order — report file first, then index entry; this Task verifies that ordering held). The negative test (AC#4 — out-of-scope write blocked) is a deliberate documented action, not an accidental side-effect — the verification needs to confirm both the positive path (in-scope writes succeed) and the negative path (out-of-scope writes blocked). Commit per the standard per-gate cadence per parent Epic R-1 — supervisor-batch cadence does **not** apply to this interactive run.

### Steps

1. **Pre-flight: verify all sibling Tasks APPROVED.** Confirm TASKs 11–17 are APPROVED before invoking. Read `./.claude/skills/shannon-supervisor/SKILL.md` and confirm the `/shannon-report` contract is in place. *(Orientation; closes no AC.)*
2. **Invoke `/shannon-report`** against this repository. The skill fans out into the three checkers, aggregates fragments, writes the dated report and the index entry per TASK-015's pipeline. Closes AC#1 (report file exists), AC#2 (index entry exists).
3. **Verify the audit log** at the path TASK-017 codified contains entries for the run's tool invocations. Closes AC#3.
4. **Execute the negative test for AC#4.** Document a controlled attempt to write outside `./docs/supervisor/` from within the supervisor-scoped invocation (e.g. an attempted write to `./docs/scratchpad.md`); confirm exit code 2 and the scope-specific error message; confirm the report-writer's writes to `./docs/supervisor/` and `./docs/knowledge_index.md` (the AC#3 R-3 exception) succeeded in the same run. Closes AC#4.
5. **Run verbatim-phrase greps.** Literal greps against the dated report and the `knowledge_index.md` entry for the four-category schema labels (Drift / Gap / Internal contradiction / Strength) and the hybrid header format. Each grep returns matches as plain prose. Closes AC#5.
6. **Scope-bounded-diff verification.** `git status` confirms the expected files only — dated report, `knowledge_index.md`, this Task file, `task_index.md`, parent Epic Activity Log. Closes AC#7.
7. **Gate 3 commit.** After directing-party approval, commit per `development_guide.md` v1.4 § Commit Cadence (the standard per-gate cadence, not the supervisor-batch cadence — per parent Epic R-1). Push per § Push Cadence trigger (a) — after every Gate 3 approval. Closes AC#6.

### Dependencies

- **Depends on**: All of TASKs 11–17 APPROVED.
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `ux_guide.md` v1.2 (APPROVED); `conceptual_design.md` v1.7 (APPROVED); `development_guide.md` v1.4 (APPROVED — AC#6 source).
- **Parent Epic** R-1 (cadence-language fix) is the critical refinement this Task carries forward: interactive runs follow the default per-gate cadence — the parent Epic Activity Log's Gate 1 ratification recorded R-1 as fixing this internal contradiction so this Task's AC#6 is now consistent with R-1.

### Risks

- **First report writing dogfood revealing report-shape gaps** (per parent Epic § Plan § Risks paragraph 2 — carried forward unchanged here). The hybrid presentation default has not been exercised live; the first run may surface shape ambiguities (e.g. zero-findings handling — explicitly deferred to EPIC-010 per parent Epic § Overview). **Mitigation**: AC#1 verifies against the hybrid-default shape; if shape gaps surface, route as framework-general ambiguities per `development_guide.md:114` to EPIC-010 elaboration.
- **Cost overrun on first dogfood run.** The 6–7× single-session cost band (per `technical_design.md` v1.2 § Cadence → *Cost note*) is spike-predicted, not measured. The first run may exceed the band — but this would surface as observation, not failure (FEAT-009's *Cadence run cost* Measurable Target tracks this directionally; EPIC-011 territory for cost-tuning follow-up). **Mitigation**: capture `/usage` output during the run; if cost exceeds 7×, surface as a finding at Gate 3 and route to scratchpad.
- **AC#4 negative test ambiguity.** Documenting "an attempted write to `./docs/scratchpad.md`" without actually attempting it leaves AC#4 unverified; actually attempting it during the invocation requires the supervisor scope to be live and the directing party comfortable with the controlled blocked-write event. **Mitigation**: AC#4 names the test as documented and controlled; the run captures both the negative-test command and the hook's blocking response.
- **Cadence-language regression.** If the implementer reaches for `git commit -m "Supervisor report YYYY-MM-DD"` (the supervisor-batch subject format from `development_guide.md` v1.4) instead of the standard per-gate cadence's commit subject, AC#6 fails. **Mitigation**: AC#6 explicitly names the standard per-gate cadence per R-1; the parent Epic Activity Log Gate 1 entry records R-1 as the cadence-language fix.

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

- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-018`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-018`, the prepared plan surfaces for Gate 2 review. Descriptive title (*First Dogfood /shannon-report Run*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-018` (Gate 1).
