# FEAT-008: Development Discipline

## Metadata

- **Status**: DRAFT
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #3 "Knowledge Accumulates" (with § Core Principles #4 "Adaptive Coherence" as secondary anchor)
- **Initial Implementation**: Partial — see Activity Log
  - **Met:** `development_guide.md` exists with retrospective conventions — § Code Style, § Git Workflow (Commit Cadence), § Testing Strategy → Pre-Commit Checklist, § Distribution / re-sync, § Setup, § CI/CD.
  - **Remaining:** Editing-order convention; Push Cadence directive; meta-gap routing channel — all addressed by EPIC-008. Future learnings from real-project use (testing / build / CI conventions) absorbed via the same channel.
- **Created**: 2026-05-24
- **Updated**: 2026-05-24

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no epic in progress) or `ACTIVE` (an epic is being worked on). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work through new Epics.

> **Retrospective Features**: When Shannon is applied to an existing project, pre-existing capabilities are captured as Features starting in **ELABORATED + STABLE**. The Requirements section describes the capability as it exists (not aspirationally); the Activity Log records that initial implementation predates Shannon's adoption. The Plan section may be empty (no Epics yet) or may name the next Epic if further evolution is planned. See conceptual_design.md § Business Rules — *Retrospective Features*.

---

## Requirements

*Initial intent captured at `/feature-create`. Full elaboration pending `/feature-elaborate FEAT-008` (or absorbed into EPIC-008's work).*

### Overview

Shannon codifies development discipline conventions — *how the work gets done* — as ratified rules in `development_guide.md`. The Feature captures the framework's commitment that disciplines surfaced during development (editing order; git workflow conventions including commit and push cadence; testing patterns; process channels for routing learnings back into the framework) are promoted into the mandated guide rather than being re-derived ad-hoc or quietly drifting.

This is the *upstream-from-implementation* counterpart to [FEAT-003](FEAT-003-unified-work-item-model.md) (Unified Work Item Model): the work-item lifecycle defines what the work IS; this Feature defines the conventions for HOW it is done. The two Features split cleanly — work-item-workflow learnings (re-elaboration mechanics, AC writing, naming) flow into FEAT-003's mandated-document amendments; dev / git / test / build / process learnings flow into FEAT-008's `development_guide` amendments.

The base capability is **retrospective**: `development_guide.md` was created during the Shannon framework's bootstrapping with initial conventions (Commit Cadence, Code Style, Testing Strategy → Pre-Commit Checklist, Distribution, CI/CD, Setup). The Feature is being created now (2026-05-24) to anchor that capability and the forward work that adds new conventions — beginning with [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md) (the dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest) and continuing as Shannon is used on real projects beyond dogfooding itself.

### Ideal State

*The framework's commitments around development discipline as it accumulates over time.*

- The mandated `development_guide.md` exists with conventions covering § Code Style, § Git Workflow (Commit Cadence, [Push Cadence — forward via EPIC-008]), § Testing Strategy → Pre-Commit Checklist, § Distribution and re-sync, § Setup, § CI/CD *(met for the listed retrospective conventions; Push Cadence and editing-order forward via EPIC-008)*
- Development disciplines surfaced during framework use are promoted into ratified `development_guide` rules via canonical work-item workflows — not lost, not re-derived ad-hoc, not silently absorbed into individual Task Plans *(not yet met — addressed by EPIC-008, which both exercises the channel and codifies it)*
- The framework provides a routing channel for "this resolved a framework-general ambiguity → route it back" so the discipline of capturing learnings is visible at the moments of action (plan / review) rather than relying on implementer initiative — the *meta-gap* *(not yet met — addressed by EPIC-008)*
- (Future) Real-project use — Shannon applied to projects other than itself — surfaces dev / test / build / CI disciplines beyond framework dogfooding; these are absorbed into `development_guide` via the same channel without forcing a separate model *(forward; expected over project lifetime)*

### User Stories

*Filled during `/feature-elaborate`.*

### Context

- **Vision**: § Core Principles #3 *Knowledge Accumulates* (knowledge gathered during work goes somewhere durable); § Core Principles #4 *Adaptive Coherence* (lessons flow back into framework rules — the upstream direction). Both anchor the Feature; #3 is primary because the substance is "knowledge captured into convention", #4 is secondary because the mechanism is the canonical work-item channel.
- **Conceptual Design**: § Mandated Documents (`development_guide.md` is one of the six); the *Re-elaborating a Work Item* workflow is the channel by which new conventions land in `development_guide` via Epic/Task amendments.
- **Mandated Document**: `development_guide.md` — the document this Feature anchors as a persistent capability.
- **Related Features**: [FEAT-003 — Unified Work Item Model](FEAT-003-unified-work-item-model.md) is the *what-the-work-IS* counterpart; FEAT-008 is the *how-the-work-is-done* counterpart. They share Vision § Adaptive Coherence as a common anchor and partition the dogfooding-harvest amendments along work-item vs dev-discipline lines.

---

## Plan

### Epics

- [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md) — PLANNED — Development Conventions Surfaced Through Dogfooding (codifies editing-order, push-cadence, and the meta-gap routing channel — the dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest, sibling to EPIC-007 under FEAT-003)

*Future Epics will surface as Shannon is used on real projects beyond framework dogfooding — dev / test / build / CI disciplines absorbed into `development_guide` via the same channel EPIC-008 codifies.*

### Dependencies

**Depends on**: `development_guide.md` (the document this Feature anchors); FEAT-002 (Mandated Project Documentation — the structural framework that mandates `development_guide`'s existence)

**Depended on by**: Future framework-refinement Epics that surface dev / test / build / CI conventions from real-project use

### Risks

- **Boundary drift with FEAT-003** — some learnings could plausibly fit either Feature (e.g. AC writing conventions are work-item-touching but also developer discipline; meta-gap routing channel is process discipline but the work-items skill prompt half is work-item-touching). Mitigation: keep the boundary explicit (work-item-workflow learnings → FEAT-003; dev / git / test / build / process learnings → FEAT-008); when ambiguous, the Epic that promotes the learning names the disposition and the rationale

---

## Success Metrics

*Filled during `/feature-elaborate`.*

---

## Activity Log

- **2026-05-24** — DRAFT: Feature created. Anchors `development_guide.md` as a persistent capability of the framework and provides a home for development / git / testing / process discipline conventions accumulated through use. Created to split the EPIC-005 / EPIC-006 dogfooding harvest cleanly — work-item-workflow learnings stay under FEAT-003 (EPIC-007); dev / git / process discipline learnings move here (EPIC-008). Vision Reference: § Core Principles #3 *Knowledge Accumulates* (primary) and #4 *Adaptive Coherence* (secondary). Initial Implementation **Partial** — `development_guide` exists with retrospective conventions (Code Style, Commit Cadence, Testing Strategy, Distribution, CI/CD, Setup); new conventions added via EPIC-008 and future use. The split was made now (rather than after EPIC-007 absorbed all seven items under FEAT-003) on the directing party's call: "best to acknowledge the split now and pay the upfront cost to prevent more cost/re-work later — future learnings will compound when Shannon is used on real projects beyond dogfooding itself." Full Requirements elaboration pending `/feature-elaborate FEAT-008` (or absorbed into EPIC-008's work).
