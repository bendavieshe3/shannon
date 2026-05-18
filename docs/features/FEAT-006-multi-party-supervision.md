# FEAT-006: Multi-Party Supervision

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #2 ("Strategic External Review")
- **Initial Implementation**: Partial — see Activity Log
- **Created**: 2026-05-18
- **Updated**: 2026-05-18 (re-elaborated)

---

## Requirements

### Overview

Shannon supports multi-party supervision: the directing party (the entity that approves at gates and reviews documents) can be a human OR a supervising agent, provided that supervising agent is distinct from the implementer at any given gate. This opens multi-agent configurations — one AI directing, another AI implementing, with a human at the top of the chain — while preserving the integrity of the quality gates.

The capability is foundational to scaling Shannon beyond solo developers. The constraint is single-purpose: independence of judgement is what gates protect; collapsing supervisor and implementer collapses the gate.

### Ideal State

- The framework's vocabulary distinguishes "directing party" (the supervisor role) from "implementer" (the work-doing role) everywhere it matters *(partly met — document layer is V6-aligned; implementation layer pending)*
- The Supervisor Distinct From Implementer business rule is named in conceptual_design and referenced consistently *(met — conceptual_design v1.1; referenced from technical_design and development_guide)*
- Skills and commands refuse self-approval flows (an implementer subagent does not call its own `*-review` command) *(partly met — convention documented; implementation in skills/commands pending)*
- Technical_design § Gate Enforcement honestly documents that enforcement is by convention, not technical control, with a path to future agent-identity checks *(met — technical_design v1.1)*
- UX patterns surface the role distinction at gate moments when meaningful — *Gate Enforcement visibility UX* is currently deferred as too speculative until multi-agent configurations are exercised (scratchpad item)
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

- **Vision (v2.2+)**: Core Principle 2 ("Strategic External Review"), Vision Statement (directing party = human or supervising agent, "from adoption through full maturity"), § Target Users — "The directing role is separable" and "Retrospective adoption"
- **Conceptual Design (v1.3+)**: *Directing Party*, *Implementer* glossary entries; *Supervisor Distinct From Implementer* business rule; updated *Three Hard Gates* and *Iterative Implementation Zone* rules; all Key Workflows use directing-party / implementer vocabulary (currently five workflows including *Re-reviewing an APPROVED Mandated Document*)
- **Technology Stack**: § Security Considerations — points to *Cooperative Access assumption* (canonical home is now conceptual_design + technical_design)
- **Technical Design**: § Cooperative Access, § Gate Enforcement
- **Development Guide**: § Multi-Agent Coordination
- **UX Guide**: § Cooperative Access Collision pattern, § Presenting Findings (Gate Enforcement visibility deferred to scratchpad)

---

## Plan

### Epics

The candidate next-Epic surface splits cleanly into two work units with different review profiles. Recommend creating them as separate Epics rather than one bundled effort.

- **Candidate Epic A (not yet created): V6 vocabulary in skills + CLAUDE.md template** — Three skill definitions (`shannon/skills/*/skill.md`) and the project-level CLAUDE.md template (`shannon/skills/project-setup/templates/CLAUDE.md`) need semantic updates. Each touches gate language, self-approval prevention, and the directing-party / implementer distinction; not pure find-and-replace. Requires per-file review judgement.
  - **Success criterion**: `rg "\buser\b" shannon/skills/ shannon/skills/project-setup/templates/CLAUDE.md` returns only intentional "human reader" occurrences; every gate-related sentence uses directing-party / implementer vocabulary correctly.
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

- **Vocabulary consistency** — "User" appears in framework prose only where it means "human terminal reader"; "directing party" / "implementer" used otherwise (currently incomplete — see remaining V6 propagation Epic)
- **Self-approval prevention** — Zero observed cases of an implementer approving its own work across a gate
- **Multi-agent project shipped** — At least one Shannon project successfully operated by a supervisor + implementer pair distinct from the human at the top

---

## Activity Log

- **2026-05-18** — Re-elaborated. Triggered by upstream evolution since initial elaboration (Vision v2.2 added retrospective adoption acknowledgement; conceptual_design v1.3 added the *Re-reviewing an APPROVED Mandated Document* workflow). Changes applied:
  - Context updated to reflect Vision v2.2 and conceptual_design v1.3 (five Key Workflows; ux_guide § Presenting Findings added)
  - Ideal State bullets now annotate which items are met vs partly met vs pending
  - "(deferred — see scratchpad)" parenthetical replaced with explicit naming of the Gate Enforcement visibility deferral
  - New user story: Retrospective Adoption into Existing Multi-Agent Projects, covering Vision v2.2 § Target Users widened scope
  - New Ideal State bullet: retrospective adoption support
  - Candidate next Epic split into two — Epic A (V6 vocabulary in skills + CLAUDE.md template, semantic) and Epic B (V6 vocabulary in command files, mechanical), each with explicit `rg`-based success criteria
  This is the first exercise of work-item re-elaboration; two framework gaps surfaced for follow-up (see scratchpad: F1 work-item re-elaboration workflow, F2 Initial Implementation lifecycle position).
- **2026-05-18** — ELABORATED: Feature created. Partially implemented: the document layer (vision, technology_stack, conceptual_design, technical_design, development_guide, ux_guide) is V6-aligned through commits `6abf672` (vision Gate 1), `f6cddc4` (conceptual_design), `35ccfee` (technology_stack), `1943f3f` (technical_design), `4f3e506` (development_guide), `d4ccc03` (ux_guide). The implementation layer — skill definitions, command files, CLAUDE.md template — still needs the V6 vocabulary sweep. A dedicated Epic for that work is the next step.
