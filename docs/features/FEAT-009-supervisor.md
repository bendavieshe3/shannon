# FEAT-009: Supervisor

## Metadata

- **Status**: IMPLEMENTED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #5 *Continuous Health Vigilance* (primary); § Key Features *Supervisor Role* (substantive commitment); § Target Users *Three roles, configurably separable* (role model); § Future Vision *supervisor portability* (forward generalisation)
- **Initial Implementation**: Built through Shannon — interactive reporting, the unattended runner and portability delivered and validated (2026-11-14). Scheduling a run for Shannon itself is a per-project choice, not yet made. See Plan and Activity Log.
- **Created**: 2026-05-29
- **Updated**: 2026-11-14

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no active implementation) or `ACTIVE` (implementation in progress). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work linked to this Feature.

---

## Requirements

*Initial intent captured at `/feature-create` (2026-05-29); Requirements refined at `/feature-elaborate FEAT-009` (Gate 1) the same day.*

### Overview

FEAT-009 captures the **supervisor role** as a persistent capability of Shannon: a continuous-vigilance role distinct from the implementer and (optionally) distinct from the directing party, organising authorised work without mandatory lower-level gates and producing dated audit reports on a project-configured cadence. The supervisor is what makes Vision § Core Principles #5 (*Continuous Health Vigilance*) operational rather than aspirational — without an actor performing vigilance on a cadence, the principle is unbacked.

The Feature began as forward work from a zero baseline; interactive reporting and synthesis have since been delivered through the historical Epics below. Autonomous cadence and portability acceptance remain separate outstanding work. The Vision v2.4 documentation cascade (`d2fd797` → `0fe6e30`, all six mandated documents) ratified the supervisor's role and architecture at framework level; FEAT-009 is the implementing Feature that delivers it. The cascade established the *what* and the *contract*; this Feature delivers the *how*.

The May 2026 architecture investigation (historical input; not included in this repository) surveyed Claude Code primitives and produced the 5-commit / 4-defer architecture that `technology_stack.md` § Supervisor Tooling and `technical_design.md` § System Architecture → *Supervisor* + § Cadence now codify. The delivery plan retains foundation, synthesis and autonomy as useful execution groupings; later integrations remain deferred. These groupings add no approval gates.

### Ideal State

Each bullet cites the cascade-doc anchor it elaborates, distinguishing **contract ratified** (cascade-delivered) from **implementation forward** (this Feature's work):

- **Cadence-driven operation** — The supervisor runs on a project-configured cadence: interactively via `/shannon-report`, autonomously via headless mode (`claude -p`, through the shipped `cadence-run.sh` runner; `--bare` was dropped on 2026-11-13 because it skips skill and hook discovery) triggered by an external scheduler the project chooses. Each run produces a dated report at `docs/supervisor/report-YYYY-MM-DD.md`. *(Contract ratified at `technical_design.md` § Cadence + § Data Model → *Supervisor Report Files*; implementation forward through foundation and autonomy work.)*

- **Three-checker fan-out** — A single supervisor invocation spawns three specialised checker subagents in parallel: Alignment Checker (Haiku — codebase vs documents), Lifecycle Checker (Sonnet — index vs source-of-truth bodies; stuck items), Drift Checker (Haiku — scratchpad pressure, uncommitted changes, branch lag). Findings aggregate into one report using the four-category schema (Drift / Gap / Internal contradiction / Strength). *(Contract ratified at `technical_design.md` § System Architecture → *Supervisor*; implementation forward through foundation delivery.)*

- **Feature-level authority** — The human owns Vision and Feature gates. Optional execution aids add no gates. A supervisor can organise work within existing approved intent; new meaning and explicit project holds return to the human. Legacy gate-authority fields grant no authority.

- **Five Claude Code hook integration points** — `SessionStart` injects a terse health summary so sessions open already oriented; `PreToolUse` write-guards against writes outside `docs/supervisor/`; `PostToolUse` audit-logs supervisor operations; `PreCompact` snapshots in-flight findings before context compaction; `Stop` runs a completion check. *(Hook roles ratified at `technical_design.md` § System Architecture → *Supervisor* → *Hook integration*; PreToolUse, PostToolUse and SessionStart are delivered; PreCompact and Stop remain forward work under EPIC-011.)*

- **Hybrid report presentation by default** — Reports are presented as a diagnostic header (counts of findings, stuck items, push lag) followed by a one- to two-finding narrative body. Diagnostic-only and conversational-only presentations are valid project customisations. Authorised execution progress and actual review findings are surfaced without implying Feature approval. *(Contract ratified at `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation* + *Supervisor-Approved Gate Notification*; implementation forward through foundation and synthesis work.)*

- **Independent review** — A reviewer who did not implement the work supplies technical judgement. The human accepts Feature delivery; self-tests, a supervisor role label and code merge do not supply that acceptance.

- **Goal decomposition via `/shannon-goal`** — A directing-party intent (free-text hint) is decomposed into candidate work items, citing existing artefacts where alignment exists and surfacing gaps where it does not. Categorised output: candidates aligned with existing artefacts; candidates surfacing gaps; explicit indication of which require directing-party approval to promote. *(Contract ratified at `ux_guide.md` § Command Surface → *Supervisor Commands* + `technical_design.md` § API Design → *Supervisor Verbs*; implementation forward through synthesis delivery.)*

- **Cost envelope honoured** — Aggregate per-run token cost stays within the spike-predicted 6–7× single-session band; Haiku for exploration-heavy checkers, Sonnet reserved for synthesis. *(Cost band committed at `technical_design.md` § Cadence → *Cost note*; implementation forward — model selection in the skill's checker definitions.)*

- **Honest deferral boundary** — Shannon's supervisor rides on five production-ready Claude Code primitives (Hooks, Subagents, Headless mode + external scheduler, Worktree isolation, Skill frontmatter control). Four alternatives are deferred to later integration work pending maturity: Cloud Routines, Managed Agents, MCP server exposure of Shannon state, statusline as full-report surface. *(Boundary committed at `technology_stack.md` § Supervisor Tooling; implementation respects the boundary across all Epics.)*

- **Portability to non-Shannon-self projects** — The supervisor skill at `./.claude/skills/shannon-supervisor/` is portable: copying the directory into any Shannon-equipped project delivers the supervisor capability without modification. Per-project configuration lives in `./.claude/shannon-supervisor.json`; per-project scheduler choice lives in that project's own `development_guide.md`. *(Aspiration named at Vision § Future Vision; implementation forward — supervisor skill packaging discipline across foundation work onward.)*

### User Stories

#### Cadence-Driven Health Summary at Session Start

**As a** solo developer returning to a Shannon project after several days away,
**I want** a terse health summary injected at session start (drift count, stuck items, push lag),
**So that** I open the session already oriented instead of having to manually audit indexes and recent commits before I can act.

#### Agent-Managed Execution Within Approved Features

**As a** directing party in a fuller (directing party + supervisor + implementer) configuration,
**I want** agents to organise and execute approved Feature work without routine child approval requests,
**So that** my interventions stay reserved for Feature- and Vision-level decisions where my judgement actually compounds.

#### Discovering Decisions Made Between Sessions

**As a** directing party opening a new session,
**I want** a concise account of actual changes, checks, reviews and unresolved decisions since I last engaged,
**So that** I learn what happened during my absence without losing the ability to second-guess any individual decision.

#### Goal Decomposition Flow

**As a** Gardener Dev with a half-formed intent ("make onboarding feel less abrupt"),
**I want** `/shannon-goal` to decompose the intent into candidate work items categorised by whether they align with existing artefacts or surface gaps,
**So that** I can pick which candidates to promote without having to scan the entire artefact set myself.

#### Existing Project Holds

**As a** directing party with explicit project-specific decisions still outstanding,
**I want** the supervisor to surface those holds and ignore legacy gate-authority fields as approval grants,
**So that** optional execution aids do not bypass real scope, access or cost authority.

#### Honest Failure Modes — Supervisor Finds Nothing

**As a** directing party reviewing a cadence report that surfaces zero findings,
**I want** "no findings" to land as an explicit, positively-stated diagnostic ("3 checkers ran cleanly; nothing surfaced"),
**So that** I can distinguish a healthy quiet run from a broken supervisor that silently failed to check.

#### Honest Failure Modes — False Positive

**As a** directing party who has reviewed a finding and decided it is intentional (e.g. an intentional documentation drift),
**I want** to mute the finding so the same false positive does not re-surface in every report,
**So that** the report's signal-to-noise stays high and I trust the cadence enough to keep using it.

#### Honest Failure Modes — Correcting a Supervisor Recommendation

**As a** directing party who disagrees with a supervisor recommendation,
**I want** to correct its interpretation and record the decision,
**So that** future work uses the current approved meaning without manufacturing child gates or inferred acceptance.

### Context

- **Vision**: § Core Principles #5 *Continuous Health Vigilance* (primary anchor); § Key Features *Supervisor Role*; § Target Users *Three roles, configurably separable*; § Future Vision (portability commitment)
- **Conceptual Design**: § Glossary → *Supervisor*; § Business Rules → *Gate Authority Split*, *Supervisor Distinct From Implementer*, *Three Hard Gates* (refreshed); § Domain Model → *Knowledge Note* Type extension for *Supervisor Report*
- **Technology Stack**: § Supervisor Tooling (the 5 committed primitives + 4 deferrals; abstract cron mechanism; `./.claude/` configuration storage)
- **Technical Design**: § System Architecture → *Supervisor*; § Cadence (headless contract + worktree pattern); § Data Model → *Supervisor Report Files* + *Supervisor Configuration* + *Cadence State*; § API Design → *Supervisor Verbs*; § Gate Enforcement (refreshed)
- **Development Guide**: § Git Workflow → *Commit Cadence* and *Push Cadence*; § Multi-Agent Coordination (refreshed); § Supervisor Report Files (dogfood)
- **UX Guide**: § Command Surface → *Supervisor Commands*; § Interaction Patterns → *Supervisor Report Presentation*, *Supervisor-Approved Gate Notification*, *Gate Approval* (human Feature decisions), *Cooperative Access Collision* (refreshed)
- **Initial architecture investigation**: the May 2026 architecture investigation (historical input; not included in this repository) — primary architectural input
- **Related Features**: [FEAT-006 — Multi-Party Supervision](FEAT-006-multi-party-supervision.md) describes the multi-party pattern; this Feature supplies the concrete supervisor capability. Its current definition has been reconciled to the human Feature-gate boundary. Earlier re-elaboration requests remain in the Activity Log as history, not outstanding delegated-gate requirements.


---

## Plan

**2026-11-01 governance revision:** the recorded delivery order is retained, and explicit scheduler/deployment/cost holds below remain outstanding. Routine child gates are superseded; this change does not start autonomous cadence, approve a scheduler or deploy hooks. Current Feature delivery acceptance remains human-owned.

The approach was approved on 2026-05-30. The retained Epics organise delivery; their legacy statuses and old review records do not impose child gates.

### Approach

Deliver the supervisor in the recorded order: health reporting (EPIC-009), synthesis and goal decomposition (EPIC-010), then autonomous invocation (EPIC-011). Foundation and synthesis deliveries are recorded below. Autonomy still needs the named scheduler, deployment and cost decisions; this revision does not waive those holds. Later integrations remain deferred until real cadence evidence justifies them.

Keep one coherent delivery group in progress at a time, using the evidence from each to refine the next. Autonomy depends on the reporting skill, while synthesis supplies goal decomposition and the SessionStart summary. Agents manage these dependencies within the approved Feature approach without re-running mandatory Epic or Task gates.

A human can correct supervisor findings or execution decisions through the relevant command or document. A progress-label change is not a delegated approval or a Feature acceptance decision. Consequential changes return to the human under `conceptual_design.md` § Business Rules → Gate Authority Split.

### Epics

- [EPIC-009](../epics/EPIC-009-health-reporting-surface.md) — **APPROVED (2026-07-11)** — Health Reporting Surface (foundation delivery — first operational supervisor; `/shannon-report` skill, three checker subagents, dated report writing, PreToolUse write-guard, PostToolUse audit logging, supervisor configuration file pattern; historical investigation). **Delivered**: the interactive `/shannon-report` reporting surface, dogfooded end-to-end (first report at `docs/supervisor/report-2026-07-05.md`). Grew from 8 to 11 Tasks via three correctives (tracked shipping source; the missing command entry point; the knowledge-index path defect the dogfood caught). Deferred to siblings as scoped: the other three hooks + `/shannon-goal` → EPIC-010; autonomous headless invocation + live hook auto-firing → EPIC-011.
- [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md) — **APPROVED (2026-08-25)** — Synthesis and Reports (synthesis delivery — `/shannon-goal` goal decomposition, hybrid report presentation default, SessionStart health-summary injection; historical investigation). **Delivered**: the `/shannon-goal` decomposition verb with a candidate-derived promotion-authority footer, the SessionStart health-summary hook, per-category finding counts in the report header, presentation-customisation prose, and the zero-findings clean-run pattern. Grew from 5 to 7 child Tasks; six APPROVED, one (TASK-026, preCompact) **deferred to EPIC-011** with EPIC-010 AC#4 re-homed there by directing-party decision. Two of the seven were correctives caught by the dogfood's own supervisor. Deferred to EPIC-011 as scoped: preCompact + Stop hooks, autonomous headless invocation.
- [EPIC-011](../epics/EPIC-011-autonomic-invocation.md) — DRAFT, mechanism delivered directly under this Feature 2026-11-13; Shannon-self scheduler activation still held — Autonomic Invocation (autonomy delivery — headless invocation contract, worktree-isolation pattern, supervisor-batch commit + third-trigger push cadence, Stop hook completion-check, **named scheduler choice for the Shannon-self project**; historical investigation)
- [EPIC-016](../epics/EPIC-016-supervisor-deployment-via-shannon-setup.md) — DRAFT, delivered directly 2026-11-13 — Supervisor Deployment via /shannon-setup (installer half of the portability commitment; created 2026-10-18 from the scratchpad triage)

**Future Epics** *(forward work beyond this Feature's current scope; not created as Epic stubs)*:

- **Cross-Project supervisor** — A single supervisor invocation servicing multiple Shannon projects (e.g. a fleet of project directories under one directing party). Deferred because per-project portability (Ideal State bullet *Portability to non-Shannon-self projects*) must ship and stabilise first; multi-project supervision is an emergent need only after multiple projects adopt the per-project pattern.
- **Managed Agents integration** — Hosted REST agent loop per `technology_stack.md` § Supervisor Tooling → *Explicitly deferred*. Beta as of May 2026; revisit once SLA stabilises.
- **MCP server exposure of Shannon project state** — Cross-agent queries against Shannon's work-item and document state. Per `technology_stack.md` deferral; useful for cross-agent coordination but not required by the supervisor itself.

### Dependencies

**Depends on** (current governing documents; historical approvals remain in their Version Histories):

- `vision.md`
- `conceptual_design.md`
- `technology_stack.md`
- `technical_design.md`
- `development_guide.md`
- `ux_guide.md`
- This Feature's approved requirements and approach; subsequent human decisions govern consequential changes
- initial architecture investigation report (2026-05-27): the May 2026 architecture investigation (historical input; not included in this repository)
- [FEAT-006 — Multi-Party Supervision](FEAT-006-multi-party-supervision.md) — sibling multi-party pattern; current authority is reconciled in its definition, while live validation remains separate.

**Depended on by**: Future development-discipline learnings surfaced through supervisor use; future framework-wide observability and dashboarding capabilities (deferred speculation, not committed).

### Risks

- **Cost compounding under frequent cadence** — Per-run aggregate token cost stays within the spike-predicted 6–7× single-session band (per `technical_design.md` § Cadence → *Cost note*), but frequent cadence (e.g. every-30-minutes during a heavy work session) compounds quickly. **Mitigation**: project-tunable cadence (the scheduler choice is the lever — a host cron job can fire hourly or daily as the project chooses); per-run cost monitored via `/usage` output per the Feature's *Cadence run cost* Measurable Target; Haiku reserved for exploration-heavy checkers per `technical_design.md` § System Architecture → *Supervisor* model selection.

- **Supervisor false positives eroding directing-party trust** — The *Supervisor trust sustained* Directional Target measures this risk directly: a supervisor whose reports go unread has failed regardless of technical correctness. **Mitigation**: the mute mechanism per `technical_design.md` § Data Model → *Cadence State* lets the directing party explicitly mark a finding as intentional so it does not re-surface; authority-integrity checks verify that reports do not invent child gates or infer human acceptance.

- **Scheduler-choice deferral blocking autonomous cadence** — `development_guide.md` deferred the Shannon-self project's specific scheduler choice to FEAT-009 (forward-cited as EPIC-011 elaboration). If EPIC-011's elaboration cannot resolve the choice, the autonomous-cadence path of the Ideal State (cadence-driven operation) never ships for Shannon-self. **Mitigation**: EPIC-011's elaboration is explicitly mandated to produce a named scheduler choice (the prepared elaboration draft surfaces this requirement as AC#5 of the prepared draft); failure surfaces as the named scheduler decision before autonomous work, not as silent deferral. The G-2 elaboration gap (flagged in FEAT-009's elaboration Activity Log) is the natural home for this resolution.

- **Managed Agents / Cloud Routines maturing differently than the spike predicted** — `technology_stack.md` § Supervisor Tooling defers four primitives honestly; the deferral could revise if any of those primitives mature in ways that change the architecture (e.g. Cloud Routines reaching production SLA might displace the host-cron-headless pattern). **Mitigation**: revisit the deferral set when later integration work is contemplated; `technology_stack.md` already names the deferrals individually so a change is easy to track; no foundation, synthesis or autonomy Epic locks Shannon into a choice that the deferral set would invalidate.

- **Supervisor skill portability not exercised until first non-Shannon-self deployment** — The Ideal State commits to portability: the supervisor skill at `./.claude/skills/shannon-supervisor/` should work in any Shannon-equipped project by directory copy. This claim is unverified until a second project adopts the skill; EPIC-009 builds for Shannon-self only and surface dependencies on Shannon-self specifics could leak in without being caught. **Mitigation**: design the skill directory layout to be self-contained from EPIC-009 onward (per `technical_design.md` § System Architecture → *Supervisor* → *Skill directory layout*); flag any cross-references to project-specific paths (e.g. `docs/` rather than `./docs/`) during EPIC-009 implementation; first non-Shannon-self deployment is forward work not blocked by this Feature.

---

## Success Metrics

Outcomes that indicate the Feature is being realised. Split honestly: Measurable Targets have a clear instrumentation path; Directional Targets guide judgement.

### Measurable Targets

- **Cadence adoption** — Once authorised cadence operation ships, the Shannon-self project produces at least one `docs/supervisor/report-YYYY-MM-DD.md` per documented cadence period. *Measured by file presence + ISO-date sequencing in `docs/supervisor/`.*
- **Cadence run cost** — Per-run aggregate token cost stays within the spike-predicted 6–7× single-session band. *Measured by `/usage` output captured per cadence run.*
- **Authority integrity** — Reports and goal candidates distinguish authorised execution from a human Feature decision; no mandatory child gate or inferred acceptance.

### Directional Targets

- **Drift detection compounds** — Drift between mandated documents and implementation is caught at the supervisor's cadence rather than at the next manual `/document-review`. *Judgement: "did the supervisor catch this before the directing party did?"*
- **Directing-party surface reduction** — Human decisions concern Vision and Features, while agents handle routine execution. *Judgement: does the supervisor surface consequential decisions without asking for routine Task approval?*
- **Supervisor trust sustained** — After several cadence cycles, the directing party still reads supervisor reports rather than skipping them as noise. *Judgement: a supervisor whose reports go unread has failed regardless of technical correctness.*
- **Goal decomposition usefulness** — `/shannon-goal` outputs surface candidates the directing party actually promotes (rather than discarding all of them). *Judgement: low promotion rate after multiple invocations indicates the decomposition heuristic needs tuning.*

---

## Activity Log

- **2026-11-14** — PLANNED → IMPLEMENTED. The finish-to-vision approach (Gate 2 for the remaining mechanism) approved by the directing party's approval of 2026-11-14 ("yes, pending decisions as recommended" on 2026-11-13, then "Just do it. Just do it all"), which covers the finish-to-vision plan offered on the Gate 2 card. Delivered in Shannon 5.1 (PR #16): PreCompact and Stop hooks with per-run working directories, `scripts/cadence-run.sh` (unattended run in a throwaway worktree, report-only commit on its own branch, throttle), the write-guard absolute-path fix, checker frontmatter Claude Code reads, and supervisor wiring by `/shannon-setup`. Evidence: a live end-to-end cadence run in a fixture (report committed, worktree removed, about $0.49); case scripts in `tests/supervisor/` (16, 13 and 10 cases); setup into a Node project wired the hooks once each (portability). Independent review: an independent reviewer approved at db33cc0. Not done, by design: scheduling `cadence-run.sh` for Shannon itself, which adds a recurring model cost on the directing party's machine; the cron and launchd lines are in `technical_design.md` § Cadence. Awaiting Gate 3.
- **2026-11-13** — Autonomy mechanism and portability implemented in source, directly under this Feature (finish-to-vision push). **Delivered:** PreCompact and Stop hooks (scripts, snippets, 11 unit checks); checker fragments saved to disk as each returns; the `cadence-run.sh` runner (throttle, worktree outside `.claude/`, scoped headless run without `--bare`, the runner commits one report per run on a `supervisor/report-*` branch, optional push, no git write tools for the model); muted findings in the state file; checkers spawned with their model alias; `SKILL.md` frontmatter; `/shannon-setup` wiring of all five hooks, config, ignores and report directory; and `technical_design.md` § Cadence rewritten. **Defect fixed:** the PreToolUse write-guard compared raw paths, but Write and Edit pass absolute paths, so every scoped write was refused. It now makes paths project-relative and refuses `..`, with 14 unit checks. **Live evidence:** in a scratch project, `cadence-run.sh` throttled a second run, then ran all three checkers and wrote the report and index entry under the active write-guard. It committed `Supervisor report 2026-11-13` on its own branch and cleaned up the worktree (about USD 0.49 per run). **Not done, by design:** no scheduler is enabled for Shannon itself, and nothing is deployed to the directing party's machine. Those remain the named scheduler, deployment and cost holds. Awaiting Gate 3 with the other Features.
- **2026-11-12** — Clarification of the approved governance revision: approval of its requirements and implementation approach is not acceptance of this Feature's whole delivered capability. Overall Status remains PLANNED; this repair records no Feature Gate 3 acceptance. Independent review and any remaining delivery or live-validation work remain outstanding.


- **2026-11-01** — Human approved Feature-level governance and implementation approach. Current requirements reconcile supervisor authority; historical delivery remains visible. No autonomous activation, deployment or Feature delivery acceptance is inferred. See [rationale](../knowledge/feature-level-governance.md).


- **2026-10-18** — Plan bookkeeping (no status change): [EPIC-016](../epics/EPIC-016-supervisor-deployment-via-shannon-setup.md) (Supervisor Deployment via /shannon-setup, DRAFT) is created on directing-party approval of the 2026-10-17 scratchpad triage. It is the installer half of § Ideal State *Portability to non-Shannon-self projects*. [SPIKE-001](../../spikes/SPIKE-001-claude-code-skill-and-subagent-file-conventions.md) (skill and subagent file conventions) was opened under this Feature by the same triage.
- **2026-08-25** — Epic outcome recorded: **EPIC-010 (Synthesis and Reports, Phase 3) APPROVED**. Delivers against § Ideal State *Goal decomposition via `/shannon-goal`*, *Hybrid report presentation by default* (the customisation prose and the clean-run case), and the **SessionStart third** of *Five Claude Code hook integration points* — three of five hooks now shipped (SessionStart, PreToolUse, PostToolUse). **The five-hook commitment is intact but re-allocated**: preCompact and Stop both now sit under EPIC-011, preCompact having been descoped from this Epic on 2026-08-25 when its Gate 1 elaboration found the prepared premise unsound (it was specified to snapshot an in-flight findings buffer no shipped component produces, and its value lands only in the long context-pressured runs EPIC-011 owns). **Dogfood value evidenced again**: two of the Epic's seven Tasks were correctives the supervisor's own checkers surfaced, and the Gate 3 review found a third instance of one pattern — artefacts binding to a document *version* or a worked *example* instead of to the governing rule (TASK-022's footer, TASK-023's report header, and this Epic's own AC#1/AC#2 citing `ux_guide.md` v1.2, three versions stale). That pattern is now the strongest open promotion candidate in `docs/scratchpad.md`. **§ Success Metrics *Goal decomposition usefulness*** gains its first exercised evidence (a live `/shannon-goal` run at Gate 3, though promotion rate remains unmeasured). Per the **one-Epic-at-a-time** discipline, EPIC-010 APPROVED unblocks **EPIC-011 (Autonomic Invocation, Phase 4)** elaboration — which now carries three inherited items: preCompact, Stop, and the descoped AC#4. Feature remains PLANNED (its own Gate 3 comes once its Epics complete); the flagged **FEAT-006 re-elaboration** remains due. #epic-outcome
- **2026-07-11** — Epic outcome recorded: **EPIC-009 (Health Reporting Surface, Phase 2) APPROVED**. The first operational supervisor ships — the interactive `/shannon-report` reporting surface: three checker subagents (Alignment/Haiku, Lifecycle/Sonnet, Drift/Haiku) fanning out into a hybrid-default dated report, indexed as a *Supervisor Report*, guarded by the PreToolUse write-guard and observed by the PostToolUse audit log, all authored in the tracked `./shannon/` source. Dogfooded end-to-end (first report `docs/supervisor/report-2026-07-05.md`); the dogfood caught a real knowledge-index path defect that seven isolated Task reviews had passed, corrected by TASK-021. Delivers against § Ideal State *Three-checker fan-out*, *Five hook integration points* (PreToolUse + PostToolUse halves), *Cost envelope honoured*, *Hybrid report presentation*, and the *Portability* discipline. **§ Success Metrics *Phase 2 adoption* now has its first evidence** (a `docs/supervisor/report-YYYY-MM-DD.md` exists). Per the **one-Epic-at-a-time** discipline, EPIC-009 APPROVED unblocks **EPIC-010 (Synthesis and Reports, Phase 3)** elaboration. Also now due: the flagged **FEAT-006 re-elaboration** to cite FEAT-009 as the concrete implementing Feature (trigger — FEAT-009 has landed its operational supervisor skill). Feature remains PLANNED (its own Gate 3 comes once its Epics complete). #epic-outcome
- **2026-05-30** — PLANNED (Gate 2 approved). Plan drafted: phase-by-phase delivery strategy inherited from the Phase-0 spike (2026-05-27) with one Epic per phase (EPIC-009 Health Reporting Surface for Phase 2; EPIC-010 Synthesis and Reports for Phase 3; EPIC-011 Autonomic Invocation for Phase 4); Phase 5+ items (Cross-Project supervisor; Managed Agents; MCP exposure of Shannon state) forward-deferred per `technology_stack.md` v1.3 § Supervisor Tooling — named in the *Future Epics* paragraph with rationale, not instantiated as Epic stubs. Plan commits Shannon to **one Epic at a time**: EPIC-009 must reach APPROVED before EPIC-010 elaboration begins; EPIC-010 must reach APPROVED before EPIC-011 elaboration begins (with EPIC-011's hard dependency on EPIC-009 and softer dependency on EPIC-010 named). **Cascading Preparation performed** per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*: three child Epic stubs created in DRAFT (EPIC-009, EPIC-010, EPIC-011), each with a **prepared elaboration draft** (in Requirements) and **prepared plan draft** (in Plan) marked "*Prepared during FEAT-009 planning, not yet reviewed*". Three new entries added to `epic_index.md` (EPIC-009 / EPIC-010 / EPIC-011, all DRAFT). **Five Risks formalised** at Feature level: cost compounding; false positives; scheduler-choice deferral blocking autonomous cadence (carried forward from FEAT-009 elaboration G-2; resolution mandated as EPIC-011 AC#5); Managed Agents / Cloud Routines maturity revision; supervisor skill portability untested until first non-Shannon-self deployment. **Gate 2 alignment findings — 3 Gaps closed inline** during ratification: (G-A) Stop hook allocated to EPIC-011 with explicit AC#7 (completion-check semantics fit autonomous runs naturally); (G-B) EPIC-009 prepared elaboration amended to add AC#6 for the Supervisor Configuration file creation pattern (absent fields take supervisor-authority defaults; present fields override uniformly); (G-C) override mechanism confirmed as emergent from existing `/[type]-elaborate` / `/[type]-review` flows — noted in this Plan's § Approach. **Two framework-general ambiguities routed to `scratchpad.md` per `development_guide.md:114`**: (M-3) Cascading Preparation at Feature-plan stage vs Epic-plan stage — candidate new canonical workflow in `conceptual_design.md` § Key Workflows; (M-4) Forward-deferral pattern for Phase 5+ items named at Feature § Plan but not instantiated as Epic stubs — candidate `conceptual_design.md` § Domain Model extension. M-5 (Stop hook allocation) closed inline via G-A. **Flagged follow-up carried forward**: FEAT-006 (Multi-Party Supervision) re-elaboration to cite FEAT-009 as the concrete implementing Feature still pending; trigger remains FEAT-009 APPROVED (or earlier, once EPIC-009 lands the operational supervisor skill). Status: ELABORATED → PLANNED.
- **2026-05-29** — ELABORATED (Gate 1 approved). Requirements refined: Overview tightened to three orientation paragraphs; Ideal State finalised as ten bullets each citing the cascade-doc anchor it elaborates (covering cadence, three-checker fan-out, delegated gate authority within the configurable ceiling, five hook integration points, hybrid report presentation, agent-identity gate integrity, goal decomposition, cost envelope, honest deferral boundary, and portability); nine User Stories drafted across solo cadence-orientation, multi-agent gate absorption, agentic-directing-party scope reduction, between-session decision discovery, goal decomposition, project customisation of the Epic and Spike gate-authority ceilings, and three honest failure modes (zero findings, false positives, supervisor-decision override); Success Metrics split into three Measurable Targets (Phase 2 adoption, cadence run cost within the 6–7× spike-predicted band, supervisor-gate override rate) and four Directional Targets (drift detection compounds, directing-party surface reduction, supervisor trust sustained, goal decomposition usefulness); Context cross-references verified against cascade-landed doc versions. Three gaps closed inline during refinement: (G-1) Spike gate-authority configurability now named alongside Epic in the Ideal State + User Stories, (G-2) Shannon-self scheduler-choice cascade-deferral surfaced as a Risk to be formalised at Plan time, (G-3) `/shannon-goal` usefulness criterion added to Directional Targets. **Flagged follow-up**: FEAT-006 (Multi-Party Supervision) requires re-elaboration to cite FEAT-009 as the concrete implementing Feature for the supervisor role specifically, update its Context block to the cascade-landed doc versions, and annotate the previously-deferred *Gate Enforcement visibility UX* Ideal State bullet as now met by `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor-Approved Gate Notification* and the *Gate Approval* refresh. Sequenced after FEAT-009 ELABORATED so FEAT-006 has a stable cross-reference target; tracked as a downstream-gap re-elaboration trigger. Two framework-general ambiguities routed to `scratchpad.md` per `development_guide.md:114`: (M-1) canonical pattern for refreshing an older Feature's cross-references when a newer Feature is created that implements part of its scope — candidate `conceptual_design.md` § Re-elaborating a Work Item Triggers refinement; (M-2) zero-findings supervisor-report presentation pattern — candidate `ux_guide.md` § Interaction Patterns refinement, revisit at EPIC-009 elaboration. Status: DRAFT → ELABORATED.
- **2026-05-29** — DRAFT: Feature created via `/feature-create`. Top-level Feature (no parent Feature) per directing-party cascade decision. Vision Reference anchored to v2.4 § Core Principles #5 + § Key Features Supervisor Role + § Target Users Three roles + § Future Vision. Initial Implementation: **Built through Shannon** from a zero baseline — the supervisor does not yet exist as code, skill, or operational pattern in this repository. The vision-v2.4 documentation cascade (Pass 1 through Pass 4B; commits `d2fd797` through `0fe6e30`) ratified the supervisor's role and architecture across all six mandated documents; FEAT-009 is the implementing Feature that delivers it. Phase-0 spike (2026-05-27) named 5 Claude Code primitives Shannon commits to building on (Hooks, Subagents, Headless mode + external cron, Worktree isolation, Skill frontmatter control) and 4 deferrals (Cloud Routines, Managed Agents, MCP server exposure, statusline-as-full-report); spike phase structure inherited as natural Epic boundaries (Phase 2: Health Reporting Surface → EPIC-009 candidate; Phase 3: Synthesis & Reports → EPIC-010 candidate; Phase 4: Autonomic Invocation → EPIC-011 candidate; Phase 5+ deferred). Full Requirements elaboration pending `/feature-elaborate FEAT-009` (Gate 1); candidate Epics pending `/feature-plan FEAT-009` (Gate 2).
