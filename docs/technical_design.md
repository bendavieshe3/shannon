# Technical Design

**Status**: APPROVED
**Last Reviewed**: 2026-05-29
**Approved**: 2026-05-29

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

### Supervisor

A specialised skill for continuous health vigilance, located at `./.claude/skills/shannon-supervisor/`. The supervisor inhabits the Commands + Skills + Subagents triad above — it is not a parallel runtime. What distinguishes it is its *cadence* (it may be invoked autonomously on a schedule the project configures; see § Cadence) and its *fan-out* (a single supervisor invocation spawns several specialised checker subagents in parallel).

**Skill directory layout**:

- `SKILL.md` — supervisor logic and the contracts for the slash commands below
- `templates/` — report templates (header, finding sections, footer)
- `checkers/` — definitions for the three specialised checker subagents
- `scripts/` — helper scripts (git log parsers, index validators)

**Checker subagents**: a supervisor invocation fans out into three specialised checkers, each with restricted tool access and a model chosen for its workload:

| Checker | Model | Purpose |
|---|---|---|
| Alignment Checker | Haiku (Explore agent) | Fast codebase scan for document-vs-implementation drift |
| Lifecycle Checker | Sonnet | Audit work-item indexes; detect stuck or stale items; cross-check index state against source-of-truth bodies |
| Drift Checker | Haiku | Scratchpad pressure, uncommitted changes, branch lag |

Each checker runs in roughly 30 seconds to 2 minutes and returns a structured finding fragment using the same four-category schema (Drift / Gap / Internal contradiction / Strength) as § Document Alignment Check. The supervisor skill aggregates fragments into a single dated report (see § Data Model → *Supervisor Report Files*).

**Slash-command surface**:

- `/shannon-report` — Run the full audit fan-out and write a dated report
- `/shannon-goal [intent]` — Decompose a high-level directing-party intent into candidate work items, citing existing artefacts where alignment exists and surfacing gaps where it doesn't

**Hook integration**: the supervisor leverages five Claude Code hook points to weave vigilance into the interactive session lifecycle:

| Hook | Role |
|---|---|
| `SessionStart` | Inject a terse health summary (drift count, stuck items, push lag) so the directing party opens a session already oriented |
| `PreToolUse` | Write-guard — refuse writes outside `docs/supervisor/` from a supervisor-scoped invocation |
| `PostToolUse` | Log supervisor operations for audit trail |
| `preCompact` | Snapshot in-flight findings before context compaction so the report survives compaction |
| `Stop` | Run a completion check; warn if context is still over threshold or if findings remain unflushed |

Hook configuration lives in the project's `settings.json` per Claude Code conventions; specific hook bodies ship with the supervisor skill.

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
| Supervisor Report | `./docs/supervisor/report-YYYY-MM-DD.md` | A Knowledge Note subtype per conceptual_design § Domain Model → *Knowledge Note*; ID is the report's ISO date. Indexed in `knowledge_index.md` like any other note |
| Supervisor Configuration | `./.claude/shannon-supervisor.json` | Per-project gate-authority ceilings and supervisor settings; schema sketched below |
| Cadence State (optional) | `./.claude/supervisor/state.json` | Optional inter-run state file; see *Cadence State* below |

### ID Allocation

Work item IDs are sequential within their type (FEAT-001, FEAT-002, ...). The skill responsible for creation finds the highest existing ID in the index and increments. ID allocation has no concurrency control — under V6 cooperative access (see Security Model), concurrent agents must coordinate by convention; simultaneous creates would produce colliding IDs and would surface as a merge conflict rather than be prevented at the framework level.

### Slugs

File names use kebab-case slugs derived from the work item name. Slugs are stable once assigned; renaming a work item does not change its slug or filename.

### Supervisor Report Files

Supervisor reports are Knowledge Notes per the subtype extension at conceptual_design § Domain Model → *Knowledge Note*. They differ from other knowledge notes only by location and naming: they live at `./docs/supervisor/report-YYYY-MM-DD.md` rather than `./docs/knowledge/<slug>.md`, and their identifier is the run's ISO date rather than a slug. The directory separation makes supervisor output easy to scope (e.g. for the PreToolUse write-guard at § System Architecture → *Supervisor* → *Hook integration*). Reports are indexed in `knowledge_index.md` with their type marked as *Supervisor Report*.

Reports are never overwritten — each cadence run produces a new dated file. If two runs occur on the same date (rare; e.g. a manual `/shannon-report` after an autonomous nightly run), the second run appends a suffix: `report-YYYY-MM-DD-<n>.md`.

### Supervisor Configuration

The Epic and Spike gate-authority ceilings are configurable per project (per conceptual_design § Business Rules → *Gate Authority Split*; technology_stack § Supervisor Tooling → *Configuration storage*). Shannon stores supervisor configuration at `./.claude/shannon-supervisor.json`.

Schema sketch:

```json
{
  "epic_gate_authority": "supervisor",
  "spike_gate_authority": "supervisor",
  "report_directory": "docs/supervisor",
  "scheduler_documented_in": "docs/development_guide.md"
}
```

Fields:

- **`epic_gate_authority`** — `"supervisor"` (default) or `"directing_party"` (reserved by the directing party for this project). Uniform across all Epics in the project — no per-Epic toggling at this version
- **`spike_gate_authority`** — `"supervisor"` (default) or `"directing_party"`. Uniform across all Spikes in the project — no per-Spike toggling at this version
- **`report_directory`** — Where supervisor reports land; default `docs/supervisor` per § Supervisor Report Files. Configurable for projects that prefer a different convention
- **`scheduler_documented_in`** — Pointer to where the project's scheduler choice is documented (per § Cadence → *Scheduler*); not a functional setting, just a discoverability aid

Absent fields take the supervisor-authority default. A project that has not reserved any gate authority may omit the file entirely.

### Cadence State

The supervisor is **stateless by default** between cadence runs. Each run reads source-of-truth artefacts (mandated documents, work-item indexes, git history, scratchpad) and writes a fresh report at `docs/supervisor/report-YYYY-MM-DD.md`. The report is the durable artefact; no separate "last successful report" or "open issues" file is required for the run-to-run loop.

A narrow optional state file at `./.claude/supervisor/state.json` is permitted for two non-functional concerns:

- **Muted findings** — a finding the directing party explicitly marked as a false positive (e.g. "this document drift is intentional"). Without persistence, the same false positive would re-surface in every report
- **Throttling** — a record of the last cadence run's timestamp, so a scheduler that fires more often than the supervisor's intended cadence can detect "too soon" and skip

The state file is not authoritative for any lifecycle decision — it is a UX aid for the directing party. A supervisor that finds the state file missing or corrupt proceeds as if stateless and notes the absence in the next report.

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

### Supervisor Verbs

Two supervisor commands surface the cadence and goal-decomposition flows (see § System Architecture → *Supervisor*):

- `/shannon-report` — Run a cadence audit and write a dated report
- `/shannon-goal [intent]` — Decompose a directing-party intent into candidate work items

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

The *Supervisor Distinct From Implementer* rule (conceptual_design § Business Rules) is enforced by convention, not by technical control. The rule's substance is an agent-identity constraint: the agent approving any gate is not the same agent that produced the work under review, regardless of which role holds gate authority per *Gate Authority Split*. Skills and commands are written to refuse self-approval flows (e.g. an implementer subagent does not call its own `*-review` command); a directing party or supervisor holding gate authority is responsible for not approving work they themselves implemented. Future versions may add architectural enforcement (e.g. agent identity checks at gate transitions); the current version trusts the skill protocol.

---

## Cadence

The supervisor (§ System Architecture → *Supervisor*) is invokable both interactively (a directing-party slash command in a live session) and autonomously (an external scheduler triggering a headless Claude Code run). Shannon commits to the *pattern* of autonomous invocation; the specific scheduler is project-configured.

### Headless invocation contract

Autonomous cadence runs invoke the supervisor in headless mode:

```
claude --bare -p "<supervisor prompt>" \
  --allowedTools "Read,Bash(git *)" \
  --output-format json
```

The contract Shannon commits to:

- **`--bare`** — skip hook, skill, and plugin discovery beyond what the supervisor needs, for reproducible runs
- **`-p`** — supervisor prompt (typically `/shannon-report` semantics rendered as a direct instruction)
- **`--allowedTools`** — explicit allow-list scoped to read operations and read-only git invocations; the supervisor is read-mostly and writes only its dated report. When the cadence run needs to write its report, `--allowedTools` is extended to include `Write(docs/supervisor/*)`; the PreToolUse hook (§ System Architecture → *Supervisor* → *Hook integration*) enforces the path scope at runtime
- **`--output-format json`** — structured output so the scheduler can inspect exit conditions, finding counts, and surface failures

### Worktree isolation

When the cadence overlaps with an interactive directing-party session, the supervisor runs in a temporary worktree so the audit never contaminates the interactive working tree:

```
claude --worktree audit-check-YYYYMMDD -p "<supervisor prompt>"
```

The worktree is auto-cleaned after the run if no commits or uncommitted changes remain. Worktree isolation is optional for offline cadences (overnight, weekend) but recommended whenever interactive work might be in flight.

### Scheduler

The scheduler that triggers cadence runs is the *project's* concern, not Shannon's. A host cron daemon, a `launchd` job, a remote scheduler such as OpenClaw, or any equivalent satisfies the contract — Shannon commits to the headless-invocation pattern, not to a specific scheduler (per technology_stack § Supervisor Tooling). Each project documents its scheduler choice in its own `development_guide.md`.

### Cost note

A single supervisor invocation fans out into three checker subagents (per § System Architecture → *Supervisor*); aggregate token cost is roughly 6–7× a single-session interactive run. This cost is acceptable for asynchronous supervision because the directing party is not waiting on the result. Cost-control patterns: Haiku for exploration-heavy checkers, Sonnet reserved for the synthesis step.

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

### 2026-05-29 - v1.2

- Cascade from Vision v2.4 (APPROVED 2026-05-28, commit `d2fd797`), conceptual_design v1.7 (APPROVED 2026-05-29, commit `a8fe1e0`), and technology_stack v1.3 (APPROVED 2026-05-29, commit `c7d66e4`) introducing the supervisor as a third role, codifying the gate-authority split, and committing to five Claude Code primitives for supervisor implementation. Pass 1 alignment surfaced findings TD-1 through TD-3; this version addresses all three, with TD-4 (Gate Enforcement refresh) cascading from conceptual_design v1.7's role taxonomy
  - **§ System Architecture → *Supervisor* (new subsection)** — names the supervisor as a skill at `./.claude/skills/shannon-supervisor/` inhabiting the existing Commands + Skills + Subagents triad; documents the three-checker fan-out (Alignment / Lifecycle / Drift) with model-selection rationale; names the `/shannon-report` and `/shannon-goal` slash-command surface; codifies five hook integration points (SessionStart, PreToolUse, PostToolUse, preCompact, Stop) with their roles
  - **§ Data Model** — three additions: the entity-to-file table gains rows for Supervisor Report, Supervisor Configuration, and (optional) Cadence State; new subsection *Supervisor Report Files* codifying the `docs/supervisor/report-YYYY-MM-DD.md` convention as a Knowledge Note subtype per conceptual_design v1.7; new subsection *Supervisor Configuration* codifying `./.claude/shannon-supervisor.json` with schema sketch (epic_gate_authority, spike_gate_authority, report_directory, scheduler_documented_in); new subsection *Cadence State* committing to stateless-by-default with a narrow optional state file at `./.claude/supervisor/state.json` for muted findings and scheduler-throttling concerns
  - **§ API Design → *Supervisor Verbs* (new subsection)** — names `/shannon-report` and `/shannon-goal` at the API surface for discoverability (complements the architectural mention at § System Architecture → *Supervisor*)
  - **§ Security Model → *Gate Enforcement*** — refreshed to express the agent-identity constraint (approver ≠ implementer regardless of role) per conceptual_design v1.7's role taxonomy; v1.1's load-bearing claim (enforced by convention, not by technical control) preserved verbatim in substance — only the role-taxonomy cross-reference is updated
  - **§ Cadence (new section)** — codifies the headless invocation contract (`claude --bare -p ... --allowedTools ... --output-format json`); names the worktree-isolation pattern (`claude --worktree audit-check-YYYYMMDD ...`); names the scheduler choice as project-configured per technology_stack v1.3 (Shannon commits to the pattern, not to a specific scheduler); records the 6–7× single-session token cost of fan-out as acceptable for asynchronous supervision; clarifies that `--allowedTools` is extended to include `Write(docs/supervisor/*)` for the report-write step, with the PreToolUse hook enforcing path scope at runtime
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing**: no v1.1 approved claim is contradicted. The *Gate Enforcement* refresh updates role-taxonomy cross-references but preserves the enforcement-by-convention claim; all other changes are net-new architectural commitments. Document stays APPROVED across the bump (no DRAFT transition). Sibling precedent: technology_stack v1.3 made the identical additive call with a parallel *Cooperative access* refresh
- Cadence performance numbers (cycle duration, per-checker latency) deliberately deferred to § Performance Approach per technology_stack v1.3's parallel deferral; Shannon-level performance targets await Phase 2 implementation evidence under FEAT-009
- Status: APPROVED (2026-05-29)

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
