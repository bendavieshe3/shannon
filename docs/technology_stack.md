# Technology Stack

**Status**: APPROVED
**Last Reviewed**: 2026-05-29
**Approved**: 2026-05-29

---

**Project Name**: Shannon

## Architecture Overview

Shannon is a file-based framework with no runtime. It runs entirely inside Claude Code, using Markdown files as templates, commands, skills, and project documentation. The "system" is the convention — directory structure, file naming, and the prompts inside command and skill files that direct Claude through workflows. There is no compiled artefact, no service, no daemon.

A Shannon-equipped project consists of: a `.claude/` directory containing commands, skills, and templates; a `docs/` directory containing project documentation and work items; and (optionally) a `spikes/` directory for disposable exploratory work. Everything is plain text, everything is human-readable without tooling.

---

## Core Technologies

### Markdown (CommonMark)

- **Purpose**: Format for all templates, commands, skills, documents, and work items
- **Rationale**: Renderable everywhere, diff-friendly, no build step required, AI-native
- **Trade-offs**: No type checking or validation — relies on convention and AI discipline to maintain structure
- **Aligns to**: Vision § Core Principles ("Adaptive Coherence"); no build step, no runtime services

### Claude Code (Anthropic CLI)

- **Purpose**: Runtime that interprets commands, invokes skills, and orchestrates subagents
- **Rationale**: Native support for slash commands, skills, and subagent spawning; primary AI development surface for Shannon's target users
- **Trade-offs**: Locks Shannon to the Claude Code ecosystem; users without it cannot use the framework as a workflow tool, though the templates remain useful as documentation conventions
- **Aligns to**: Vision § Target Users (solo developers using Claude Code)

### Git

- **Purpose**: Version control for templates, commands, skills, and the dogfood `docs/`; primary distribution mechanism (`git clone`)
- **Rationale**: Ubiquitous, plain-text friendly, no additional infrastructure required
- **Trade-offs**: Users must have git to install via the recommended path; alternative install paths (curl script, package managers) are roadmap items

---

## Data Layer

Shannon has no persistent runtime data. All "state" lives in the project's Markdown files (work items, indexes, documents). The filesystem is the database.

- **Markdown files** — Source of truth for all project state
- **Index files** (`feature_index.md`, `epic_index.md`, `task_index.md`, `spike_index.md`, `knowledge_index.md`) — Flat lists with status; maintained by AI as work items transition

---

## External Integrations

Shannon itself has no external integrations. Projects built with Shannon will have their own integrations, documented in their own technology_stack.md.

---

## Development Tooling

- **Claude Code** — The development environment for Shannon itself
- **Markdown linter** *(optional)* — Templates are plain text; no formal lint required, but contributors may use one locally

---

## Infrastructure

- **GitHub** — Source repository, distribution point, issue tracking
- **No CI/CD** — Shannon has no code to build, test, or deploy. Validation happens by using the templates in real projects

---

## Key Dependencies

Shannon has no runtime dependencies. The only requirement is Claude Code.

---

## Security Considerations

- **No secrets** — Shannon stores no credentials. Projects built with Shannon document their own secrets management in their development_guide.md
- **No Shannon-originated network calls** — Shannon adds no network calls of its own; the framework operates on local files within the Claude Code runtime (which makes its own network calls outside Shannon's scope)
- **Trust boundary** — When Shannon templates and commands are installed into a project, they execute as part of Claude Code's permission model; the directing party reviews and approves commands like any other Claude Code skill or command
- **Cooperative access assumption** — The file-based model assumes cooperative access. Concurrent writes by multiple agents are out of scope at this version. The three roles named at `vision.md` § Target Users → *Three roles, configurably separable* (directing party, supervisor, implementer) coexist on shared files by convention — including the canonical gate-integrity constraint (the agent approving any gate is not the same agent that produced the work under review, per `conceptual_design.md` § Business Rules → *Supervisor Distinct From Implementer*). Enforcement is by skill protocol and reviewer discipline, not by technical concurrency control or agent-identity attestation

---

## Performance Targets

- **Setup latency** — `/shannon-setup` must complete in under 5 minutes from first invocation to first ready-to-implement task
- **Context overhead** — Mandated documents should be readable within the AI's working context without summarisation; target <20K tokens per mandated document for typical projects
- **Index operations** — Work item index updates must be O(1) appends or in-place edits; no full-file rewrites required for status transitions

---

## Supervisor Tooling

The supervisor role introduced at Vision v2.4 (§ Core Principles → *Continuous Health Vigilance*; § Target Users → *Three roles, configurably separable*) requires Claude Code primitives that support continuous, cadence-driven, optionally autonomous operation. Shannon commits to building on the five primitives below — all production-ready as of the May 2026 capability survey — and explicitly defers four others that are not yet ready for load-bearing use.

### Committed primitives

- **Hooks** (`SessionStart`, `PreToolUse`, `PostToolUse`, `preCompact`, `Stop`) — Lifecycle interception points used to inject health summaries at session start, guard against accidental writes outside supervisor scope, log operations for audit trail, snapshot findings before context compaction, and run completion checks. All five hook kinds are production-ready.
- **Subagents** — Specialised parallel checkers (alignment, lifecycle, drift) run with isolated context windows, per-task model selection (Haiku for fast scans, Sonnet for synthesis), and restricted tool access. The existing Commands + Skills + Subagents architecture (see `technical_design.md` § System Architecture) already commits to subagents for context-heavy reading; the supervisor extends that commitment to parallel health checks.
- **Headless mode** (`claude -p`) **with an external cron mechanism the project configures** — The autonomous-cadence invocation path for the supervisor. Shannon commits to the *pattern* (headless invocation triggered by an external scheduler) and leaves the specific scheduler (a host cron daemon, a launchd job, a remote scheduler such as OpenClaw, or equivalent) to the project's configuration. Structured output (`--output-format json`, `--json-schema`) and explicit `--allowedTools` make headless runs scriptable and auditable.
- **Worktree isolation** (`--worktree`) — Read-only audits run in a temporary worktree so the supervisor never contaminates the interactive working tree. Used when the audit cadence overlaps with interactive directing-party sessions.
- **Skill frontmatter control** (`model`, `allowed-tools`, `disable-model-invocation`) — Per-invocation control over which model runs a skill, which tools it may call, and whether the skill can be auto-invoked by the model versus only by explicit directing-party action. Used to restrict supervisor skills to read-mostly tool access and to scope writes to `docs/supervisor/`.

### Explicitly deferred

Named so the boundary is honest, not implied:

- **Cloud Routines** (Claude-hosted scheduled runs) — Research preview; no SLA. Revisit Phase 5+ once stable.
- **Managed Agents** (hosted REST agent loop) — Beta; reliability guarantees unspecified. Revisit Phase 5+.
- **MCP server exposure of Shannon project state** — Useful for cross-agent queries but not required by the supervisor itself. Phase 3 enhancement, not a Phase 2/4 prerequisite.
- **Statusline as a full report surface** — The statusline's terse single-line format suits summary metrics (counts of stuck items, drift hits) but is not a substitute for full reports. Full supervisor reports go to Markdown files; the statusline at most carries a one-line summary.

### Configuration storage

Per `conceptual_design.md` § Business Rules → *Gate Authority Split*, the Epic and Spike gate-authority ceilings are configurable per project. Shannon stores this configuration under `./.claude/` (the same root that houses commands, skills, and templates). The specific filename and schema are codified in `technical_design.md` § Data Model. Storing supervisor configuration under `./.claude/` keeps the project's Shannon installation self-describing and version-controllable through the same Git mechanism the rest of the framework relies on.

### Aligns to

Vision § Core Principles 5 (*Continuous Health Vigilance*) and Vision § Key Features (*Supervisor Role* — "invokable both interactively … and autonomously … on a cadence the project configures"). The committed-versus-deferred split discharges the vision-level commitment honestly: Shannon's autonomous cadence rides on production-ready primitives, not on research-preview ones.

---

## Future Considerations

- **Distribution channels** — npm package, pip package, curl install script, GitHub template repository; each lowers the barrier to first use
- **Project type templates** — Pre-customised template sets for common project types (web app, CLI tool, library); reduce the editing burden of first setup
- **Cross-tool portability** — Templates may evolve to be usable outside Claude Code (other AI coding assistants) with minimal adaptation, but Shannon's command/skill workflow remains Claude Code-specific

---

## Version History

### 2026-05-29 - v1.3

- Cascade from Vision v2.4 (APPROVED 2026-05-28, commit `d2fd797`) and sibling conceptual_design v1.7 (APPROVED 2026-05-29, commit `a8fe1e0`) introducing the supervisor as a third role and codifying the gate-authority split. Pass 1 alignment surfaced findings T-1 through T-3; this version addresses T-1 (Supervisor Tooling gap) and T-2 (Cooperative access refresh); T-3 (cadence performance target) is consciously deferred per the rationale below
  - **§ Supervisor Tooling (new top-level section)** — names the five primitives Shannon commits to relying on for the supervisor (Hooks, Subagents, Headless mode + external cron, Worktree isolation, Skill frontmatter control), explicitly defers four immature alternatives (Cloud Routines, Managed Agents, MCP server exposure of Shannon state, statusline-as-full-report), and commits to `./.claude/` as the configuration root for per-project Epic and Spike gate-authority ceilings (with the specific schema location codified in `technical_design.md` § Data Model)
  - **§ Security Considerations → *Cooperative access assumption*** — refreshed to reference the canonical three-role taxonomy (directing party / supervisor / implementer) per Vision v2.4 § Target Users → *Three roles, configurably separable* and conceptual_design v1.7 § Business Rules → *Supervisor Distinct From Implementer*. v1.2's load-bearing claim (enforced by convention, not by technical concurrency control) is preserved verbatim in substance; only the role-taxonomy cross-reference is updated to the canonical vocabulary
- **Performance Targets cadence commitment deliberately deferred**: supervisor invocations land via headless mode on a project-configured cadence, but Shannon-level performance numbers (cycle duration, per-checker latency) await Phase 2 implementation evidence and a chosen measurement context. Surface as a candidate target once FEAT-009 Phase 2 has lived data
- **External cron mechanism left abstract**: the spike report names OpenClaw as the directing party's preferred scheduler, but technology_stack v1.3 commits only to the *pattern* (headless mode + external scheduler the project configures) rather than to a specific scheduler. Rationale: Shannon should not bake in a personal tool; the spike confirms the pattern works with multiple cron implementations. Specific scheduler choice lives in each project's own `development_guide.md`
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing**: no v1.2 approved claim is contradicted. The *Cooperative access* refresh updates the role-taxonomy cross-reference but preserves the enforcement-by-convention claim; all other changes are net-new commitments. Document stays APPROVED across the bump (no DRAFT transition)
- Status: APPROVED (2026-05-29)

### 2026-05-19 - v1.2

- Maintenance amendment cascading from Vision v2.3 (Principle 4 renamed "Living Documentation" → "Adaptive Coherence"). Markdown § *Aligns to* updated to track the new principle name. No semantic change; pure reference refresh.
- Status: APPROVED (2026-05-19)

### 2026-05-16 - v1.1

- Applied Gate 1 review findings:
  - **TS1**: Removed unsupported "must work offline with no tooling" claim from Markdown alignment line; replaced with "no build step, no runtime services" which vision does support
  - **TS2**: Reframed Security Considerations "No network calls" — Shannon adds no network calls of its own, but the Claude Code runtime makes its own; the original wording was an overclaim and literally false at runtime
  - **TS3**: Added "Cooperative access assumption" to Security Considerations naming the multi-agent / concurrent-write boundary under V6; the Supervisor Distinct From Implementer rule is enforced by convention, not concurrency control
- Status: APPROVED (2026-05-16)

### 2026-05-15 - v1.0

- Initial technology stack drafted
- Status: DRAFT

---

## What Belongs Here (and What Doesn't)

✅ Markdown / Claude Code / Git as core technologies and rationale
✅ Trade-offs and limitations of the file-based approach
✅ Performance targets specific to a file-based framework
✅ Alignment to vision

❌ How to install Shannon (→ development_guide.md)
❌ Directory structure details (→ technical_design.md)
❌ Command and skill mechanics (→ technical_design.md)
