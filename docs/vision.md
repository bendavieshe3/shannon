# Product Vision

**Status**: APPROVED
**Last Reviewed**: 2026-05-28
**Approved**: 2026-05-28

---

**Product Name**: Shannon

## Problem Statement

AI-assisted development has unlocked unprecedented productivity for solo developers, but the bottleneck has shifted. The constraint is no longer "can the AI write the code" — it's "does the AI have the right context, and does the code stay aligned with the intent that motivated it?"

Working with AI today, solo developers face a recurring set of failures: the AI forgets past decisions and re-asks settled questions; it makes choices inconsistent with earlier work; the implementation drifts from the conceptual design and nobody notices until a refactor is needed; documentation falls behind reality, then becomes untrustworthy, then gets ignored. The standard answer — "put it in the prompt" — collapses under the weight of a real project.

The result is the same productivity tax that plagued teams before AI: the developer becomes a human router, ferrying context between sessions, between documents, between intent and code. The AI does the cheap work; the human does the expensive work of staying coherent.

---

## Vision Statement

Shannon is the framework that lets solo developers and knowledge workers build high-quality software with AI in a sustained state of flow. The implementing AI carries the burden of documentation, context, and coherence; a directing party — human, or an agent acting in the directing-party role distinct from the implementer — supplies vision and review at high-leverage gates. Projects built with Shannon stay aligned to their intent from adoption through full maturity, without the directing party ever having to remember which document said what. Between gates, a supervisor role — distinct from the implementer, and optionally distinct from the directing party — sustains project health: detecting drift, surfacing strategic opportunities, approving routine work, and converting the directing party's high-level intent into candidate work items.

---

## Core Principles

### 1. **Automated Context Management**

The implementing AI reads, maintains, and cross-references documentation. The directing party directs, reviews, and decides. The framework shoulders the bookkeeping so the directing party can focus on vision and trade-offs, not on which document needs to be updated next.

### 2. **Strategic External Review**

Three quality gates at high-leverage points — requirements elaboration, implementation planning, and completion review. No code review, no micromanagement. A directing party intervenes where independent judgement compounds; the implementer handles the rest. The directing party is most often a human, but may be an agent acting in the directing-party role — provided that agent is *not* the same agent doing the implementation. The framework treats the directing role as a role, not a species — and reserves the term *supervisor* for the distinct vigilance role introduced in Principle 5.

### 3. **Complete Traceability**

Code traces back to tasks; tasks to epics or features; features to the vision. Nothing significant gets built without a clear "why." The framework makes drift between intent and implementation visible before it becomes expensive.

### 4. **Adaptive Coherence**

Coherence is dynamic, not static. The framework absorbs change — new understanding, new projects, new framework versions — without losing alignment. Reviewed context is treated as authoritative; drift between layers is caught early and resolved through canonical re-review and re-elaboration workflows. Projects can adopt Shannon at any maturity, with pre-existing capabilities captured as Retrospective Features. Framework evolution (new attributes, new workflows) propagates to existing artefacts through the same review mechanisms. Knowledge accumulates so the same investigation never happens twice.

### 5. **Continuous Health Vigilance**

Between the directing party's high-leverage interventions, the framework continuously watches for the conditions that erode coherence: documents drifting out of alignment, work items stuck mid-lifecycle, indexes diverging from their source-of-truth bodies, scratchpad items aging without resolution, opportunities to adopt new tools going unnoticed. A **supervisor** role — distinct from the implementer, and optionally distinct from the directing party — performs this vigilance on a cadence, reports up, and absorbs routine gate decisions so the directing party intervenes only on the consequential ones. The framework's promise of "drift in days, not refactors" becomes a continuous commitment rather than a hope.

---

## Key Features

- **Mandated Project Documentation** — Six core documents (vision, technology stack, conceptual design, technical design, development guide, UX guide) that together describe the project at every relevant scope, with explicit authority relationships between them.

- **Unified Work Item Model** — Features, Epics, Tasks, and Spikes share a single status lifecycle and a single file structure. Learn the model once; apply it everywhere.

- **Three Quality Gates** — Explicit approval gates at requirements elaboration, planning, and completion. Built into the lifecycle, not bolted on. Approval comes from a directing party — human, or an agent acting in the directing-party role, distinct from the implementer. For Task gates (and Epic gates by default) the supervisor role introduced in Principle 5 holds delegated approval authority; see Target Users § *Three roles, configurably separable*.

- **Knowledge Base** — Research notes, implementation details, and document extensions captured as the project runs. Spikes produce knowledge notes as their primary output.

- **Lightweight Idea Capture** — A pre-workflow scratchpad (`docs/scratchpad.md`) for ideas, half-formed work, and unprocessed TODOs that don't yet belong to a formal work item. Items get processed periodically: promoted to Features, Epics, Tasks, or Spikes; moved to knowledge notes when they harden into durable findings; or dropped. The scratchpad is the deliberate middle between losing thoughts and forcing premature classification.

- **Supervisor Role** — A continuous-vigilance role distinct from the implementer (and optionally distinct from the directing party). Audits project health on a cadence, produces dated reports, and exercises delegated gate authority for routine work — by default approving Task-level gates and the promotion of scratchpad items to Tasks, with Epic-level gate authority configurable per project. Vision and Feature gates always remain with the directing party. Designed to be invokable both interactively (during a directing-party session) and autonomously (on a cadence the project configures).

---

## Target Users

### Architect Dev — Solo developer with a strong existing vision

The Architect arrives with a formed product idea, often supported by conceptual models, existing artefacts, or domain expertise. They move methodically: solid requirements first, then conceptual design, then technical design, then implementation prepared for the final product to emerge. They want to ensure the AI's implementation respects the conceptual model and considers future requirements they have already anticipated. They do not want to review or hand-edit code.

### Gardener Dev — Solo developer exploring the problem and feature space

The Gardener starts with an unrefined idea and wants to explore it through iterative development. They expect their requirements and conceptual model to evolve as they learn. They rely on AI to fill in details and to help them notice when their evolving vision contradicts their earlier work. They may hold off on testing and rigour until they decide to commit to bringing the product to completion.

Both personas direct AI rather than write code themselves. The framework must make AI implementation trustworthy enough that line-by-line code review is the exception rather than the norm.

### Three roles, configurably separable

Shannon names three roles:

- **Implementer** — the AI that writes code, maintains documentation, and drafts work items for review.
- **Directing party** — the source of vision and high-leverage decisions. Always retains gate authority over the Vision document and over Features. A human (Architect or Gardener) is the most common occupant; an agent acting in the directing-party role is supported.
- **Supervisor** — performs continuous health vigilance and absorbs the routine gate workload so the directing party's interventions stay high-leverage. By default the supervisor holds Task-level gate authority and may promote scratchpad items into Tasks autonomously. Epic-level gate authority sits with the supervisor by default but may be reserved by the directing party per project. Scratchpad promotion to an Epic always requires directing-party approval, because Epics live under Features the directing party owns.

Two constraints govern role assignment:

1. **Supervisor ≠ implementer.** Gate integrity requires that the agent performing the work is not the same as the agent approving it. This constraint is absolute.
2. **Supervisor = directing party is permitted.** In solo configurations one person can occupy both roles — the supervisor's value (cadence-driven vigilance, routine gate absorption) still applies, just without a second party. In fuller configurations the supervisor is an agent and the human only consumes its synthesis and exercises the gates it cannot.

Gate authority therefore has a fixed floor (Vision + Features always with the directing party) and a configurable ceiling for the supervisor (Tasks always, Epics by default, Features and Vision never).

### Retrospective adoption

Shannon does not require a greenfield project. It can be adopted into an existing codebase with pre-existing capabilities — the framework captures those capabilities as Retrospective Features (ELABORATED + STABLE), with each Feature's Activity Log recording that initial implementation predates Shannon's adoption. Future evolution then proceeds through Epics in the standard way. This means both personas above can adopt Shannon mid-project, not only at first commit; "from adoption through full maturity" includes both cases.

---

## Success Metrics

Outcomes that indicate the vision is being realised. Split honestly: targets we can instrument now sit alongside commitments that guide judgement without yet having a measurement path.

### Measurable Targets

Targets with a clear instrumentation path. Each names what is measured and how.

- **Setup time** — From `/shannon-setup` to first task in PLANNED status: under 5 minutes. *Measured by timestamps on `/shannon-setup` invocation and first Gate 2 approval.*
- **Planning approval rate** — AI-drafted plans approved at Gate 2 without revision: 80%+. *Measured by tracking Gate 2 approvals versus revision cycles in the work-item Activity Log.*
- **Documentation upkeep ratio** — Session time spent in `/document-*` commands: under 10% of total session time. *Measured with session-time tracking on document-related commands (requires instrumentation in the project-documentation skill).*

### Directional Targets

Commitments without a clean measurement path. They guide judgement when measurable targets conflict, and become candidates for future instrumentation.

- **Context retrieval relevance** — The AI surfaces the right documents during elaboration and planning. The framework's value depends on this being true; a useful proxy is whether the user has to redirect the AI to additional documents during a workflow.
- **Alignment drift detection** — Drift between layers is caught before it becomes expensive to fix. "Expensive" is judgement, not metric — the commitment is that drift surfaces in days, not refactors.
- **Resume latency** — A developer returning after weeks away reaches full context quickly. "Full context" is subjective; the commitment is that mandated documents plus indexes are enough to rebuild context without re-reading conversation history.

---

## Future Vision

Beyond solo development: Shannon's coherence model — explicit authority graphs, unified work item lifecycles, AI-managed cross-references — is a candidate for any setting where humans direct AI on long-running projects. Knowledge workers managing research programmes, designers running multi-month projects, technical writers maintaining living documentation, operators of long-horizon agent fleets — all face variants of the same context-management problem.

The framework deliberately avoids language and framework lock-in. Markdown files, conventional directory layouts, and Claude Code slash commands are the only requirements. The bet is that what Shannon does for software projects can extend, with little adaptation, to any structured creative endeavour.

The supervisor role generalises naturally: any setting where humans direct long-running AI work benefits from continuous vigilance over alignment, lifecycle, and opportunity. Shannon's supervisor pattern is portable to any domain that adopts the rest of the framework.

---

## Version History

### 2026-05-28 - v2.4

- **Introduced the supervisor as a third role**, distinct from the implementer and optionally distinct from the directing party. Added Core Principle 5 (Continuous Health Vigilance), a new Key Feature (Supervisor Role), a new Target Users subsection (*Three roles, configurably separable*) replacing the prior *The directing role is separable* subsection, an extension to the Vision Statement, and an extension to Future Vision
- **Codified gate-authority split**: Vision + Features always with the directing party (fixed floor); Tasks always with the supervisor; Epics with the supervisor by default but reservable by the directing party per project. Supervisor may auto-promote scratchpad items to Tasks; scratchpad-to-Epic promotion requires directing-party approval
- **Hard constraint**: supervisor ≠ implementer (gate integrity preserved). **Soft constraint**: supervisor = directing party is permitted in solo configurations
- Tightened Principle 2 and the prior *Directing role is separable* subsection to remove the naming collision: "supervising agent" wording reframed as "an agent acting in the directing-party role." The term *supervisor* is now reserved for the new role
- Treated as additive amendment per conceptual_design v1.3 § Re-reviewing — preserves prior commitments (gate integrity, supervisor ≠ implementer, all four prior principles) and extends them. DRAFT transit elected as the cautious path per § Re-reviewing → *when uncertain, treat as substantive*; the classification remains additive (no prior approved claim contradicted)
- Rationale: the framework's promise of "drift in days" needs a continuous mechanism, and the directing party's time is the framework's scarcest resource — the supervisor exists to protect both. Naming the supervisor at vision level unblocks the downstream cascade (technology_stack tooling, conceptual_design role model, technical_design, FEAT-009 and its Epics) without each having to argue its own warrant
- Status: APPROVED (2026-05-28). G1 alignment review surfaced one required pre-approval fix at Key Features § Three Quality Gates (completed the naming-collision sweep that the rest of the amendment retires) plus copy edits / altitude-lift at the supervisor Key Feature (invocation modes phrased as cadence-pattern abstract rather than mechanism-specific). Downstream cascade preview: technology_stack + conceptual_design re-reviewable in parallel (conceptual_design heaviest — Glossary entry, Three Hard Gates rule rework, Gate Authority Split as new Business Rule, Supervisor Report domain-model decision); technical_design after both; development_guide + ux_guide after technical_design.

### 2026-05-19 - v2.3

- Sharpened Principle 4: renamed from "Living Documentation" to **"Adaptive Coherence"**; expanded to commit to three faces of the framework's adaptive promise — drift resolution (not just detection), retrospective adoption elevated to principle level, framework evolution (new attributes / workflows) absorbed by existing artefacts via the same review mechanisms
- Treated as additive amendment per conceptual_design v1.3 § Re-reviewing — preserves prior commitments (authoritative reviewed context, drift caught early, knowledge accumulation) and extends them; doc remains APPROVED
- Rationale: the framework's value depends on its capacity to absorb change. Greenfield-only commitment failed to name adoption of existing projects, in-flight gap correction, and forward-compatibility with framework evolution as core promises. This sharpening makes the commitment explicit so downstream artefacts (features, epics) can be measured against it
- Status: APPROVED (2026-05-19)

### 2026-05-18 - v2.2

- Re-review triggered by downstream evolution since v2.1 (conceptual_design v1.2 *Retrospective Features* business rule and creation of FEAT-002 through FEAT-007, especially FEAT-007 Lightweight Idea Capture which had no Vision § Key Features anchor)
- **G1**: Added "Lightweight Idea Capture" as a 5th Key Feature, naming the scratchpad pattern as a Shannon capability and giving FEAT-007 its Vision Reference home
- **G2**: Added "Retrospective adoption" subsection to Target Users, recognising that Shannon can be applied to existing projects (per the new Retrospective Features business rule); both Architect and Gardener personas can adopt Shannon mid-project, not only at first commit
- **S1**: Vision Statement updated — "from first commit through full maturity" → "from adoption through full maturity" — widens scope to match the adoption case
- Status: APPROVED (2026-05-18). First successful exercise of the re-approval-after-upstream-change pattern (G3 scratchpad item); informs the formal workflow that's still to be drafted in conceptual_design

### 2026-05-15 - v2.1

- Applied Gate 1 review findings:
  - Softened Traceability principle ("every line of code" → "code traces back to tasks")
  - Removed two implementation-leak features from Key Features ("Commands + Skills + Subagents" and "Document Authority Graph") — they live in technical_design.md
  - Tightened Living Documentation principle to value-only, removed DRAFT/APPROVED workflow detail
  - Split Success Metrics into Measurable Targets (with instrumentation methodology) and Directional Targets (commitments without measurement)
  - Renamed Principle 2 from "Strategic Human Review" to "Strategic External Review"; opened the directing role to supervising agents distinct from the implementer
  - Added "The directing role is separable" subsection to Target Users, naming the supervisor ≠ implementer constraint
- Status: APPROVED (2026-05-15)

### 2026-05-15 - v2.0

- Restructured to new Vision template (Problem / Vision / Principles / Features / Users / Metrics / Future)
- Re-articulated problem framing around AI context management as the new bottleneck
- Added "Commands + Skills + Subagents" and "Document Authority Graph" as key features
- Status: superseded by v2.1 before approval

### 2025-11-09 - v1.0

- Initial product requirements created (previous structure: PRD with pillars, capability areas, user stories)
- Defined two personas: Architect Dev and Gardener Dev
- Established four product pillars (now Core Principles)
- Status: APPROVED (2025-11-09)
