# FEAT-004: Three Quality Gates

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Three Feature Gates" + Principle 2 ("Strategic External Review")
- **Initial Implementation**: Retrospective (predates this Feature's creation)
- **Created**: 2026-05-18
- **Updated**: 2026-11-01

---

## Requirements

### Overview

The human approves Feature requirements and observable acceptance criteria (Gate 1), approach and consequential trade-offs (Gate 2), and delivered capability against evidence (Gate 3). Agents execute below those boundaries without mandatory Epic/Task/Spike gates. Vision and consequential changes to approved document meaning remain human-owned.

### Ideal State

- Feature lifecycle transitions remain explicit and record actual human decisions. Reuse exact approval already supplied; silence is never approval.
- Agents choose and revise decomposition, implementation and tests within approved scope. No child record is required.
- Independent technical review comes from a reviewer who did not implement the work. It is distinct from self-tests, merge and human acceptance.
- Factual documentation and bookkeeping remain agent work; material divergence returns to the relevant human decision before affected work.
- Evidence includes checks/results, review identity/verdict, unresolved issues and enough context to resume. Legacy lower-level gates remain history, not new obligations.

### User Stories

As the directing party, I exercise product judgement at Feature boundaries without reviewing every internal action. I can distinguish a tested change, an independent technical approval and my acceptance of delivered behaviour.

### Context

`vision.md` § Strategic External Review; `conceptual_design.md` § Three Hard Gates and Gate Authority Split; `technical_design.md` § Gate Enforcement; `ux_guide.md` § Gate Approval; the work-items skill and Feature commands.

## Plan

### Epics

*None yet. Candidate future Epic: technical gate enforcement (agent identity check at gate transitions rather than relying on convention) — speculative until multi-agent configurations are exercised.*

### Dependencies

**Depends on**: FEAT-003 (Unified Work Item Model) — gates are lifecycle transitions; FEAT-006 (Multi-Party Supervision) — the supervisor ≠ implementer constraint lives in V6

**Depended on by**: All forward-development features rely on the gates being trustworthy

### Risks

- **Approval fatigue:** avoid mandatory child gates and reuse exact decisions already made.
- **Convention-only enforcement:** Markdown instructions are not technical access controls; repository and tool permissions remain in force.
- **False independence:** the implementer cannot satisfy independent review by renaming its role.

## Success Metrics

- Every Feature acceptance records an explicit human decision with verification and independent-review evidence.
- Direct Feature delivery succeeds without child records or lower-level human approvals.
- Material divergence is surfaced before affected execution; factual upkeep does not generate ritual approvals.

These are criteria to verify, not claims that this revision has passed a live trial.

## Activity Log

- **2026-11-01** — Human approved Feature-only gate design and implementation approach. Updated current requirements; retained earlier activity and identifiers. Independent review and delivery acceptance are pending. See [rationale](../knowledge/feature-level-governance.md).

- **2026-05-18** — ELABORATED: Feature created retrospectively. Gate logic, business rules, workflows, and UX patterns were established during the Shannon v4 refactor and subsequent document reviews (commits `6852b29` through `d4ccc03`). This Feature codifies the capability.
