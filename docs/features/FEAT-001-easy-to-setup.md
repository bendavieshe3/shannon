# FEAT-001: Easy to Setup

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Mandated Project Documentation" and "Commands + Skills + Subagents"
- **Created**: 2025-11-09
- **Updated**: 2026-05-15

---

## Requirements

### Overview

Developers can discover, download, install, and integrate Shannon into their projects with minimal effort and clear guidance. The setup process covers sourcing Shannon from GitHub, copying files into the project structure (`.claude/` directory), and integrating with either fresh or existing projects. Setup is intelligent, safe, and idempotent — it establishes the documentation structure and guides developers through initial vision and technical decisions without forcing them to read a manual first.

This feature is foundational. Every other Shannon capability depends on a developer successfully getting from "interested" to "set up."

### Ideal State

- Developers can find Shannon easily via GitHub, documentation, and (eventually) package registries
- Multiple installation channels exist: `git clone`, curl script, GitHub template repository, language-ecosystem packages
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

- **Vision**: § Key Features ("Mandated Project Documentation"), § Success Metrics ("Setup time under 5 minutes")
- **Technology Stack**: Markdown-based, no build step, git as primary distribution
- **Technical Design**: File-based deployment into `.claude/` and `docs/`

---

## Plan

### Epics

- [EPIC-001](../epics/EPIC-001-basic-installation.md) — DRAFT — Basic Installation
- [EPIC-002](../epics/EPIC-002-smart-installation.md) — DRAFT — Smart Installation
- [EPIC-003](../epics/EPIC-003-version-management.md) — DRAFT — Version Management
- [EPIC-004](../epics/EPIC-004-distribution-channels.md) — DRAFT — Distribution Channels

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

- **2026-05-15** — Re-elaborated as part of refactor: migrated 4 phases into 4 epics (EPIC-001 through EPIC-004), restructured to new feature template, status set to ELABORATED pending re-approval
- **2025-11-11** — Feature review (Health Score 5/10): flagged stalled state, doc approval backlog, Phase 1 not initiated, Phase 4 possibly overambitious. Recommendations carried forward into epic structure
- **2025-11-09** — DRAFT: Initial feature created with 12 user stories across Discovery & Installation, Setup & Integration, Maintenance & Updates; planned 4-phase roadmap
