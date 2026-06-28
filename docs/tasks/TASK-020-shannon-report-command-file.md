# TASK-020: Shannon-Report Command File

## Metadata

- **Status**: PLANNED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #command #shannon-report #entry-point #corrective
- **Created**: 2026-06-28
- **Updated**: 2026-06-28

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated at Gate 1 (2026-06-28).*

### Overview

Corrective Task added 2026-06-28, surfaced during TASK-018 (dogfood) Gate 1. EPIC-009 built the supervisor **skill** (`SKILL.md` + `/shannon-report` contract prose), the three checkers, the report pipeline + templates, and both hooks — but **never created the thin `/shannon-report` command file**. Per Shannon's own Commands + Skills + Subagents architecture (commands are thin entry points that delegate to skills — see `shannon/commands/*.md` and `shannon/commands/README.md`), `/shannon-report` needs a `./.claude/commands/shannon-report.md` (tracked source at `./shannon/commands/shannon-report.md`) to be invocable. Without it, the `/shannon-report` contract in `SKILL.md` is described but unreachable.

This Task creates that thin command file — a delegate-to-skill entry point in the same shape as the existing 24 command files — so `/shannon-report` is a real invocation surface. It does not change the skill, the pipeline, the checkers, or the hooks (all APPROVED); it only adds the missing entry point. TASK-018's dogfood depends on it.

**Out of scope**: any skill/pipeline/checker/hook change (all APPROVED); the `/shannon-goal` command (named in `SKILL.md` as future work, not part of EPIC-009); the `/shannon-setup` deploy-flow update (separately deferred).

### Acceptance Criteria

- **AC#1 — Thin `/shannon-report` command file authored in tracked `./shannon/commands/`, deployed to `./.claude/`.** `./shannon/commands/shannon-report.md` exists as a thin entry point in the canonical command shape (per `shannon/commands/README.md` § How Commands Work): (1) states explicitly which skill to invoke ("You MUST invoke the `shannon-supervisor` skill"), (2) passes the report verb (and notes `/shannon-report` takes no arguments), (3) includes fallback wording if the skill fails to activate, (4) returns to the conversation / surfaces the report location. Deployed to `./.claude/commands/shannon-report.md`. Derives from `shannon/commands/README.md` § How Commands Work and the existing `shannon/commands/*.md` thin-delegate precedent.

- **AC#2 — Delegates to the supervisor skill; does not reimplement the pipeline.** The command file invokes the `shannon-supervisor` skill (which owns the `/shannon-report` contract + § Report Pipeline from TASK-011/015) rather than duplicating any pipeline logic — consistent with the Commands-are-thin principle ("the actual workflow logic lives in the skills, not the commands"). Derives from `shannon/commands/README.md` § How Commands Work and CLAUDE.md (Commands delegate to Skills).

- **AC#3 — Command reference kept in sync.** `shannon/commands/README.md` is additively amended to list `/shannon-report` (a Supervisor entry naming its purpose) so the command reference does not go stale — the same doc/filesystem-sync discipline Shannon applies to indexes. Derives from `shannon/commands/README.md` (the § Command Reference table it maintains).

- **AC#4 — Project-relative paths; six-target portability.** Literal grep of the command file (and the README amendment) for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension) and the prior-Task six-target precedent.

- **AC#5 — Scope-bounded per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./shannon/commands/shannon-report.md` (deployed to `./.claude/`) and additively amends `shannon/commands/README.md`. It does **not** modify the supervisor skill (`SKILL.md`), any checker, any template, any hook script or `settings.json`, or any mandated document. Tracked files verified via `git diff`; deployed `./.claude/commands/` copy via `diff`. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — corrective Task added mid-implementation (Task 10), sequenced before TASK-018.
- **Predecessors**: TASK-011 (skill skeleton + `/shannon-report` contract this command invokes), TASK-019 (tracked `./shannon/` convention).
- **Depended on by**: TASK-018 (the dogfood needs an invocable `/shannon-report`).
- **Reference**: `shannon/commands/README.md` (command-file shape); existing `shannon/commands/*.md` (thin-delegate pattern).
- **Scratchpad**: the EPIC-009-decomposition-omitted-the-command-file finding.

---

## Plan

*Elaborated at Gate 2 (2026-06-28).*

### Approach

A single-file authoring pass plus a one-line README sync — author the thin command in the tracked `./shannon/commands/` source, deploy to `./.claude/`. The command body follows the canonical 4-point shape (per `shannon/commands/README.md` § How Commands Work and the `shannon-setup.md` precedent): name the skill to invoke, pass the verb, fallback wording, return. No pipeline logic — the `shannon-supervisor` skill owns that.

### Steps

1. **Author `./shannon/commands/shannon-report.md`** — thin delegate: "You MUST invoke the `shannon-supervisor` skill" for the report verb; note `/shannon-report` takes no arguments; fallback wording if the skill fails to activate (naming `./.claude/skills/shannon-supervisor/SKILL.md`); surface the produced report location on return. Closes AC#1, AC#2.
2. **Sync the command reference.** Additively add a Supervisor entry naming `/shannon-report` to `shannon/commands/README.md` § Command Reference. Closes AC#3.
3. **Deploy to the active copy.** Copy `shannon-report.md` to `./.claude/commands/`; `diff` confirms identical. Deploy the README too (it lives under `shannon/commands/`; the `./.claude/commands/` copy mirrors it).
4. **Portability + scope verification.** Six-target greps against the command file + README amendment (each 0); `git diff` confirms only `./shannon/commands/shannon-report.md` (new) + `README.md` (additive) + lifecycle bookkeeping — no skill/checker/template/hook/mandated-doc change. Closes AC#4, AC#5.

### Dependencies

- **Depends on**: TASK-011 APPROVED (the `SKILL.md` `/shannon-report` contract this command invokes); TASK-019 APPROVED (the tracked `./shannon/` convention).
- **Depended on by**: TASK-018 (the dogfood needs the invocation surface).
- **Cascade docs**: none amended — this is a command-layer entry point, not a content or mandated-doc change.

### Risks

- **Command thickens beyond a thin delegate.** Tempting to inline pipeline steps. **Mitigation**: AC#2 forbids reimplementation; the `shannon-setup.md` precedent is the shape reference (a few lines).
- **README drift.** Adding the command without listing it leaves the reference stale. **Mitigation**: AC#3 + Step 2 make the README sync explicit.

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

- **2026-06-28** — PLANNED (Gate 2 approved). Four-Step authoring-and-verify Plan (no cascading-prepared draft — created fresh at TASK-018 Gate 1): (1) author the thin `shannon-report.md` delegate per the 4-point shape; (2) sync `shannon/commands/README.md` § Command Reference; (3) deploy command + README to `./.claude/`; (4) six-target portability + `git diff` scope verification. Two risks named (command thickening → AC#2 thin-delegate guard; README drift → AC#3 sync). No cascade docs amended (command-layer entry point). Dependencies confirmed: TASK-011/019 APPROVED. Status: ELABORATED → PLANNED.
- **2026-06-28** — ELABORATED (Gate 1 — pending directing-party approval). Five acceptance criteria finalised from the provisional create-time set, grounded in `shannon/commands/README.md` § How Commands Work (the canonical thin-command shape): AC#1 (thin `/shannon-report` command file in tracked `./shannon/commands/`, deployed — the 4-point delegate shape: name the skill / pass the report verb / fallback wording / return); AC#2 (delegates to `shannon-supervisor`, does not reimplement the pipeline — Commands-are-thin); AC#3 (additively list `/shannon-report` in `shannon/commands/README.md` so the command reference stays in sync); AC#4 (six-target portability); AC#5 (scope-bounded — command file + README only; no skill/checker/template/hook/mandated-doc change). Each AC carries a `Derives from` line. This is a small, mechanical entry-point Task — its value is unblocking TASK-018's dogfood by giving the `SKILL.md` `/shannon-report` contract a real invocation surface. Status: DRAFT → ELABORATED.
- **2026-06-28** — DRAFT: Corrective Task created (fast capture) following the TASK-018 Gate 1 finding that EPIC-009 never scoped the thin `/shannon-report` command entry point. Creates `./shannon/commands/shannon-report.md` (deployed to `./.claude/`) so the `/shannon-report` contract in `SKILL.md` is actually invocable. Sequenced before TASK-018's dogfood. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-020` (Gate 1).
