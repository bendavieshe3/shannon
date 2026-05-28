# Conceptual Design

**Status**: APPROVED
**Last Reviewed**: 2026-05-29
**Approved**: 2026-05-29

---

**Project Name**: Shannon

## Glossary

- **Work Item** — Any of the four types of work-tracking entity in Shannon: Feature, Epic, Task, Spike. All share a common lifecycle and file structure.
- **Mandated Document** — One of the six core project documents that together describe the project. Vision, technology stack, conceptual design, technical design, development guide, UX guide.
- **Quality Gate** — An explicit approval point in a work item's lifecycle, decided by the holder of gate authority for that work item type (the directing party or the supervisor; see § Business Rules → *Gate Authority Split*). Three gates exist: requirements (Gate 1), planning (Gate 2), completion (Gate 3).
- **Directing Party** — The role that sources vision and exercises the gate authorities not delegated to the supervisor. Always holds approval authority for the Vision document and for Features; may reserve Epic gate authority per project. Most commonly a human (Architect or Gardener persona); an agent acting in the directing-party role is supported, provided that agent is not the implementer at the gate in question. The framework treats the directing role as a role, not a species. See § Business Rules → *Gate Authority Split*.
- **Supervisor** — The role that performs continuous health vigilance between gates and absorbs delegated gate authority for routine work. By default holds approval authority for Task gates (always) and Epic gates (configurable per project), and may auto-promote scratchpad items to Tasks. Vision and Feature gate authority always remains with the directing party. May be a distinct agent or, in solo configurations, the directing party themselves; must never be the same agent as the implementer at the gate it approves. See § Business Rules → *Gate Authority Split*.
- **Implementer** — The agent that executes work (elaboration drafts, planning drafts, implementation). At any given gate, the implementer cannot be the agent approving that gate (whether directing party or supervisor) — independence of judgement is what the gate protects.
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

**Naming**: Child work items in Epic plans are named by descriptive title (and by real ID once allocated) — never by opaque plan-letter labels (TASK-A, TASK-B, TASK-C). Ordering, when relevant, is expressed by position language ("the first Task", "the verification Task"). Letter placeholders that appear in transient planning notation must not propagate into the Epic § Plan, child work-item files, indexes, or downstream prose. Skill prompt at `shannon/skills/work-items/skill.md` § Process: Plan step 3 (*Cascading Preparation (for Epics)*) instructs the planning subagent to use descriptive titles from the outset.

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

- **Type** — Research, Implementation Details, Extension, or Supervisor Report
- **Related** — The mandated doc section, work item, or other note this connects to

**Relationships**:

- Belongs to a **Project**'s knowledge base
- May extend a **Mandated Document** (Extension type)
- May be produced by a **Spike**
- May be produced by a supervisor audit cycle (Supervisor Report type)

---

## Business Rules

- **Single Vision Authority** — Every project has exactly one Vision document, and it is the supreme authority. All other documents and work items must align to it.

- **Document Alignment Direction** — Lower documents in the authority graph must enable higher documents. A technology stack cannot specify desktop-only technology if the vision describes a web application. Drift between layers is a defect.

- **Work Items Consume Guides** — The Development Guide and UX Guide are reference material. Work items consume them; they are not updated by work items. Updates to guides happen through `/document-create` or `/document-review` flows.

- **Higher Work Items May Update Mid-Level Docs** — Features and Epics may elaborate the Technical Design when planning. Tasks only consume documents; they do not update them.

- **Unified Status Lifecycle** — All work items move through the same status sequence: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. No work item type has a unique lifecycle. Features additionally carry an orthogonal `Activity` attribute (STABLE / ACTIVE) describing whether an epic is in progress *under* the feature; this is descriptive state, not a lifecycle stage.

- **Three Hard Gates** — DRAFT → ELABORATED, ELABORATED → PLANNED, and REVIEW → APPROVED transitions require explicit approval by the gate authority holder for the work item type, per *Gate Authority Split*. The implementer cannot approve its own work across a gate, regardless of which role holds gate authority; see *Supervisor Distinct From Implementer*.

- **Supervisor Distinct From Implementer** — The role-holder approving any gate (whether directing party or supervisor) must not be the same agent as the implementer at that gate. The constraint is on agent identity, not role label: a human directing party approving Feature gates, a supervisor agent approving Task gates, and a directing party occupying the supervisor role in a solo configuration are all valid — provided none of them is the agent that produced the work being approved. Collapsing approver and implementer collapses the gate. See *Gate Authority Split* for which role holds which gate.

- **Gate Authority Split** — Gate approval authority is partitioned by work item type into a fixed floor and a configurable ceiling:

  - **Fixed floor (directing party, always)** — The Vision document and all Feature gates are approved by the directing party. This authority is not delegable.
  - **Configurable ceiling (supervisor)** — Task gates are always supervisor authority. Epic gates are supervisor authority by default, and may be reserved by the directing party per project. Spike gates are supervisor authority by default, and may be reserved by the directing party per project (mirroring the Epic ceiling pattern).
  - **Scratchpad promotion authority** — Promotion of a scratchpad item to a Task may be exercised autonomously by the supervisor. Promotion of a scratchpad item to an Epic requires directing-party approval (because Epics live under Features whose gate authority sits in the fixed floor). Promotion to a Feature always requires directing-party approval for the same reason. Promotion to a Spike follows the configurable ceiling — supervisor exercises autonomously unless the directing party has reserved Spike authority for the project.
  - **Solo-collapse case** — When the directing party occupies the supervisor role (permitted per Vision § Target Users), they exercise whichever authority the gate calls for. The agent-identity constraint of *Supervisor Distinct From Implementer* still applies in full: the human cannot approve gates on work an agent acting under their direction implemented if that agent is, in protocol terms, the implementer for that gate.
  - **Orphan Tasks** — Tasks without a parent Epic still follow the Task default: supervisor authority at Gate 1, Gate 2, and Gate 3. The absence of a parent Epic does not promote gate authority to the directing party; orphan-ness is a parentage attribute, not an authority attribute.

  Project configuration of the Epic and Spike ceilings lives in `./.claude/` per `technical_design.md`. Reservation by the directing party is per-project and applies uniformly across all Epics (or all Spikes) in that project — no per-Epic or per-Spike toggling at this version.

- **Iterative Implementation Zone** — Between IMPLEMENTING, IMPLEMENTED, and REVIEW, the implementer and the directing party iterate freely without gates. Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone.

- **Retrospective Features** — When Shannon is applied to an existing project, the project's pre-existing capabilities should be captured as Features even though their initial implementation predates Shannon's adoption. Such Features start in ELABORATED status (the description is reviewed and matches reality) with Activity: STABLE (no epic in progress), and their Activity Log records that initial implementation happened outside Shannon's lifecycle. Future evolution proceeds through Epics in the standard way. A Feature may also be *partially* retrospective: existing capability documented, with a clear next Epic for remaining work. The framework treats retrospective and forward-built Features identically once they reach ELABORATED — the distinction is historical, captured in the Activity Log and the Feature's `Initial Implementation` field.

- **Spike Output Is Knowledge** — A spike's durable artefact is its knowledge note. The spike file itself is the activity record and is disposable.

- **Approved Tasks Are Archived** — Tasks that reach APPROVED are moved to `./docs/tasks/archive/`. Epics, Features, and Spikes remain in place as historical records.

- **Scope-Boundary Acceptance Criteria Use Cross-Type Guards** — When a work-item Acceptance Criterion expresses scope (what is *not* touched), phrase it as a guard against changes to other types or layers — e.g. *"no epic/task/spike template, index, or skill modified"*. Do **not** enumerate a literal file count or a fixed file list as the scope assertion: work-item transitions necessarily touch routine bookkeeping files (work-item index entries, parent work-item Tasks-line entries) that literal counts and fixed enumerations cannot anticipate.

  Acceptance Criteria *may* name target files when describing edit-target intent (e.g. *"the FEAT-XXX file gains a `**Met:** / **Remaining:**` sub-block"*). The rule applies only when the AC's purpose is to assert what is *out of scope*. The distinguishing test: **if the AC's failure mode is "an unintended file changed", it is a scope-guard AC and must use the cross-type-guard form.** (The test phrasing is intentionally general so it transfers to non-work-item contexts later, but the rule itself is scoped to work-item Acceptance Criteria — non-work-item scope assertions are outside this Epic's mandate.)

  Three-instance precedent: **TASK-002 AC#6** (the "only two files modified" literal-count assertion contradicted AC#5, which required modifying a third); **TASK-002 AC#8** (example grep mis-worded — missing bold markers around the field name); **TASK-003 AC#9** (enumerated six files when the diff carried eight). Skill prompt at `shannon/skills/work-items/skill.md` § Process: Plan step 2 (*Spawn Planning Subagent*, AC-drafting bullet) repeats the failure-mode test verbatim. Companion edit-discipline rule: see `development_guide.md` § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts* (the editing-order convention from EPIC-008 AC#1) — together they answer *"what must I edit, in what order, and how do I assert the boundary?"*

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

**Rules applied**: Document Alignment Direction; DRAFT Documents Are Not Authoritative; Supervisor Distinct From Implementer; Gate Authority Split.

### Taking a Task from Idea to Approval

**Goal**: Deliver a single unit of implementation work.

**Flow**:

1. `/task-create [hint]` — Task captured in DRAFT
2. `/task-elaborate` — Implementer reads parent Epic, Feature, and relevant Guides; drafts Requirements; **Gate 1**: gate authority holder approves (per *Gate Authority Split*) → ELABORATED
3. `/task-plan` — Implementer reads Development Guide and Technical Design; drafts Plan; **Gate 2**: gate authority holder approves (per *Gate Authority Split*) → PLANNED
4. `/task-implement` — Implementer executes the plan; status IMPLEMENTING → IMPLEMENTED, possibly iterating through REVIEW
5. `/task-review` — Verification against acceptance criteria; **Gate 3**: gate authority holder approves (per *Gate Authority Split*) → APPROVED; task moved to archive

**Rules applied**: Three Hard Gates; Supervisor Distinct From Implementer; Gate Authority Split; Work Items Consume Guides; Approved Tasks Are Archived.

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

**Rules applied**: Document Alignment Direction; DRAFT Documents Are Not Authoritative; Three Hard Gates; Supervisor Distinct From Implementer; Gate Authority Split.

### Re-elaborating a Work Item

**Goal**: Refresh a non-DRAFT work item (Feature, Epic, Task, or Spike) when upstream artefacts evolve, a downstream gap surfaces, or the framework itself changes in a way the work item must accommodate. The mechanism preserves the *Unified Status Lifecycle* by re-running Gate 1 (and, for substantive cases, subsequent gates) rather than introducing new statuses.

**Triggers** *(loose-coupled — any of these surfaces a need)*:

- **Upstream cascade** — a parent work item or mandated document just changed (e.g. parent Feature re-elaborated, Vision principle sharpened)
- **Downstream gap** — a child work item or review surfaced a missing aspiration the parent should now name
- **Framework evolution** — a Shannon version introduces a new attribute, workflow, or convention that an existing work item must absorb

**Flow**:

1. Trigger identified; directing party invokes `/[type]-elaborate [ID]` on a non-DRAFT work item (the work-items skill recognises this as the re-elaboration branch — see *Re-elaboration Branch* in the skill)
2. Skill spawns an alignment subagent reading the target work item plus its parent (Feature → Vision; Epic → parent Feature; Task → parent Epic or Feature; Spike → optional Feature for context) and any documents the work item must align to per the Work Item ↔ Document Relationships table
3. Subagent returns findings using the canonical four-category schema (Drift / Gap / Internal contradiction / Strength)
4. Directing party reviews findings and decides which to apply inline, which to defer to scratchpad, and which to ignore
5. Implementer applies the approved refinements; directing party explicitly approves the new state via **Gate 1**
   - **Bundled re-elaboration.** Multiple work-item re-elaborations may be applied inside a single Task's implementation; the Task's own Gate 2 and Gate 3 serve as the per-item directing-party refinement-approval the workflow's step 5 otherwise requires. Permitted only when **(a)** the bundle is *additive* per § Status semantics below and **(b)** the parent (Epic or Task) **explicitly enumerates** the re-elaborated work items by ID in its Plan or Acceptance Criteria. Co-occurs with the commit-hash clarification at step 6 below; **TASK-003** is the worked precedent (three Feature re-elaborations on FEAT-003 / FEAT-006 / FEAT-007 bundled inside one Task, citing upstream `09844df`).
6. Activity Log entry is added recording **(a) trigger category** (upstream cascade / downstream gap / framework evolution), **(b) upstream commit hash** where applicable, and **(c) summary of what changed**. The "where applicable" qualifier on (b) covers the **bundled-Task case** (see the bundled re-elaboration sub-bullet on step 5 above): when the re-elaboration is bundled inside a Task whose own commit lands after Gate 3 (per `development_guide.md` § Commit Cadence — commits land after Gate 3, not mid-implementation), the entry cannot cite its own work item's commit hash because that hash does not exist at write-time; the entry instead cites the **upstream commit hash** — the hash that delivered the change being absorbed — and **references the bundling work item by ID**. Worked example: **TASK-003** cited upstream `09844df` and referenced TASK-003 by ID for its bundle of three re-elaborations on FEAT-003 / FEAT-006 / FEAT-007.

**Status semantics**:

Re-elaboration is **additive** (refinements do not contradict the work item's previously-approved claims; the work item stays at its current status; only Gate 1 re-passes as a refinement-approval) or **substantive** (refinements contradict previously-approved claims; the work item transitions back to DRAFT and re-passes Gate 1, then re-passes any later gates that had previously been crossed). Per-status behaviour:

| Status before re-elaboration | Additive | Substantive |
|---|---|---|
| ELABORATED | Stays ELABORATED; refinement approved at Gate 1 | Returns to DRAFT; re-passes Gate 1 |
| PLANNED | Stays PLANNED; Plan section preserved unless refinement affects it; refinement approved at Gate 1 | Returns to DRAFT; re-passes Gate 1 and Gate 2 |
| IMPLEMENTING | Stays IMPLEMENTING; if refinement only touches Requirements, no implementation rework required | Returns to DRAFT; re-passes Gate 1, Gate 2, then resumes implementation |
| IMPLEMENTED | Stays IMPLEMENTED; refinement approved at Gate 1; Gate 3 review then proceeds against refined Requirements | Returns to DRAFT; full lifecycle re-pass |
| REVIEW | Stays REVIEW; refinement approved at Gate 1; Gate 3 review continues | Returns to DRAFT; full lifecycle re-pass |
| APPROVED | Stays APPROVED; Activity Log records the refinement | Returns to DRAFT; full lifecycle re-pass (rare — usually preferable to create a new work item) |

When uncertain, treat as substantive (the more cautious path).

**Cross-type applicability**: this workflow applies to all four work-item types, with these adjustments:

- **Features** have no upstream work-item parent — their upstream is the Vision principle they elaborate; upstream-cascade triggers therefore originate at Vision review events
- **Spikes** are standalone — they have no Feature/Epic parent for traceability purposes; upstream cascade rarely applies; the dominant trigger is downstream gap (an investigation surfaced a question the original framing missed)
- **Orphan Tasks** (without a parent Epic) behave as Features for trigger purposes — their upstream is the Feature they nominally elaborate or the Vision section they touch directly

**Rules applied**: Document Alignment Direction; DRAFT Documents Are Not Authoritative; Three Hard Gates; Supervisor Distinct From Implementer; Gate Authority Split; Unified Status Lifecycle.

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
5. Re-elaborate the parent (and, if necessary, re-review the Vision principle the parent derives from) to add aspirational criteria the proposed work will fulfil. Use the *Re-reviewing an APPROVED Mandated Document* workflow for documents; for work items, use the *Re-elaborating a Work Item* workflow
6. Create the downstream work (Epic, Task) with Acceptance Criteria that explicitly fulfil the upstream aspiration
7. If the gap was first captured in the scratchpad, move that item to Processed pointing at the new downstream artefact

**Why this matters**: the framework's self-correcting property depends on upstream aspirations being specific enough that downstream omissions register as drift. Creating downstream work that no upstream artefact requires breaks the chain — the work exists but cannot be missed by a future alignment check.

**Rules applied**: Document Alignment Direction; Three Hard Gates (at each upstream re-approval or downstream creation).

### Running a Spike to Reduce Uncertainty

**Goal**: Answer a specific question that's blocking decisions on a Feature or Epic.

**Flow**:

1. `/spike-create [hint]` — Spike captured in DRAFT, time-box estimated
2. `/spike-elaborate` — Question and expected output sharpened; **Gate 1**: gate authority holder approves (per *Gate Authority Split*) → ELABORATED
3. `/spike-plan` — Investigation approach defined; **Gate 2**: gate authority holder approves (per *Gate Authority Split*) → PLANNED
4. `/spike-implement` — Implementer runs investigation within time-box; findings captured in Investigation Notes
5. Knowledge note produced and indexed; recommendation captured in spike
6. `/spike-review` — **Gate 3**: gate authority holder approves (per *Gate Authority Split*) → APPROVED; spike file remains as activity record, knowledge note is the durable artefact

**Rules applied**: Spike Output Is Knowledge; Three Hard Gates; Supervisor Distinct From Implementer; Gate Authority Split.

---

## Version History

### 2026-05-29 - v1.7

- Cascade from Vision v2.4 (APPROVED 2026-05-28, commit `d2fd797`) introducing the supervisor as a third role and codifying the gate-authority split. Pass 1 alignment surfaced findings C-1 through C-7; this version addresses C-1 through C-5 and C-7 plus bookkeeping D-1 / D-2 cascades. C-6 (Supervisor Audit Key Workflow) deferred to FEAT-009 elaboration per the cascade plan.
  - **§ Glossary** — new *Supervisor* entry naming the continuous-vigilance role and its delegated gate authority; *Directing Party* reworked to retire "supervising agent" wording and name the fixed-floor authorities (Vision + Features); *Quality Gate* reworked to refer to "the gate authority holder per § Gate Authority Split" rather than the directing party; *Implementer* refreshed to clarify the approver ≠ implementer constraint applies regardless of which role holds gate authority
  - **§ Domain Model → *Knowledge Note*** — `Type` attribute extended to include *Supervisor Report* alongside Research / Implementation Details / Extension; Relationships extended to record that supervisor audit cycles produce reports. No new entity. File-path convention (`docs/supervisor/report-YYYY-MM-DD.md`) codified in `technical_design.md` at Pass 3, not here
  - **§ Business Rules → *Three Hard Gates*** — reworked to point at *Gate Authority Split* rather than naming the directing party as the universal approver
  - **§ Business Rules → *Supervisor Distinct From Implementer*** — reworked to express the constraint as agent-identity (approver ≠ implementer) regardless of which role holds gate authority; retires "supervising agent" vocabulary aligned with Vision v2.4
  - **§ Business Rules** — new entry *Gate Authority Split* codifying the fixed floor (Vision + Features → directing party) and configurable ceiling (Tasks always → supervisor; Epics by default → supervisor, reservable per project; Spikes by default → supervisor, reservable per project — mirroring the Epic ceiling pattern), the scratchpad-promotion authority asymmetry (Task auto / Epic requires directing-party approval / Spike follows the ceiling), the solo-collapse case (one human exercises whichever authority the gate calls for), and orphan-Task handling (parentage does not change authority)
  - **§ Key Workflows → *Rules applied* lines** (D-1) — appended *Gate Authority Split* to five workflows: Creating and Approving a Mandated Document; Taking a Task from Idea to Approval; Re-reviewing an APPROVED Mandated Document; Re-elaborating a Work Item; Running a Spike to Reduce Uncertainty
  - **§ Key Workflows → Task and Spike workflow gate markers** (D-2) — gate phrasing updated from "directing party approves" to "gate authority holder approves (per *Gate Authority Split*)" at each Gate marker in both workflows
- Classified as **substantive revision per § Re-reviewing**: while most amendments are net additive (new Glossary entries, new Business Rule, Type attribute extension), the *Three Hard Gates* and *Quality Gate* updates narrow approved claims (v1.6 attributed all gate approval to the directing party; v1.7 attributes it to type-dispatched authority). Per § Re-reviewing → "when uncertain, treat as substantive," the document transited APPROVED → DRAFT for the duration of the revision and returned to APPROVED via Gate 1 ratification 2026-05-29
- C-6 deferred to FEAT-009: the canonical *Supervisor Audit* Key Workflow will be drafted as part of FEAT-009 elaboration, which is where the audit cadence, report shape, and trigger surfaces are decided
- Status: APPROVED (2026-05-29)

### 2026-05-25 - v1.6

- Per EPIC-007 — Work-Item Conventions Surfaced Through Dogfooding — additive amendments codifying four work-item-workflow conventions surfaced during EPIC-005 / EPIC-006 dogfooding:
  - **§ Re-elaborating a Work Item → *Flow* step 6** — inline expansion of the existing "where applicable" phrase clarifying commit-hash timing in the bundled-Task case (cites TASK-003 as worked example with upstream `09844df`)
  - **§ Re-elaborating a Work Item → *Flow* step 5** — new sub-bullet naming **bundled re-elaboration** as a valid pattern (three permission conditions; cites TASK-003 as worked precedent)
  - **§ Domain Model → *Work Item*** — naming note after the Attributes list disallowing opaque plan-letter labels (TASK-A, TASK-B, TASK-C) for child work items in Epic plans
  - **§ Business Rules** — new entry *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* establishing the AC-writing rule for scope-boundary ACs (failure-mode test; cites three-instance precedent — TASK-002 AC#6, TASK-002 AC#8, TASK-003 AC#9; cross-references EPIC-008 AC#1's editing-order convention in `development_guide.md` § Code Style as companion edit-discipline rule)
- Classified as **additive amendment per § Re-reviewing** — no existing approved claim contradicted; document stays APPROVED across the bump (no DRAFT transition)
- EPIC-008 (Development Conventions Surfaced Through Dogfooding, APPROVED 2026-05-24, commit `eac486b`) is the contemporaneous sibling exercise of the routing channel; together, EPIC-007 and EPIC-008 are the first two formal exercises of that channel. The cross-Epic AC pair (EPIC-007 AC#4 ↔ EPIC-008 AC#1) completes bidirectional on this Task's landing — the new § Business Rules entry's bold lead matches `development_guide.md:79`'s cross-reference text verbatim, self-healing the forward HTML comment landed by TASK-007
- Status: APPROVED (2026-05-25)

### 2026-05-21 - v1.5

- Added Key Workflow **Re-elaborating a Work Item** — canonical pattern for refreshing a non-DRAFT Feature/Epic/Task/Spike when upstream artefacts evolve, downstream gaps surface, or the framework itself changes. Parallel structure to *Re-reviewing an APPROVED Mandated Document* (Goal / Triggers / Flow / Status semantics / Rules applied) with two work-item-specific elaborations: a per-status table covering the six non-DRAFT statuses (vs documents' single APPROVED state), and a cross-type applicability section addressing Features (no upstream work-item parent), Spikes (standalone), and orphan Tasks (Feature-like for trigger purposes)
- Removed the gap-flag parenthetical from § Responsible Promotion step 5 ("canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap"); the step now references the new workflow by name
- Delivers TASK-001 under EPIC-006 under FEAT-003 § Adaptive Coherence-aligned Ideal State bullet 1
- Treated as additive amendment per § Re-reviewing — non-contradictory addition; doc remains APPROVED
- Status: APPROVED (2026-05-21)

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
