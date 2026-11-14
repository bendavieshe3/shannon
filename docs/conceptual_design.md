# Conceptual Design

**Status**: APPROVED
**Last Reviewed**: 2026-11-13
**Approved**: 2026-11-01 (feature-level governance design; implementation pending independent review)

---

**Project Name**: Shannon

## Glossary

- **Work Item** — Any of the four types of work-tracking entity in Shannon: Feature, Epic, Task, Spike. Features carry human gates; the other types are optional execution records.
- **Mandated Document** — One of the six core project documents that together describe the project. Vision, technology stack, conceptual design, technical design, development guide, UX guide.
- **Quality Gate** — a human approval point for Feature requirements (Gate 1), approach (Gate 2), or delivered capability (Gate 3). Vision and consequential document decisions also remain human-owned.
- **Directing Party** — the human owner of the Vision and Feature gates; decides material scope, meaning, cost and access changes.
- **Supervisor** — project-health vigilance and synthesis; may organise authorised work but has no delegated Feature approval authority and adds no mandatory lower-level gates.
- **Implementer** — the agent carrying out authorised execution and self-tests; independent review must come from someone who did not implement the work.
- **Authority Graph** — The directed relationship between documents. Lower documents must align to and enable higher ones.
- **Skill** — A reusable unit of framework logic, with templates, invoked by commands. Skills are where Shannon's behaviour lives.
- **Command** — A user-invoked entry point. Thin — its job is to identify what to do and delegate to a skill.
- **Scratchpad** — The project's pre-workflow capture file, `docs/scratchpad.md`: one-line ideas with no ID, status or parent, processed periodically into a work item, a knowledge note, or nothing. Context, never authority.
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
- **Scratchpad** — Unprocessed ideas awaiting a disposition (see *Scratchpad Item*)

**Relationships**:

- Contains exactly one **Vision**
- Contains zero or more **Mandated Documents** (vision is always present; others as relevant)
- Contains zero or more **Features**, **Tasks**, **Spikes** (Epics exist under Features)
- Contains zero or more **Knowledge Notes**
- Contains one **Scratchpad** holding zero or more **Scratchpad Items**

### Work Item

The collective name for the four work-tracking entities. Each work item describes work to be done (or, in the case of Features, an enduring capability of the product).

**Attributes**:

- **Status** — Feature approval state, or optional execution progress
- **Type** — Feature, Epic, Task, or Spike
- **Parent** — Higher-level work item this belongs to (where applicable)
- **Requirements** — The "what" and "why"
- **Plan** — The "how"
- **Activity Log** — Timestamped history

**Naming**: Child work items in Epic plans are named by descriptive title (and by real ID once allocated) — never by opaque plan-letter labels (TASK-A, TASK-B, TASK-C). Ordering, when relevant, is expressed by position language ("the first Task", "the verification Task"). Letter placeholders that appear in transient planning notation must not propagate into the Epic § Plan, child work-item files, indexes, or downstream prose. Use descriptive names when optional child records are useful; do not create them merely to pass a gate.

**Relationships**:

- Belongs to a **Project**
- May have a **Parent** work item (Epics → Features, Tasks → Epics)
- May reference **Mandated Documents** and **Knowledge Notes** as context

### Feature

A persistent capability of the product — what the product IS, not work to be done.

**Attributes**:

- **Vision Reference** — The vision section this feature elaborates
- **Activity** — STABLE (no active implementation) or ACTIVE (implementation in progress)
- **Delivery Evidence** — linked changes, checks and independent-review results; Epics are optional organisation

**Relationships**:

- Elaborates the **Vision**
- Contains zero or more **Epics**

### Epic

An optional coherent unit of work delivering part of a Feature's ideal state.

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

### Scratchpad Item

An idea, half-formed piece of work or unprocessed TODO, captured before it is ready to be classified.

**Attributes**:

- **Title and line** — One line; what and why
- **Tags** — Optional `#tags`
- **Disposition** *(once processed)* — Acted on, promoted, moved to knowledge, or dropped, with the date and a pointer. An item kept for later stays unprocessed, with a dated note when something changed

**Relationships**:

- Lives in the project's single `docs/scratchpad.md`, under § Items until processed and § Processed afterwards
- May become a **Feature** (human decision), an optional **Epic**, **Task** or **Spike**, or a **Knowledge Note**
- Has no ID, status or parent. It is not a work item and grants no authority

---

## Business Rules

- **Single Vision Authority** — Every project has exactly one Vision document, and it is the supreme authority. All other documents and work items must align to it.

- **Document Alignment Direction** — Lower documents in the authority graph must enable higher documents. A technology stack cannot specify desktop-only technology if the vision describes a web application. Drift between layers is a defect.

- **Work Items Consume the UX Guide; May Refine the Development Guide** — Agents read and maintain all relevant documents, including both Guides, within approved intent. A factual update, corrected link or implementation detail can accompany the change it describes. Changes to approved product meaning, consequential design, acceptance criteria or authority return to the human through document review or the affected Feature gate. Record the decision and its rationale; no lower-level work item can grant that authority. Earlier Guide-specific restrictions are superseded by this meaning-based boundary.

- **Higher Work Items May Update Mid-Level Docs** — The authorisation boundary is approved meaning, not the type of execution record. Direct Feature execution and optional Epics/Tasks/Spikes may maintain relevant documents within that boundary. Surface substantive contradictions before making the affected change.

- **Unified Status Lifecycle** — The existing sequence `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED` remains the Feature lifecycle. Optional execution records may reuse existing progress labels for compatibility, but have no required sequence or human gates; record actual readiness and evidence, never approval that did not occur. Feature Activity is ACTIVE while implementation is under way, with or without an Epic. Existing identifiers, logs and archive locations remain valid; no bulk migration is required.

- **Three Hard Gates** — The three hard gates apply to Features: requirements and acceptance criteria (Gate 1), approach and consequential trade-offs (Gate 2), delivered capability (Gate 3). The human explicitly approves each; previous explicit approval is reused rather than requested again. Intermediate implementation choices and optional records are agent-managed.

- **Supervisor Distinct From Implementer** — Independent technical review must be performed by a reviewer who did not implement the work. Self-tests are evidence, not independent approval. Human Feature acceptance and independent technical review are distinct; a supervisor label does not make the implementer independent.

- **Gate Authority Split** — The human retains Vision and all Feature gates. There are no mandatory Epic, Task or Spike gates to delegate. Agents may organise authorised execution and promote scratchpad notes into optional aids when those aids stay within existing approved intent and permissions. New or materially changed Feature scope, or a consequential change to a governing document, returns to the human. Legacy `epic_gate_authority` and `spike_gate_authority` settings cannot create or delegate gates under this model; any explicitly recorded project-specific hold still needs a named disposition before affected work proceeds.

- **Iterative Implementation Zone** — After Feature Gate 2, agents choose and revise plans, decomposition and implementation order, maintain relevant documents, test and obtain independent review before offering Feature Gate 3. Incremental delivery does not force a new Feature or a human gate for every slice. Stop affected work on material divergence; continue unrelated authorised work where useful.

- **Retrospective Features** — When Shannon is applied to an existing project, the project's pre-existing capabilities should be captured as Features even though their initial implementation predates Shannon's adoption. Such Features start in ELABORATED status (the description is reviewed and matches reality) with Activity: STABLE (no active implementation), and their Activity Log records that initial implementation happened outside Shannon's lifecycle. Future evolution proceeds through Feature gates and agent-managed execution, with Epics optional. A Feature may also be *partially* retrospective: existing capability documented, with a clear next Epic for remaining work. The framework treats retrospective and forward-built Features identically once they reach ELABORATED — the distinction is historical, captured in the Activity Log and the Feature's `Initial Implementation` field.

- **Spike Output Is Knowledge** — A spike's durable artefact is its knowledge note. The spike file itself is the activity record and is disposable.

- **Approved Tasks Are Archived** — Existing archived Tasks stay where they are. Optional completed Tasks may be archived when authorised and useful; no mandatory move or lower-level approval is required. Update affected relative/inbound links and any existing index in the same operation. Never automatically move or delete historical records to adopt this governance change.

- **Scope-Boundary Acceptance Criteria Use Cross-Type Guards** — When a work-item Acceptance Criterion expresses scope (what is *not* touched), phrase it as a guard against changes to other types or layers — e.g. *"no epic/task/spike template, index, or skill modified"*. Do **not** enumerate a literal file count or a fixed file list as the scope assertion: work-item transitions necessarily touch routine bookkeeping files (work-item index entries, parent work-item Tasks-line entries) that literal counts and fixed enumerations cannot anticipate.

  Acceptance Criteria *may* name target files when describing edit-target intent (e.g. *"the FEAT-XXX file gains a `**Met:** / **Remaining:**` sub-block"*). The rule applies only when the AC's purpose is to assert what is *out of scope*. The distinguishing test: **if the AC's failure mode is "an unintended file changed", it is a scope-guard AC and must use the cross-type-guard form.** (The test phrasing is intentionally general so it transfers to non-work-item contexts later, but the rule itself is scoped to work-item Acceptance Criteria — non-work-item scope assertions are outside this Epic's mandate.)

  Three-instance precedent: **TASK-002 AC#6** (the "only two files modified" literal-count assertion contradicted AC#5, which required modifying a third); **TASK-002 AC#8** (example grep mis-worded — missing bold markers around the field name); **TASK-003 AC#9** (enumerated six files when the diff carried eight). The work-items skill applies this scope test when selecting verification. Companion edit-discipline rule: see `development_guide.md` § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts* (the editing-order convention from EPIC-008 AC#1) — together they answer *"what must I edit, in what order, and how do I assert the boundary?"*

- **DRAFT Documents Are Not Authoritative** — AI must treat DRAFT mandated documents as not-yet-trustworthy context. Only APPROVED documents are authoritative.

---

## Key Workflows

### Creating and Approving a Mandated Document

Keep all six documents and their authority graph. Draft new authoritative meaning for human approval, beginning with the Vision. Read higher-authority neighbours and affected Features; identify contradictions and consequential choices. Routine factual upkeep within already-approved meaning is agent work, recorded with its source. Independent review of changes remains required by the project's contribution policy; neither a lower-level record nor its completion grants authority to change approved intent.

### Taking a Task from Idea to Approval

This retained heading is a compatibility pointer: Tasks are optional execution aids, not an approval boundary.

1. Identify the approved Feature, or the governing engineering rule and product purpose for maintenance.
2. Read relevant Vision/design/Guide context and the current implementation.
3. Choose a plan; create an Epic, Task or Spike record only if useful. No human requirements/plan gates are required for these aids.
4. Implement and test within approved scope, maintain affected documents, and obtain independent technical review.
5. Link changes, checks, review and remaining work from the Feature. Only human Feature acceptance crosses Gate 3.

Direct `/feature-implement` can perform this flow without creating any children. Keep enough decisions and next-step evidence for a fresh session to resume.

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

Review on a governing decision change, implementation drift, a surfaced contradiction or an explicit request. Read the current document and relevant authority neighbours; optional delegated reading must be authorised. Distinguish factual maintenance from a change to approved meaning.

- **Additive/factual maintenance:** preserve APPROVED status when meaning stays within existing authority; update relevant content, source links and version history with the change.
- **Substantive revision:** retain the prior decision, draft the proposed replacement, and obtain explicit human approval of the changed meaning. Use DRAFT while unresolved. When uncertainty affects the outcome, surface it rather than treating it as permission.

Approval already supplied for the exact design is recorded once and reused during its implementation. Updates follow source-body-before-derived-references discipline. Check downstream alignment and record any remaining obligations without mandating a new work item for each one.

### Re-elaborating a Work Item

Features are re-elaborated when Vision, related design, delivered behaviour or a discovered gap changes their approved scope. Read the Feature and relevant sources, identify additive clarification versus substantive change, and show the concrete requirements/approach/acceptance delta to the human. Materially changed requirements return to DRAFT and re-pass affected Feature gates; accepted completed delivery is never inferred from a new design approval. Factual records can be reconciled without inventing new approval.

Record the trigger (upstream change, downstream gap, sibling change or framework evolution), relevant source revision where known, and the actual decision. Historical statuses/logs remain evidence. Optional execution aids may be revised by agents within approved intent; they do not re-pass Feature gates simply because their notes change.

### Responsible Promotion

Before implementing a finding, read the affected Feature and Vision or the governing engineering rule and its product purpose. If existing approved intent covers it, choose useful execution aids or work directly. If it changes intent, seek the relevant human Feature/document decision first. A scratchpad entry or lower-level record supplies context, not authority. Preserve the source and disposition of the finding; optional records use descriptive names and cite their governing context. Never split an unapproved product decision into Tasks to evade the human boundary.

### Processing the Scratchpad

**Goal**: Keep cheap capture from turning into a junk drawer. Elaborates Vision § Key Features *Lightweight Idea Capture*.

**Flow**:

1. Anyone captures an idea as one line under § Items (`/scratchpad-add` or a direct edit). The implementer also captures framework-general ambiguities it notices during other work (`development_guide.md` § Pre-Commit Checklist).
2. Periodically, and whenever the supervisor's Drift Checker reports scratchpad pressure, `/scratchpad-process` works the items.
3. Each item gets one disposition: act within an existing approved Feature or governing rule; promote, where new or changed Feature scope goes to the human as a DRAFT Feature or re-elaboration, and optional Epics, Tasks or Spikes may be created within approved intent; move a durable finding to a knowledge note; drop it with a reason; or keep it for later.
4. Disposed items move to § Processed with the date and a pointer, so the trail survives.

**Rules applied**: *Responsible Promotion* (a scratchpad item supplies context, not authority); *Gate Authority Split* (only the human approves new Feature scope).

### Running a Spike to Reduce Uncertainty

A Spike is an optional time-boxed investigation, linked to the affected Feature or governing decision. Define the question, output and time/cost limits; research within existing authority; save reusable knowledge and a recommendation. State an inconclusive result when the time-box expires. No mandatory Spike approval stages apply, but a new external cost, access need or consequential choice still requires the human decision. An investigation result cannot approve its own resulting Feature change.

## Version History

### 2026-11-13 - v2.1

- **Scratchpad ratified (FEAT-007).** Added the *Scratchpad* glossary entry, the *Scratchpad Item* domain entity and the *Processing the Scratchpad* key workflow. Additive: it ratifies the capability Vision § Key Features *Lightweight Idea Capture* and FEAT-007's approved requirements already name, and contradicts no approved claim. The document stays APPROVED.

### 2026-11-12 - Reference repair

- Describe Epics as optional delivery groups without the superseded phase-model comparison. Factual alignment within the approved Feature-level governance design; no new Feature delivery acceptance is recorded. The preserved v1.8 history contains an obsolete TASK-029 relative link; the record is now [archived here](tasks/archive/TASK-029-acceptance-criteria-cite-governing-rules.md).

### 2026-11-01 - v2.0

- Substantive revision approved by Ben: preserve all six documents and alignment, trace everything from the Vision, retain human Feature gates, and let agents manage execution below Features. Independent review remains distinct from implementation. Historical work records and identifiers are preserved.


### 2026-08-26 - v1.8

- Re-review triggered by a **live framework contradiction surfaced at TASK-029's creation** (2026-08-25) and resolved by directing-party ruling the same day; drafted 2026-08-25, ratified at Gate 1 on 2026-08-26. The rule *Work Items Consume Guides* (v1.7 and earlier) said, without qualification, that neither the Development Guide nor the UX Guide is updated by work items — yet EPIC-008 / TASK-007 amended `development_guide.md` three times with approval (all APPROVED 2026-05-27, recorded in FEAT-008 § Ideal State as Task-delivered), while TASK-027 was held to the literal rule and had to route a `ux_guide.md` correction through `/document-review`. Both could not be right under one undifferentiated rule.
  - **§ Business Rules → *Work Items Consume Guides*** renamed to **_Work Items Consume the UX Guide; May Refine the Development Guide_** and rewritten to distinguish the two Guides by kind: the **UX Guide describes the product** (a work item may not redefine it — consume only, changes via `/document-review`); the **Development Guide describes the process work items execute** (a work item that discovers or ratifies a development convention during its work may amend it, riding the work item's own gates). Names TASK-007 and TASK-027 as the two worked precedents the split reconciles. Directing-party ruling: *"the Development Guide decides the process and the UX Guide decides the product, so they aren't the same."*
  - **§ Business Rules → *Higher Work Items May Update Mid-Level Docs*** — the closing clause *"Tasks only consume documents; they do not update them"* carved out to name the Development Guide exception, so the two rules no longer contradict each other.
- Classified as **substantive revision per § Re-reviewing**: v1.7 and earlier approved the claim that work items never update either Guide; this version reverses that claim for the Development Guide. Per § Re-reviewing → *Status semantics*, the document transited APPROVED → DRAFT for the duration of the revision and returns to APPROVED via Gate 1.
- **Downstream, not deferred**: unblocks [TASK-029](./tasks/archive/TASK-029-acceptance-criteria-cite-governing-rules.md), whose scope was pending this ruling — the convention it carries (an acceptance criterion cites the governing rule, not a version-pinned reference or illustrative example) may now land its doc-half in `development_guide.md` via the Task itself, no split required. No cascade to lower documents: `development_guide.md` and `ux_guide.md` already behave per this split; the rule change ratifies practice rather than redirecting it.
- Status: DRAFT → APPROVED (2026-08-26, Gate 1 approved by the directing party)

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
