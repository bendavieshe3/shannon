# TASK-019: Supervisor Shipping-Source Establishment and APPROVED-Deliverable Backfill

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #shipping-source #backfill #portability #distribution #corrective
- **Created**: 2026-06-27
- **Updated**: 2026-06-27

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated at Gate 1 (2026-06-27).*

### Overview

Corrective Task added 2026-06-27 following the directing-party decision at TASK-015 Gate 1 (see `docs/scratchpad.md` shipping-source-mirror item, DECISION 2026-06-27). EPIC-009's first four Tasks (TASK-011 Skeleton, TASK-012 Alignment Checker, TASK-013 Lifecycle Checker, TASK-014 Drift Checker) authored their deliverables **only** in the gitignored `./.claude/skills/shannon-supervisor/` deployed copy, deferring the `./shannon/` shipping-source mirror per each Task's AC#6. That left the supervisor skill with no tracked home — inconsistent with the other three Shannon skills (`work-items`, `project-setup`, `project-documentation`), whose source of truth is the tracked `./shannon/skills/`.

This Task establishes `./shannon/skills/shannon-supervisor/` as the tracked shipping source and backfills the four APPROVED Tasks' deliverables into it, so the supervisor skill is version-controlled like every other Shannon skill. From TASK-015 onward, the supervisor skill is authored in `./shannon/` (tracked) and deployed to `./.claude/` (active copy).

**Supersedes** the shipping-source-mirror deferral clauses in TASK-011 AC#6, TASK-012 AC#6, TASK-013 AC#6, and TASK-014 AC#6 (those Tasks remain APPROVED; their deliverables were correct — only the source-of-truth location is corrected here).

**Out of scope**: the `/shannon-setup` deploy-flow update (installer changes, Supervisor Report `knowledge_index.md` subtype handling, per-project gate-authority configuration) — that remains deferred to the future deployment Epic. This Task version-controls the source only; it does not change how `/shannon-setup` deploys.

### Acceptance Criteria

- **AC#1 — `./shannon/skills/shannon-supervisor/` exists as tracked shipping source.** The directory is created and git-tracked, mirroring the four APPROVED deliverables byte-identically from the current `./.claude/` deployed copy (which is the present source of truth until this Task lands): `SKILL.md`, `checkers/alignment.md`, `checkers/lifecycle.md`, `checkers/drift.md`. The empty `templates/` and `scripts/` subdirectories are **not** backfilled — git does not track empty directories, and they are created in the tracked source by the Tasks that first populate them (`templates/` by TASK-015; `scripts/` by TASKs 16–17). This is the one-time exceptional copy direction (`./.claude/` → `./shannon/`); henceforth the source relationship is `./shannon/` authored → `./.claude/` deployed. Derives from the scratchpad shipping-source-mirror item (DECISION 2026-06-27) and the existing-skill precedent that source of truth is `./shannon/skills/` (`work-items`, `project-setup`, `project-documentation`).

- **AC#2 — `./.claude/` deployed copy matches the tracked source.** After the backfill, `./.claude/skills/shannon-supervisor/SKILL.md` and the three `checkers/*.md` are byte-identical to their `./shannon/` counterparts — confirming the deploy relationship holds at handoff. Verifiable by `diff -r` over the two `shannon-supervisor/` trees (ignoring the empty deployed `templates/`+`scripts/`). Derives from the scratchpad DECISION 2026-06-27 (deploy relationship `./shannon/` → `./.claude/`).

- **AC#3 — Backfilled deliverables show in `git status` / `git diff` as tracked additions.** Because `./shannon/` is not gitignored (contrast `./.claude/`, per `.gitignore` lines 2–3), the four files appear as new tracked files in `git status` — restoring normal `git diff`-based scope-bounded-edit verification for all future supervisor work (TASK-015 onward). Verifiable: `git status --short ./shannon/skills/shannon-supervisor/` lists the four files; `git ls-files` counts them after staging. Derives from the scratchpad DECISION 2026-06-27 (the verification-discipline correction — `ls`-workaround was Shannon-self scaffolding; tracked source restores `git diff`).

- **AC#4 — Portability discipline preserved in the tracked location.** The six-target portability grep set (`FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, absolute repo path) returns zero hits across the four backfilled files — re-verifying the APPROVED deliverables in their new tracked home (a fourth consecutive clean checker-family pass, after TASK-012/013/014). Derives from parent Epic AC#1 (G-F portability extension) and TASK-012/013/014 AC#5 lived precedent.

- **AC#5 — Scope-bounded per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./shannon/skills/shannon-supervisor/` (new tracked source) from the existing `./.claude/` copy. It does **not** modify the four APPROVED Task documents (TASK-011/012/013/014 stay APPROVED — their AC#6 mirror-deferral clauses are superseded by this Task's existence, not edited); does **not** modify any mandated document; does **not** modify any other skill under `./shannon/skills/` or `./.claude/skills/`; does **not** touch `checkers/` *content* (the backfilled files are byte-identical copies, not edits). Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — corrective Task added mid-implementation (Task 9, sequenced before TASK-015 implementation).
- **Predecessors**: TASK-011/012/013/014 (APPROVED — their deliverables are what this Task backfills).
- **Depended on by**: TASK-015 (extends `SKILL.md`; needs the tracked `./shannon/` home to exist first), and TASKs 16–18 (author in `./shannon/` going forward).
- **Scratchpad**: shipping-source-mirror item, DECISION 2026-06-27.

---

## Plan

*Filled at `/task-plan TASK-019` (Gate 2).*

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled at Gate 3.*

### Verification

- [ ] All acceptance criteria met
- [ ] Code follows development_guide.md
- [ ] Tests added or updated, passing
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

---

## Activity Log

- **2026-06-27** — ELABORATED (Gate 1 — pending directing-party approval). Five acceptance criteria finalised from the provisional create-time set: AC#1 (tracked `./shannon/skills/shannon-supervisor/` mirrors the four APPROVED deliverables byte-identically; empty `templates/`+`scripts/` not backfilled since git ignores empty dirs — created by their populating Tasks); AC#2 (`./.claude/` deployed copy byte-identical to the tracked source, `diff -r`-verifiable); AC#3 (backfilled files show as tracked additions in `git status`, restoring `git diff` verification); AC#4 (six-target portability greps 0 hits — fourth consecutive clean checker-family pass); AC#5 (scope-bounded — APPROVED Task docs untouched, their AC#6 deferral clauses superseded not edited; no mandated-doc or other-skill changes). Each AC carries a `Derives from` line per the field-report discipline. The one-time exceptional copy direction (`./.claude/` → `./shannon/`) is called out; henceforth `./shannon/` is authored and `./.claude/` is the deployed copy. Status: DRAFT → ELABORATED.
- **2026-06-27** — DRAFT: Corrective Task created (fast capture) following the directing-party decision at TASK-015 Gate 1 to author the supervisor skill in tracked `./shannon/` going forward and backfill the four APPROVED Tasks' deliverables. Establishes `./shannon/skills/shannon-supervisor/` as the tracked shipping source; supersedes the shipping-source-mirror deferral clauses in TASK-011–014 AC#6 (those Tasks stay APPROVED). `/shannon-setup` deploy-flow update remains separately deferred. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-019` (Gate 1).
