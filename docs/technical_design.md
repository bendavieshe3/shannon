# Technical Design

**Status**: APPROVED
**Last Reviewed**: 2026-05-16
**Approved**: 2026-05-16

---

**Project Name**: Shannon

## System Architecture

Shannon has no runtime in the conventional sense. Its "architecture" is the structure of files and the prompts inside them. Three layers compose the framework:

```
Commands (user-facing, thin)
    │
    ├── Invoke Skills (framework logic, reusable)
    │       │
    │       └── Spawn Subagents (context-heavy work)
    │               - Read multiple docs
    │               - Check alignment
    │               - Draft elaborations
    │               - Return structured summaries
    │
    └── Project-specific extensions (optional per-project customisation)
```

Each layer has a single, clear responsibility. Commands accept user input and route to the right skill. Skills encode the framework's process logic — how to elaborate, how to plan, how to enforce gates, how to instantiate templates. Subagents handle the reading and synthesis that would otherwise bloat the main conversation context.

### Commands

User-invoked entry points. Intentionally thin — they identify what to do and delegate. Located at `./.claude/commands/` in a deployed project, `./shannon/commands/` in this source repository.

- **Purpose**: Parse user input, identify the target work item or document, invoke the relevant skill
- **Responsibilities**: Argument parsing, skill invocation, conversation resumption after the framework action completes
- **Pattern**: All commands are named `[type]-[verb]` (e.g. `/feature-elaborate`, `/task-plan`) for predictability

### Skills

Reusable framework logic with templates. Where Shannon's behaviour lives. Located at `./.claude/skills/<name>/` (or `./shannon/skills/<name>/` in source).

Three skills exist:

| Skill | Purpose |
|---|---|
| `project-setup` | Initialise a new project with Shannon |
| `project-documentation` | Manage mandated documents (create, review, approve) |
| `work-items` | Manage all work item types through their lifecycle |

Each skill consists of:

- `skill.md` — Skill definition: purpose, invocation contract, process logic
- `templates/` — Markdown templates the skill instantiates

Skills are responsible for:

- Process logic (how to elaborate, plan, implement, review)
- Document relationship enforcement (what aligns to what at each stage)
- Quality gate enforcement (no transition past a gate without explicit approval by the directing party; the implementer cannot approve its own work)
- Template instantiation
- Index updates

### Subagents

Ephemeral processes spawned by skills for context-heavy operations. The subagent reads documents, drafts updates directly into work item files, and returns a structured summary to the main conversation. The main agent presents the summary to the directing party.

Benefits:

- **Context management** — Main conversation stays focused; subagent absorbs the document reading
- **Model optimisation** — Subagents can use faster, cheaper models for routine reading
- **Parallelism** — Multiple read-only subagents (e.g. cross-cutting alignment checks against several documents) can run concurrently. Subagents performing writes operate sequentially within a single skill invocation; the file-based model assumes cooperative access (see Security Model)

---

## Data Model

Shannon's "data" is the file structure. Mapping conceptual entities to physical files:

| Conceptual Entity | Storage | Notes |
|---|---|---|
| Project | A directory containing `.claude/`, `docs/`, and (optionally) `spikes/` | No project-level manifest file; presence of `.claude/` is the marker |
| Vision | `./docs/vision.md` | Single file, always present |
| Mandated Document | `./docs/<name>.md` | One file per document; status tracked in frontmatter |
| Feature | `./docs/features/FEAT-XXX-slug.md` | Plus an entry in `feature_index.md` |
| Epic | `./docs/epics/EPIC-XXX-slug.md` | Plus an entry in `epic_index.md` |
| Task | `./docs/tasks/TASK-XXX-slug.md` (or `./docs/tasks/archive/` when APPROVED) | Plus an entry in `task_index.md` |
| Spike | `./spikes/SPIKE-XXX-slug.md` | Project root, not under `docs/`; plus entry in `spike_index.md` |
| Knowledge Note | `./docs/knowledge/<slug>.md` | Plus entry in `knowledge_index.md` |

### ID Allocation

Work item IDs are sequential within their type (FEAT-001, FEAT-002, ...). The skill responsible for creation finds the highest existing ID in the index and increments. ID allocation has no concurrency control — under V6 cooperative access (see Security Model), concurrent agents must coordinate by convention; simultaneous creates would produce colliding IDs and would surface as a merge conflict rather than be prevented at the framework level.

### Slugs

File names use kebab-case slugs derived from the work item name. Slugs are stable once assigned; renaming a work item does not change its slug or filename.

---

## API Design

Shannon's "API" is the set of slash commands. They follow a single pattern.

### Command Naming

`/[type]-[verb]` for all work item operations. `/document-[verb]` for document operations. `/shannon-setup` for the one-off setup command.

This naming groups related commands when listed (all `feature-*` commands appear together in a `/` menu) and makes the verb predictable.

### Lifecycle Verbs

Every work item type supports the same five verbs:

- `create [hint]` — Create in DRAFT
- `elaborate [ID]` — Elaborate to ELABORATED (Gate 1)
- `plan [ID]` — Plan to PLANNED (Gate 2)
- `implement [ID]` — Execute; IMPLEMENTING ↔ IMPLEMENTED
- `review [ID]` — Verify and approve; REVIEW → APPROVED (Gate 3)

### Document Verbs

Documents have a simpler surface:

- `document-create [type]` — Instantiate a mandated document or knowledge note
- `document-review [path]` — Review and approve a document

### Skill Invocation Pattern

Commands invoke skills via explicit wording in the command's Markdown body. To ensure reliable activation:

1. Commands state explicitly: "You MUST invoke the [skill] skill"
2. Skills begin with a self-identification line confirming they were activated
3. Commands include fallback wording: "If the skill did not activate, report the error"

This redundancy guards against silent skill-loading failures.

---

## Key Algorithms

### Cascading Operations: Batch Preparation, Individual Gates

When the directing party invokes an operation on a higher-level work item (e.g. `/epic-plan`), the implementer does bulk preparation for the entire subtree — including drafting elaborations and plans for child work items — but each child still passes through its own gate individually. No new statuses are introduced; the batch preparation happens invisibly behind the standard lifecycle commands.

**Approach**:

1. Implementer plans the parent (epic, in this example) and writes the plan into its file
2. Implementer identifies the child tasks needed
3. Implementer creates each child task in DRAFT, with a *prepared elaboration draft* and a *prepared plan draft* stored in the relevant sections of the task file (marked clearly as "prepared during EPIC-XXX planning, not yet reviewed")
4. Implementer presents a summary of the parent plan and the prepared children to the directing party
5. When the directing party later runs `/task-elaborate TASK-XXX`, the subagent surfaces the prepared elaboration instead of starting fresh; same for `/task-plan TASK-XXX`. Each child still requires its own Gate 1 and Gate 2 approval

**Rationale**: Preserves the *Unified Status Lifecycle* rule from conceptual_design.md — no work item type carries a unique status sequence and no transition skips a gate. The bulk-preparation benefit is realised by reusing draft content at the moment each child's gate is invoked, not by extending the status model. This minimises framework surface area while still saving the directing party from approving N empty drafts.

**Trade-off**: Prepared drafts may go stale if the directing party delays approving children long enough for the parent or sibling work to change. The implementer should warn when surfacing a stale prepared draft and offer to refresh.

### Document Alignment Check

When a higher-level document is approved, lower-level documents should be checked for misalignment. The same algorithm runs as part of every `/document-review` invocation, so the target document is checked against everything above and (optionally) below it in the authority graph.

**Approach**:

1. The `project-documentation` skill spawns a subagent for each relevant document neighbour in the authority graph
2. Each subagent reads its assigned document plus the target document
3. Subagent returns a structured finding report (schema below)
4. Skill aggregates findings and surfaces them to the directing party as review candidates and (for upstream-change cascades) candidate follow-up work items

**Finding schema**: Each finding belongs to one of four categories:

- **Drift** — A lower-doc statement contradicts a higher-doc commitment. Must be resolved before the lower doc can remain APPROVED
- **Gap** — A higher-doc commitment that the lower doc should elaborate but doesn't. May or may not block approval depending on materiality
- **Internal contradiction** — A self-contradiction or stale reference within the document being reviewed
- **Strength** — Notable cleanly-aligned elaboration. Reported for signal, not action

Findings cite the specific section or line being commented on. The aggregating skill presents categorised findings; the directing party decides which to apply inline, which to defer to scratchpad, and which to ignore.

**Trade-offs**: Alignment checks consume tokens. Run them on document approval (and on `/document-review` invocations) rather than on every save. Subagent reads are parallelisable across neighbours since they are read-only.

---

## Security Model

Shannon adds no network calls of its own; the framework operates on local files within the Claude Code runtime. Its security model is the security model of Claude Code plus three Shannon-specific stances.

- **Authentication**: None — Shannon has no notion of identity. The directing party is whoever is invoking commands in the Claude Code session
- **Authorisation**: None at the framework level; project-specific authorisation lives in the project's own technical_design.md
- **Trust boundary**: Commands and skills installed by Shannon execute under Claude Code's permission model. The directing party reviews and approves commands and tool uses like any other Claude Code skill

### Cooperative Access

The file-based model assumes cooperative access. Concurrent writes by multiple agents are out of scope at this version. Multi-agent configurations (e.g. supervising agent + implementing agent under V6) coordinate by convention: each agent operates on disjoint work items, or surfaces concurrent edits as ordinary diffs to be resolved by the directing party. There is no file locking and no transaction layer.

### Gate Enforcement

The *Supervisor Distinct From Implementer* rule (conceptual_design.md) is enforced by convention, not by technical control. Skills and commands are written to refuse self-approval flows (e.g. an implementer subagent does not call its own `*-review` command), and the directing party is responsible for not running review commands on work that the directing party itself just produced. Future versions may add architectural enforcement (e.g. agent identity checks at gate transitions); the current version trusts the skill protocol.

---

## Error Handling

- **Skill activation failures** — Commands include explicit fallback wording. If a skill fails to activate, the command surfaces the error to the directing party rather than silently proceeding
- **Missing documents** — Skills check for the presence of required parent documents before proceeding. If a referenced document is missing, the skill surfaces a clear error: "Cannot elaborate FEAT-001 because vision.md does not exist. Run `/document-create vision` first."
- **DRAFT documents as authority** — When a skill needs a document as authoritative context and the document is DRAFT, the skill warns the directing party and asks whether to proceed with reduced confidence

---

## Performance Approach

- **Subagent offloading** — Reading-heavy operations spawn subagents to keep main context lean
- **Lazy template instantiation** — Templates are read from disk at the moment of use, not pre-loaded
- **Index-based lookups** — Work item discovery uses the flat index files rather than directory scans, keeping operations O(index size) rather than O(filesystem)

---

## Version History

### 2026-05-16 - v1.1

- Applied Gate 1 review findings:
  - **V6 propagation**: Updated vocabulary throughout (user → directing party, AI → implementer in lifecycle contexts); softened quality gate enforcement to forbid implementer self-approval rather than all AI approval; rewrote V6-stale "single-developer tool" lines in ID Allocation and Security Model
  - **PENDING reconciliation (option b)**: Rewrote Cascading Operations to preserve the *Unified Status Lifecycle* invariant. Batch preparation now produces prepared draft content stashed inside child work items (rather than introducing `*-PENDING` sub-statuses); the prepared content is surfaced when each child's gate command is invoked. Removed reference to non-existent `/task-approve` command
  - **Subagent concurrency clarification**: Reworded Parallelism bullet to distinguish read-only concurrent subagents (safe) from write-performing subagents (sequential within a skill invocation, cooperative across invocations)
  - **Document Alignment Check elaboration (G3)**: Added a four-category finding schema (Drift, Gap, Internal contradiction, Strength) for structured subagent reports. Matches the pattern already in use during these reviews
  - **Cooperative Access architecture (G1)**: Added subsection to Security Model naming the assumption and explaining what "by convention" looks like
  - **Gate Enforcement mechanism (G2)**: Added subsection to Security Model explicitly stating that the supervisor ≠ implementer constraint is enforced by skill-protocol convention, not technical control. Honest about the limitation
- Status: APPROVED (2026-05-16)

### 2026-05-15 - v1.0

- Initial technical design drafted around Commands + Skills + Subagents architecture
- Status: DRAFT
