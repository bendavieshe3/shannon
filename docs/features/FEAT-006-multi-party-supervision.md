# FEAT-006: Multi-Party Supervision

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #2 ("Strategic External Review")
- **Initial Implementation**: Partial — see Activity Log
  - **Met:** Document-layer V6 alignment — the six mandated documents use directing-party / implementer vocabulary; the *Supervisor Distinct From Implementer* business rule is named; cooperative-access conventions are documented. **Plus (EPIC-005 APPROVED):** the implementation-layer vocabulary sweep of the 3 skill definitions + the CLAUDE.md template, including the self-approval-refusal language in those skills.
  - **Remaining:** The V6 vocabulary sweep of the 22 command files (candidate Epic B) and the self-approval-refusal wording in them; a multi-agent configuration — a supervisor + implementer pair distinct from the human — exercised in practice. *(FEAT-009's supervisor — EPIC-009 APPROVED 2026-07-11 — delivers the supervising-agent role's existence and operation, but has not yet been exercised as a directing party over a separate implementer, so this last item stays open.)*
- **Created**: 2026-05-18
- **Updated**: 2026-07-11 (re-elaborated)

---

## Requirements

### Overview

Shannon supports multi-party supervision: the directing party (the entity that approves at gates and reviews documents) can be a human OR a supervising agent, provided that supervising agent is distinct from the implementer at any given gate. This opens multi-agent configurations — one AI directing, another AI implementing, with a human at the top of the chain — while preserving the integrity of the quality gates.

The capability is foundational to scaling Shannon beyond solo developers. The constraint is single-purpose: independence of judgement is what gates protect; collapsing supervisor and implementer collapses the gate.

### Ideal State

- The framework's vocabulary distinguishes "directing party" (the supervisor role) from "implementer" (the work-doing role) everywhere it matters *(partly met — document layer V6-aligned; the skills + CLAUDE.md template V6-aligned via EPIC-005 (APPROVED); the 22 command files remain — candidate Epic B)*
- The Supervisor Distinct From Implementer business rule is named in conceptual_design and referenced consistently *(met — conceptual_design v1.7; referenced from technical_design and development_guide)*
- Skills and commands refuse self-approval flows (an implementer subagent does not call its own `*-review` command) *(partly met — convention documented; self-approval-refusal language landed in the skills via EPIC-005; the command files remain)*
- Technical_design § Gate Enforcement honestly documents that enforcement is by convention, not technical control, with a path to future agent-identity checks *(met — technical_design v1.2)*
- UX patterns surface the role distinction at gate moments when meaningful *(now met — ux_guide v1.2 § Interaction Patterns → *Supervisor-Approved Gate Notification* + the *Gate Approval* refresh ship the pattern previously deferred as too speculative)*
- Multi-agent configurations work in practice — supervisor and implementer coordinate via cooperative access (no file locking; conflicts surface as diffs)
- Cooperative access conventions are documented and the development_guide spells out the practice *(met — development_guide v1.2 § Multi-Agent Coordination)*
- Shannon can be adopted retrospectively into projects that already operate with multi-agent configurations — the framework captures their existing supervisor/implementer arrangements without special-casing

### User Stories

#### Multi-Agent Project Operation

**As a** human at the top of a chain,
**I want** to have one AI direct while another AI implements,
**So that** I can scale beyond what a single human-directing-one-AI workflow allows.

#### Trust in the Gate

**As a** directing party (human or supervising agent),
**I want** the framework to refuse implementer self-approval structurally,
**So that** the gate means what it claims.

#### Coordinating Concurrent Edits

**As a** directing party in a multi-agent setup,
**I want** concurrent edits to surface as diffs rather than overwriting silently,
**So that** I retain control over collisions.

#### Retrospective Adoption into Existing Multi-Agent Projects

**As a** human at the top of a project that already operates with multiple AI agents,
**I want** to adopt Shannon without restructuring the existing agent arrangement,
**So that** I can bring the framework's gates and documentation discipline to a team that's already in motion.

### Context

- **Vision (v2.4)**: Core Principle 2 ("Strategic External Review"), Vision Statement (directing party = human or supervising agent, "from adoption through full maturity"), § Target Users — "The directing role is separable" and "Retrospective adoption"
- **Conceptual Design (v1.7)**: *Directing Party*, *Implementer* glossary entries; *Supervisor Distinct From Implementer* business rule; *Three Hard Gates* and *Iterative Implementation Zone* rules; Key Workflows use directing-party / implementer vocabulary
- **Technology Stack (v1.3)**: § Security Considerations — points to *Cooperative Access assumption* (canonical home is conceptual_design + technical_design)
- **Technical Design (v1.2)**: § Cooperative Access, § Gate Enforcement
- **Development Guide (v1.4)**: § Multi-Agent Coordination
- **UX Guide (v1.2)**: § Cooperative Access Collision pattern; § Interaction Patterns → *Supervisor-Approved Gate Notification* (the Gate Enforcement visibility pattern — previously deferred, now shipped)
- **Related Feature — [FEAT-009](FEAT-009-supervisor.md)**: the concrete implementing Feature for the supervisor role. FEAT-006 defines the *multi-party pattern* (the directing party may be a supervising agent distinct from the implementer); FEAT-009 delivers the *supervisor's existence and operation* (the `/shannon-report` supervisor skill; EPIC-009 APPROVED 2026-07-11). The scope split: FEAT-006 owns the role-independence constraint and its cross-cutting vocabulary/self-approval discipline; FEAT-009 owns the operational supervisor. FEAT-006's "multi-agent configuration exercised in practice" remains the open validation — EPIC-009 shipped a single-agent reporting surface, not yet a supervisor directing over a separate implementer.

---

## Plan

### Epics

The candidate next-Epic surface splits cleanly into two work units with different review profiles. Recommend creating them as separate Epics rather than one bundled effort.

- [EPIC-005](../epics/EPIC-005-v6-skills-and-claude-template.md) — APPROVED — V6 Vocabulary in Skills and CLAUDE.md Template — Three skill definitions (`shannon/skills/*/skill.md`) and the project-level CLAUDE.md template need semantic updates. Each touches gate language, self-approval prevention, and the directing-party / implementer distinction; not pure find-and-replace. Requires per-file review judgement. Elaboration also folded in a correction: `work-items/skill.md` still has `PLAN-PENDING` references that contradict technical_design v1.1, now part of EPIC-005's scope.
  - **Success criterion**: `rg "\b[Uu]sers?\b" shannon/skills/ shannon/skills/project-setup/templates/CLAUDE.md` returns only intentional "human reader" or "Target Users" occurrences; every gate-related sentence uses directing-party / implementer vocabulary correctly; no `*-PENDING` references remain.
- **Candidate Epic B (not yet created): V6 vocabulary in command files** — 22 command files (`shannon/commands/*.md`) need vocabulary updates. Mostly mechanical (`/[type]-[verb]` commands have nearly identical structure) and batchable. Lower per-file judgement; easy to verify in aggregate.
  - **Success criterion**: `rg "\buser\b" shannon/commands/` returns only intentional "human reader" occurrences; every command's wording about gate approval names the directing party explicitly.

Promote each candidate to a real Epic via `/epic-create` when ready to schedule the work.

### Dependencies

**Depends on**: FEAT-003 (Unified Work Item Model), FEAT-004 (Three Quality Gates) — gates are where supervision happens

**Depended on by**: Future enterprise / multi-developer adoption of Shannon

### Risks

- **Convention-only enforcement** — Until technical gate enforcement exists, an implementer that ignores the skill protocol could self-approve. Acceptable today (a deliberate AI doing this is a different threat model); revisit when multi-agent configurations are actually exercised
- **Vocabulary creep back** — "User" is the natural default in CLI prose; without ongoing discipline, future contributions may reintroduce it where "directing party" is correct. Mitigation: the dev_guide and ux_guide patterns make the distinction visible
- **No real-world validation yet** — Multi-agent configurations have not been exercised against Shannon. The convention may break in ways not anticipated; expect refinement when the first multi-agent project ships

---

## Success Metrics

- **Vocabulary consistency** — "User" appears in framework prose only where it means "human terminal reader"; "directing party" / "implementer" used otherwise (skills + CLAUDE.md template complete via EPIC-005 APPROVED; the 22 command files remain — candidate Epic B)
- **Self-approval prevention** — Zero observed cases of an implementer approving its own work across a gate
- **Multi-agent project shipped** — At least one Shannon project successfully operated by a supervisor + implementer pair distinct from the human at the top

---

## Activity Log

- **2026-07-11** — Re-elaborated (additive). **Trigger**: downstream-gap — a sibling Feature, **FEAT-009 (Supervisor)**, now exists as the concrete implementing Feature for the supervisor role, and its first Epic **EPIC-009 (Health Reporting Surface) reached APPROVED** (commit `cc78667`); FEAT-009's own Activity Log flagged this FEAT-006 re-elaboration as owed. (The trigger fits the *downstream-gap*-adjacent "sibling Feature implements part of my scope" case that scratchpad M-1 notes is not yet a perfectly-fitting canonical trigger category — a pending `conceptual_design.md` § Re-elaborating refinement.) **Change** — four additive refreshes, no previously-approved requirement or scope claim contradicted (verified by an independent alignment subagent, four-category findings): (1) **added a Related-Feature cross-reference to FEAT-009** in § Context with the scope split (FEAT-006 = the multi-party pattern + role-independence constraint; FEAT-009 = the operational supervisor); (2) **refreshed all § Context and Ideal-State doc-version citations to current** (Vision v2.4, conceptual_design v1.7, technical_design v1.2, technology_stack v1.3, development_guide v1.4, ux_guide v1.2); (3) **moved the EPIC-005-delivered work from *Remaining* to *Met*** in the Initial Implementation block and narrowed the two "partly met" Ideal-State annotations accordingly (skills + CLAUDE.md template V6-aligned; only the 22 command files / candidate Epic B remain) — resolving the Metadata-vs-Plan internal contradiction the alignment check found; (4) **re-annotated the *Gate Enforcement visibility UX* Ideal-State bullet from deferred → met**, now shipped by ux_guide v1.2 § Interaction Patterns → *Supervisor-Approved Gate Notification* + the *Gate Approval* refresh. **Deliberately NOT changed**: the *Multi-agent project shipped* Success Metric stays **pending** — EPIC-009 shipped a *single-agent* supervisor reporting surface, not a supervisor directing over a separate implementer, so the multi-party configuration remains unexercised; the core Overview intent and the Risks are preserved verbatim. No previously-approved claim contradicted — additive; status stays ELABORATED.
- **2026-05-22** — Re-elaborated (additive). **Trigger**: framework evolution — EPIC-006 (via TASK-002, commit `09844df`) delivered the queryable Partial-completeness affordance that pre-existing Partial Features must absorb. **Change**: added the `**Met:** / **Remaining:**` sub-block beneath the `Initial Implementation` line, surfacing the Partial state at a glance without an Activity Log dive; applied via TASK-003. No previously-approved claim contradicted — additive; status stays ELABORATED.
- **2026-05-18** — Re-elaborated. Triggered by upstream evolution since initial elaboration (Vision v2.2 added retrospective adoption acknowledgement; conceptual_design v1.3 added the *Re-reviewing an APPROVED Mandated Document* workflow). Changes applied:
  - Context updated to reflect Vision v2.2 and conceptual_design v1.3 (five Key Workflows; ux_guide § Presenting Findings added)
  - Ideal State bullets now annotate which items are met vs partly met vs pending
  - "(deferred — see scratchpad)" parenthetical replaced with explicit naming of the Gate Enforcement visibility deferral
  - New user story: Retrospective Adoption into Existing Multi-Agent Projects, covering Vision v2.2 § Target Users widened scope
  - New Ideal State bullet: retrospective adoption support
  - Candidate next Epic split into two — Epic A (V6 vocabulary in skills + CLAUDE.md template, semantic) and Epic B (V6 vocabulary in command files, mechanical), each with explicit `rg`-based success criteria
  This is the first exercise of work-item re-elaboration; two framework gaps surfaced for follow-up (see scratchpad: F1 work-item re-elaboration workflow, F2 Initial Implementation lifecycle position).
- **2026-05-18** — ELABORATED: Feature created. Partially implemented: the document layer (vision, technology_stack, conceptual_design, technical_design, development_guide, ux_guide) is V6-aligned through commits `6abf672` (vision Gate 1), `f6cddc4` (conceptual_design), `35ccfee` (technology_stack), `1943f3f` (technical_design), `4f3e506` (development_guide), `d4ccc03` (ux_guide). The implementation layer — skill definitions, command files, CLAUDE.md template — still needs the V6 vocabulary sweep. A dedicated Epic for that work is the next step.
