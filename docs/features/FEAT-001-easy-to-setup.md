# FEAT-001: Easy to Setup

## Metadata

- **Status**: IMPLEMENTED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Mandated Project Documentation" and "Commands + Skills + Subagents"
- **Created**: 2025-11-09
- **Updated**: 2026-11-14

---

## Requirements

### Overview

Developers can discover, download, install, and integrate Shannon into their projects with minimal effort and clear guidance. The setup process covers sourcing Shannon from GitHub, copying files into the project structure (`.claude/` directory), and integrating with either fresh or existing projects. Setup is intelligent, safe, and idempotent — it establishes the documentation structure and guides developers through initial vision and technical decisions without forcing them to read a manual first.

This feature is foundational. Every other Shannon capability depends on a developer successfully getting from "interested" to "set up."

### Ideal State

- Developers can find Shannon easily via GitHub and its documentation
- Installation needs only `git clone` and `/shannon-setup`; upgrades only a newer clone and `/shannon-update` (optionally, a GitHub template repository)
- A single command (`/shannon-setup`) detects project type and customises appropriately
- Installation distinguishes fresh projects from existing ones and adapts behaviour
- Existing `.claude/` customisations are preserved across installs and updates
- An interactive setup flow elicits initial product vision and key technical decisions
- Integration verification confirms setup completed successfully
- Updates are available with smart merging of template changes
- Zero configuration for simple cases, full customisation for advanced users
- Version tracking and update notifications are built into the framework
- Clear changelog and migration guides accompany every version

### User Stories

#### Discovery and Installation

**As a** developer,
**I want** to discover Shannon easily through documentation and GitHub,
**So that** I can evaluate whether it fits my needs.

**As a** developer,
**I want** to clone or download Shannon with a single command,
**So that** I can get started quickly.

**As a** developer,
**I want** to install Shannon into my project's `.claude/` directory,
**So that** all templates and commands are available.

#### Setup and Integration

**As a** developer,
**I want** to run `/shannon-setup` and have all mandated documents instantiated,
**So that** I have a complete framework ready to use.

**As a** developer,
**I want** existing `.claude/` customisations preserved during installation,
**So that** I don't lose my work.

**As a** developer,
**I want** to be guided through initial product vision setup,
**So that** my documentation starts with real context.

**As a** developer,
**I want** to choose whether to start fresh or integrate with an existing project,
**So that** Shannon adapts to my situation.

**As a** developer,
**I want** setup to complete in under 5 minutes,
**So that** I can start real development work quickly.

#### Maintenance and Updates

**As a** developer,
**I want** to know which version of Shannon I'm using,
**So that** I understand which features are available.

**As a** developer,
**I want** to be notified when a newer version is available,
**So that** I can stay current.

**As a** developer,
**I want** to update Shannon without losing my customisations,
**So that** maintenance is low-effort.

**As a** developer,
**I want** to see what changed between versions,
**So that** I can decide when to upgrade.

### Context

- **Vision**: § Key Features ("Mandated Project Documentation"), § Measurable Targets ("Setup time" under 5 minutes)
- **Technology Stack**: Markdown-based, no build step, git as primary distribution
- **Technical Design**: File-based deployment into `.claude/` and `docs/`

---

## Plan

### Approach (finish-to-vision push, 2026-11-13; Gate 2 approved 2026-11-14)

Delivered directly under this Feature, without the Epics (Vision v3.0). The Epics below are kept as the record of the original split.

- **Basic installation (EPIC-001)**: already met. The README documents clone, copy and `/shannon-setup`, and setup instantiates the documents idempotently and captures the first vision pass.
- **Smart installation (EPIC-002)**: in source. `/shannon-setup` reports existing `.claude/` contents, backs up to `.claude/.shannon-backup/YYYY-MM-DD/` before overwriting, merges `CLAUDE.md` inside `<!-- shannon:begin/end -->` markers, merges `.claude/settings.json`, detects Node, Python, Go and Rust projects to pre-fill the stack and build commands, and verifies the result, including that every skill loads.
- **Version management (EPIC-003)**: in source. `shannon/guides/CHANGELOG.md` is the version source; installs record `.claude/.shannon-version` and a hash manifest; `/shannon-update [path]` reports versions, classifies customised files, backs up, and walks records through each entry's *Records* notes. With no network calls, "latest available" is whatever clone the directing party has pulled.
- **Supervisor deployment (EPIC-016, FEAT-009)**: in source. Setup merges the hook snippets, writes the default `shannon-supervisor.json`, ignores the audit log and creates `docs/supervisor/`.
- **Distribution channels (EPIC-004)**: cut approved by the directing party 2026-11-14. Keep git clone and an optional GitHub template repository; drop the curl script and the npm and pip packages, because a Markdown-only framework with no build step gains little from packaging and each channel adds release maintenance. The Ideal State's channel bullet is trimmed to match (Gate 1 and Gate 2, 2026-11-14).

**Evidence (live, `claude -p` 2.1.325, scratch projects):** a first install into a Node project with an existing `CLAUDE.md`, a `.claude/commands/deploy.md` and a `settings.json` holding a user hook and permission kept all three. It merged the four hooks once each, backed up the three touched files, pre-filled pnpm build and test commands marked *confirm at review*, and its verification caught the supervisor skill's missing frontmatter (since fixed). An update to a 5.2 fixture kept one customised command, merged another, applied a *meaning* Records note to an existing Feature as a re-elaboration, and verified. A dry run to 5.3 classified files against the manifest correctly.

### Epics

- [EPIC-001](../epics/EPIC-001-basic-installation.md) — DRAFT, met — Basic Installation
- [EPIC-002](../epics/EPIC-002-smart-installation.md) — DRAFT, delivered directly 2026-11-13 — Smart Installation
- [EPIC-003](../epics/EPIC-003-version-management.md) — DRAFT, delivered directly 2026-11-13 — Version Management
- [EPIC-004](../epics/EPIC-004-distribution-channels.md) — DRAFT (SUPERSEDED by the 2026-11-14 distribution cut) — Distribution Channels

### Dependencies

**Depends on**:

- GitHub repository for distribution
- README with clear installation instructions
- Template files under `shannon/skills/*/templates/`
- `/shannon-setup` command implementation (EPIC-001)

**Depended on by**:

- Every Shannon capability — installation is the prerequisite for using the framework at all
- Documentation Maintenance features depend on version tracking (EPIC-003)

### Risks

- **EPIC-004 scope** — The 2025-11-11 health review flagged distribution channels (especially npm/pip) as possibly overambitious. Revisit scope when planning EPIC-004
- **Smart-installation correctness** — EPIC-002's customisation preservation must be near-perfect; a single lost customisation breaks user trust in updates

---

## Success Metrics

- **Installation time** — First-time install completes in under 2 minutes
- **Installation success rate** — 95%+ of attempted installations complete without manual intervention
- **Setup completion rate** — 90%+ of users who start `/shannon-setup` finish it
- **Customisation preservation** — 100% of user customisations preserved across updates (zero data loss target)
- **User-reported setup issues** — Under 5% of users report setup problems

---

## Activity Log

- **2026-11-14** — ELABORATED → PLANNED → IMPLEMENTED. Gate 2 (approach, including the distribution cut and the trimmed Ideal State bullet, which also takes Gate 1) approved by the directing party's approval of 2026-11-14 ("yes, pending decisions as recommended" on 2026-11-13, then "Just do it. Just do it all"), which covers the finish-to-vision plan offered on the Gate 2 card. Delivered in Shannon 5.1 (PR #16, merged 2026-11-14 as 65e307f): `/shannon-update`, version and manifest files, `guides/CHANGELOG.md`, smart setup with backups, marked `CLAUDE.md` merge, `settings.json` merge, project-type detection, supervisor wiring and verification; the `SKILL.md` rename with a case-insensitive-filesystem step. Independent review: two reviewers that neither wrote nor pushed the PR passed it at db33cc0. Awaiting the directing party's Gate 3.
- **2026-11-13** — Implementation in source of smart installation, versioning and update, and supervisor wiring, delivered directly under this Feature (see Plan § Approach). The approach and the distribution cut are offered to the directing party for Gate 2, and Gate 1 for the trimmed Ideal State bullet. No status change until then.
- **2026-05-15** — Re-elaborated as part of refactor: migrated 4 phases into 4 epics (EPIC-001 through EPIC-004), restructured to new feature template, status set to ELABORATED pending re-approval
- **2025-11-11** — Feature review (Health Score 5/10): flagged stalled state, doc approval backlog, Phase 1 not initiated, Phase 4 possibly overambitious. Recommendations carried forward into epic structure
- **2025-11-09** — DRAFT: Initial feature created with 12 user stories across Discovery & Installation, Setup & Integration, Maintenance & Updates; planned 4-phase roadmap
