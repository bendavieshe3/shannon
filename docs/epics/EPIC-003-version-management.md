# EPIC-003: Version Management

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-001](../features/FEAT-001-easy-to-setup.md)
- **Created**: 2026-05-15
- **Updated**: 2026-05-15

---

## Requirements

### Overview

Track which version of Shannon is installed in a project, surface update availability, and enable safe upgrades. Without version tracking, users cannot reason about which features they have or whether they should upgrade.

### Goal

A developer can answer "which version of Shannon am I on?", be notified when a newer version is available, upgrade without losing their customisations, and see what changed between versions.

### Acceptance Criteria

- [ ] `.claude/.shannon-version` file tracks installed version
- [ ] A command (e.g. `/shannon-version`) reports current version and latest available
- [ ] Update flow safely upgrades framework files while preserving project content
- [ ] Each release ships with a changelog readable from within Claude Code
- [ ] Breaking changes between versions ship with migration guides

### Context

- **Parent Feature**: FEAT-001 — Easy to Setup
- **Vision**: § Success Metrics ("Maintenance overhead <10%")

---

## Plan

[To be filled during `/epic-plan EPIC-003`.]

### Approach

[High-level approach. Which tasks combine to deliver the goal.]

### Tasks

[To be created during planning.]

### Dependencies

**Depends on**: [EPIC-002](./EPIC-002-smart-installation.md) — version-aware updates require smart installation primitives (backup, merge)

**Depended on by**: All future Shannon evolutions where users on different versions need to coexist

### Risks

- [To be identified during planning]

---

## Activity Log

- **2026-05-15** — DRAFT: Created as part of refactor; migrated from FEAT-001 Phase 3
