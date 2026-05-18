# Product Vision

**Status**: APPROVED
**Last Reviewed**: 2026-05-18
**Approved**: 2026-05-18

---

**Product Name**: Shannon

## Problem Statement

AI-assisted development has unlocked unprecedented productivity for solo developers, but the bottleneck has shifted. The constraint is no longer "can the AI write the code" — it's "does the AI have the right context, and does the code stay aligned with the intent that motivated it?"

Working with AI today, solo developers face a recurring set of failures: the AI forgets past decisions and re-asks settled questions; it makes choices inconsistent with earlier work; the implementation drifts from the conceptual design and nobody notices until a refactor is needed; documentation falls behind reality, then becomes untrustworthy, then gets ignored. The standard answer — "put it in the prompt" — collapses under the weight of a real project.

The result is the same productivity tax that plagued teams before AI: the developer becomes a human router, ferrying context between sessions, between documents, between intent and code. The AI does the cheap work; the human does the expensive work of staying coherent.

---

## Vision Statement

Shannon is the framework that lets solo developers and knowledge workers build high-quality software with AI in a sustained state of flow. The implementing AI carries the burden of documentation, context, and coherence; a directing party — human, or a supervising agent distinct from the implementer — supplies vision and review at high-leverage gates. Projects built with Shannon stay aligned to their intent from adoption through full maturity, without the directing party ever having to remember which document said what.

---

## Core Principles

### 1. **Automated Context Management**

The implementing AI reads, maintains, and cross-references documentation. The directing party directs, reviews, and decides. The framework shoulders the bookkeeping so the directing party can focus on vision and trade-offs, not on which document needs to be updated next.

### 2. **Strategic External Review**

Three quality gates at high-leverage points — requirements elaboration, implementation planning, and completion review. No code review, no micromanagement. A directing party intervenes where independent judgement compounds; the implementer handles the rest. The directing party is most often a human, but may be a supervising agent — provided that supervisor is *not* the same agent doing the implementation. The framework treats supervision as a role, not a species.

### 3. **Complete Traceability**

Code traces back to tasks; tasks to epics or features; features to the vision. Nothing significant gets built without a clear "why." The framework makes drift between intent and implementation visible before it becomes expensive.

### 4. **Living Documentation**

Documentation evolves with understanding. Reviewed context is treated as authoritative; drift between layers is caught early; knowledge accumulates so the same investigation never happens twice.

---

## Key Features

- **Mandated Project Documentation** — Six core documents (vision, technology stack, conceptual design, technical design, development guide, UX guide) that together describe the project at every relevant scope, with explicit authority relationships between them.

- **Unified Work Item Model** — Features, Epics, Tasks, and Spikes share a single status lifecycle and a single file structure. Learn the model once; apply it everywhere.

- **Three Quality Gates** — Explicit approval gates at requirements elaboration, planning, and completion. Built into the lifecycle, not bolted on. Approval comes from a directing party — human, or a supervising agent distinct from the implementer.

- **Knowledge Base** — Research notes, implementation details, and document extensions captured as the project runs. Spikes produce knowledge notes as their primary output.

- **Lightweight Idea Capture** — A pre-workflow scratchpad (`docs/scratchpad.md`) for ideas, half-formed work, and unprocessed TODOs that don't yet belong to a formal work item. Items get processed periodically: promoted to Features, Epics, Tasks, or Spikes; moved to knowledge notes when they harden into durable findings; or dropped. The scratchpad is the deliberate middle between losing thoughts and forcing premature classification.

---

## Target Users

### Architect Dev — Solo developer with a strong existing vision

The Architect arrives with a formed product idea, often supported by conceptual models, existing artefacts, or domain expertise. They move methodically: solid requirements first, then conceptual design, then technical design, then implementation prepared for the final product to emerge. They want to ensure the AI's implementation respects the conceptual model and considers future requirements they have already anticipated. They do not want to review or hand-edit code.

### Gardener Dev — Solo developer exploring the problem and feature space

The Gardener starts with an unrefined idea and wants to explore it through iterative development. They expect their requirements and conceptual model to evolve as they learn. They rely on AI to fill in details and to help them notice when their evolving vision contradicts their earlier work. They may hold off on testing and rigour until they decide to commit to bringing the product to completion.

Both personas direct AI rather than write code themselves. The framework must make AI implementation trustworthy enough that line-by-line code review is the exception rather than the norm.

### The directing role is separable

The framework treats "directing party" as a role, not a person. A human (Architect or Gardener) is the most common occupant. A supervising agent — distinct from the agent doing the implementation — can occupy the same role, opening multi-agent configurations in which one AI directs and another implements, with a human at the top of the chain. The integrity of the gates depends on a single constraint: **the supervisor must not be the same agent as the implementer**. Independence of judgement is what the gates protect; collapsing the two collapses the gate.

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

---

## Version History

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
