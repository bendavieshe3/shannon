# Technical Design

**Status**: APPROVED
**Last Reviewed**: 2026-11-13
**Approved**: 2026-11-01 (feature-level governance design; implementation pending independent review)

---

**Project Name**: Shannon

## System Architecture

Shannon has no runtime in the conventional sense. Its "architecture" is the structure of files and the prompts inside them. Three layers compose the framework:

```
Commands (user-facing, thin)
    │
    ├── Invoke Skills (framework logic, reusable)
    │       │
    │       └── Optional authorised Subagents (context-heavy work)
    │               - Read multiple docs
    │               - Check alignment
    │               - Draft elaborations
    │               - Return structured summaries
    │
    └── Project-specific extensions (optional per-project customisation)
```

Each layer has a single, clear responsibility. Commands accept user input and route to the right skill. Skills encode the framework's process logic — how to elaborate, how to plan, how to enforce gates, how to instantiate templates. Implementation delegation is optional and requires the applicable authorisation; independent review remains separate.

### Commands

User-invoked entry points. Intentionally thin — they identify what to do and delegate. Located at `./.claude/commands/` in a deployed project, `./shannon/commands/` in this source repository.

- **Purpose**: Parse user input, identify the target work item or document, invoke the relevant skill
- **Responsibilities**: Argument parsing, skill invocation, conversation resumption after the framework action completes
- **Pattern**: All commands are named `[type]-[verb]` (e.g. `/feature-elaborate`, `/task-plan`) for predictability

### Skills

Reusable framework logic with templates. Where Shannon's behaviour lives. Located at `./.claude/skills/<name>/` (or `./shannon/skills/<name>/` in source).

Four skills exist:

| Skill | Purpose |
|---|---|
| `project-setup` | Initialise a new project with Shannon |
| `project-documentation` | Manage mandated documents (create, review, approve) |
| `work-items` | Feature gates and agent-managed execution; optional lower-level records |
| `shannon-supervisor` | Continuous health vigilance and goal decomposition (see *Supervisor* below) |

Each skill consists of:

- `skill.md` — Skill definition: purpose, invocation contract, process logic (the supervisor ships its manifest as `SKILL.md`; which casing Claude Code's skill discovery requires is an open question, see `scratchpad.md`)
- `templates/` — Markdown templates the skill instantiates

Skills are responsible for:

- Process logic (how to elaborate, plan, implement, review)
- Document relationship enforcement (what aligns to what at each stage)
- Feature gate enforcement (human requirements/approach/delivery decisions); independent review is distinct from self-tests
- Template instantiation
- Index updates

### Subagents

Optional helpers for context-heavy operations, used only when separately authorised and useful. They are not mandatory steps for Feature elaboration, planning or implementation. The implementer may read/draft directly. An independent reviewer must not be the implementer; changing a prompt or role label within the same continuing implementer does not supply independent review. Authorised concurrent helpers coordinate writes and return source-linked evidence.

### Supervisor

A specialised skill for continuous health vigilance, located at `./.claude/skills/shannon-supervisor/`. The supervisor inhabits the Commands + Skills + Subagents triad above — it is not a parallel runtime. What distinguishes it is its *cadence* (it may be invoked autonomously on a schedule the project configures; see § Cadence) and its *fan-out* (a single supervisor invocation spawns several specialised checker subagents in parallel).

**Skill directory layout**:

- `SKILL.md` — supervisor logic and the contracts for the slash commands below
- `templates/` — report templates (header, finding sections, footer)
- `checkers/` — definitions for the three specialised checker subagents
- `scripts/` — helper scripts (git log parsers, index validators) and hook bodies
- `hooks/` — shippable `settings.json` registration snippets, one per shipped hook

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

**Hook integration**: the supervisor's committed architecture uses five Claude Code hook points to weave vigilance into the interactive session lifecycle. Three have shipped; `PreCompact` and `Stop` are pending [EPIC-011](epics/EPIC-011-autonomic-invocation.md) (Autonomic Invocation). `Stop` has been allocated to EPIC-011 since FEAT-009's plan; `PreCompact` moved there from EPIC-010 by directing-party decision on 2026-08-24:

| Hook | Role | State |
|---|---|---|
| `SessionStart` | Inject a terse health summary (drift count, stuck items, push lag) so the directing party opens a session already oriented | Shipped (EPIC-010) |
| `PreToolUse` | Write-guard — refuse writes outside `docs/supervisor/` from a supervisor-scoped invocation | Shipped (EPIC-009) |
| `PostToolUse` | Log supervisor operations for audit trail | Shipped (EPIC-009) |
| `PreCompact` | Snapshot in-flight findings before context compaction so the report survives compaction | Pending EPIC-011 |
| `Stop` | Run a completion check; warn if context is still over threshold or if findings remain unflushed | Pending EPIC-011 |

Hook configuration lives in the project's `settings.json` per Claude Code conventions. Event names are written exactly as Claude Code's hooks reference spells them (`PreCompact`, not `preCompact`), since a misspelt key registers nothing; specific hook bodies ship with the supervisor skill.

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
| Task | `./docs/tasks/TASK-XXX-slug.md` (or `./docs/tasks/archive/` after an authorised archive move) | Plus an entry in `task_index.md` |
| Spike | `./spikes/SPIKE-XXX-slug.md` | Project root, not under `docs/`; plus entry in `spike_index.md` |
| Knowledge Note | `./docs/knowledge/<slug>.md` | Plus entry in `knowledge_index.md` |
| Scratchpad | `./docs/scratchpad.md` | One file per project with § Items and § Processed; instantiated by `/shannon-setup` from `work-items/templates/scratchpad.md`; no IDs and no index |
| Supervisor Report | `./docs/supervisor/report-YYYY-MM-DD.md` | A Knowledge Note subtype per conceptual_design § Domain Model → *Knowledge Note*; ID is the report's ISO date. Indexed in `knowledge_index.md` like any other note |
| Supervisor Configuration | `./.claude/shannon-supervisor.json` | Report settings; legacy gate fields have no authority |
| Cadence State (optional) | `./.claude/supervisor/state.json` | Optional inter-run state file; see *Cadence State* below |

### ID Allocation

Work item IDs are sequential within their type (FEAT-001, FEAT-002, ...). The skill responsible for creation finds the highest existing ID in the index and increments. ID allocation has no concurrency control — under V6 cooperative access (see Security Model), concurrent agents must coordinate by convention; simultaneous creates would produce colliding IDs and would surface as a merge conflict rather than be prevented at the framework level.

### Slugs

File names use kebab-case slugs derived from the work item name. Slugs are stable once assigned; renaming a work item does not change its slug or filename.

### Supervisor Report Files

Supervisor reports are Knowledge Notes per the subtype extension at conceptual_design § Domain Model → *Knowledge Note*. They differ from other knowledge notes only by location and naming: they live at `./docs/supervisor/report-YYYY-MM-DD.md` rather than `./docs/knowledge/<slug>.md`, and their identifier is the run's ISO date rather than a slug. The directory separation makes supervisor output easy to scope (e.g. for the PreToolUse write-guard at § System Architecture → *Supervisor* → *Hook integration*). Reports are indexed in `knowledge_index.md` with their type marked as *Supervisor Report*.

Reports are never overwritten — each cadence run produces a new dated file. If two runs occur on the same date (rare; e.g. a manual `/shannon-report` after an autonomous nightly run), the second run appends a suffix: `report-YYYY-MM-DD-<n>.md`.

### Supervisor Configuration

The optional `./.claude/shannon-supervisor.json` controls report presentation/storage, for example `{"report_directory": "docs/supervisor"}`. Missing configuration uses defaults; malformed configuration is reported and refused.

Legacy `epic_gate_authority` and `spike_gate_authority` fields are retained as compatibility inputs but do not grant or create approval stages. Report that they no longer govern gate authority. A separately recorded explicit project hold remains an obligation until dispositioned. Human Vision/Feature gates cannot be delegated through configuration. Existing files are not automatically deleted or rewritten.

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

All five command names remain available. Features use create, elaborate (Gate 1), plan (Gate 2), implement and review (Gate 3). `/feature-implement` performs delivery directly; it does not merely route to an Epic.

Epic/Task/Spike verbs are optional agent-managed record operations. Their invocation does not require a particular prior progress label or a human approval stage. Scope, governing intent and actual verification remain required. Compatibility labels may be retained honestly; lower-level APPROVED in an old record is historical and cannot be treated as Feature acceptance.

### Document Verbs

Documents have a simpler surface:

- `document-create [type]` — Instantiate a mandated document or knowledge note
- `document-review [path]` — Review and approve a document

### Supervisor Verbs

Two supervisor commands surface the cadence and goal-decomposition flows (see § System Architecture → *Supervisor*):

- `/shannon-report` — Run a cadence audit and write a dated report
- `/shannon-goal [intent]` — Decompose a directing-party intent into candidate work items

### Scratchpad Verbs

The scratchpad uses the `[type]-[verb]` pattern with its own two verbs, both handled by the `work-items` skill:

- `/scratchpad-add [idea]` — Append one line under § Items
- `/scratchpad-process` — Give each item a disposition and move it to § Processed (see `conceptual_design.md` § Key Workflows → *Processing the Scratchpad*)

Capture stays a one-line edit, so the verbs exist for discoverability and for the processing rhythm, not because a direct edit is wrong.

### Skill Invocation Pattern

Commands invoke skills via explicit wording in the command's Markdown body. To ensure reliable activation:

1. Commands state explicitly: "You MUST invoke the [skill] skill"
2. Skills begin with a self-identification line confirming they were activated
3. Commands include fallback wording: "If the skill did not activate, report the error"

This redundancy guards against silent skill-loading failures.

---

## Key Algorithms

### Cascading Operations: Batch Preparation, Individual Gates

This retained section name records a superseded mechanism. Current delivery is Feature-led: human Gate 2 authorises the approach and consequential trade-offs, not a mandatory child hierarchy. Agents may prepare execution notes or child records when useful, but each child has no mandatory human gate. Maintain existing indexes only for records actually used; no speculative child creation is required. Link implementation, verification and independent-review evidence from the Feature. Preserve existing identifiers/history rather than bulk-renaming or archiving them.

### Document Alignment Check

Read the target document, relevant higher-authority neighbours and affected Features/implementation; cite actual governing sections. The agent can do this directly or use separately authorised helpers. Classify Drift, Gap, Internal contradiction and Strength; report unknowns rather than inventing findings. Maintain factual alignment within approved intent, and return consequential changes to the human. Do not create a human gate for each mechanical documentation correction.

## Security Model

Shannon adds no network calls of its own; the framework operates on local files within the Claude Code runtime. Its security model is the security model of Claude Code plus three Shannon-specific stances.

- **Authentication**: None — Shannon has no notion of identity. The directing party is whoever is invoking commands in the Claude Code session
- **Authorisation**: None at the framework level; project-specific authorisation lives in the project's own technical_design.md
- **Trust boundary**: Commands and skills installed by Shannon execute under Claude Code's permission model. The directing party reviews and approves commands and tool uses like any other Claude Code skill

### Cooperative Access

The file-based model assumes cooperative access. Concurrent writes by multiple agents are out of scope at this version. Multi-agent configurations (e.g. supervising agent + implementing agent under V6) coordinate by convention: each agent operates on disjoint work items, or surfaces concurrent edits as ordinary diffs to be resolved by the directing party. There is no file locking and no transaction layer.

### Gate Enforcement

The human owns Vision and Feature requirements/approach/delivery gates. Optional Epics/Tasks/Spikes have no mandatory approval gates. Meaning-changing document decisions, scope/cost/access changes and explicit project holds remain human decisions. Enforcement by Markdown instructions is a convention, not a technical security boundary; real tool permissions and repository protection remain in force. Independent technical review must come from a reviewer who did not implement the change, and is separate from human product acceptance.

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
- **`--allowedTools`** — explicit allow-list scoped to read operations and read-only git invocations; the supervisor is read-mostly and writes only its dated report. When the cadence run needs to write its report, `--allowedTools` is extended to include `Write(docs/supervisor/*)`; the PreToolUse hook (§ System Architecture → *Supervisor* → *Hook integration*) enforces the path scope at runtime once the invocation sets `SHANNON_SUPERVISOR_SCOPE`. Until EPIC-011's launcher sets that signal the write-guard is inert, so the path scope rests on `--allowedTools` alone
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

### 2026-11-13 - v2.1

- **Scratchpad ratified (FEAT-007).** Added the Scratchpad row to § Data Model and § API Design → *Scratchpad Verbs* (`/scratchpad-add`, `/scratchpad-process`, both in the `work-items` skill). Additive: it ratifies the capability Vision § Key Features *Lightweight Idea Capture* and FEAT-007's approved requirements already name, and contradicts no approved claim. The document stays APPROVED.

### 2026-11-01 - v2.0

- Substantive revision approved by Ben: preserve all six documents and alignment, trace everything from the Vision, retain human Feature gates, and let agents manage execution below Features. Independent review remains distinct from implementation. Historical work records and identifiers are preserved.


### 2026-10-17 - v1.4

- Corrections from the 2026-10-17 scratchpad triage, each checked against the shipped files:
  - **§ System Architecture → *Supervisor* → *Hook integration*** — the compaction hook is written `PreCompact`, the casing Claude Code's hooks reference uses (https://code.claude.com/docs/en/hooks); settings keys are case-sensitive, so the lowercase form would register nothing. A sentence now says event names follow the reference's spelling
  - **§ Cadence → *Headless invocation contract*** — the `--allowedTools` bullet no longer claims runtime enforcement unconditionally: the PreToolUse write-guard is inert until `SHANNON_SUPERVISOR_SCOPE` is set, which EPIC-011 builds
  - **§ System Architecture → *Skills*** — four skills, not three; the table gains `shannon-supervisor`, and the manifest-casing difference (`skill.md` vs `SKILL.md`) is named as open
  - **§ System Architecture → *Supervisor* → *Skill directory layout*** — adds the shipped `hooks/` directory and names hook bodies under `scripts/`
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing → *Status semantics***: no commitment changes; stated facts are brought in line with what ships. Document stays APPROVED across the bump
- Status: APPROVED (2026-10-17, on directing-party merge)

### 2026-10-08 - v1.3

- Corrects present-tense drift in § System Architecture → *Supervisor* → *Hook integration*, surfaced by the Alignment checker in supervisor report 2026-09-29 (Gap: "`technical_design.md` claims five supervisor hooks in the present tense; three are registered"):
  - The five-hook design is restated as the **committed architecture**, and the table gains a *State* column: SessionStart (EPIC-010), PreToolUse and PostToolUse (EPIC-009) shipped; preCompact and Stop pending EPIC-011 (Stop by FEAT-009's original allocation; preCompact by the 2026-08-24 deferral recorded in EPIC-010 and EPIC-011's Activity Logs)
  - Verified against the shipped registration snippets at `shannon/skills/shannon-supervisor/hooks/` (sessionstart, pretooluse, posttooluse — no preCompact or Stop)
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing → *Status semantics***: the five-hook commitment is unchanged; only its delivery state is now stated. Document stays APPROVED across the bump (no DRAFT transition)
- Status: APPROVED (2026-10-08, on directing-party merge)

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
