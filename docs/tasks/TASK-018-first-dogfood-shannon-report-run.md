# TASK-018: First Dogfood `/shannon-report` Run

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #dogfood #report #knowledge-index #commit #shannon-self
- **Created**: 2026-05-30
- **Updated**: 2026-06-28

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-018` (Gate 1).*

### Overview

The closing Task of EPIC-009: perform the first dogfood of the supervisor by **executing the `/shannon-report` pipeline** against the Shannon-self repository, producing a real dated report and `knowledge_index.md` entry, and verifying the artefacts satisfy parent Epic AC#3, AC#5, AC#7. Commit per the standard per-gate cadence per parent Epic R-1 (the cadence-language fix — interactive `/shannon-report` runs follow the default per-gate cadence, not the supervisor-batch cadence, which is EPIC-011 territory).

**Execution reality (surfaced at Gate 1).** The supervisor is a Markdown **skill** (`SKILL.md` prose + checker definitions + templates + hook scripts), not auto-running code. "Running `/shannon-report`" therefore means *an agent follows the SKILL.md § Report Pipeline*: spawn the three checker subagents (per their `checkers/*.md` definitions), aggregate their fragments into the hybrid-default report using the `templates/`, write the dated report, and add the `knowledge_index.md` entry. This Task **depends on TASK-020** (the thin `/shannon-report` command entry point — never scoped in EPIC-009, created as a corrective Task) so the invocation surface exists. The **hooks** (TASK-016 PreToolUse write-guard, TASK-017 PostToolUse audit log) are demonstrated by running their scripts directly against the run's write events with `SHANNON_SUPERVISOR_SCOPE` set (their logic is already proven by their unit suites) — whether Claude Code **auto-fires** the registered hooks during a real invocation, and whether it **propagates** `SHANNON_SUPERVISOR_SCOPE` to the hook subprocesses, cannot be verified in an interactive dev session and is **explicitly deferred to EPIC-011** (with the sentinel-file fallback noted in the scratchpad signal item).

This Task is the end-to-end exercise of the prior EPIC-009 work: TASK-011's skeleton + `/shannon-report` contract; TASKs 12–14's three-checker fan-out; TASK-015's report writer + index updater; the two hooks (demonstrated). Out of scope: autonomous headless invocation and live hook auto-firing / env propagation (EPIC-011); the zero-findings degenerate case (EPIC-010 — deferred per parent Epic § Overview); the `/shannon-report` command file itself (TASK-020); subsequent dogfood runs beyond the first.

### Acceptance Criteria

- **AC#1 — Executing the `/shannon-report` pipeline produces a valid dated report.** Following the `SKILL.md` § Report Pipeline (spawn the three checker subagents per their `checkers/*.md` definitions → aggregate fragments → instantiate `templates/` → write) produces a file at `./docs/supervisor/report-2026-MM-DD.md` (date of the run) per `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*. The report follows the hybrid-presentation default per `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation* (diagnostic header — finding/stuck/push-lag counts + checkers-succeeded — followed by one or two narrative findings), instantiated from TASK-015's templates. The three checkers run as real subagents reading the real repository, so the findings are genuine. Closes the dogfood half of parent Epic AC#3.

- **AC#2 — `knowledge_index.md` entry written for the report.** The report is indexed in `./docs/knowledge_index.md` with Type marked *Supervisor Report* per `conceptual_design.md` v1.7 § Domain Model → *Knowledge Note*. The entry's relative-path reference resolves to the dated report file. This is the first real exercise of TASK-015's codified knowledge_index write step (which was codified-not-executed per TASK-015's R-A contradiction fix). Closes the index half of parent Epic AC#3. Derives from `conceptual_design.md` v1.7 § Domain Model → *Knowledge Note* (Supervisor Report subtype) and `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*.

- **AC#3 — PostToolUse audit-log hook demonstrated against the run's write events.** The TASK-017 audit-log hook (`posttool-auditlog.sh`) is run directly, with `SHANNON_SUPERVISOR_SCOPE` set, against the dogfood run's actual tool events (the report Write to `./docs/supervisor/` and the index Edit on `./docs/knowledge_index.md`), producing audit entries that name those invocations with ISO-8601 timestamps. This demonstrates the hook records supervisor operations as designed (its logic is already proven by TASK-017's unit suite). **Whether Claude Code auto-fires the registered PostToolUse hook during a real invocation is not verified here — deferred to EPIC-011** (see AC#8). Closes the audit-log half of parent Epic AC#3 (R-5 amendment) and the demonstration half of parent Epic AC#5. Derives from parent Epic AC#3 (R-5 amendment) and AC#5 (R-2 amendment), as reframed for the manual-dogfood scope (Gate 1 finding).

- **AC#4 — Out-of-scope write refusal demonstrated by the PreToolUse hook.** The TASK-016 write-guard (`pretool-writeguard.sh`) is run directly, with `SHANNON_SUPERVISOR_SCOPE` set, against (a) a negative-test out-of-scope write event (e.g. `./docs/scratchpad.md`) — confirming **exit code 2** and the scope-specific stderr message — and (b) the dogfood's in-scope writes (`./docs/supervisor/...` and the `./docs/knowledge_index.md` exception) — confirming **exit 0**. This demonstrates the guard's positive and negative paths in the dogfood context (logic already proven by TASK-016's unit suite). **Live auto-firing during a real invocation is deferred to EPIC-011** (see AC#8). Closes the hook-verification half of parent Epic AC#4. Derives from parent Epic AC#4 (PreToolUse hook scope), as reframed for the manual-dogfood scope.

- **AC#5 — Verbatim phrases pass plain-prose grep on the real output.** The produced report and the `knowledge_index.md` entry satisfy the plain-prose substring discipline (parent Epic AC#7): literal greps against the run's output for the four-category schema labels (Drift / Gap / Internal contradiction / Strength) and the *Supervisor Report* Type token land as plain prose (no Markdown interposing). Closes parent Epic AC#7's dogfood-verification half. Derives from parent Epic AC#7.

- **AC#6 — Standard per-gate commit cadence applied.** A single commit lands at Gate 3 approval per `development_guide.md` v1.4 § Commit Cadence — the standard per-gate cadence for interactive runs per parent Epic R-1 (the supervisor-batch cadence is autonomous-only / EPIC-011 territory; do **not** use the `Supervisor report YYYY-MM-DD` batch subject). The commit captures the report file, the `knowledge_index.md` update, and this Task's bookkeeping (status transition, archive move, parent Epic Activity Log update). Derives from `development_guide.md` v1.4 § Commit Cadence and parent Epic R-1.

- **AC#7 — Scope-bounded edit per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task's tracked diff covers the dated report under `./docs/supervisor/`, the `./docs/knowledge_index.md` entry, this Task's own file, `./docs/tasks/task_index.md`, and the parent Epic Activity Log at `./docs/epics/EPIC-009-health-reporting-surface.md`. It does **not** modify any skill body (TASK-011/015 territory); any checker definition (TASKs 12–14); any hook script or `settings.json` (TASKs 16–17); the `/shannon-report` command file (TASK-020 territory); or any mandated document. The audit log written under `./.claude/` is gitignored (operational telemetry). Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

- **AC#8 — Runtime-integration limitations documented honestly.** The dogfood verifies the pipeline composes end-to-end and produces real artefacts, and that the hook *logic* behaves — but it does **not** verify the Claude Code runtime integration: (i) that a literal `/shannon-report` slash-command invocation triggers the skill, (ii) that the registered hooks **auto-fire** on the main agent's tool calls, (iii) that `SHANNON_SUPERVISOR_SCOPE` **propagates** to hook subprocesses. These require a real deployed invocation and are **deferred to EPIC-011** (autonomous runs), where the sentinel-file fallback for the scope signal (scratchpad `SHANNON_SUPERVISOR_SCOPE` item) is also resolved. This AC is met by recording these limitations explicitly in this Task's Implementation Notes and routing them forward — honest-failure-modes discipline per FEAT-009 § User Stories *Supervisor Finds Nothing* / *Honest Failure Modes*. Derives from FEAT-009 § User Stories (honest failure framing) and the parent Epic § Overview (autonomous cadence is EPIC-011).

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

This is the end-to-end exercise Task — mostly execution and verification, not construction — performed as a **manual dogfood**: the agent acts as the supervisor and follows the `SKILL.md` § Report Pipeline, since the skill is prose rather than auto-running code. It **depends on TASK-020** (the `/shannon-report` command entry point). The report is the source-of-truth artefact written first, then the index entry (editing-order). The hooks are **demonstrated by direct script invocation** with `SHANNON_SUPERVISOR_SCOPE` set — both the negative path (out-of-scope write → exit 2) and positive path (in-scope → exit 0) for the write-guard, and the audit-log entries for the run's write events. Runtime auto-firing / env propagation / literal slash-command triggering are **not** verifiable here and are documented + deferred to EPIC-011 (AC#8). Commit per the standard per-gate cadence per parent Epic R-1.

### Steps

1. **Pre-flight.** Confirm TASKs 11–17 **and TASK-020** are APPROVED; read `./.claude/skills/shannon-supervisor/SKILL.md` § Report Pipeline + the `/shannon-report` contract + command file. *(Orientation; closes no AC.)*
2. **Execute the pipeline.** Spawn the three checker subagents (Alignment, Lifecycle, Drift) per their `checkers/*.md` definitions against the real repository; collect their four-category fragments; instantiate `templates/header.md` + `finding-section.md` (×1–2 highest-signal) + `footer.md`; write the dated report to `./docs/supervisor/report-YYYY-MM-DD.md`; append the *Supervisor Report* entry to `./docs/knowledge_index.md`. Closes AC#1, AC#2.
3. **Demonstrate the audit-log hook (AC#3).** Run `posttool-auditlog.sh` (signal set) against the run's actual write events (the report Write, the index Edit); confirm entries with ISO-8601 timestamps name those invocations.
4. **Demonstrate the write-guard hook (AC#4).** Run `pretool-writeguard.sh` (signal set) against a negative-test out-of-scope write (`./docs/scratchpad.md` → exit 2 + stderr) and the in-scope writes (`./docs/supervisor/...`, `./docs/knowledge_index.md` → exit 0).
5. **Verbatim-phrase greps (AC#5).** Literal greps against the dated report + the `knowledge_index.md` entry for the four-category schema labels and the *Supervisor Report* Type token; each lands as plain prose.
6. **Document runtime-integration limitations (AC#8).** Record in Implementation Notes that literal slash-command triggering, hook auto-firing, and `SHANNON_SUPERVISOR_SCOPE` propagation are unverified-here and deferred to EPIC-011; route forward.
7. **Scope-bounded-diff verification (AC#7).** `git status` confirms the expected files only — dated report, `knowledge_index.md`, this Task file, `task_index.md`, parent Epic Activity Log — and no skill/checker/hook/command/mandated-doc change.
8. **Gate 3 commit + push (AC#6).** After approval, commit per the standard per-gate cadence (not the supervisor-batch subject); push per § Push Cadence trigger (a).

### Dependencies

- **Depends on**: All of TASKs 11–17 APPROVED; **TASK-020 APPROVED** (the `/shannon-report` command entry point — the dogfood needs an invocable surface).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `ux_guide.md` v1.2 (APPROVED); `conceptual_design.md` v1.7 (APPROVED); `development_guide.md` v1.4 (APPROVED — AC#6 source).
- **Parent Epic** R-1 (cadence-language fix) is the critical refinement this Task carries forward: interactive runs follow the default per-gate cadence — the parent Epic Activity Log's Gate 1 ratification recorded R-1 as fixing this internal contradiction so this Task's AC#6 is now consistent with R-1.

### Risks

- **First report writing dogfood revealing report-shape gaps** (per parent Epic § Plan § Risks paragraph 2 — carried forward unchanged here). The hybrid presentation default has not been exercised live; the first run may surface shape ambiguities (e.g. zero-findings handling — explicitly deferred to EPIC-010 per parent Epic § Overview). **Mitigation**: AC#1 verifies against the hybrid-default shape; if shape gaps surface, route as framework-general ambiguities per `development_guide.md:114` to EPIC-010 elaboration.
- **Cost overrun on first dogfood run.** The 6–7× single-session cost band (per `technical_design.md` v1.2 § Cadence → *Cost note*) is spike-predicted, not measured. The first run may exceed the band — but this would surface as observation, not failure (FEAT-009's *Cadence run cost* Measurable Target tracks this directionally; EPIC-011 territory for cost-tuning follow-up). **Mitigation**: capture `/usage` output during the run; if cost exceeds 7×, surface as a finding at Gate 3 and route to scratchpad.
- **AC#4 negative test ambiguity — resolved by direct script demonstration.** Rather than relying on a live auto-fired hook (not verifiable here), AC#4 runs `pretool-writeguard.sh` directly with the scope signal against both the negative and positive write events — a concrete, captured exit-code demonstration. **Mitigation**: the run records both the blocked (exit 2 + stderr) and allowed (exit 0) responses.
- **Manual-dogfood honesty — runtime integration unverified.** Because the skill is prose and hook auto-firing/env propagation can't be exercised in a dev session, the dogfood proves the pipeline *composes* and the hook *logic* behaves, not the live Claude Code wiring. **Mitigation**: AC#8 documents these limitations explicitly and routes them to EPIC-011, rather than overclaiming a full runtime verification.
- **The checkers surface real findings about Shannon-self.** The dogfood runs the three checkers against the actual repository, so the report may contain genuine drift/lifecycle/operational findings (e.g. the deferred `/shannon-setup` mirror work, the open scratchpad items). **Mitigation**: this is the supervisor working as intended — the report should reflect findings honestly (zero-findings degenerate handling is EPIC-010); any actionable finding is captured, not suppressed.
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

- **2026-06-28** — ELABORATED (Gate 1 — pending directing-party approval). The closing dogfood Task; Gate 1 surfaced a **structural gap and an execution reality** that reshape it. **(Finding 1 — missing command entry point)** EPIC-009 built the skill, checkers, pipeline, and hooks but **never created the thin `/shannon-report` command file**, so the `SKILL.md` contract had no invocation surface (Shannon's Commands+Skills+Subagents architecture requires a `./.claude/commands/*.md` delegate). Resolved by directing-party decision: a corrective Task **TASK-020** creates the command file (tracked `./shannon/commands/`, deployed); TASK-018 now **depends on TASK-020 APPROVED**. The decomposition-gap lesson is routed to scratchpad. **(Finding 2 — the skill is prose, runtime is unverifiable here)** the supervisor is a Markdown skill an agent executes by following `SKILL.md`; "running `/shannon-report`" = the agent spawns the three checkers, aggregates, writes the report + index. Three runtime facts cannot be verified in an interactive dev session — hook **auto-firing**, `SHANNON_SUPERVISOR_SCOPE` **propagation** to hook subprocesses, and literal slash-command **triggering** — so they are **deferred to EPIC-011** (a new **AC#8** documents this honestly; the scratchpad runtime item carries it forward). **ACs reshaped to the manual-dogfood scope**: AC#1 (execute the pipeline → real dated report, hybrid shape, genuine checker findings); AC#2 (real `knowledge_index.md` entry — the first execution of TASK-015's codified-not-executed write step); AC#3/AC#4 (hooks **demonstrated** via direct `posttool-auditlog.sh` / `pretool-writeguard.sh` runs with the signal set, against the run's actual write events — logic already proven by their unit suites; live auto-firing deferred); AC#5 (verbatim greps on the real output); AC#6 (standard per-gate cadence, not the batch subject); AC#7 (scope-bounded — report + index + bookkeeping; command file is TASK-020 territory); **AC#8 (new — runtime-integration limitations documented + deferred to EPIC-011)**. Plan reworked to the 8-step manual-dogfood shape; Dependencies updated (+TASK-020); Risks updated (AC#4 ambiguity resolved by direct demonstration; manual-dogfood honesty; checkers may surface real Shannon-self findings). Status: DRAFT → ELABORATED.
- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-018`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-018`, the prepared plan surfaces for Gate 2 review. Descriptive title (*First Dogfood /shannon-report Run*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-018` (Gate 1).
