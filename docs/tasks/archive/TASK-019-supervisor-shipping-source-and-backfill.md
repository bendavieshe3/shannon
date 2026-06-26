# TASK-019: Supervisor Shipping-Source Establishment and APPROVED-Deliverable Backfill

## Metadata

- **Status**: APPROVED
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

*Elaborated at Gate 2 (2026-06-27).*

### Approach

A mechanical, copy-and-verify pass — no authoring of new content. The current `./.claude/skills/shannon-supervisor/` files (`SKILL.md` + three `checkers/*.md`, all APPROVED) are the present source of truth; this Task copies them verbatim into a new tracked `./shannon/skills/shannon-supervisor/` directory, establishing the tracked shipping source. Because the copy is byte-identical, no portability or content regression is possible beyond what the four APPROVED Gate-3 reviews already verified; the verification steps re-confirm cleanliness in the new location. After this Task, `./shannon/` is the authored source and `./.claude/` the deployed copy (the standing relationship for the other three skills).

### Steps

1. **Create the tracked source and copy the four deliverables.** `mkdir -p ./shannon/skills/shannon-supervisor/checkers`, then copy `SKILL.md` and `checkers/{alignment,lifecycle,drift}.md` from `./.claude/skills/shannon-supervisor/` into it. Do **not** create empty `templates/` or `scripts/` (git ignores empty dirs; their populating Tasks create them in the tracked source). Closes AC#1.
2. **Confirm deployed copy matches the tracked source.** `diff -r` the `SKILL.md` + `checkers/` of the two `shannon-supervisor/` trees; expect zero differences. Closes AC#2.
3. **Confirm tracked-addition visibility.** `git add ./shannon/skills/shannon-supervisor/` then `git status --short` / `git ls-files` shows the four files as new tracked files (contrast `./.claude/`, gitignored). Closes AC#3.
4. **Portability discipline verification.** Six-target greps (`FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, absolute repo path) against the four backfilled files; each returns zero hits. Closes AC#4.
5. **Scope-bounded-edit verification via `git diff`.** Confirm the staged diff adds only `./shannon/skills/shannon-supervisor/{SKILL.md,checkers/*.md}` plus the lifecycle bookkeeping (TASK-019 + `task_index.md`); no APPROVED Task-doc edits, no mandated-doc edits, no other-skill changes. Closes AC#5.

### Dependencies

- **Depends on**: TASK-011/012/013/014 APPROVED (the deliverables this Task backfills — all APPROVED; commits `4135e91`, `76b869b`, `97b9b9d`, `2d85663`).
- **Depended on by**: TASK-015 APPROVED dependency (its `SKILL.md` extension needs the tracked source); TASKs 16–18 author in `./shannon/` going forward.
- **Cascade docs**: none amended — this is a source-relocation Task, not a content or doc change.

### Risks

- **Copy drift between `./shannon/` and `./.claude/`.** A non-identical copy would defeat the deploy relationship. **Mitigation**: AC#2's `diff -r` is the explicit zero-difference gate; Step 2 runs before staging.
- **Empty-dir expectation mismatch at Gate 3.** A reviewer might expect `templates/`+`scripts/` mirrored. **Mitigation**: AC#1 names the deliberate omission (git ignores empty dirs; populating Tasks create them) so the absence is expected, not a defect.

---

## Implementation Notes

### Deviations from Plan

- None. The 5-Step Plan ran exactly as Gate-2-approved.

### Gotchas

- **First tracked supervisor files in the repo.** Before this Task, `git ls-files .claude/` returned 0 (the whole skill tree was gitignored). After this Task, `git ls-files shannon/skills/shannon-supervisor/` returns 4 — the supervisor skill finally has a version-controlled home, byte-identical to the deployed `./.claude/` copy. From here, scope-bounded-edit verification for supervisor work uses normal `git diff` (the `ls`-based `.claude/`-gitignored workaround is retired for `./shannon/`-authored content).
- **Empty `templates/`/`scripts/` deliberately absent from the tracked source.** Git does not track empty directories, so `./shannon/skills/shannon-supervisor/` has only `SKILL.md` + `checkers/`. `templates/` is created in the tracked source by TASK-015 (when it authors the three report templates); `scripts/` by TASKs 16–17 (hook bodies). The deployed `./.claude/` copy still carries the empty `templates/`+`scripts/` dirs TASK-011 created — that asymmetry is expected and harmless.

### Documents Updated

- None. Source-relocation Task — no mandated-document or other-skill change. The four APPROVED Task documents (TASK-011/012/013/014) are untouched; their AC#6 mirror-deferral clauses are superseded by this Task's existence (recorded in the scratchpad shipping-source-mirror DECISION 2026-06-27), not edited.

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

- **2026-06-27** — APPROVED (Gate 3 approved). Independent verification subagent re-ran all 5 ACs from raw disk + git artefacts (not from the Activity Log); all PASS. **AC#1**: `ls -R ./shannon/skills/shannon-supervisor/` shows exactly `SKILL.md` + `checkers/{alignment,lifecycle,drift}.md`, no empty `templates/`/`scripts/` (intended). **AC#2**: `diff` (SKILL.md) + `diff -r` (checkers/) between deployed and tracked trees zero differences; byte counts match (6782/4415/5658/5970). **AC#3**: `git ls-files ./shannon/skills/shannon-supervisor/` lists the four files; `git ls-files ./.claude/skills/shannon-supervisor/` empty (still gitignored). **AC#4**: 24 grep checks (4 files × 6 portability targets) all 0. **AC#5**: HEAD `12c4cce` shows only TASK-019 bookkeeping + the four new `./shannon/` files as pure additions; no APPROVED-Task-doc, mandated-doc, or other-skill changes. Reviewer confirmed every Activity-Log claim against disk/git. **Outcome**: the supervisor skill now has a version-controlled home consistent with Shannon's other three skills; the structural gap (deliverables living only in gitignored `./.claude/`) is closed. Future supervisor work (TASK-015 onward) verifies scope via normal `git diff`. File archived to `./docs/tasks/archive/TASK-019-supervisor-shipping-source-and-backfill.md`; `task_index.md` link updated. **Unblocks TASK-015** (its `SKILL.md` extension dependency on the tracked source is now satisfied). Status: REVIEW → APPROVED.
- **2026-06-27** — IMPLEMENTED: All 5 Steps executed cleanly. **Step 1**: created `./shannon/skills/shannon-supervisor/checkers/` and copied the four APPROVED deliverables verbatim from `./.claude/` — `SKILL.md` (6782 bytes), `checkers/alignment.md` (4415), `checkers/lifecycle.md` (5970), `checkers/drift.md` (5658). Empty `templates/`/`scripts/` deliberately not created (git ignores empty dirs). AC#1 closed. **Step 2**: `diff` of `SKILL.md` and `diff -r` of `checkers/` between the deployed and tracked trees returned zero differences — byte-identical. AC#2 closed. **Step 3**: `git add ./shannon/skills/shannon-supervisor/` then `git ls-files` returns 4 — the four files are now tracked additions (contrast `./.claude/`, gitignored, still 0 tracked). AC#3 closed — **the supervisor skill has a tracked home for the first time.** **Step 4**: six-target portability greps (`FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, absolute repo path) across all four backfilled files returned an aggregate of **0 hits** — fourth consecutive clean checker-family portability pass, re-verifying the APPROVED deliverables in their tracked location. AC#4 closed. **Step 5**: `git diff --cached --name-only` shows only the four `./shannon/skills/shannon-supervisor/` files staged; absence checks confirm 0 APPROVED-Task-doc edits, 0 mandated-doc edits, 0 other-skill changes. AC#5 closed. **Milestone**: scope-bounded-edit verification for all future supervisor work (TASK-015 onward) now uses normal `git diff` against the tracked `./shannon/` source — the `.claude/`-gitignored `ls`-workaround is retired. Ready for Gate 3 review via `/task-review TASK-019`.
- **2026-06-27** — IMPLEMENTING: Started execution of the 5-Step copy-and-verify Plan.
- **2026-06-27** — PLANNED (Gate 2 approved). Five-Step mechanical copy-and-verify Plan authored (no cascading-prepared draft existed — this Task was created fresh at TASK-015 Gate 1): (1) create `./shannon/skills/shannon-supervisor/checkers/` and copy the four APPROVED deliverables verbatim; (2) `diff -r` confirms deployed-copy match (AC#2); (3) `git status`/`git ls-files` confirms tracked-addition visibility (AC#3); (4) six-target portability greps (AC#4); (5) `git diff` scope-bounded-edit verification (AC#5). Two risks named (copy drift → `diff -r` gate; empty-dir expectation mismatch → AC#1 deliberate-omission clause). No cascade docs amended (source-relocation Task). Status: ELABORATED → PLANNED.
- **2026-06-27** — ELABORATED (Gate 1 — pending directing-party approval). Five acceptance criteria finalised from the provisional create-time set: AC#1 (tracked `./shannon/skills/shannon-supervisor/` mirrors the four APPROVED deliverables byte-identically; empty `templates/`+`scripts/` not backfilled since git ignores empty dirs — created by their populating Tasks); AC#2 (`./.claude/` deployed copy byte-identical to the tracked source, `diff -r`-verifiable); AC#3 (backfilled files show as tracked additions in `git status`, restoring `git diff` verification); AC#4 (six-target portability greps 0 hits — fourth consecutive clean checker-family pass); AC#5 (scope-bounded — APPROVED Task docs untouched, their AC#6 deferral clauses superseded not edited; no mandated-doc or other-skill changes). Each AC carries a `Derives from` line per the field-report discipline. The one-time exceptional copy direction (`./.claude/` → `./shannon/`) is called out; henceforth `./shannon/` is authored and `./.claude/` is the deployed copy. Status: DRAFT → ELABORATED.
- **2026-06-27** — DRAFT: Corrective Task created (fast capture) following the directing-party decision at TASK-015 Gate 1 to author the supervisor skill in tracked `./shannon/` going forward and backfill the four APPROVED Tasks' deliverables. Establishes `./shannon/skills/shannon-supervisor/` as the tracked shipping source; supersedes the shipping-source-mirror deferral clauses in TASK-011–014 AC#6 (those Tasks stay APPROVED). `/shannon-setup` deploy-flow update remains separately deferred. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-019` (Gate 1).
