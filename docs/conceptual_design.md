# Conceptual Design

**Status**: DRAFT
**Last Reviewed**: 2026-05-15

---

**Project Name**: Shannon

## Glossary

- **Work Item** — Any of the four types of work-tracking entity in Shannon: Feature, Epic, Task, Spike. All share a common lifecycle and file structure.
- **Mandated Document** — One of the six core project documents that together describe the project. Vision, technology stack, conceptual design, technical design, development guide, UX guide.
- **Quality Gate** — An explicit human approval point in a work item's lifecycle. Three gates exist: requirements (Gate 1), planning (Gate 2), completion (Gate 3).
- **Authority Graph** — The directed relationship between documents. Lower documents must align to and enable higher ones.
- **Skill** — A reusable unit of framework logic, with templates, invoked by commands. Skills are where Shannon's behaviour lives.
- **Command** — A user-invoked entry point. Thin — its job is to identify what to do and delegate to a skill.
- **Subagent** — An ephemeral AI process spawned by a skill to handle context-heavy reading without bloating the main conversation.
- **Knowledge Note** — A captured piece of research, implementation detail, or document extension. Lives in the knowledge base.

---

## Domain Model

### Project

A Shannon-managed software project. Contains a vision, mandated documents, work items, and knowledge.

**Attributes**:

- **Vision** — The product vision that all other content elaborates
- **Mandated Documents** — The six core documents describing the project
- **Work Items** — Features, Epics, Tasks, and Spikes
- **Knowledge Base** — Notes capturing learnings and elaborations

**Relationships**:

- Contains exactly one **Vision**
- Contains zero or more **Mandated Documents** (vision is always present; others as relevant)
- Contains zero or more **Features**, **Tasks**, **Spikes** (Epics exist under Features)
- Contains zero or more **Knowledge Notes**

### Work Item

The collective name for the four work-tracking entities. Each work item describes work to be done (or, in the case of Features, an enduring capability of the product).

**Attributes**:

- **Status** — Current position in the unified lifecycle
- **Type** — Feature, Epic, Task, or Spike
- **Parent** — Higher-level work item this belongs to (where applicable)
- **Requirements** — The "what" and "why"
- **Plan** — The "how"
- **Activity Log** — Timestamped history

**Relationships**:

- Belongs to a **Project**
- May have a **Parent** work item (Epics → Features, Tasks → Epics)
- May reference **Mandated Documents** and **Knowledge Notes** as context

### Feature

A persistent capability of the product — what the product IS, not work to be done.

**Attributes**:

- **Vision Reference** — The vision section this feature elaborates
- **Activity** — STABLE (no epic in progress) or ACTIVE (epic in progress)
- **Epics** — The accumulated history of work delivering this feature

**Relationships**:

- Elaborates the **Vision**
- Contains zero or more **Epics**

### Epic

A coherent unit of work delivering part of a feature's ideal state. Epics replace the older "phases" concept.

**Attributes**:

- **Parent Feature** — The feature this epic delivers against
- **Tasks** — The atomic work units that make up this epic

**Relationships**:

- Belongs to a **Feature**
- Contains zero or more **Tasks**
- Remains as a historical record once APPROVED

### Task

A discrete development assignment. The atomic unit of implementation work, completable in a single focused session.

**Attributes**:

- **Parent Epic** — The epic this task belongs to (or *orphan* for one-off work)
- **Acceptance Criteria** — Specific, testable success criteria

**Relationships**:

- Belongs to an **Epic**, or is *orphan*
- May reference a **Feature** when orphaned or when its epic chain is implicit

### Spike

Time-boxed exploratory work whose primary output is knowledge, not implementation.

**Attributes**:

- **Question** — The uncertainty this spike will reduce
- **Time-box** — Hours, not days
- **Output** — A knowledge note

**Relationships**:

- Optionally references a **Feature** for context
- Produces exactly one **Knowledge Note**

### Mandated Document

One of the six core project documents. Each has a defined purpose, scope, and authority relationship to other documents.

**Attributes**:

- **Status** — DRAFT or APPROVED
- **Authority** — Position in the document authority graph

**Relationships**:

- Authority graph: `Vision → {Technology Stack, Conceptual Design} → Technical Design → {Development Guide, UX Guide}`
- Each document must align to and enable the documents above it in the graph

### Knowledge Note

A captured piece of project knowledge that doesn't belong in a mandated document.

**Attributes**:

- **Type** — Research, Implementation Details, or Extension
- **Related** — The mandated doc section, work item, or other note this connects to

**Relationships**:

- Belongs to a **Project**'s knowledge base
- May extend a **Mandated Document** (Extension type)
- May be produced by a **Spike**

---

## Business Rules

- **Single Vision Authority** — Every project has exactly one Vision document, and it is the supreme authority. All other documents and work items must align to it.

- **Document Alignment Direction** — Lower documents in the authority graph must enable higher documents. A technology stack cannot specify desktop-only technology if the vision describes a web application. Drift between layers is a defect.

- **Work Items Consume Guides** — The Development Guide and UX Guide are reference material. Work items consume them; they are not updated by work items. Updates to guides happen through `/document-create` or `/document-review` flows.

- **Higher Work Items May Update Mid-Level Docs** — Features and Epics may elaborate the Technical Design when planning. Tasks only consume documents; they do not update them.

- **Unified Status Lifecycle** — All work items move through the same status sequence: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. No work item type has a unique lifecycle.

- **Three Hard Gates** — DRAFT → ELABORATED, ELABORATED → PLANNED, and REVIEW → APPROVED transitions require explicit user approval. AI cannot self-approve across a gate.

- **Iterative Implementation Zone** — Between IMPLEMENTING, IMPLEMENTED, and REVIEW, AI and user iterate freely without gates. Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone.

- **Spike Output Is Knowledge** — A spike's durable artefact is its knowledge note. The spike file itself is the activity record and is disposable.

- **Approved Tasks Are Archived** — Tasks that reach APPROVED are moved to `./docs/tasks/archive/`. Epics, Features, and Spikes remain in place as historical records.

- **DRAFT Documents Are Not Authoritative** — AI must treat DRAFT mandated documents as not-yet-trustworthy context. Only APPROVED documents are authoritative.

---

## Key Workflows

### Creating and Approving a Mandated Document

**Goal**: Establish a piece of project context that AI can rely on.

**Flow**:

1. User invokes `/document-create [type]`
2. Skill instantiates the relevant template into `./docs/`
3. User and AI elaborate the document collaboratively
4. User invokes `/document-review [path]`
5. Skill verifies alignment with higher documents
6. User explicitly approves; status transitions DRAFT → APPROVED

**Rules applied**: Document Alignment Direction; DRAFT Documents Are Not Authoritative.

### Taking a Task from Idea to Approval

**Goal**: Deliver a single unit of implementation work.

**Flow**:

1. `/task-create [hint]` — Task captured in DRAFT
2. `/task-elaborate` — Subagent reads parent Epic, Feature, and relevant Guides; drafts Requirements; **Gate 1**: user approves → ELABORATED
3. `/task-plan` — Subagent reads Development Guide and Technical Design; drafts Plan; **Gate 2**: user approves → PLANNED
4. `/task-implement` — AI executes the plan; status IMPLEMENTING → IMPLEMENTED, possibly iterating through REVIEW
5. `/task-review` — Verification against acceptance criteria; **Gate 3**: user approves → APPROVED; task moved to archive

**Rules applied**: Three Hard Gates; Work Items Consume Guides; Approved Tasks Are Archived.

### Running a Spike to Reduce Uncertainty

**Goal**: Answer a specific question that's blocking decisions on a Feature or Epic.

**Flow**:

1. `/spike-create [hint]` — Spike captured in DRAFT, time-box estimated
2. `/spike-elaborate` — Question and expected output sharpened; **Gate 1** → ELABORATED
3. `/spike-plan` — Investigation approach defined; **Gate 2** → PLANNED
4. `/spike-implement` — Investigation runs within time-box; findings captured in Investigation Notes
5. Knowledge note produced and indexed; recommendation captured in spike
6. `/spike-review` — **Gate 3** → APPROVED; spike file remains as activity record, knowledge note is the durable artefact

**Rules applied**: Spike Output Is Knowledge; Three Hard Gates.

---

## Version History

### 2026-05-15 - v1.0

- Initial conceptual design drafted as part of refactor
- Status: DRAFT
