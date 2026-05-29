# FEAT-009: Supervisor

## Metadata

- **Status**: DRAFT
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #5 *Continuous Health Vigilance* (primary); § Key Features *Supervisor Role* (substantive commitment); § Target Users *Three roles, configurably separable* (role model); § Future Vision *supervisor portability* (forward generalisation)
- **Initial Implementation**: Built through Shannon — no retrospective component. The supervisor role does not yet exist in this codebase; FEAT-009 captures it as forward work to be delivered through its constituent Epics.
- **Created**: 2026-05-29
- **Updated**: 2026-05-29

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no epic in progress) or `ACTIVE` (an epic is being worked on). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work through new Epics.

---

## Requirements

*Initial intent captured at `/feature-create` (2026-05-29). Full Requirements drafted at `/feature-elaborate FEAT-009`.*

### Overview

FEAT-009 captures the **supervisor role** as a persistent capability of Shannon: a continuous-vigilance role distinct from the implementer and (optionally) distinct from the directing party, exercising delegated gate authority for routine work and producing dated audit reports on a project-configured cadence. The supervisor's existence is what makes Vision § Core Principles #5 (*Continuous Health Vigilance*) operational rather than aspirational — without an actor performing the vigilance on a cadence, the principle is unbacked.

The Feature is **forward work** from a zero baseline: the supervisor does not yet exist as code, skill, or operational pattern in this repository. The cascade that landed Vision v2.4 → conceptual_design v1.7 → technology_stack v1.3 → technical_design v1.2 → development_guide v1.4 → ux_guide v1.2 ratified the supervisor's role and architecture at framework level; FEAT-009 is the implementing Feature that delivers it.

The Phase-0 spike report (`~/Documents/Vaults/general-vault/Areas/Situations/SIT-026-Shannon-Development-Framework/spike-claude-code-features-2026-05-27.md`) surveyed Claude Code primitives and produced the 5-commit / 4-defer architecture that technology_stack v1.3 § Supervisor Tooling and technical_design v1.2 § System Architecture → *Supervisor* + § Cadence now codify. The Feature inherits the spike's phase structure as the natural Epic boundary.

### Ideal State

*[Filled during elaboration. Draft outline:]*

- The supervisor runs on a project-configured cadence (interactive via `/shannon-report`; autonomously via headless mode + external scheduler), producing a dated report at `docs/supervisor/report-YYYY-MM-DD.md` per cadence run
- The supervisor exercises delegated gate authority per `conceptual_design.md` § Business Rules → *Gate Authority Split*: Task gates always; Epic + Spike gates by default (reservable per project); never Vision or Features
- The supervisor's three checker subagents (Alignment / Lifecycle / Drift) fan out in parallel and aggregate into a single hybrid-presentation report (diagnostic header + 1–2 finding narrative body) per `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*
- Five Claude Code hook integration points (SessionStart, PreToolUse, PostToolUse, preCompact, Stop) weave vigilance into the interactive session lifecycle
- The supervisor honours the agent-identity gate-integrity constraint absolutely (approver ≠ implementer), the configurable-ceiling default, and the abstract-cron pattern
- The supervisor's `/shannon-goal` command decomposes a directing-party intent into candidate work items, citing existing artefacts where alignment exists and surfacing gaps where it doesn't
- The supervisor pattern is portable to non-Shannon-self projects without modification (per Vision § Future Vision)

### User Stories

*[Filled during elaboration. Anticipated themes: solo developer with cadence-driven health summary; multi-agent configuration with delegated routine gates; agentic directing-party reducing surface area on routine decisions.]*

### Context

- **Vision**: § Core Principles #5 *Continuous Health Vigilance* (primary anchor); § Key Features *Supervisor Role*; § Target Users *Three roles, configurably separable*; § Future Vision (portability commitment)
- **Conceptual Design** (v1.7): § Glossary → *Supervisor*; § Business Rules → *Gate Authority Split*, *Supervisor Distinct From Implementer*, *Three Hard Gates* (refreshed); § Domain Model → *Knowledge Note* Type extension for *Supervisor Report*
- **Technology Stack** (v1.3): § Supervisor Tooling (the 5 committed primitives + 4 deferrals; abstract cron mechanism; `./.claude/` configuration storage)
- **Technical Design** (v1.2): § System Architecture → *Supervisor*; § Cadence (headless contract + worktree pattern); § Data Model → *Supervisor Report Files* + *Supervisor Configuration* + *Cadence State*; § API Design → *Supervisor Verbs*; § Security Model → *Gate Enforcement* (refreshed)
- **Development Guide** (v1.4): § Commit Cadence → *Supervisor cadence runs*; § Push Cadence (third trigger); § Multi-Agent Coordination (refreshed); § Supervisor Report Files (dogfood)
- **UX Guide** (v1.2): § Command Surface → *Supervisor Commands*; § Interaction Patterns → *Supervisor Report Presentation*, *Supervisor-Approved Gate Notification*, *Gate Approval* (refreshed for both authorities), *Cooperative Access Collision* (refreshed)
- **Phase-0 Spike**: `~/Documents/Vaults/general-vault/Areas/Situations/SIT-026-Shannon-Development-Framework/spike-claude-code-features-2026-05-27.md` — primary architectural input
- **Related Features**: [FEAT-006 — Multi-Party Supervision](FEAT-006-multi-party-supervision.md) names the multi-party pattern at vision level (Partial); FEAT-009 is the *concrete implementing* Feature for the supervisor role specifically. The two coexist by scope: FEAT-006 is the multi-party-supervision pattern; FEAT-009 is the supervisor role's existence and operation. FEAT-006 may be re-elaborated downstream to cross-reference FEAT-009 as the implementing surface.

---

## Plan

*To be filled at `/feature-plan FEAT-009` (Gate 2). Candidate Epics inherit the Phase-0 spike's phase structure as natural Epic boundaries:*

### Epics

*Candidates pending elaboration + planning. Each Epic to be created and elaborated individually per the canonical workflow.*

- **EPIC-009 — Phase 2: Health Reporting Surface** *(candidate)* — Delivers the `/shannon-report` skill at `.claude/skills/shannon-supervisor/`; three checker subagents (Alignment / Lifecycle / Drift) with model selection per `technical_design.md` § System Architecture → *Supervisor*; report writing to `docs/supervisor/report-YYYY-MM-DD.md` per the Knowledge Note subtype convention; PreToolUse hook for write-guard; PostToolUse hook for audit logging. First operational supervisor.
- **EPIC-010 — Phase 3: Synthesis & Reports** *(candidate)* — Delivers `/shannon-goal [intent]` for decomposing directing-party intents into candidate work items; aggregation patterns + the hybrid presentation default per `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*; SessionStart hook for health summary injection; preCompact hook for in-flight findings snapshot.
- **EPIC-011 — Phase 4: Autonomic Invocation** *(candidate)* — Delivers the headless invocation path (`claude --bare -p ... --allowedTools ... --output-format json`); worktree-isolation pattern for read-only audits; supervisor-batch commit cadence + third-trigger push at end of autonomous run per `development_guide.md` § Commit Cadence + § Push Cadence; specific scheduler choice for the Shannon-self project (deferred from `development_guide.md` v1.4 to this Epic per the cascade plan).
- **Phase 5+ deferred** *(forward work beyond this Feature's current scope)* — Cross-project supervisor (single supervisor servicing multiple Shannon projects); Managed Agents integration; MCP server exposure of Shannon project state for cross-agent queries. Revisit once Phase 2–4 has produced real-world cadence evidence.

### Dependencies

**Depends on**:

- Vision v2.4 (APPROVED 2026-05-28, commit `d2fd797`) — the supervisor's existence is ratified here
- conceptual_design v1.7 (APPROVED 2026-05-29, commit `a8fe1e0`) — role model, *Gate Authority Split* Business Rule, Knowledge Note Supervisor Report subtype
- technology_stack v1.3 (APPROVED 2026-05-29, commit `c7d66e4`) — 5 committed Claude Code primitives + 4 deferrals; abstract cron pattern
- technical_design v1.2 (APPROVED 2026-05-29, commit `71b7ac5`) — supervisor architecture, cadence contract, data model
- development_guide v1.4 (APPROVED 2026-05-29, commit `a6cad77`) — supervisor cadence commit/push conventions
- ux_guide v1.2 (APPROVED 2026-05-29, commit `0fe6e30`) — supervisor command + interaction-pattern surface
- Phase-0 spike report (2026-05-27) — primary architectural input
- [FEAT-006 — Multi-Party Supervision](FEAT-006-multi-party-supervision.md) — the multi-party pattern this Feature concretely implements for the supervisor role; FEAT-006 may need re-elaboration to cite FEAT-009 as the implementing surface

**Depended on by**: Future development-discipline learnings surfaced through supervisor use; future framework-wide observability and dashboarding capabilities (deferred speculation, not committed)

### Risks

*[Filled during planning. Anticipated risks: subagent token cost compounding under frequent cadence; supervisor false positives eroding directing-party trust; scheduler choice lock-in for the Shannon-self project; Managed Agents / Cloud Routines maturing differently than the spike predicted, requiring path revision.]*

---

## Success Metrics

*To be filled at `/feature-elaborate FEAT-009` (Gate 1) and refined at `/feature-plan FEAT-009` (Gate 2). Anticipated metrics — split honestly between measurable and directional per Vision § Success Metrics precedent:*

**Measurable Targets** *(candidates):*

- **Supervisor adoption** — Once Phase 2 ships, the Shannon-self project runs `/shannon-report` at a documented cadence (interactive or autonomous); measured by report-file presence in `docs/supervisor/`
- **Cadence run cost** — Per-run aggregate token cost stays within the spike's predicted 6–7× single-session band; measured by `/usage` output across cadence runs

**Directional Targets** *(candidates):*

- **Drift detection compounds** — Once the supervisor is running, drift between mandated documents and implementation is caught at the supervisor's cadence rather than at the next manual `/document-review`. Measured by judgement: "did the supervisor catch this before the directing party did?"
- **Directing-party surface reduction** — Routine Task gates are absorbed by the supervisor; the directing party's gate-engagement time shifts from per-Task to per-Feature/Vision. Measured by judgement: "is the directing party still approving Task-level gates manually?"

---

## Activity Log

- **2026-05-29** — DRAFT: Feature created via `/feature-create`. Top-level Feature (no parent Feature) per directing-party cascade decision. Vision Reference anchored to v2.4 § Core Principles #5 + § Key Features Supervisor Role + § Target Users Three roles + § Future Vision. Initial Implementation: **Built through Shannon** from a zero baseline — the supervisor does not yet exist as code, skill, or operational pattern in this repository. The vision-v2.4 documentation cascade (Pass 1 through Pass 4B; commits `d2fd797` through `0fe6e30`) ratified the supervisor's role and architecture across all six mandated documents; FEAT-009 is the implementing Feature that delivers it. Phase-0 spike (2026-05-27) named 5 Claude Code primitives Shannon commits to building on (Hooks, Subagents, Headless mode + external cron, Worktree isolation, Skill frontmatter control) and 4 deferrals (Cloud Routines, Managed Agents, MCP server exposure, statusline-as-full-report); spike phase structure inherited as natural Epic boundaries (Phase 2: Health Reporting Surface → EPIC-009 candidate; Phase 3: Synthesis & Reports → EPIC-010 candidate; Phase 4: Autonomic Invocation → EPIC-011 candidate; Phase 5+ deferred). Full Requirements elaboration pending `/feature-elaborate FEAT-009` (Gate 1); candidate Epics pending `/feature-plan FEAT-009` (Gate 2).
