# Conceptual Design

**Status**: APPROVED
**Last Reviewed**: 2026-05-19
**Approved**: 2026-05-19

---

**Project Name**: Shannon

## Glossary

- **Work Item** — Any of the four types of work-tracking entity in Shannon: Feature, Epic, Task, Spike. All share a common lifecycle and file structure.
- **Mandated Document** — One of the six core project documents that together describe the project. Vision, technology stack, conceptual design, technical design, development guide, UX guide.
- **Quality Gate** — An explicit approval point in a work item's lifecycle, decided by the directing party. Three gates exist: requirements (Gate 1), planning (Gate 2), completion (Gate 3).
- **Directing Party** — The role that directs, reviews, and approves at gates. May be a human, or a supervising agent distinct from the implementer. The framework treats supervision as a role, not a species.
- **Implementer** — The agent that executes work (elaboration drafts, planning drafts, implementation). At any given gate, the implementer cannot be the directing party — independence of judgement is what the gate protects.
- **Authority Graph** — The directed relationship between documents. Lower documents must align to and enable higher ones.
- **Skill** — A reusable unit of framework logic, with templates, invoked by commands. Skills are where Shannon's behaviour lives.
- **Command** — A user-invoked entry point. Thin — its job is to identify what to do and delegate to a skill.
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

- **Unified Status Lifecycle** — All work items move through the same status sequence: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. No work item type has a unique lifecycle. Features additionally carry an orthogonal `Activity` attribute (STABLE / ACTIVE) describing whether an epic is in progress *under* the feature; this is descriptive state, not a lifecycle stage.

- **Three Hard Gates** — DRAFT → ELABORATED, ELABORATED → PLANNED, and REVIEW → APPROVED transitions require explicit approval by the directing party. The implementer cannot approve its own work across a gate; see *Supervisor Distinct From Implementer*.

- **Supervisor Distinct From Implementer** — The directing party at any gate must not be the same agent as the implementer at that gate. A human is the most common directing party; a supervising agent (an AI distinct from the implementing AI) is also valid. Collapsing the two roles collapses the gate.

- **Iterative Implementation Zone** — Between IMPLEMENTING, IMPLEMENTED, and REVIEW, the implementer and the directing party iterate freely without gates. Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone.

- **Retrospective Features** — When Shannon is applied to an existing project, the project's pre-existing capabilities should be captured as Features even though their initial implementation predates Shannon's adoption. Such Features start in ELABORATED status (the description is reviewed and matches reality) with Activity: STABLE (no epic in progress), and their Activity Log records that initial implementation happened outside Shannon's lifecycle. Future evolution proceeds through Epics in the standard way. A Feature may also be *partially* retrospective: existing capability documented, with a clear next Epic for remaining work. The framework treats retrospective and forward-built Features identically once they reach ELABORATED — the distinction is historical, captured in the Activity Log and the Feature's `Initial Implementation` field.

- **Spike Output Is Knowledge** — A spike's durable artefact is its knowledge note. The spike file itself is the activity record and is disposable.

- **Approved Tasks Are Archived** — Tasks that reach APPROVED are moved to `./docs/tasks/archive/`. Epics, Features, and Spikes remain in place as historical records.

- **DRAFT Documents Are Not Authoritative** — AI must treat DRAFT mandated documents as not-yet-trustworthy context. Only APPROVED documents are authoritative.

---

## Key Workflows

### Creating and Approving a Mandated Document

**Goal**: Establish a piece of project context that AI can rely on.

**Flow**:

1. Directing party invokes `/document-create [type]`
2. Skill instantiates the relevant template into `./docs/`
3. Directing party and implementer elaborate the document collaboratively
4. Directing party invokes `/document-review [path]`
5. Skill verifies alignment with higher documents
6. Directing party explicitly approves; status transitions DRAFT → APPROVED

**Rules applied**: Document Alignment Direction; DRAFT Documents Are Not Authoritative; Supervisor Distinct From Implementer.

### Taking a Task from Idea to Approval

**Goal**: Deliver a single unit of implementation work.

**Flow**:

1. `/task-create [hint]` — Task captured in DRAFT
2. `/task-elaborate` — Implementer reads parent Epic, Feature, and relevant Guides; drafts Requirements; **Gate 1**: directing party approves → ELABORATED
3. `/task-plan` — Implementer reads Development Guide and Technical Design; drafts Plan; **Gate 2**: directing party approves → PLANNED
4. `/task-implement` — Implementer executes the plan; status IMPLEMENTING → IMPLEMENTED, possibly iterating through REVIEW
5. `/task-review` — Verification against acceptance criteria; **Gate 3**: directing party approves → APPROVED; task moved to archive

**Rules applied**: Three Hard Gates; Supervisor Distinct From Implementer; Work Items Consume Guides; Approved Tasks Are Archived.

### Capturing Knowledge as the Project Runs

**Goal**: Preserve findings, decisions, and implementation details so the same investigation never has to happen twice. Elaborates Vision § Adaptive Coherence.

**Flow**:

1. Implementer or directing party identifies a piece of knowledge worth persisting — a research finding, an implementation gotcha, a decision rationale, or an elaboration of a mandated-doc section that does not belong inline
2. `/document-create knowledge` instantiates a Knowledge Note from the template into `./docs/knowledge/`
3. Note is classified: **Research** (general comparison), **Implementation Details** (project-specific approach), or **Extension** (deep elaboration of a mandated-doc section)
4. Implementer drafts the content and adds a one-line entry to `knowledge_index.md`
5. Cross-references added from the originating work item (in its Implementation Notes or Activity Log) and from any mandated doc the note extends
6. Future workflows discover the note via the index when reading context for elaboration or planning

**Rules applied**: Spike Output Is Knowledge (when a spike is the source). Knowledge notes are not gated artefacts — they are working knowledge, not reviewed context.

### Re-reviewing an APPROVED Mandated Document

**Goal**: Refresh an APPROVED document when downstream evolution, an upstream cascade, or a surfaced gap means it no longer faithfully describes the project. The mechanism preserves the authority graph by re-passing Gate 1.

**Triggers**:

- **Downstream evolution** — a feature, epic, or sibling document has elaborated capabilities the document should ratify (e.g. a new Key Feature surfaced by a work item)
- **Upstream cascade** — a higher-authority document was just approved with changes that may affect this one
- **Surfaced gap** — a work item or review explicitly flagged a missing anchor (e.g. a Feature whose Vision Reference does not resolve)
- **Periodic** — time-based reviews if the project chooses to do them (not framework-mandated)

**Flow**:

1. Trigger identified; directing party invokes `/document-review [path]` on the APPROVED document
2. Skill spawns an alignment subagent reading the target document plus its authority-graph neighbours, with the specific trigger named in the prompt
3. Subagent returns findings using the canonical four-category schema (Drift / Gap / Internal contradiction / Strength)
4. Directing party reviews findings and decides which to apply inline, which to defer to scratchpad, and which to ignore
5. Implementer applies the approved changes plus any cascading updates (e.g. work-item Vision References that should now point to the new content)
6. **Gate 1**: directing party explicitly approves the new version
7. Version bumps — minor (e.g. v2.1 → v2.2) for additive amendments, major (e.g. v1.0 → v2.0) for substantive revisions
8. Per development_guide § Commit Cadence, the version bump and cascading updates ship in a single commit

**Status semantics**:

- **Additive amendment** — content that does not contradict existing approved claims. The document stays APPROVED through the edit; the version history records the new version and a new approval date
- **Substantive revision** — content that contradicts existing approved claims and resolves the contradiction. The document transitions APPROVED → DRAFT for the duration of the revision, returning to APPROVED via Gate 1

When uncertain, treat as substantive (the more cautious path).

**Rules applied**: Document Alignment Direction; DRAFT Documents Are Not Authoritative; Three Hard Gates; Supervisor Distinct From Implementer.

### Responsible Promotion

**Goal**: Ensure that work created downstream traces to an upstream aspiration. Before creating an Epic or Task to address a recognised gap, verify (or update) the parent Feature, Vision, or relevant document so the work corresponds to something an upstream commitment requires. Otherwise drift becomes silent: the work gets done but is not traceable; if the work is omitted, no review can detect the gap. Elaborates Vision § Adaptive Coherence (specifically the "drift caught early and resolved" commitment).

**Triggers** *(loose-coupled — any of these surfaces a gap)*:

- A scratchpad item ripens into actionable work
- A review of an existing document or work item surfaces a finding
- A directly-recognised functional gap during normal use of the framework
- Anticipation of framework evolution (e.g. a future Shannon version introduces a new attribute that existing projects must accommodate)

The scratchpad is one valid input, not the gatekeeper. Gaps flow into this workflow directly from any of the triggers above.

**Flow**:

1. Gap identified by any trigger
2. Identify the natural parent for the work — usually a Feature in the existing set; occasionally a new Feature is required
3. Read the parent Feature's Ideal State and the Vision principle(s) it derives from
4. **Decision**: does the parent aspire to the work?
   - **Yes** — the Ideal State explicitly requires the capability the work delivers → proceed to step 6
   - **No** — the Ideal State does not name the capability → step 5
5. Re-elaborate the parent (and, if necessary, re-review the Vision principle the parent derives from) to add aspirational criteria the proposed work will fulfil. Use the *Re-reviewing an APPROVED Mandated Document* workflow for documents; for work items, re-elaboration follows the analogous pattern (canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap)
6. Create the downstream work (Epic, Task) with Acceptance Criteria that explicitly fulfil the upstream aspiration
7. If the gap was first captured in the scratchpad, move that item to Processed pointing at the new downstream artefact

**Why this matters**: the framework's self-correcting property depends on upstream aspirations being specific enough that downstream omissions register as drift. Creating downstream work that no upstream artefact requires breaks the chain — the work exists but cannot be missed by a future alignment check.

**Rules applied**: Document Alignment Direction; Three Hard Gates (at each upstream re-approval or downstream creation).

### Running a Spike to Reduce Uncertainty

**Goal**: Answer a specific question that's blocking decisions on a Feature or Epic.

**Flow**:

1. `/spike-create [hint]` — Spike captured in DRAFT, time-box estimated
2. `/spike-elaborate` — Question and expected output sharpened; **Gate 1**: directing party approves → ELABORATED
3. `/spike-plan` — Investigation approach defined; **Gate 2**: directing party approves → PLANNED
4. `/spike-implement` — Implementer runs investigation within time-box; findings captured in Investigation Notes
5. Knowledge note produced and indexed; recommendation captured in spike
6. `/spike-review` — **Gate 3**: directing party approves → APPROVED; spike file remains as activity record, knowledge note is the durable artefact

**Rules applied**: Spike Output Is Knowledge; Three Hard Gates; Supervisor Distinct From Implementer.

---

## Version History

### 2026-05-19 - v1.4

- Added Key Workflow **Responsible Promotion** — names the canonical flow from gap-recognition to downstream work-item creation, with explicit step 4 ("does the parent aspire to the work?") and step 5 (re-elaborate upstream first if not). Loose-coupled triggers — scratchpad, review finding, in-flight realisation, anticipated framework evolution — capture the user's point that scratchpad must not be the gatekeeper for upstream updates
- Elaborates Vision § Adaptive Coherence (Vision v2.3 commit `7c117d4`): the workflow is the operational mechanism by which Vision's commitment to drift resolution becomes day-to-day practice
- Reference refresh: § Capturing Knowledge as the Project Runs → "Elaborates Vision § Adaptive Coherence" (was Living Documentation); cascading from the Vision v2.3 rename
- Treated as additive amendment per § Re-reviewing — non-contradictory addition; doc remains APPROVED
- Status: APPROVED (2026-05-19)

### 2026-05-18 - v1.3

- Added Key Workflow **Re-reviewing an APPROVED Mandated Document** — canonises the pattern prototyped during the Vision v2.2 re-review (commit `3a65a73`). Covers four triggers (downstream evolution, upstream cascade, surfaced gap, periodic), names the additive-amendment vs substantive-revision distinction with corresponding status semantics, and ties to existing rules (Document Alignment Direction, DRAFT Documents Are Not Authoritative, Three Hard Gates, Supervisor Distinct From Implementer)
- Resolves scratchpad item G3 ("Workflow: Re-approval of APPROVED Docs After Upstream Change"); partially addresses G1 ("Workflow: Alignment Drift Detection") since drift detection now has a named conceptual workflow when it happens *during* a review
- Treated as an additive amendment per the new workflow's own semantics — non-contradictory addition; doc stays APPROVED
- Status: APPROVED (2026-05-18)

### 2026-05-18 - v1.2

- Added business rule **Retrospective Features** — names the case where Shannon is applied to an existing project and pre-existing capabilities are captured as Features starting in ELABORATED + STABLE. Also covers partially-retrospective Features (existing capability + clear next Epic). Surfaced during the dogfood exercise when creating FEAT-002 through FEAT-007 to represent Shannon's own capabilities-to-date.
- Status: APPROVED (in-session amendment by the directing party; non-contradictory addition)

### 2026-05-16 - v1.1

- Applied Gate 1 review findings:
  - **V6 propagation**: Added Directing Party and Implementer glossary entries; updated Quality Gate definition; reworded Three Hard Gates rule to remove implementer self-approval rather than all AI approval; added new Business Rule "Supervisor Distinct From Implementer"; updated workflow steps to use "directing party" and "implementer" consistently
  - **C1**: Reconciled Feature `Activity` attribute with the Unified Status Lifecycle rule — Activity is now named as an orthogonal descriptive state, not a lifecycle variant
  - **C2**: Removed unused "Subagent" glossary entry (concept belongs in technical_design.md)
  - **C3**: Removed redundant Epic relationship "Remains as historical record once APPROVED" — already covered by the *Approved Tasks Are Archived* business rule
  - **G2**: Added "Capturing Knowledge as the Project Runs" workflow elaborating Vision § Living Documentation commitment that "knowledge accumulates so the same investigation never happens twice"
- Status: APPROVED (2026-05-16)

### 2026-05-15 - v1.0

- Initial conceptual design drafted as part of refactor
- Status: DRAFT
