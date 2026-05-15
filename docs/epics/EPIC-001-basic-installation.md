# EPIC-001: Basic Installation

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-001](../features/FEAT-001-easy-to-setup.md)
- **Created**: 2026-05-15
- **Updated**: 2026-05-15

---

## Requirements

### Overview

Enable a developer to manually install Shannon into a project and run `/shannon-setup` to initialise the documentation structure. This is the minimum viable path from "interested user" to "ready to do work" — no version tracking, no smart merging, no distribution channels beyond `git clone`.

### Goal

A developer can clone Shannon, copy the framework into their project's `.claude/`, run `/shannon-setup`, and have a complete documentation skeleton ready for their first feature.

### Acceptance Criteria

- [ ] README documents the installation steps clearly and completely
- [ ] `/shannon-setup` command exists and instantiates all mandated documents
- [ ] Setup deploys templates from `shannon/skills/*/templates/` into the project's `docs/` and `.claude/`
- [ ] Setup is idempotent — running it twice does not duplicate or corrupt files
- [ ] Setup prompts for and captures initial product vision content

### Context

- **Parent Feature**: FEAT-001 — Easy to Setup
- **Vision**: § Key Features ("Mandated Project Documentation")
- **Technical Design**: § System Architecture (Commands + Skills + Subagents), § Data Model (file structure)

---

## Plan

[To be filled during `/epic-plan EPIC-001`.]

### Approach

[High-level approach. Which tasks combine to deliver the goal.]

### Tasks

[To be created during planning.]

### Dependencies

**Depends on**: None — this is the foundational epic.

**Depended on by**: All subsequent epics (smart installation, version management, distribution channels) require basic installation to work.

### Risks

- [To be identified during planning]

---

## Activity Log

- **2026-05-15** — DRAFT: Created as part of refactor; migrated from FEAT-001 Phase 1
