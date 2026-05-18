# EPIC-002: Smart Installation

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-001](../features/FEAT-001-easy-to-setup.md)
- **Created**: 2026-05-15
- **Updated**: 2026-05-15

---

## Requirements

### Overview

Make installation intelligent: detect existing `.claude/` customisations, preserve them across updates, intelligently merge `CLAUDE.md`, detect project type, and verify installation success. This epic raises the floor from "works on a clean directory" to "works safely on a project that already has Claude Code state."

### Goal

A developer can install or update Shannon in a project that already has Claude Code customisations, and the installation preserves every customisation while bringing Shannon's structure online.

### Acceptance Criteria

- [ ] Installation detects existing `.claude/` contents and reports what it found
- [ ] Existing files are backed up before any overwrite
- [ ] `CLAUDE.md` merge preserves user content; Shannon-managed sections are clearly delineated
- [ ] Installation detects common project types (Node, Python, generic) and selects appropriate template defaults
- [ ] A post-install verification step confirms the framework is fully wired up

### Context

- **Parent Feature**: FEAT-001 — Easy to Setup
- **Vision**: § Core Principles ("Adaptive Coherence" — absorbing change without losing alignment is precisely what Smart Installation does when preserving customisations across framework updates)
- **Technical Design**: § Data Model (file structure to preserve)

---

## Plan

[To be filled during `/epic-plan EPIC-002`.]

### Approach

[High-level approach. Which tasks combine to deliver the goal.]

### Tasks

[To be created during planning.]

### Dependencies

**Depends on**: [EPIC-001](./EPIC-001-basic-installation.md) — basic installation must exist before smart installation can extend it

**Depended on by**: EPIC-003 (version management relies on safe update behaviour)

### Risks

- [To be identified during planning]

---

## Activity Log

- **2026-05-19** — Context references refreshed: Vision § Core Principles updated to "Adaptive Coherence" (Vision v2.3 rename); stale "Document Authority Graph" reference removed (was excluded from Vision § Key Features back in v2.1).
- **2026-05-15** — DRAFT: Created as part of refactor; migrated from FEAT-001 Phase 2
