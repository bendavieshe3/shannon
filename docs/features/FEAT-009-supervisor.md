# FEAT-009: Supervisor

## Metadata

- **Status**: PLANNED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #5 *Continuous Health Vigilance* (primary); § Key Features *Supervisor Role* (substantive commitment); § Target Users *Three roles, configurably separable* (role model); § Future Vision *supervisor portability* (forward generalisation)
- **Initial Implementation**: Built through Shannon — no retrospective component. The supervisor role does not yet exist in this codebase; FEAT-009 captures it as forward work to be delivered through its constituent Epics.
- **Created**: 2026-05-29
- **Updated**: 2026-05-30 (planned)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no epic in progress) or `ACTIVE` (an epic is being worked on). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work through new Epics.

---

## Requirements

*Initial intent captured at `/feature-create` (2026-05-29); Requirements refined at `/feature-elaborate FEAT-009` (Gate 1) the same day.*

### Overview

FEAT-009 captures the **supervisor role** as a persistent capability of Shannon: a continuous-vigilance role distinct from the implementer and (optionally) distinct from the directing party, exercising delegated gate authority for routine work and producing dated audit reports on a project-configured cadence. The supervisor is what makes Vision § Core Principles #5 (*Continuous Health Vigilance*) operational rather than aspirational — without an actor performing vigilance on a cadence, the principle is unbacked.

The Feature is **forward work from a zero baseline**: the supervisor does not yet exist as code, skill, or operational pattern in this repository. The Vision v2.4 documentation cascade (`d2fd797` → `0fe6e30`, all six mandated documents) ratified the supervisor's role and architecture at framework level; FEAT-009 is the implementing Feature that delivers it. The cascade established the *what* and the *contract*; this Feature delivers the *how*.

The Phase-0 spike report (`~/Documents/Vaults/general-vault/Areas/Situations/SIT-026-Shannon-Development-Framework/spike-claude-code-features-2026-05-27.md`) surveyed Claude Code primitives and produced the 5-commit / 4-defer architecture that `technology_stack.md` v1.3 § Supervisor Tooling and `technical_design.md` v1.2 § System Architecture → *Supervisor* + § Cadence now codify. The Feature inherits the spike's phase structure (Phase 2 / Phase 3 / Phase 4 / Phase 5+) as the natural Epic boundary.

### Ideal State

Each bullet cites the cascade-doc anchor it elaborates, distinguishing **contract ratified** (cascade-delivered) from **implementation forward** (this Feature's work):

- **Cadence-driven operation** — The supervisor runs on a project-configured cadence: interactively via `/shannon-report`, autonomously via headless mode (`claude --bare -p ...`) triggered by an external scheduler the project chooses. Each run produces a dated report at `docs/supervisor/report-YYYY-MM-DD.md`. *(Contract ratified at `technical_design.md` § Cadence + § Data Model → *Supervisor Report Files*; implementation forward through Phase 2 + Phase 4 Epics.)*

- **Three-checker fan-out** — A single supervisor invocation spawns three specialised checker subagents in parallel: Alignment Checker (Haiku — codebase vs documents), Lifecycle Checker (Sonnet — index vs source-of-truth bodies; stuck items), Drift Checker (Haiku — scratchpad pressure, uncommitted changes, branch lag). Findings aggregate into one report using the four-category schema (Drift / Gap / Internal contradiction / Strength). *(Contract ratified at `technical_design.md` § System Architecture → *Supervisor*; implementation forward through Phase 2.)*

- **Delegated gate authority within the configurable ceiling** — The supervisor exercises Task gates always; Epic gates and Spike gates by default, each reservable per project. Vision and Feature gate authority remains permanently with the directing party. Scratchpad → Task promotion is autonomous; scratchpad → Epic/Feature promotion requires directing-party approval. *(Contract ratified at `conceptual_design.md` § Business Rules → *Gate Authority Split*; implementation forward — skill protocol + the configuration file at `./.claude/shannon-supervisor.json`.)*

- **Five Claude Code hook integration points** — `SessionStart` injects a terse health summary so sessions open already oriented; `PreToolUse` write-guards against writes outside `docs/supervisor/`; `PostToolUse` audit-logs supervisor operations; `preCompact` snapshots in-flight findings before context compaction; `Stop` runs a completion check. *(Hook roles ratified at `technical_design.md` § System Architecture → *Supervisor* → *Hook integration*; implementation forward through Phase 2 + Phase 3.)*

- **Hybrid report presentation by default** — Reports are presented as a diagnostic header (counts of findings, stuck items, push lag) followed by a one- to two-finding narrative body. Diagnostic-only and conversational-only presentations are valid project customisations. Supervisor-approved gate decisions surface to the directing party after the fact via a one-line notification at next session start, with override always available. *(Contract ratified at `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation* + *Supervisor-Approved Gate Notification*; implementation forward through Phase 2 + Phase 3.)*

- **Agent-identity gate-integrity preserved absolutely** — The supervisor never approves a gate on work the same agent implemented, regardless of which role formally holds gate authority. Skills refuse self-approval flows by protocol. *(Contract ratified at `conceptual_design.md` § Business Rules → *Supervisor Distinct From Implementer*; implementation forward — skill-protocol refusal patterns in the supervisor skill.)*

- **Goal decomposition via `/shannon-goal`** — A directing-party intent (free-text hint) is decomposed into candidate work items, citing existing artefacts where alignment exists and surfacing gaps where it does not. Categorised output: candidates aligned with existing artefacts; candidates surfacing gaps; explicit indication of which require directing-party approval to promote. *(Contract ratified at `ux_guide.md` § Command Surface → *Supervisor Commands* + `technical_design.md` § API Design → *Supervisor Verbs*; implementation forward through Phase 3.)*

- **Cost envelope honoured** — Aggregate per-run token cost stays within the spike-predicted 6–7× single-session band; Haiku for exploration-heavy checkers, Sonnet reserved for synthesis. *(Cost band committed at `technical_design.md` § Cadence → *Cost note*; implementation forward — model selection in the skill's checker definitions.)*

- **Honest deferral boundary** — Shannon's supervisor rides on five production-ready Claude Code primitives (Hooks, Subagents, Headless mode + external scheduler, Worktree isolation, Skill frontmatter control). Four alternatives are deferred to Phase 5+ pending maturity: Cloud Routines, Managed Agents, MCP server exposure of Shannon state, statusline as full-report surface. *(Boundary committed at `technology_stack.md` § Supervisor Tooling; implementation respects the boundary across all Epics.)*

- **Portability to non-Shannon-self projects** — The supervisor skill at `./.claude/skills/shannon-supervisor/` is portable: copying the directory into any Shannon-equipped project delivers the supervisor capability without modification. Per-project configuration lives in `./.claude/shannon-supervisor.json`; per-project scheduler choice lives in that project's own `development_guide.md`. *(Aspiration named at Vision § Future Vision; implementation forward — supervisor skill packaging discipline across Phase 2 onward.)*

### User Stories

#### Cadence-Driven Health Summary at Session Start

**As a** solo developer returning to a Shannon project after several days away,
**I want** a terse health summary injected at session start (drift count, stuck items, push lag),
**So that** I open the session already oriented instead of having to manually audit indexes and recent commits before I can act.

#### Multi-Agent Configuration Absorbing Routine Gate Workload

**As a** directing party in a fuller (directing party + supervisor + implementer) configuration,
**I want** the supervisor to exercise Task gates (and Epic / Spike gates by default) without surfacing each decision in real time,
**So that** my interventions stay reserved for Feature- and Vision-level decisions where my judgement actually compounds.

#### Agentic Directing Party Reducing Surface Area

**As an** agent acting in the directing-party role,
**I want** the supervisor to absorb routine gate workload so my decision surface narrows to Vision and Feature gates,
**So that** my cognitive scope matches the gates the framework reserves for the directing party — not the gates Shannon already partitioned away.

#### Discovering Decisions Made Between Sessions

**As a** directing party opening a new session,
**I want** a one-line notification of every gate the supervisor approved since I last engaged (with override always available),
**So that** I learn what happened during my absence without losing the ability to second-guess any individual decision.

#### Goal Decomposition Flow

**As a** Gardener Dev with a half-formed intent ("make onboarding feel less abrupt"),
**I want** `/shannon-goal` to decompose the intent into candidate work items categorised by whether they align with existing artefacts or surface gaps,
**So that** I can pick which candidates to promote without having to scan the entire artefact set myself.

#### Project Customisation of the Gate-Authority Ceiling

**As a** directing party who wants tighter control over Epic-level decisions on a particular project,
**I want** to reserve Epic gate authority (and/or Spike gate authority) for myself via `./.claude/shannon-supervisor.json`,
**So that** the supervisor remains active on Task-level vigilance and reporting while leaving Epic and Spike approvals interactive.

#### Honest Failure Modes — Supervisor Finds Nothing

**As a** directing party reviewing a cadence report that surfaces zero findings,
**I want** "no findings" to land as an explicit, positively-stated diagnostic ("3 checkers ran cleanly; nothing surfaced"),
**So that** I can distinguish a healthy quiet run from a broken supervisor that silently failed to check.

#### Honest Failure Modes — False Positive

**As a** directing party who has reviewed a finding and decided it is intentional (e.g. an intentional documentation drift),
**I want** to mute the finding so the same false positive does not re-surface in every report,
**So that** the report's signal-to-noise stays high and I trust the cadence enough to keep using it.

#### Honest Failure Modes — Override of a Supervisor Decision

**As a** directing party who disagrees with a supervisor-approved Task gate,
**I want** to override the decision by invoking the relevant command on the work item, returning the item to its prior status and re-running the gate under my authority,
**So that** supervisor delegation never becomes irrevocable — override is rare by design but always open.

### Context

- **Vision**: § Core Principles #5 *Continuous Health Vigilance* (primary anchor); § Key Features *Supervisor Role*; § Target Users *Three roles, configurably separable*; § Future Vision (portability commitment)
- **Conceptual Design** (v1.7): § Glossary → *Supervisor*; § Business Rules → *Gate Authority Split*, *Supervisor Distinct From Implementer*, *Three Hard Gates* (refreshed); § Domain Model → *Knowledge Note* Type extension for *Supervisor Report*
- **Technology Stack** (v1.3): § Supervisor Tooling (the 5 committed primitives + 4 deferrals; abstract cron mechanism; `./.claude/` configuration storage)
- **Technical Design** (v1.2): § System Architecture → *Supervisor*; § Cadence (headless contract + worktree pattern); § Data Model → *Supervisor Report Files* + *Supervisor Configuration* + *Cadence State*; § API Design → *Supervisor Verbs*; § Security Model → *Gate Enforcement* (refreshed)
- **Development Guide** (v1.4): § Commit Cadence → *Supervisor cadence runs*; § Push Cadence (third trigger); § Multi-Agent Coordination (refreshed); § Supervisor Report Files (dogfood)
- **UX Guide** (v1.2): § Command Surface → *Supervisor Commands*; § Interaction Patterns → *Supervisor Report Presentation*, *Supervisor-Approved Gate Notification*, *Gate Approval* (refreshed for both authorities), *Cooperative Access Collision* (refreshed)
- **Phase-0 Spike**: `~/Documents/Vaults/general-vault/Areas/Situations/SIT-026-Shannon-Development-Framework/spike-claude-code-features-2026-05-27.md` — primary architectural input
- **Related Features**: [FEAT-006 — Multi-Party Supervision](FEAT-006-multi-party-supervision.md) names the multi-party pattern at vision level (Partial); FEAT-009 is the *concrete implementing* Feature for the supervisor role specifically. The two coexist by scope: FEAT-006 is the multi-party-supervision pattern; FEAT-009 is the supervisor role's existence and operation. FEAT-006 requires downstream re-elaboration (sequenced after FEAT-009 ELABORATED so FEAT-006 has a stable cross-reference target) to update Context to the v2.4 cascade doc versions, annotate the previously-deferred *Gate Enforcement visibility UX* Ideal State bullet as now met by `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor-Approved Gate Notification* and the *Gate Approval* refresh, and cite FEAT-009 as the concrete implementing Feature for the supervisor role specifically. Flagged in this Feature's Activity Log as a downstream-gap re-elaboration trigger.

---

## Plan

*Filled at `/feature-plan FEAT-009` (Gate 2) 2026-05-30. Phase structure inherited from the Phase-0 spike (2026-05-27); three child Epics created in DRAFT with prepared elaboration and plan drafts via Cascading Preparation; Phase 5+ items forward-deferred.*

### Approach

FEAT-009 ships the supervisor in three phases corresponding to the Phase-0 spike's Phase 2 (foundation), Phase 3 (synthesis and goal-decomposition), and Phase 4 (autonomy). Phase 5+ items (Cross-Project supervisor, Managed Agents, MCP exposure of Shannon state) are forward-deferred per `technology_stack.md` v1.3 § Supervisor Tooling — they are not created as Epic stubs now and will be revisited once Phase 2–4 has produced real-world cadence evidence.

Shannon commits to **one Epic at a time**: Phase 2 must reach APPROVED before Phase 3 elaboration begins; Phase 3 must reach APPROVED before Phase 4 elaboration begins. This honours the framework's epic-as-coherent-unit-of-work principle (per `conceptual_design.md` § Domain Model → *Epic*) and avoids speculative parallel planning at a stage where lived-in evidence from each phase is the most valuable input to the next. Phase 3 depends on Phase 2's report-writing pipeline (goal-decomposition produces candidate work items that aggregate the same checker fan-out the report uses); Phase 4 depends on Phase 2's skill structure (headless mode invokes the same `/shannon-report` skill the interactive path exercises). Phase 3 is helpful but not strictly required for Phase 4 — autonomous reporting can ship without `/shannon-goal`, though SessionStart hook integration from Phase 3 makes the autonomous loop's value visible.

**Override of supervisor decisions is emergent from existing lifecycle commands.** The *Honest Failure Modes — Override of a Supervisor Decision* User Story is satisfied by invoking the relevant `/[type]-elaborate` or `/[type]-review` command on a supervisor-approved work item — this returns the item to the prior status and re-runs the gate under the directing party's authority. No new Epic AC is required to deliver this mechanism; the override channel is open by virtue of the existing unified lifecycle and the *Iterative Implementation Zone* business rule. This emergent mechanism was confirmed at FEAT-009 Gate 2 review (closing finding G-C).

### Epics

- [EPIC-009](../epics/EPIC-009-health-reporting-surface.md) — **APPROVED (2026-07-11)** — Health Reporting Surface (Phase 2 — first operational supervisor; `/shannon-report` skill, three checker subagents, dated report writing, PreToolUse write-guard, PostToolUse audit logging, supervisor configuration file pattern; per spike § 1, § 2, § 3, § 4). **Delivered**: the interactive `/shannon-report` reporting surface, dogfooded end-to-end (first report at `docs/supervisor/report-2026-07-05.md`). Grew from 8 to 11 Tasks via three correctives (tracked shipping source; the missing command entry point; the knowledge-index path defect the dogfood caught). Deferred to siblings as scoped: the other three hooks + `/shannon-goal` → EPIC-010; autonomous headless invocation + live hook auto-firing → EPIC-011.
- [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md) — DRAFT — Synthesis and Reports (Phase 3 — `/shannon-goal` goal decomposition, hybrid report presentation default, SessionStart health-summary injection, preCompact findings snapshot; per spike § 3, § 11)
- [EPIC-011](../epics/EPIC-011-autonomic-invocation.md) — DRAFT — Autonomic Invocation (Phase 4 — headless invocation contract, worktree-isolation pattern, supervisor-batch commit + third-trigger push cadence, Stop hook completion-check, **named scheduler choice for the Shannon-self project**; per spike § 5, § 6, § 7)

**Future Epics** *(forward work beyond this Feature's current scope; not created as Epic stubs)*:

- **Cross-Project supervisor** — A single supervisor invocation servicing multiple Shannon projects (e.g. a fleet of project directories under one directing party). Deferred because per-project portability (Ideal State bullet *Portability to non-Shannon-self projects*) must ship and stabilise first; multi-project supervision is an emergent need only after multiple projects adopt the per-project pattern.
- **Managed Agents integration** — Hosted REST agent loop per `technology_stack.md` v1.3 § Supervisor Tooling → *Explicitly deferred*. Beta as of May 2026; revisit once SLA stabilises.
- **MCP server exposure of Shannon project state** — Cross-agent queries against Shannon's work-item and document state. Per `technology_stack.md` v1.3 deferral; useful for cross-agent coordination but not required by the supervisor itself.

### Dependencies

**Depends on**:

- Vision v2.4 (APPROVED 2026-05-28, commit `d2fd797`)
- conceptual_design v1.7 (APPROVED 2026-05-29, commit `a8fe1e0`)
- technology_stack v1.3 (APPROVED 2026-05-29, commit `c7d66e4`)
- technical_design v1.2 (APPROVED 2026-05-29, commit `71b7ac5`)
- development_guide v1.4 (APPROVED 2026-05-29, commit `a6cad77`)
- ux_guide v1.2 (APPROVED 2026-05-29, commit `0fe6e30`)
- FEAT-009 ELABORATED (Gate 1, commit `dfd7f4e`)
- Phase-0 spike report (2026-05-27): `~/Documents/Vaults/general-vault/Areas/Situations/SIT-026-Shannon-Development-Framework/spike-claude-code-features-2026-05-27.md`
- [FEAT-006 — Multi-Party Supervision](FEAT-006-multi-party-supervision.md) — sibling Feature; multi-party-supervision pattern at vision level. FEAT-006 requires downstream re-elaboration after FEAT-009 lands to cite FEAT-009 as the concrete implementing surface for the supervisor role specifically (flagged in this Feature's Activity Log at ELABORATED).

**Depended on by**: Future development-discipline learnings surfaced through supervisor use; future framework-wide observability and dashboarding capabilities (deferred speculation, not committed).

### Risks

- **Cost compounding under frequent cadence** — Per-run aggregate token cost stays within the spike-predicted 6–7× single-session band (per `technical_design.md` v1.2 § Cadence → *Cost note*), but frequent cadence (e.g. every-30-minutes during a heavy work session) compounds quickly. **Mitigation**: project-tunable cadence (the scheduler choice is the lever — a host cron job can fire hourly or daily as the project chooses); per-run cost monitored via `/usage` output per the Feature's *Cadence run cost* Measurable Target; Haiku reserved for exploration-heavy checkers per `technical_design.md` v1.2 § System Architecture → *Supervisor* model selection.

- **Supervisor false positives eroding directing-party trust** — The *Supervisor trust sustained* Directional Target measures this risk directly: a supervisor whose reports go unread has failed regardless of technical correctness. **Mitigation**: the mute mechanism per `technical_design.md` v1.2 § Data Model → *Cadence State* lets the directing party explicitly mark a finding as intentional so it does not re-surface; the *Override rate* Measurable Target's project-tunable ≤10% threshold provides an explicit signal for when delegation needs revisiting; honest review of the override-rate metric as part of each Epic's Gate 3.

- **Scheduler-choice deferral blocking autonomous cadence** — `development_guide.md` v1.4 deferred the Shannon-self project's specific scheduler choice to FEAT-009 (forward-cited as EPIC-011 elaboration). If EPIC-011's elaboration cannot resolve the choice, the autonomous-cadence path of the Ideal State (cadence-driven operation) never ships for Shannon-self. **Mitigation**: EPIC-011's elaboration is explicitly mandated to produce a named scheduler choice (the prepared elaboration draft surfaces this requirement as AC#5 of the prepared draft); failure surfaces as a directing-party decision point at EPIC-011 Gate 1, not as silent deferral. The G-2 elaboration gap (flagged in FEAT-009's elaboration Activity Log) is the natural home for this resolution.

- **Managed Agents / Cloud Routines maturing differently than the spike predicted** — `technology_stack.md` v1.3 § Supervisor Tooling defers four primitives honestly; the deferral could revise if any of those primitives mature in ways that change the architecture (e.g. Cloud Routines reaching production SLA might displace the host-cron-headless pattern). **Mitigation**: revisit the deferral set when Phase 5+ work is contemplated; `technology_stack.md` v1.3 already names the deferrals individually so a change is easy to track; no Phase 2/3/4 Epic locks Shannon into a choice that the deferral set would invalidate.

- **Supervisor skill portability not exercised until first non-Shannon-self deployment** — The Ideal State commits to portability: the supervisor skill at `./.claude/skills/shannon-supervisor/` should work in any Shannon-equipped project by directory copy. This claim is unverified until a second project adopts the skill; EPIC-009 builds for Shannon-self only and surface dependencies on Shannon-self specifics could leak in without being caught. **Mitigation**: design the skill directory layout to be self-contained from EPIC-009 onward (per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Skill directory layout*); flag any cross-references to project-specific paths (e.g. `docs/` rather than `./docs/`) during EPIC-009 implementation; first non-Shannon-self deployment is forward work not blocked by this Feature.

---

## Success Metrics

Outcomes that indicate the Feature is being realised. Split honestly: Measurable Targets have a clear instrumentation path; Directional Targets guide judgement.

### Measurable Targets

- **Phase 2 adoption** — Once Phase 2 ships, the Shannon-self project produces at least one `docs/supervisor/report-YYYY-MM-DD.md` per documented cadence period. *Measured by file presence + ISO-date sequencing in `docs/supervisor/`.*
- **Cadence run cost** — Per-run aggregate token cost stays within the spike-predicted 6–7× single-session band. *Measured by `/usage` output captured per cadence run.*
- **Override rate** — Once Phase 2 + Phase 3 ship, supervisor-approved gates overridden by the directing party stay below a project-tunable threshold (initial sketch: ≤10% of supervisor gate decisions overridden within their first 30 days). *Measured by Activity Log entries on the relevant work items — supervisor approvals followed by directing-party reversions are countable.*

### Directional Targets

- **Drift detection compounds** — Drift between mandated documents and implementation is caught at the supervisor's cadence rather than at the next manual `/document-review`. *Judgement: "did the supervisor catch this before the directing party did?"*
- **Directing-party surface reduction** — The directing party's gate-engagement time shifts from per-Task to per-Feature/Vision. *Judgement: "is the directing party still approving Task-level gates manually?"*
- **Supervisor trust sustained** — After several cadence cycles, the directing party still reads supervisor reports rather than skipping them as noise. *Judgement: a supervisor whose reports go unread has failed regardless of technical correctness.*
- **Goal decomposition usefulness** — `/shannon-goal` outputs surface candidates the directing party actually promotes (rather than discarding all of them). *Judgement: low promotion rate after multiple invocations indicates the decomposition heuristic needs tuning.*

---

## Activity Log

- **2026-07-11** — Epic outcome recorded: **EPIC-009 (Health Reporting Surface, Phase 2) APPROVED**. The first operational supervisor ships — the interactive `/shannon-report` reporting surface: three checker subagents (Alignment/Haiku, Lifecycle/Sonnet, Drift/Haiku) fanning out into a hybrid-default dated report, indexed as a *Supervisor Report*, guarded by the PreToolUse write-guard and observed by the PostToolUse audit log, all authored in the tracked `./shannon/` source. Dogfooded end-to-end (first report `docs/supervisor/report-2026-07-05.md`); the dogfood caught a real knowledge-index path defect that seven isolated Task reviews had passed, corrected by TASK-021. Delivers against § Ideal State *Three-checker fan-out*, *Five hook integration points* (PreToolUse + PostToolUse halves), *Cost envelope honoured*, *Hybrid report presentation*, and the *Portability* discipline. **§ Success Metrics *Phase 2 adoption* now has its first evidence** (a `docs/supervisor/report-YYYY-MM-DD.md` exists). Per the **one-Epic-at-a-time** discipline, EPIC-009 APPROVED unblocks **EPIC-010 (Synthesis and Reports, Phase 3)** elaboration. Also now due: the flagged **FEAT-006 re-elaboration** to cite FEAT-009 as the concrete implementing Feature (trigger — FEAT-009 has landed its operational supervisor skill). Feature remains PLANNED (its own Gate 3 comes once its Epics complete). #epic-outcome
- **2026-05-30** — PLANNED (Gate 2 approved). Plan drafted: phase-by-phase delivery strategy inherited from the Phase-0 spike (2026-05-27) with one Epic per phase (EPIC-009 Health Reporting Surface for Phase 2; EPIC-010 Synthesis and Reports for Phase 3; EPIC-011 Autonomic Invocation for Phase 4); Phase 5+ items (Cross-Project supervisor; Managed Agents; MCP exposure of Shannon state) forward-deferred per `technology_stack.md` v1.3 § Supervisor Tooling — named in the *Future Epics* paragraph with rationale, not instantiated as Epic stubs. Plan commits Shannon to **one Epic at a time**: EPIC-009 must reach APPROVED before EPIC-010 elaboration begins; EPIC-010 must reach APPROVED before EPIC-011 elaboration begins (with EPIC-011's hard dependency on EPIC-009 and softer dependency on EPIC-010 named). **Cascading Preparation performed** per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*: three child Epic stubs created in DRAFT (EPIC-009, EPIC-010, EPIC-011), each with a **prepared elaboration draft** (in Requirements) and **prepared plan draft** (in Plan) marked "*Prepared during FEAT-009 planning, not yet reviewed*". Three new entries added to `epic_index.md` (EPIC-009 / EPIC-010 / EPIC-011, all DRAFT). **Five Risks formalised** at Feature level: cost compounding; false positives; scheduler-choice deferral blocking autonomous cadence (carried forward from FEAT-009 elaboration G-2; resolution mandated as EPIC-011 AC#5); Managed Agents / Cloud Routines maturity revision; supervisor skill portability untested until first non-Shannon-self deployment. **Gate 2 alignment findings — 3 Gaps closed inline** during ratification: (G-A) Stop hook allocated to EPIC-011 with explicit AC#7 (completion-check semantics fit autonomous runs naturally); (G-B) EPIC-009 prepared elaboration amended to add AC#6 for the Supervisor Configuration file creation pattern (absent fields take supervisor-authority defaults; present fields override uniformly); (G-C) override mechanism confirmed as emergent from existing `/[type]-elaborate` / `/[type]-review` flows — noted in this Plan's § Approach. **Two framework-general ambiguities routed to `scratchpad.md` per `development_guide.md:114`**: (M-3) Cascading Preparation at Feature-plan stage vs Epic-plan stage — candidate new canonical workflow in `conceptual_design.md` § Key Workflows; (M-4) Forward-deferral pattern for Phase 5+ items named at Feature § Plan but not instantiated as Epic stubs — candidate `conceptual_design.md` § Domain Model extension. M-5 (Stop hook allocation) closed inline via G-A. **Flagged follow-up carried forward**: FEAT-006 (Multi-Party Supervision) re-elaboration to cite FEAT-009 as the concrete implementing Feature still pending; trigger remains FEAT-009 APPROVED (or earlier, once EPIC-009 lands the operational supervisor skill). Status: ELABORATED → PLANNED.
- **2026-05-29** — ELABORATED (Gate 1 approved). Requirements refined: Overview tightened to three orientation paragraphs; Ideal State finalised as ten bullets each citing the cascade-doc anchor it elaborates (covering cadence, three-checker fan-out, delegated gate authority within the configurable ceiling, five hook integration points, hybrid report presentation, agent-identity gate integrity, goal decomposition, cost envelope, honest deferral boundary, and portability); nine User Stories drafted across solo cadence-orientation, multi-agent gate absorption, agentic-directing-party scope reduction, between-session decision discovery, goal decomposition, project customisation of the Epic and Spike gate-authority ceilings, and three honest failure modes (zero findings, false positives, supervisor-decision override); Success Metrics split into three Measurable Targets (Phase 2 adoption, cadence run cost within the 6–7× spike-predicted band, supervisor-gate override rate) and four Directional Targets (drift detection compounds, directing-party surface reduction, supervisor trust sustained, goal decomposition usefulness); Context cross-references verified against cascade-landed doc versions. Three gaps closed inline during refinement: (G-1) Spike gate-authority configurability now named alongside Epic in the Ideal State + User Stories, (G-2) Shannon-self scheduler-choice cascade-deferral surfaced as a Risk to be formalised at Plan time, (G-3) `/shannon-goal` usefulness criterion added to Directional Targets. **Flagged follow-up**: FEAT-006 (Multi-Party Supervision) requires re-elaboration to cite FEAT-009 as the concrete implementing Feature for the supervisor role specifically, update its Context block to the cascade-landed doc versions, and annotate the previously-deferred *Gate Enforcement visibility UX* Ideal State bullet as now met by `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor-Approved Gate Notification* and the *Gate Approval* refresh. Sequenced after FEAT-009 ELABORATED so FEAT-006 has a stable cross-reference target; tracked as a downstream-gap re-elaboration trigger. Two framework-general ambiguities routed to `scratchpad.md` per `development_guide.md:114`: (M-1) canonical pattern for refreshing an older Feature's cross-references when a newer Feature is created that implements part of its scope — candidate `conceptual_design.md` § Re-elaborating a Work Item Triggers refinement; (M-2) zero-findings supervisor-report presentation pattern — candidate `ux_guide.md` § Interaction Patterns refinement, revisit at EPIC-009 elaboration. Status: DRAFT → ELABORATED.
- **2026-05-29** — DRAFT: Feature created via `/feature-create`. Top-level Feature (no parent Feature) per directing-party cascade decision. Vision Reference anchored to v2.4 § Core Principles #5 + § Key Features Supervisor Role + § Target Users Three roles + § Future Vision. Initial Implementation: **Built through Shannon** from a zero baseline — the supervisor does not yet exist as code, skill, or operational pattern in this repository. The vision-v2.4 documentation cascade (Pass 1 through Pass 4B; commits `d2fd797` through `0fe6e30`) ratified the supervisor's role and architecture across all six mandated documents; FEAT-009 is the implementing Feature that delivers it. Phase-0 spike (2026-05-27) named 5 Claude Code primitives Shannon commits to building on (Hooks, Subagents, Headless mode + external cron, Worktree isolation, Skill frontmatter control) and 4 deferrals (Cloud Routines, Managed Agents, MCP server exposure, statusline-as-full-report); spike phase structure inherited as natural Epic boundaries (Phase 2: Health Reporting Surface → EPIC-009 candidate; Phase 3: Synthesis & Reports → EPIC-010 candidate; Phase 4: Autonomic Invocation → EPIC-011 candidate; Phase 5+ deferred). Full Requirements elaboration pending `/feature-elaborate FEAT-009` (Gate 1); candidate Epics pending `/feature-plan FEAT-009` (Gate 2).
