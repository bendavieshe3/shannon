# FEAT-008: Development Discipline

## Metadata

- **Status**: PLANNED
- **Activity**: ACTIVE
- **Type**: Feature
- **Vision Reference**: § Core Principles #4 *Adaptive Coherence* — both its framework-evolution clause ("Framework evolution … propagates to existing artefacts through the same review mechanisms") and its closing commitment ("Knowledge accumulates so the same investigation never happens twice"). Secondary anchor: § Key Features → *Mandated Project Documentation*, which mandates `development_guide.md` as one of the six.
- **Initial Implementation**: Partial — the Development Guide contains the retrospective conventions and later dogfooding amendments. The current learning-capture channel consists of the Guide's Pre-Commit Checklist and the work-items skill's implementation responsibility; the earlier Plan/Review soft prompts were removed by the Feature-level governance revision.
  - **Met:** The Guide covers environment setup, build/run, code style, testing, git workflow and distribution. EPIC-008 added editing order, push cadence and learning capture; TASK-029 added the governing-rule citation convention. These are delivered precedents, not claims that the removed prompts still exist. [The routing-channel note](../knowledge/meta-gap-routing-channel.md) records the original implementation and its replacement.
  - **Remaining:** Testing Strategy still omits the discipline used for shipped executable hooks; that correction remains separate work. Naming each convention's worked precedent is met in practice but not yet a stated format requirement. The backlog under Known forward work remains open; this governance repair does not deliver or accept it.
- **Created**: 2026-05-24
- **Updated**: 2026-11-12

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no active implementation) or `ACTIVE` (implementation in progress, with or without an Epic). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work linked to this Feature.

> **Retrospective Features**: When Shannon is applied to an existing project, pre-existing capabilities are captured as Features starting in **ELABORATED + STABLE**. The Requirements section describes the capability as it exists (not aspirationally); the Activity Log records that initial implementation predates Shannon's adoption. The Plan may name the next delivery approach, with optional execution aids. See conceptual_design.md § Business Rules — *Retrospective Features*.

---

## Requirements

*Elaborated at `/feature-elaborate FEAT-008` (2026-09-29); refined from Gate 1 review findings 2026-10-05. Gate 1 approved by the directing party 2026-10-05.*

### Overview

Shannon codifies development discipline conventions — *how the work gets done* — as ratified rules in `development_guide.md`. The Feature captures the framework's commitment that disciplines surfaced during development (editing order; git workflow conventions including commit and push cadence; testing patterns; process channels for routing learnings back into the framework) are promoted into the mandated guide rather than being re-derived ad-hoc or quietly drifting.

This is the *upstream-from-implementation* counterpart to [FEAT-003](FEAT-003-unified-work-item-model.md) (Unified Work Item Model): the work-item lifecycle defines what the work IS; this Feature defines the conventions for HOW it is done. The two Features split cleanly — work-item-workflow learnings (re-elaboration mechanics, AC scope-guard rules, naming) flow into FEAT-003's mandated-document amendments; dev / git / test / build / process learnings flow into FEAT-008's `development_guide` amendments.

The base capability is **retrospective**: `development_guide.md` was created during the Shannon framework's bootstrapping with initial conventions (Environment Setup, Build and Run, Code Style, Testing Strategy → Pre-Commit Checklist, Git Workflow → Commit Cadence, CI/CD → Distribution). The Feature was created on 2026-05-24 to anchor that capability and the forward work that adds new conventions — beginning with [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md) (the dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest) and continuing as Shannon is used on real projects beyond dogfooding itself.

The authority rule at `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide* allows agents to maintain the Guide within approved intent as part of the work that surfaces a convention. A corrected link, factual update or implementation detail needs no child gate. A consequential change to approved meaning returns to the human through document review or the affected Feature gate. Capture and ratification can accompany the originating work without inventing Task approval authority.

### Ideal State

*The framework's commitments around development discipline as it accumulates over time.*

- The mandated `development_guide.md` exists with conventions covering § Environment Setup, § Build and Run, § Code Style, § Testing Strategy (incl. Pre-Commit Checklist), § Git Workflow (Commit Cadence and Push Cadence), § CI/CD (incl. Distribution and re-sync) *(met, with one section stale — the retrospective conventions at bootstrapping; Push Cadence and the editing-order convention added by EPIC-008. § Testing Strategy no longer describes how Shannon is tested once executable hook bodies shipped; see Metadata → Remaining)*
- Development disciplines surfaced during framework use are captured in `scratchpad.md` or a follow-up record, then promoted into `development_guide.md` within the applicable authority boundary. They must remain visible beyond an individual execution plan *(met through the Guide's Pre-Commit Checklist and `shannon/skills/work-items/skill.md` § Feature lifecycle → Implement — agent-managed delivery; EPIC-008 and TASK-029 are earlier worked precedents)*
- The learning-capture responsibility is visible while implementation is under way and before commit. The current channel replaces the removed Plan/Review soft prompts; it does not claim those prompts as delivered current behaviour *(met at the same Guide and skill sections; the [routing-channel note](../knowledge/meta-gap-routing-channel.md) retains the original evidence)*
- Guide maintenance accompanies the originating work within approved meaning. Consequential changes receive the human document or Feature decision they require; optional execution records add no gates *(authority at `conceptual_design.md` § Business Rules → Work Items Consume the UX Guide; May Refine the Development Guide)*
- Each ratified convention carries the evidence that produced it — the worked precedent, named — so a future reader can tell a rule from an opinion *(partially met — met in practice by every convention added since bootstrapping; not yet a stated requirement of the Guide's own format. Retrospective bootstrapping conventions are exempt: they are ratified as existing practice per `conceptual_design.md` § Business Rules → *Retrospective Features*)*
- (Future) Real-project use — Shannon applied to projects other than itself — surfaces dev / test / build / CI disciplines beyond framework dogfooding; these are absorbed into `development_guide` via the same channel without forcing a separate model *(forward; expected over project lifetime)*

### User Stories

#### Conventions Ratified Rather Than Re-Derived

**As an** implementer picking up a work item months after a convention was settled,
**I want** development disciplines to live as ratified rules in `development_guide.md`,
**So that** I follow the settled answer instead of re-reasoning it from first principles and arriving somewhere subtly different.

#### Routing a Learning at the Moment It Surfaces

**As an** implementer who has just resolved a framework-general ambiguity in the course of a Task,
**I want** the implementation workflow and pre-commit checklist to remind me to route the learning back,
**So that** capture does not depend on my remembering to be diligent at exactly the moment I am focused on something else.

#### Ratifying Without a Second Review Cycle

**As an** implementer who has surfaced a development convention during a work item,
**I want** to maintain the Development Guide alongside the originating work within approved intent, escalating consequential changes to the human,
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
- **Conceptual Design**: § Domain Model → *Mandated Document* (`development_guide.md` is one of the six); § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide* (factual maintenance within approved meaning; consequential changes return to the human); § Business Rules → *Higher Work Items May Update Mid-Level Docs* (document maintenance depends on approved meaning, not execution-record type); § Business Rules → *Retrospective Features* (the basis for this Feature's Partial initial implementation); § Key Workflows → *Re-elaborating a Work Item* (the pattern by which this Feature and its children absorb change).
- **Mandated Document**: `development_guide.md` — the document this Feature anchors as a persistent capability.
- **Related Features**: [FEAT-003 — Unified Work Item Model](FEAT-003-unified-work-item-model.md) is the *what-the-work-IS* counterpart; FEAT-008 is the *how-the-work-is-done* counterpart. They share Vision § Adaptive Coherence as a common anchor and partition the dogfooding-harvest amendments along work-item vs dev-discipline lines.

---

## Plan

*Drafted at `/feature-plan FEAT-008` (Gate 2) 2026-10-18; Gate 2 approved by the directing party 2026-10-19. One child Epic created in DRAFT with prepared elaboration and plan drafts via Cascading Preparation.*

### Approach

FEAT-008 grows by harvest. Conventions surface while other work is done, wait in `docs/scratchpad.md`, and are promoted into `development_guide.md` in batches once a cluster has formed. EPIC-008 was the first harvest (from EPIC-005 / EPIC-006). The supervisor build-out under FEAT-009 has produced the second, so this plan carries it as one Epic, [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md), rather than as a run of orphan Tasks: the items share one source and one target document, and checking the batch together catches overlaps that isolated checks would miss. The Epic is an optional execution aid; it adds no human gate.

EPIC-012 delivers the two Ideal State bullets that are not yet met (bullet 1, § Testing Strategy stale for shipped executables; bullet 5, precedent-naming not a stated requirement) and the six items under *Known forward work*, plus one item that was already in the scratchpad but missed by this Feature's *Known forward work* sweep (the `{{SLOT}}` placeholder divergence in the supervisor templates, surfaced at TASK-028 Gate 1 on 2026-08-21). Its remaining delivery must be verified against those outcomes; an optional Epic status cannot establish Feature acceptance.

Single conventions that surface outside a harvest keep the TASK-029 route: an optional orphan Task under this Feature, executed within approved intent without its own human gates.

### Epics

- [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md) — APPROVED — Development Conventions Surfaced Through Dogfooding (codified editing-order, Push Cadence, and the meta-gap routing channel — the dev-discipline half of the EPIC-005 / EPIC-006 dogfooding harvest, sibling to EPIC-007 under FEAT-003; APPROVED 2026-05-27 via TASK-007 + TASK-010; fulfilled aspirational Ideal State bullets 2 and 3)
- [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) — PLANNED — Development Conventions Surfaced Through the Supervisor Build-Out (the second dogfooding harvest: § Testing Strategy for shipped executables, cross-Task editing order, skill packaging, audit-log location, plain-prose verification substrings, placeholder syntax for machine-filled templates, and precedent-naming as a stated requirement; targets Ideal State bullets 1 and 5)

Orphan Tasks under this Feature (no parent Epic — EPIC-008 is APPROVED and closed, and each convention was too small to warrant a new Epic; optional records add no gates per `conceptual_design.md` § Business Rules → *Gate Authority Split*):

- [TASK-029](../tasks/archive/TASK-029-acceptance-criteria-cite-governing-rules.md) — APPROVED — Acceptance Criteria Cite Governing Rules, Not Version-Pinned References (added `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule* plus a companion skill prompt that was later removed by the governance revision; APPROVED 2026-08-28; fulfilled Ideal State bullet 4)

### Known forward work

Active `docs/scratchpad.md` § Items that name `development_guide.md` or a dev-discipline convention as their candidate route. All six below are carried by [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md); they stay in the scratchpad until verified completion justifies moving them to § Processed.

- **§ Testing Strategy has no Test Level for shipped executables** — three supervisor Tasks unit-tested hook scripts against a discipline the section does not carry. The scratchpad item's own note that this needs `/document-review` predates `conceptual_design.md` § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide*; an orphan Task under this Feature may now make the amendment
- **Cross-Task editing order** — the *Source-of-truth body before derived artefacts* convention covers one Task's diff, not a downstream Task extending an upstream Task's body
- **Portability discipline for skill-creating Epics** — project-relative paths inside skills, checkers and templates as a verifiable convention
- **Shipping-source mirror convention for new skills** — author in `./shannon/`, deploy to `./.claude/`
- **Supervisor audit-log convention** — the PostToolUse audit-log location is named in an Epic AC but not at framework level
- **Verbatim-phrasing grep tests need plain-prose substrings** — Markdown formatting that interposes between substring characters breaks verification greps

*Further Epics will surface as Shannon is used on real projects beyond framework dogfooding — dev / test / build / CI disciplines absorbed into `development_guide` via the same channel EPIC-008 codifies.*

### Dependencies

**Depends on**: `development_guide.md` (the document this Feature anchors); FEAT-002 (Mandated Project Documentation — the structural framework that mandates `development_guide`'s existence)

**Depended on by**: Future framework-refinement Epics that surface dev / test / build / CI conventions from real-project use

### Risks

- **Boundary drift with FEAT-003** — some learnings could plausibly fit either Feature (e.g. AC writing conventions are work-item-touching but also developer discipline; meta-gap routing channel is process discipline but the work-items skill prompt half is work-item-touching). Mitigation: keep the boundary explicit (work-item-workflow learnings → FEAT-003; dev / git / test / build / process learnings → FEAT-008); when ambiguous, the work item that promotes the learning names the disposition and the rationale, or the Feature's § Plan entry records it after the fact. Recorded disposition for TASK-029: AC-writing citation discipline sits here, not under FEAT-003, because its ratified output is a `development_guide.md` § Code Style rule that every work item consumes, rather than a change to the work-item model itself

---

## Success Metrics

- **Re-derivation absence** — A convention already ratified in `development_guide.md` is not re-reasoned inside a later work item's Plan. *Judgement, with a countable proxy: a Task Plan that argues from first principles to a conclusion the Guide already states is a miss; the editing-order convention (buried in TASK-003's Plan before EPIC-008 promoted it) is the canonical example of the failure.*
- **Routing-channel throughput** — Framework-general ambiguities surfaced during work reach `scratchpad.md` or a follow-up work item rather than dying in the session. *Countable: scratchpad items and work items whose Activity Log names the meta-gap prompt as their trigger. EPIC-007, EPIC-008 and TASK-029 are the exercises to date.*
- **Ratification follows the authority boundary** — Guide maintenance accompanies the originating work within approved meaning; consequential changes cite the actual human document or Feature decision. *Check each new Guide Version History entry for the originating work, evidence and any required decision. Historical Task approvals remain precedents, not current Task gate requirements.*
- **Guide currency** — `development_guide.md`'s stated conventions match how the work is actually being done. *Judgement: drift shows up as a Gate 3 review adjudicating an implementer's ad-hoc reasoning on a point the Guide should already have settled.*
- **Precedent density** — Each ratified convention names the worked precedent that produced it. *Countable: bullets under § Code Style → Patterns to Follow added since bootstrapping that carry a named Task or Epic; a post-bootstrapping convention with no precedent is an opinion that has not yet earned ratification. Retrospective bootstrapping conventions are out of scope for this metric.*
- **Boundary held with FEAT-003** — Learnings land under the Feature whose kind they match (dev / git / test / build / process here; work-item-workflow learnings under FEAT-003), with the promoting work item naming the disposition when ambiguous. *Judgement: a learning filed under both, or under neither, is the failure this metric watches for.*

---

## Activity Log

- **2026-11-12** — Clarification of the approved governance revision: approval of its requirements and implementation approach is not acceptance of this Feature's whole delivered capability. Overall Status remains PLANNED; this repair records no Feature Gate 3 acceptance. Independent review and any remaining delivery or live-validation work remain outstanding.


- **2026-05-24** — DRAFT: Feature created. Anchors `development_guide.md` as a persistent capability of the framework and provides a home for development / git / testing / process discipline conventions accumulated through use. Created to split the EPIC-005 / EPIC-006 dogfooding harvest cleanly — work-item-workflow learnings stay under FEAT-003 (EPIC-007); dev / git / process discipline learnings move here (EPIC-008). Vision Reference: § Core Principles #3 *Knowledge Accumulates* (primary) and #4 *Adaptive Coherence* (secondary). Initial Implementation **Partial** — `development_guide` exists with retrospective conventions (Code Style, Commit Cadence, Testing Strategy, Distribution, CI/CD, Setup); new conventions added via EPIC-008 and future use. The split was made now (rather than after EPIC-007 absorbed all seven items under FEAT-003) on the directing party's call: "best to acknowledge the split now and pay the upfront cost to prevent more cost/re-work later — future learnings will compound when Shannon is used on real projects beyond dogfooding itself." Full Requirements elaboration pending `/feature-elaborate FEAT-008` (or absorbed into EPIC-008's work).
- **2026-09-29** — DRAFT (elaboration pass, Gate 1 pending): Requirements elaborated at `/feature-elaborate FEAT-008`. Drafted § User Stories (five stories: re-derivation, routing at the moment of surfacing, in-item ratification, Guide currency, retrospective adoption) and § Success Metrics (six, judgement-led with countable proxies). **Vision Reference corrected**: the Feature had cited *§ Core Principles #3 "Knowledge Accumulates"* as primary anchor. No such principle exists, and none ever has — #3 has read *Complete Traceability* in every approved Vision version (v2.1 `6abf672`, v2.2 `3a65a73`, v2.3 `7c117d4`, v2.4 `d2fd797`). "Knowledge accumulates so the same investigation never happens twice" is the closing sentence of Principle **#4 Adaptive Coherence**, which the Feature already carried as its secondary anchor. This was an original citation error at `/feature-create`, not drift from a moved target. Anchor now reads § Core Principles #4 *Adaptive Coherence* (primary, covering both the knowledge-accumulation and framework-evolution clauses) with § Key Features → *Mandated Project Documentation* as secondary. Also: replaced all line-number and version-pinned citations (`development_guide.md:79`/`:114`/`:149`, `skill.md:174`/`:236`, `development_guide.md v1.3`) with governing section paths per `development_guide.md` § Code Style → Patterns to Follow → *Acceptance criteria cite the governing rule* — the pinned line numbers had already gone stale as the Guide reached v1.5; corrected § Environment Setup / § Build and Run / § CI/CD → Distribution section names, which the Feature had been calling "§ Setup" and "§ Distribution"; added the `conceptual_design.md` v1.8 Guide-authority split to § Overview, § Ideal State (new bullet 4) and § Context as the rule that makes the routing channel closeable; added a precedent-density bullet to § Ideal State; and recorded orphan [TASK-029](../tasks/archive/TASK-029-acceptance-criteria-cite-governing-rules.md) (APPROVED 2026-08-28) under § Plan, which the Feature had not been carrying at all.
- **2026-10-05** — DRAFT (Gate 1 refinements, additive): Applied directing-party-accepted findings from a Gate 1 review (Drift / Gap / Internal contradiction / Strength). **Gap**: Metadata → Remaining had read "No outstanding aspirational criteria" while `docs/scratchpad.md` held active items routed at `development_guide.md`; added § Plan → *Known forward work* naming six, and rewrote Remaining. **Drift**: Ideal State bullet 1 marked § Testing Strategy met, but the section's "no units" claim no longer holds after TASK-016 / TASK-017 / TASK-025; bullet now reads met-with-one-section-stale. **Internal contradiction**: bullet 5 (precedent naming "not yet a stated requirement") against Remaining "none"; bullet 5 now partially met, and both it and the *Precedent density* metric exempt retrospective bootstrapping conventions per `conceptual_design.md` § Business Rules → *Retrospective Features*. **Minor**: recorded TASK-029's FEAT-003 boundary disposition under § Risks and softened the mitigation to "the promoting work item, or the § Plan entry after the fact"; narrowed § Overview's FEAT-003 example from "AC writing" to "AC scope-guard rules" to match; *Ratification stays in-item* metric now states that only v1.5 names its route explicitly. **Date correction**: the elaboration entry and the Requirements banner had read 2026-08-29; the elaboration was committed 2026-09-29 (`732289a`), now corrected. **Strengths** confirmed: Vision anchor at Principle #4, every cited business rule and Guide section resolves by name, no line-number citations. Status stays DRAFT; Gate 1 not given.
- **2026-10-19** — ELABORATED → PLANNED (Gate 2): Directing party approved the plan, choosing one Epic over orphan Tasks or a Testing-Strategy-only plan. Activity stays STABLE until EPIC-012 enters elaboration. EPIC-012 stays DRAFT; its prepared drafts surface at `/epic-elaborate EPIC-012` and `/epic-plan EPIC-012`, each with its own gate.
- **2026-10-18** — ELABORATED (Gate 2 drafted, pending approval): Plan drafted at `/feature-plan FEAT-008`. Added § Plan → *Approach* (growth by harvest; one Epic per harvest; single conventions keep the orphan-Task route). **Cascading Preparation performed**: [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) created in DRAFT with a prepared elaboration draft (ten ACs) and a prepared plan draft (seven Task candidates), both marked "Prepared during FEAT-008 planning, not yet reviewed"; one entry added to `epic_index.md`. EPIC-012 carries the six *Known forward work* items, the `{{SLOT}}` placeholder item surfaced at TASK-028 Gate 1 (after this Feature's Gate 1), and Ideal State bullet 5. Out of scope and named in EPIC-012: the `/shannon-setup` half of the audit-log item (deferred deployment Epic) and the hook-fragment deployment item (FEAT-009, Drift Checker). Status stays ELABORATED until the directing party approves Gate 2.
- **2026-10-05** — DRAFT → ELABORATED (Gate 1): Directing party approved the refined Requirements (commit `affdbec`). Activity stays STABLE; no Epic is in progress. § Plan → *Known forward work* is captured, not committed: each item still enters through promotion to an orphan Task or a new Epic.
- **2026-10-20** — PLANNED (correction, additive): § Plan → *Approach* had said the `{{SLOT}}` placeholder item "surfaced after Gate 1". It surfaced at TASK-028 Gate 1 on 2026-08-21, before this Feature's elaboration, and was missed by the *Known forward work* sweep. Corrected during `/epic-elaborate EPIC-012`; the 2026-10-18 entry above is left as written. Status unchanged.
- **2026-10-21** — PLANNED (Activity STABLE → ACTIVE): [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) passed Gate 1 and is ELABORATED, so an Epic is now in progress under this Feature, as the 2026-10-19 entry anticipated. Status unchanged.
- **2026-10-23** — PLANNED (child Epic advanced, additive): [EPIC-012](../epics/EPIC-012-development-conventions-from-supervisor-build-out.md) passed Gate 2 and is PLANNED, with seven DRAFT child Tasks (TASK-033 to TASK-039). Status unchanged.
