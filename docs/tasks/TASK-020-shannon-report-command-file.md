# TASK-020: Shannon-Report Command File

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #command #shannon-report #entry-point #corrective
- **Created**: 2026-06-28
- **Updated**: 2026-06-28

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Captured at create (fast capture). Full elaboration pending `/task-elaborate TASK-020` (Gate 1).*

### Overview

Corrective Task added 2026-06-28, surfaced during TASK-018 (dogfood) Gate 1. EPIC-009 built the supervisor **skill** (`SKILL.md` + `/shannon-report` contract prose), the three checkers, the report pipeline + templates, and both hooks — but **never created the thin `/shannon-report` command file**. Per Shannon's own Commands + Skills + Subagents architecture (commands are thin entry points that delegate to skills — see `shannon/commands/*.md` and `shannon/commands/README.md`), `/shannon-report` needs a `./.claude/commands/shannon-report.md` (tracked source at `./shannon/commands/shannon-report.md`) to be invocable. Without it, the `/shannon-report` contract in `SKILL.md` is described but unreachable.

This Task creates that thin command file — a delegate-to-skill entry point in the same shape as the existing 24 command files — so `/shannon-report` is a real invocation surface. It does not change the skill, the pipeline, the checkers, or the hooks (all APPROVED); it only adds the missing entry point. TASK-018's dogfood depends on it.

**Out of scope**: any skill/pipeline/checker/hook change (all APPROVED); the `/shannon-goal` command (named in `SKILL.md` as future work, not part of EPIC-009); the `/shannon-setup` deploy-flow update (separately deferred).

### Acceptance Criteria (provisional — finalised at Gate 1)

- **AC#1 — Thin `/shannon-report` command file authored in tracked `./shannon/commands/`.** `./shannon/commands/shannon-report.md` exists as a thin entry point that delegates to the `shannon-supervisor` skill for the report verb, in the same shape as the existing `shannon/commands/*.md` files (per `shannon/commands/README.md` and the Commands-are-thin principle). Deployed to `./.claude/commands/shannon-report.md`.
- **AC#2 — Delegates to the supervisor skill, not reimplementing the pipeline.** The command file invokes the `shannon-supervisor` skill (which owns the `/shannon-report` contract + § Report Pipeline) rather than duplicating any pipeline logic — consistent with the thin-command discipline.
- **AC#3 — Project-relative paths; six-target portability.** Literal grep of the command file for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and the absolute repo path returns zero hits.
- **AC#4 — Scope-bounded.** Creates only `./shannon/commands/shannon-report.md` (deployed to `./.claude/`); does not modify the skill, checkers, templates, hooks, or any mandated document.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — corrective Task added mid-implementation (Task 10), sequenced before TASK-018.
- **Predecessors**: TASK-011 (skill skeleton + `/shannon-report` contract this command invokes), TASK-019 (tracked `./shannon/` convention).
- **Depended on by**: TASK-018 (the dogfood needs an invocable `/shannon-report`).
- **Reference**: `shannon/commands/README.md` (command-file shape); existing `shannon/commands/*.md` (thin-delegate pattern).
- **Scratchpad**: the EPIC-009-decomposition-omitted-the-command-file finding.

---

## Plan

*Filled at `/task-plan TASK-020` (Gate 2).*

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

- **2026-06-28** — DRAFT: Corrective Task created (fast capture) following the TASK-018 Gate 1 finding that EPIC-009 never scoped the thin `/shannon-report` command entry point. Creates `./shannon/commands/shannon-report.md` (deployed to `./.claude/`) so the `/shannon-report` contract in `SKILL.md` is actually invocable. Sequenced before TASK-018's dogfood. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-020` (Gate 1).
