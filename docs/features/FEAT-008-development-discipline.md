# FEAT-008: Development Discipline

## Metadata

- **Status**: DRAFT
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #4 *Adaptive Coherence* — both its framework-evolution clause ("Framework evolution … propagates to existing artefacts through the same review mechanisms") and its closing commitment ("Knowledge accumulates so the same investigation never happens twice"). Secondary anchor: § Key Features → *Mandated Project Documentation*, which mandates `development_guide.md` as one of the six.
- **Initial Implementation**: Partial — `development_guide.md` carries the original retrospective conventions plus the three EPIC-008 amendments (editing-order convention, Push Cadence subsection, meta-gap routing-channel Pre-Commit Checklist line); the meta-gap routing channel is operationalised end-to-end (canonical checklist line + step-adjoining skill prompts in the `work-items` skill at § Process: Plan and § Process: Review); further conventions have since arrived through the same channel (TASK-029), and future learnings from real-project use (testing / build / CI conventions) will absorb the same way. See Met / Remaining below.
  - **Met:** `development_guide.md` exists with retrospective conventions — § Environment Setup, § Build and Run, § Code Style, § Testing Strategy (incl. Pre-Commit Checklist), § Git Workflow (Commit Cadence), § CI/CD (incl. Distribution / re-sync) — plus three EPIC-008 amendments, all APPROVED 2026-05-27: the editing-order convention at § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*; the Push Cadence subsection at § Git Workflow, sibling to Commit Cadence; and the meta-gap routing channel as a two-touch (§ Testing Strategy → Pre-Commit Checklist line, plus step-adjoining soft prompts in `shannon/skills/work-items/skill.md` at § Process: Plan and § Process: Review). Durable record at `docs/knowledge/meta-gap-routing-channel.md` (Extension knowledge note). The channel has since been exercised again by orphan [TASK-029](../tasks/archive/TASK-029-acceptance-criteria-cite-governing-rules.md) (APPROVED 2026-08-28), which added § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule* and its companion § Process: Elaborate soft prompt.
  - **Remaining:** No outstanding aspirational criteria at this time. Future learnings from real-project use (dev / test / build / CI disciplines surfaced as Shannon is applied beyond framework dogfooding) will absorb into `development_guide.md` via the routing channel EPIC-008 established — forward work expected over the project lifetime, not a missing criterion.
- **Created**: 2026-05-24
- **Updated**: 2026-08-29

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no epic in progress) or `ACTIVE` (an epic is being worked on). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work through new Epics.

> **Retrospective Features**: When Shannon is applied to an existing project, pre-existing capabilities are captured as Features starting in **ELABORATED + STABLE**. The Requirements section describes the capability as it exists (not aspirationally); the Activity Log records that initial implementation predates Shannon's adoption. The Plan section may be empty (no Epics yet) or may name the next Epic if further evolution is planned. See conceptual_design.md § Business Rules — *Retrospective Features*.

---

## Requirements

*Elaborated at `/feature-elaborate FEAT-008` (2026-08-29). Gate 1 pending directing-party approval.*

### Overview

Shannon codifies development discipline conventions — *how the work gets done* — as ratified rules in `development_guide.md`. The Feature captures the framework's commitment that disciplines surfaced during development (editing order; git workflow conventions including commit and push cadence; testing patterns; process channels for routing learnings back into the framework) are promoted into the mandated guide rather than being re-derived ad-hoc or quietly drifting.

This is the *upstream-from-implementation* counterpart to [FEAT-003](FEAT-003-unified-work-item-model.md) (Unified Work Item Model): the work-item lifecycle defines what the work IS; this Feature defines the conventions for HOW it is done. The two Features split cleanly — work-item-workflow learnings (re-elaboration mechanics, AC writing, naming) flow into FEAT-003's mandated-document amendments; dev / git / test / build / process learnings flow into FEAT-008's `development_guide` amendments.

The base capability is **retrospective**: `development_guide.md` was created during the Shannon framework's bootstrapping with initial conventions (Environment Setup, Build and Run, Code Style, Testing Strategy → Pre-Commit Checklist, Git Workflow → Commit Cadence, CI/CD → Distribution). The Feature was created on 2026-05-24 to anchor that capability and the forward work that adds new conventions — beginning with [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md) (the dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest) and continuing as Shannon is used on real projects beyond dogfooding itself.

What makes the capability *tractable* rather than merely aspirational is the authority rule at `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*: because the Development Guide describes the process work items execute, a work item that discovers or ratifies a development convention during its own work may amend the Guide as part of that work, riding its own gates rather than requiring a separate `/document-review`. Without that rule, every convention this Feature accumulates would need a second, out-of-band approval cycle, and the routing channel would leak. With it, the channel closes: the moment of discovery, the capture, and the ratification all sit inside one work item.

### Ideal State

*The framework's commitments around development discipline as it accumulates over time.*

- The mandated `development_guide.md` exists with conventions covering § Environment Setup, § Build and Run, § Code Style, § Testing Strategy (incl. Pre-Commit Checklist), § Git Workflow (Commit Cadence and Push Cadence), § CI/CD (incl. Distribution and re-sync) *(met — the retrospective conventions at bootstrapping; Push Cadence and the editing-order convention added by EPIC-008)*
- Development disciplines surfaced during framework use are promoted into ratified `development_guide` rules via canonical work-item workflows — not lost, not re-derived ad-hoc, not silently absorbed into individual Task Plans *(met — delivered by EPIC-008 / TASK-007 (editing-order, Push Cadence, meta-gap checklist line) + TASK-010 (skill prompts); APPROVED 2026-05-27)*
- The framework provides a routing channel for "this resolved a framework-general ambiguity → route it back" so the discipline of capturing learnings is visible at the moments of action (plan / review) rather than relying on implementer initiative — the *meta-gap* *(met — delivered by EPIC-008; routing channel codified at `development_guide.md` § Testing Strategy → Pre-Commit Checklist plus the soft prompts in `shannon/skills/work-items/skill.md` § Process: Plan and § Process: Review; APPROVED 2026-05-27; durable record at `docs/knowledge/meta-gap-routing-channel.md`)*
- A convention ratified into the Guide is ratified **by the work item that surfaced it**, not by a second out-of-band review cycle — so the cost of capturing a learning stays proportional to the learning *(met — authority granted at `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*; first exercised end-to-end by orphan TASK-029, APPROVED 2026-08-28)*
- Each ratified convention carries the evidence that produced it — the worked precedent, named — so a future reader can tell a rule from an opinion *(met in practice by every convention shipped to date; not yet a stated requirement of the Guide's own format)*
- (Future) Real-project use — Shannon applied to projects other than itself — surfaces dev / test / build / CI disciplines beyond framework dogfooding; these are absorbed into `development_guide` via the same channel without forcing a separate model *(forward; expected over project lifetime)*

### User Stories

#### Conventions Ratified Rather Than Re-Derived

**As an** implementer picking up a work item months after a convention was settled,
**I want** development disciplines to live as ratified rules in `development_guide.md`,
**So that** I follow the settled answer instead of re-reasoning it from first principles and arriving somewhere subtly different.

#### Routing a Learning at the Moment It Surfaces

**As an** implementer who has just resolved a framework-general ambiguity in the course of a Task,
**I want** the framework to prompt me — at planning and at review — to route the learning back,
**So that** capture does not depend on my remembering to be diligent at exactly the moment I am focused on something else.

#### Ratifying Without a Second Review Cycle

**As an** implementer who has surfaced a development convention during a work item,
**I want** to amend the Development Guide inside that work item's own gates,
**So that** the cost of capturing the learning stays proportional to the learning, rather than requiring a separate `/document-review` that discourages capture altogether.

#### Trusting the Guide as Current

**As a** directing party approving a Gate 3,
**I want** the Development Guide to be the single place where "how we do the work here" is settled,
**So that** I can review against a stated rule rather than adjudicating each implementer's ad-hoc reasoning.

#### Adopting Shannon With Conventions Already in Place

**As a** directing party applying Shannon to an existing project,
**I want** the project's pre-existing development conventions captured retrospectively into `development_guide.md`,
**So that** the Guide starts out describing reality, and forward conventions accumulate onto a truthful base rather than displacing one.

### Context

- **Vision**: § Core Principles #4 *Adaptive Coherence* — the closing commitment ("Knowledge accumulates so the same investigation never happens twice") is the substance this Feature delivers, and the framework-evolution clause ("Framework evolution … propagates to existing artefacts through the same review mechanisms") is the mechanism it uses. § Key Features → *Mandated Project Documentation* is the secondary anchor: it names `development_guide.md` as one of the six mandated documents this Feature anchors.
- **Conceptual Design**: § Domain Model → *Mandated Document* (`development_guide.md` is one of the six); § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide* (the authority rule that lets a work item ratify a convention inside its own gates); § Business Rules → *Higher Work Items May Update Mid-Level Docs* (which names the Development Guide as the one document a Task may refine); § Business Rules → *Retrospective Features* (the basis for this Feature's Partial initial implementation); § Key Workflows → *Re-elaborating a Work Item* (the pattern by which this Feature and its children absorb change).
- **Mandated Document**: `development_guide.md` — the document this Feature anchors as a persistent capability.
- **Related Features**: [FEAT-003 — Unified Work Item Model](FEAT-003-unified-work-item-model.md) is the *what-the-work-IS* counterpart; FEAT-008 is the *how-the-work-is-done* counterpart. They share Vision § Adaptive Coherence as a common anchor and partition the dogfooding-harvest amendments along work-item vs dev-discipline lines.

---

## Plan

### Epics

- [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md) — APPROVED — Development Conventions Surfaced Through Dogfooding (codified editing-order, Push Cadence, and the meta-gap routing channel — the dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest, sibling to EPIC-007 under FEAT-003; APPROVED 2026-05-27 via TASK-007 + TASK-010; fulfilled aspirational Ideal State bullets 2 and 3)

Orphan Tasks under this Feature (no parent Epic — EPIC-008 is APPROVED and closed, and each convention was too small to warrant a new Epic; orphan-ness does not change gate authority per `conceptual_design.md` § Business Rules → *Gate Authority Split*):

- [TASK-029](../tasks/archive/TASK-029-acceptance-criteria-cite-governing-rules.md) — APPROVED — Acceptance Criteria Cite Governing Rules, Not Version-Pinned References (added `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule* plus the companion § Process: Elaborate soft prompt in the `work-items` skill; APPROVED 2026-08-28; fulfilled Ideal State bullet 4)

*Future Epics will surface as Shannon is used on real projects beyond framework dogfooding — dev / test / build / CI disciplines absorbed into `development_guide` via the same channel EPIC-008 codifies.*

### Dependencies

**Depends on**: `development_guide.md` (the document this Feature anchors); FEAT-002 (Mandated Project Documentation — the structural framework that mandates `development_guide`'s existence)

**Depended on by**: Future framework-refinement Epics that surface dev / test / build / CI conventions from real-project use

### Risks

- **Boundary drift with FEAT-003** — some learnings could plausibly fit either Feature (e.g. AC writing conventions are work-item-touching but also developer discipline; meta-gap routing channel is process discipline but the work-items skill prompt half is work-item-touching). Mitigation: keep the boundary explicit (work-item-workflow learnings → FEAT-003; dev / git / test / build / process learnings → FEAT-008); when ambiguous, the Epic that promotes the learning names the disposition and the rationale

---

## Success Metrics

- **Re-derivation absence** — A convention already ratified in `development_guide.md` is not re-reasoned inside a later work item's Plan. *Judgement, with a countable proxy: a Task Plan that argues from first principles to a conclusion the Guide already states is a miss; the editing-order convention (buried in TASK-003's Plan before EPIC-008 promoted it) is the canonical example of the failure.*
- **Routing-channel throughput** — Framework-general ambiguities surfaced during work reach `scratchpad.md` or a follow-up work item rather than dying in the session. *Countable: scratchpad items and work items whose Activity Log names the meta-gap prompt as their trigger. EPIC-007, EPIC-008 and TASK-029 are the exercises to date.*
- **Ratification stays in-item** — Conventions surfaced during a work item are ratified inside that item's own gates rather than deferred to a separate `/document-review`. *Countable from the `development_guide.md` Version History: each entry names whether it arrived via a work item or a document review; a rising share routed out-of-band indicates the authority rule is not being relied on.*
- **Guide currency** — `development_guide.md`'s stated conventions match how the work is actually being done. *Judgement: drift shows up as a Gate 3 review adjudicating an implementer's ad-hoc reasoning on a point the Guide should already have settled.*
- **Precedent density** — Each ratified convention names the worked precedent that produced it. *Countable: bullets under § Code Style → Patterns to Follow carrying a named Task or Epic; a convention with no precedent is an opinion that has not yet earned ratification.*
- **Boundary held with FEAT-003** — Learnings land under the Feature whose kind they match (dev / git / test / build / process here; work-item-workflow learnings under FEAT-003), with the promoting work item naming the disposition when ambiguous. *Judgement: a learning filed under both, or under neither, is the failure this metric watches for.*

---

## Activity Log

- **2026-05-24** — DRAFT: Feature created. Anchors `development_guide.md` as a persistent capability of the framework and provides a home for development / git / testing / process discipline conventions accumulated through use. Created to split the EPIC-005 / EPIC-006 dogfooding harvest cleanly — work-item-workflow learnings stay under FEAT-003 (EPIC-007); dev / git / process discipline learnings move here (EPIC-008). Vision Reference: § Core Principles #3 *Knowledge Accumulates* (primary) and #4 *Adaptive Coherence* (secondary). Initial Implementation **Partial** — `development_guide` exists with retrospective conventions (Code Style, Commit Cadence, Testing Strategy, Distribution, CI/CD, Setup); new conventions added via EPIC-008 and future use. The split was made now (rather than after EPIC-007 absorbed all seven items under FEAT-003) on the directing party's call: "best to acknowledge the split now and pay the upfront cost to prevent more cost/re-work later — future learnings will compound when Shannon is used on real projects beyond dogfooding itself." Full Requirements elaboration pending `/feature-elaborate FEAT-008` (or absorbed into EPIC-008's work).
- **2026-08-29** — DRAFT (elaboration pass, Gate 1 pending): Requirements elaborated at `/feature-elaborate FEAT-008`. Drafted § User Stories (five stories: re-derivation, routing at the moment of surfacing, in-item ratification, Guide currency, retrospective adoption) and § Success Metrics (six, judgement-led with countable proxies). **Vision Reference corrected**: the Feature had cited *§ Core Principles #3 "Knowledge Accumulates"* as primary anchor. No such principle exists, and none ever has — #3 has read *Complete Traceability* in every approved Vision version (v2.1 `6abf672`, v2.2 `3a65a73`, v2.3 `7c117d4`, v2.4 `d2fd797`). "Knowledge accumulates so the same investigation never happens twice" is the closing sentence of Principle **#4 Adaptive Coherence**, which the Feature already carried as its secondary anchor. This was an original citation error at `/feature-create`, not drift from a moved target. Anchor now reads § Core Principles #4 *Adaptive Coherence* (primary, covering both the knowledge-accumulation and framework-evolution clauses) with § Key Features → *Mandated Project Documentation* as secondary. Also: replaced all line-number and version-pinned citations (`development_guide.md:79`/`:114`/`:149`, `skill.md:174`/`:236`, `development_guide.md v1.3`) with governing section paths per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule* — the pinned line numbers had already gone stale as the Guide reached v1.5; corrected § Environment Setup / § Build and Run / § CI/CD → Distribution section names, which the Feature had been calling "§ Setup" and "§ Distribution"; added the `conceptual_design.md` v1.8 Guide-authority split to § Overview, § Ideal State (new bullet 4) and § Context as the rule that makes the routing channel closeable; added a precedent-density bullet to § Ideal State; and recorded orphan [TASK-029](../tasks/archive/TASK-029-acceptance-criteria-cite-governing-rules.md) (APPROVED 2026-08-28) under § Plan, which the Feature had not been carrying at all.
