# Product Vision

**Status**: DRAFT
**Last Reviewed**: 2026-05-15

---

**Product Name**: Shannon

## Problem Statement

AI-assisted development has unlocked unprecedented productivity for solo developers, but the bottleneck has shifted. The constraint is no longer "can the AI write the code" — it's "does the AI have the right context, and does the code stay aligned with the intent that motivated it?"

Working with AI today, solo developers face a recurring set of failures: the AI forgets past decisions and re-asks settled questions; it makes choices inconsistent with earlier work; the implementation drifts from the conceptual design and nobody notices until a refactor is needed; documentation falls behind reality, then becomes untrustworthy, then gets ignored. The standard answer — "put it in the prompt" — collapses under the weight of a real project.

The result is the same productivity tax that plagued teams before AI: the developer becomes a human router, ferrying context between sessions, between documents, between intent and code. The AI does the cheap work; the human does the expensive work of staying coherent.

---

## Vision Statement

Shannon is the framework that lets solo developers and knowledge workers build high-quality software with AI in a sustained state of flow. The AI carries the burden of documentation, context, and coherence; the human supplies vision and review at high-leverage gates. Projects built with Shannon stay aligned to their intent from first commit through full maturity, without the developer ever having to remember which document said what.

---

## Core Principles

### 1. **Automated Context Management**

AI reads, maintains, and cross-references documentation. Humans direct, review, and decide. The framework shoulders the bookkeeping so the developer can focus on vision and trade-offs, not on which document needs to be updated next.

### 2. **Strategic Human Review**

Three quality gates at high-leverage points — requirements elaboration, implementation planning, and completion review. No code review, no micromanagement. Humans intervene where their judgement compounds; AI handles the rest.

### 3. **Complete Traceability**

Every line of code traces back to a task, every task to an epic or feature, every feature to the vision. Nothing gets built without a clear "why." The framework makes drift between intent and implementation visible before it becomes expensive.

### 4. **Living Documentation**

Documentation evolves with understanding. A DRAFT → APPROVED workflow ensures AI only treats human-reviewed context as authoritative. Alignment checks catch drift between layers. Knowledge notes capture learnings so the same investigation never has to happen twice.

---

## Key Features

- **Mandated Project Documentation** — Six core documents (vision, technology stack, conceptual design, technical design, development guide, UX guide) that together describe the project at every relevant scope, with explicit authority relationships between them.

- **Unified Work Item Model** — Features, Epics, Tasks, and Spikes share a single status lifecycle and a single file structure. Learn the model once; apply it everywhere.

- **Three Quality Gates** — Explicit human approval gates at requirements elaboration, planning, and completion. Built into the lifecycle, not bolted on.

- **Commands + Skills + Subagents** — A thin command layer for user invocation, reusable skills that encode framework logic and templates, and subagents that handle context-heavy reading without bloating the main conversation.

- **Knowledge Base** — Research notes, implementation details, and document extensions captured as the project runs. Spikes produce knowledge notes as their primary output.

- **Document Authority Graph** — Explicit rules about which documents must align to which others, and which work items may update which documents at which stages.

---

## Target Users

### Architect Dev — Solo developer with a strong existing vision

The Architect arrives with a formed product idea, often supported by conceptual models, existing artefacts, or domain expertise. They move methodically: solid requirements first, then conceptual design, then technical design, then implementation prepared for the final product to emerge. They want to ensure the AI's implementation respects the conceptual model and considers future requirements they have already anticipated. They do not want to review or hand-edit code.

### Gardener Dev — Solo developer exploring the problem and feature space

The Gardener starts with an unrefined idea and wants to explore it through iterative development. They expect their requirements and conceptual model to evolve as they learn. They rely on AI to fill in details and to help them notice when their evolving vision contradicts their earlier work. They may hold off on testing and rigour until they decide to commit to bringing the product to completion.

Both personas share one thing: they do not write or review code. The framework must make AI implementation trustworthy enough that human code review is the exception, not the norm.

---

## Success Metrics

- **Setup time** — From `/shannon-setup` to first ready-to-implement task: under 5 minutes
- **Context retrieval** — AI surfaces the relevant documentation context during elaboration and planning 95%+ of the time
- **Alignment drift** — Drift between conceptual design and technical implementation caught within 2-4 weeks, before it becomes expensive
- **Maintenance overhead** — Developers spend <10% of session time on documentation upkeep; the framework handles the rest
- **Planning approval rate** — AI-drafted plans approved without changes 80%+ of the time (signal that the AI read the right docs)
- **Resume latency** — A developer returning after weeks away reaches full context in under 10 minutes

---

## Future Vision

Beyond solo development: Shannon's coherence model — explicit authority graphs, unified work item lifecycles, AI-managed cross-references — is a candidate for any setting where humans direct AI on long-running projects. Knowledge workers managing research programmes, designers running multi-month projects, technical writers maintaining living documentation, operators of long-horizon agent fleets — all face variants of the same context-management problem.

The framework deliberately avoids language and framework lock-in. Markdown files, conventional directory layouts, and Claude Code slash commands are the only requirements. The bet is that what Shannon does for software projects can extend, with little adaptation, to any structured creative endeavour.

---

## Version History

### 2026-05-15 - v2.0

- Restructured to new Vision template (Problem / Vision / Principles / Features / Users / Metrics / Future)
- Re-articulated problem framing around AI context management as the new bottleneck
- Added "Commands + Skills + Subagents" and "Document Authority Graph" as key features
- Status: DRAFT (re-elaboration pending review)

### 2025-11-09 - v1.0

- Initial product requirements created (previous structure: PRD with pillars, capability areas, user stories)
- Defined two personas: Architect Dev and Gardener Dev
- Established four product pillars (now Core Principles)
- Status: APPROVED (2025-11-09)
