# EPIC-004: Distribution Channels

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-001](../features/FEAT-001-easy-to-setup.md)
- **Created**: 2026-05-15
- **Updated**: 2026-05-15

---

## Requirements

### Overview

Offer multiple ways to install Shannon beyond `git clone`. Each channel removes friction for a different user: a curl script for users who don't want to manage a clone, a GitHub template repo for users starting fresh, language-ecosystem packages for users already in those ecosystems.

This epic is deliberately scoped after the foundational epics. Distribution channels only add value once installation is solid (EPIC-001), safe (EPIC-002), and versionable (EPIC-003).

### Goal

A developer can install Shannon through whichever channel matches their workflow, and every channel produces an installation identical to `git clone`.

### Acceptance Criteria

- [ ] curl install script (`curl ... | sh`) installs Shannon into a project
- [ ] GitHub template repository allows "Use this template" as a first-step option
- [ ] Decision recorded for whether to ship npm and pip packages, with rationale
- [ ] (If proceeding) npm package installs Shannon into a Node project's `.claude/`
- [ ] (If proceeding) pip package installs Shannon into a Python project's `.claude/`
- [ ] All channels result in identical installed state and version

### Context

- **Parent Feature**: FEAT-001 — Easy to Setup
- **Vision**: § Future Vision (lowering the barrier to first use)
- **Technology Stack**: § Future Considerations (distribution channels)

---

## Plan

[To be filled during `/epic-plan EPIC-004`.]

### Approach

[High-level approach. Which tasks combine to deliver the goal.]

### Tasks

[To be created during planning.]

### Dependencies

**Depends on**: [EPIC-003](./EPIC-003-version-management.md) — versioning must exist before non-git channels can promise consistent installs

**Depended on by**: None directly; this epic is a horizon-extender, not a foundation

### Risks

- **Channel proliferation cost** — Each channel is a maintenance commitment. The Phase-4-as-distribution decision in the original FEAT-001 review noted this risk; the epic may be split or reduced in scope
- **Decision deferred**: Whether to ship npm/pip packages should be revisited at planning time, informed by actual user installs from the curl/template channels

---

## Activity Log

- **2026-05-15** — DRAFT: Created as part of refactor; migrated from FEAT-001 Phase 4. Captured the scope concern flagged in the 2025-11-11 FEAT-001 health review (Phase 4 may be overambitious)
