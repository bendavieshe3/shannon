# FEAT-006: Multi-Party Supervision

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #2 ("Strategic External Review")
- **Initial Implementation**: Partial — see Activity Log
- **Created**: 2026-05-18
- **Updated**: 2026-05-18

---

## Requirements

### Overview

Shannon supports multi-party supervision: the directing party (the entity that approves at gates and reviews documents) can be a human OR a supervising agent, provided that supervising agent is distinct from the implementer at any given gate. This opens multi-agent configurations — one AI directing, another AI implementing, with a human at the top of the chain — while preserving the integrity of the quality gates.

The capability is foundational to scaling Shannon beyond solo developers. The constraint is single-purpose: independence of judgement is what gates protect; collapsing supervisor and implementer collapses the gate.

### Ideal State

- The framework's vocabulary distinguishes "directing party" (the supervisor role) from "implementer" (the work-doing role) everywhere it matters
- The Supervisor Distinct From Implementer business rule is named in conceptual_design and referenced consistently
- Skills and commands refuse self-approval flows (an implementer subagent does not call its own `*-review` command)
- Technical_design § Gate Enforcement honestly documents that enforcement is by convention, not technical control, with a path to future agent-identity checks
- UX patterns surface the role distinction at gate moments when meaningful (deferred — see scratchpad)
- Multi-agent configurations work in practice — supervisor and implementer coordinate via cooperative access (no file locking; conflicts surface as diffs)
- Cooperative access conventions are documented and the development_guide spells out the practice

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

### Context

- **Vision**: Core Principle 2 ("Strategic External Review"), Vision Statement (directing party = human or supervising agent), § Target Users — "The directing role is separable"
- **Conceptual Design**: *Directing Party*, *Implementer* glossary entries; *Supervisor Distinct From Implementer* business rule; updated *Three Hard Gates* and *Iterative Implementation Zone* rules; all three Key Workflows use directing-party / implementer vocabulary
- **Technology Stack**: § Security Considerations — Cooperative Access assumption
- **Technical Design**: § Cooperative Access, § Gate Enforcement
- **Development Guide**: § Multi-Agent Coordination
- **UX Guide**: § Cooperative Access Collision pattern (Gate Enforcement visibility deferred)

---

## Plan

### Epics

- **Next Epic (not yet created): V6 propagation to implementation layer** — Vision, conceptual_design, technical_design, development_guide, and ux_guide are V6-aligned. The remaining surface needs vocabulary updates: 3 skill definitions (`shannon/skills/*/skill.md`), the CLAUDE.md template (`shannon/skills/project-setup/templates/CLAUDE.md`), and 22 command files (`shannon/commands/*.md`). Mostly mechanical edits since the architectural decisions are fixed at the doc layer.

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

- **2026-05-18** — ELABORATED: Feature created. Partially implemented: the document layer (vision, technology_stack, conceptual_design, technical_design, development_guide, ux_guide) is V6-aligned through commits `6abf672` (vision Gate 1), `f6cddc4` (conceptual_design), `35ccfee` (technology_stack), `1943f3f` (technical_design), `4f3e506` (development_guide), `d4ccc03` (ux_guide). The implementation layer — skill definitions, command files, CLAUDE.md template — still needs the V6 vocabulary sweep. A dedicated Epic for that work is the next step.
