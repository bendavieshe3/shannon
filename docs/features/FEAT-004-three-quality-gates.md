# FEAT-004: Three Quality Gates

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Three Quality Gates" + Principle 2 ("Strategic External Review")
- **Initial Implementation**: Retrospective (predates this Feature's creation)
- **Created**: 2026-05-18
- **Updated**: 2026-05-18

---

## Requirements

### Overview

Shannon enforces three explicit human-or-supervising-agent approval points across the work item lifecycle: requirements elaboration (Gate 1), implementation planning (Gate 2), and completion review (Gate 3). The gates are not advisory checkpoints — they are mandatory transitions that the framework refuses to cross without explicit approval from the directing party. Between IMPLEMENTING, IMPLEMENTED, and REVIEW, the implementer and directing party iterate freely with no gate.

This capability is what makes "AI does the work, human (or supervising agent) directs" practical: review attention concentrates where judgement compounds, not on every line of code.

### Ideal State

- Three gates — G1 (DRAFT → ELABORATED), G2 (ELABORATED → PLANNED), G3 (REVIEW → APPROVED) — apply to every work item type
- A fourth gate exists implicitly for mandated documents: G1 (DRAFT → APPROVED) on documents themselves
- Gates require explicit approval; AI cannot self-approve across a gate
- The implementer at a gate cannot be the same agent as the directing party (Supervisor Distinct From Implementer rule)
- Skills present the proposed transition with full context and wait for response — silent transitions are a defect
- Cascading operations (e.g. `/epic-plan` creating child task drafts) still produce one gate per child — bulk preparation, individual gates
- UX patterns (Gate Approval, Presenting Findings, DRAFT Context Caveat) make gate moments unmistakable

### User Stories

#### Strategic Review

**As a** directing party,
**I want** approval moments at requirements, plan, and completion,
**So that** I exercise judgement at high-leverage points without reviewing every line.

#### Confidence in Implementation

**As a** directing party,
**I want** my implementer to be unable to self-approve,
**So that** independence of judgement is preserved structurally, not just by goodwill.

#### Batch Without Losing Granularity

**As a** directing party who runs `/epic-plan` and gets 4 child tasks,
**I want** each child to require its own gate when I'm ready to review it,
**So that** bulk preparation doesn't override per-task judgement.

### Context

- **Vision**: § Core Principles #2 ("Strategic External Review"), § Key Features ("Three Quality Gates")
- **Conceptual Design**: *Three Hard Gates*, *Supervisor Distinct From Implementer*, *Iterative Implementation Zone* business rules; gate references throughout all three Key Workflows
- **Technical Design**: § Cascading Operations (the option-b pattern preserving gate granularity), § Gate Enforcement (by convention, not technical control)
- **UX Guide**: § Gate Approval, § Cascading Operations, § Presenting Findings, § DRAFT Context Caveat
- **Project files**: Gate logic embedded in `shannon/skills/work-items/skill.md` and `shannon/skills/project-documentation/skill.md`

---

## Plan

### Epics

*None yet. Candidate future Epic: technical gate enforcement (agent identity check at gate transitions rather than relying on convention) — speculative until multi-agent configurations are exercised.*

### Dependencies

**Depends on**: FEAT-003 (Unified Work Item Model) — gates are lifecycle transitions; FEAT-006 (Multi-Party Supervision) — the supervisor ≠ implementer constraint lives in V6

**Depended on by**: All forward-development features rely on the gates being trustworthy

### Risks

- **Gate fatigue** — Three gates per work item, multiplied across types, may feel heavy for tiny pieces of work. Mitigation: orphan tasks for trivial fixes; spikes for time-boxed exploration; future scratchpad-promotion patterns
- **Convention-only enforcement** — Supervisor ≠ implementer is currently enforced by skill protocol, not by technical check. Honest about this limitation in technical_design § Gate Enforcement

---

## Success Metrics

- **Approval explicitness** — 100% of gate transitions require explicit "approve" / equivalent from the directing party; zero silent transitions
- **Planning approval rate** — AI-drafted plans approved at G2 without revision: 80%+ (per Vision Measurable Targets)
- **Review cycle count** — Average iterations through IMPLEMENTING ↔ REVIEW before G3 approval; lower is better, but not below "1" (some iteration is healthy)

---

## Activity Log

- **2026-05-18** — ELABORATED: Feature created retrospectively. Gate logic, business rules, workflows, and UX patterns were established during the Shannon v4 refactor and subsequent document reviews (commits `6852b29` through `d4ccc03`). This Feature codifies the capability.
