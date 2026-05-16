# Technology Stack

**Status**: APPROVED
**Last Reviewed**: 2026-05-16
**Approved**: 2026-05-16

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
- **Aligns to**: Vision § Core Principles ("Living Documentation"); no build step, no runtime services

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
- **Cooperative access assumption** — The file-based model assumes cooperative access. Concurrent writes by multiple agents are out of scope at this version; the *Supervisor Distinct From Implementer* rule (conceptual_design.md) is enforced by convention, not by technical concurrency control

---

## Performance Targets

- **Setup latency** — `/shannon-setup` must complete in under 5 minutes from first invocation to first ready-to-implement task
- **Context overhead** — Mandated documents should be readable within the AI's working context without summarisation; target <20K tokens per mandated document for typical projects
- **Index operations** — Work item index updates must be O(1) appends or in-place edits; no full-file rewrites required for status transitions

---

## Future Considerations

- **Distribution channels** — npm package, pip package, curl install script, GitHub template repository; each lowers the barrier to first use
- **Project type templates** — Pre-customised template sets for common project types (web app, CLI tool, library); reduce the editing burden of first setup
- **Cross-tool portability** — Templates may evolve to be usable outside Claude Code (other AI coding assistants) with minimal adaptation, but Shannon's command/skill workflow remains Claude Code-specific

---

## Version History

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
