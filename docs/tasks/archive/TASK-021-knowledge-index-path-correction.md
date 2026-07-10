# TASK-021: Knowledge-Index Path Correction

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #bug #knowledge-index #path #corrective #dogfood
- **Created**: 2026-07-06
- **Updated**: 2026-07-10

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated at Gate 1 (2026-07-06).*

### Overview

Corrective Task created 2026-07-06 to fix the **knowledge-index path mismatch** the first dogfood run (TASK-018) surfaced. The supervisor implementation consistently codifies `./docs/knowledge_index.md`, but the project's knowledge index actually lives at `./docs/knowledge/knowledge_index.md`. The mismatch is functionally serious: the PreToolUse write-guard's exception (`pretool-writeguard.sh` line 18) names the wrong path, so a real supervisor run writing to the correct index would be **refused** (demonstrated live in TASK-018 Step 4 — the real index path returns exit 2), and the report-indexing step would target a non-existent top-level file.

This Task corrects the path at every codified site, authored in the tracked `./shannon/` source and deployed to `./.claude/`. It **supersedes** the wrong path in TASK-011 (SKILL.md), TASK-015 (footer template), and TASK-016 (write-guard + snippet) — those Tasks remain APPROVED; only the path is corrected here (their AC intent was right; the string was wrong). It also clarifies the knowledge-index indexing convention nuance the dogfood found (the actual index uses section headers, not a `Type:` field — the report added a *Supervisor Reports* section).

**Out of scope**: any behavioural change to the pipeline, checkers, or hooks beyond the path string; the already-written `report-2026-07-05.md` and its index entry (already at the correct path); the deferred EPIC-010/011 work.

### Acceptance Criteria

- **AC#1 — Every codified `docs/knowledge_index.md` reference corrected to `docs/knowledge/knowledge_index.md`.** All sites the TASK-018 dogfood identified are fixed in the tracked `./shannon/` source: `SKILL.md` (§ /shannon-report contract line ~38, § Report Pipeline step 6 + closing line ~83/85, § Hook Integration PreToolUse bullet line ~91), `scripts/pretool-writeguard.sh` (the functional `index_exception=` on line ~18 **and** the header comment line ~7), `hooks/pretooluse.settings.json` (the `_comment`), and `templates/footer.md` (line 4). Verifiable: `grep -rn 'docs/knowledge_index.md'` across `./shannon/skills/shannon-supervisor/` returns **zero** hits that are not the corrected `docs/knowledge/knowledge_index.md` (i.e. no bare `docs/knowledge_index.md`). Derives from the TASK-018 dogfood finding (scratchpad knowledge-index-path-mismatch item) and the real index location `./docs/knowledge/knowledge_index.md`.

- **AC#2 — The write-guard now permits the real index path and still blocks out-of-scope writes (re-tested).** After the fix, `pretool-writeguard.sh` (with `SHANNON_SUPERVISOR_SCOPE` set) returns **exit 0** for `docs/knowledge/knowledge_index.md` (the real index — the exception now names it), **exit 0** for `docs/supervisor/...` (in scope), and **exit 2** for `docs/scratchpad.md` (out of scope). This reverses the bug TASK-018 demonstrated (real index was exit 2). Verified by re-running the hook's unit cases directly before commit (the global test-before-commit rule). Derives from TASK-016 AC#2/AC#6 (the hook contract + unit-test discipline) and the TASK-018 dogfood demonstration.

- **AC#3 — Deployed `./.claude/` copies match the corrected tracked source.** The four corrected files are deployed to `./.claude/skills/shannon-supervisor/`; `diff` confirms byte-identical. Derives from the scratchpad shipping-source DECISION 2026-06-27 (author in `./shannon/`, deploy to `./.claude/`).

- **AC#4 — Indexing-convention nuance clarified.** `SKILL.md` § Report Pipeline step 6 is clarified so the "Type *Supervisor Report*" wording matches how the entry actually lands in `knowledge_index.md` — under a dedicated *Supervisor Reports* section (the format the actual index uses: section headers, not a `Type:` field), with *Supervisor Report* retained as the entry's Type label. A light additive clarification, not a behavioural change. Derives from the TASK-018 dogfood finding (the format nuance) and `conceptual_design.md` v1.7 § Domain Model → *Knowledge Note* (Supervisor Report subtype).

- **AC#5 — Project-relative paths; six-target portability.** Literal grep of the four corrected files for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension).

- **AC#6 — Scope-bounded per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task edits only the four supervisor files under `./shannon/skills/shannon-supervisor/` (`SKILL.md`, `scripts/pretool-writeguard.sh`, `hooks/pretooluse.settings.json`, `templates/footer.md`) and deploys them to `./.claude/`. It does **not** change the checkers, the other templates (`header.md`, `finding-section.md`), the audit-log hook (`posttool-auditlog.sh`), the command file, `settings.json` registration structure, or any mandated document; it does not touch the already-written `report-2026-07-05.md` or its (correct) index entry. Verified via `git diff`. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — corrective Task added post-dogfood (Task 11), fixing the defect TASK-018 surfaced; should land before EPIC-009's own Gate 3 so the Epic closes on a working supervisor.
- **Predecessors / superseded strings**: TASK-011 (SKILL.md), TASK-015 (footer template), TASK-016 (write-guard + snippet) — all APPROVED; only the path string is corrected.
- **Surfaced by**: TASK-018 (first dogfood run) — the finding and live demonstration.
- **Scratchpad**: the knowledge-index-path-mismatch item (2026-07-05).

---

## Plan

*Elaborated at Gate 2 (2026-07-09).*

### Approach

A mechanical string correction across four files in the tracked `./shannon/skills/shannon-supervisor/` source, deployed to `./.claude/`. The functional site is `pretool-writeguard.sh`'s `index_exception=`; the rest are prose/comment references that must agree so the codified contract matches behaviour. Because the write-guard is executable and this Task changes its behaviour, **re-run TASK-016's full unit suite before commit** (the global test-before-commit rule) — confirming the real index path flips from blocked to allowed while every other case is unchanged. The already-written `report-2026-07-05.md` and its (correct) index entry are untouched.

### Steps

1. **Correct `SKILL.md`** — the four `./docs/knowledge_index.md` references (§ /shannon-report contract, § Report Pipeline step 6 + closing line, § Hook Integration PreToolUse bullet) → `./docs/knowledge/knowledge_index.md`. Apply the AC#4 clarification at § Report Pipeline step 6 (the entry lands under a *Supervisor Reports* section, with *Supervisor Report* as its Type label). Closes AC#1 (partly), AC#4.
2. **Correct `scripts/pretool-writeguard.sh`** — the functional `index_exception="docs/knowledge/knowledge_index.md"` and the header comment. Closes AC#1 (the functional site).
3. **Correct `hooks/pretooluse.settings.json` `_comment` and `templates/footer.md` line 4.** Closes AC#1 (remaining sites).
4. **Deploy to the active copy.** Copy the four corrected files to `./.claude/skills/shannon-supervisor/`; `diff` confirms byte-identical. Closes AC#3.
5. **Re-test the write-guard (AC#2).** Re-run TASK-016's unit cases with `SHANNON_SUPERVISOR_SCOPE` set: `docs/knowledge/knowledge_index.md` → **exit 0** (was 2 — the bug reversed); `docs/supervisor/...` → 0; `docs/scratchpad.md` → 2; signal-absent → 0 (inert); configured-override honoured. Confirm no regression in the untouched cases.
6. **Verification.** `grep -rn 'docs/knowledge_index.md'` across `./shannon/skills/shannon-supervisor/` returns zero bare hits (AC#1); six-target portability greps on the four files (AC#5); `git diff` shows only the four files + deploy + lifecycle bookkeeping — no checker, no `header.md`/`finding-section.md`, no `posttool-auditlog.sh`, no command file, no mandated doc, no touch of the written report/index entry (AC#6).

### Dependencies

- **Depends on**: TASK-018 APPROVED (surfaced and demonstrated the defect); TASK-011/015/016 APPROVED (the deliverables whose path string this Task supersedes); TASK-019 APPROVED (tracked `./shannon/` convention).
- **Depended on by**: EPIC-009's own Gate 3 review — the Epic should close on a working supervisor.
- **Cascade docs**: none amended — this is a defect correction to skill content, not a doc or behaviour change.

### Risks

- **Partial fix — a site missed.** Eight references across four files; missing one leaves the contract inconsistent. **Mitigation**: AC#1's verification is a repo-wide `grep` for the bare wrong path returning **zero**, not a per-file check.
- **Regression in the write-guard.** Changing `index_exception` could break the block/allow paths. **Mitigation**: Step 5 re-runs TASK-016's full unit suite (not just the changed case) before commit; the out-of-scope block and inert-by-default paths must remain unchanged.
- **Scope creep into the indexing convention.** AC#4's clarification is prose-only; it must not become a behavioural change to how entries are written. **Mitigation**: AC#4 explicitly names it "a light additive clarification, not a behavioural change"; the already-written entry is untouched.

---

## Implementation Notes

### Deviations from Plan

- None. The 6-Step Plan ran exactly as Gate-2-approved.

### Gotchas

- **The bug is reversed, and the old wrong path is now correctly blocked.** Post-fix, `docs/knowledge/knowledge_index.md` (the real index) returns **exit 0** where TASK-018 demonstrated exit 2. Symmetrically, the previously-codified `docs/knowledge_index.md` now returns **exit 2** — it is no longer the exception and is not under the report directory, so the guard correctly refuses it. Both directions of the fix are verified, not just the happy path.
- **Full-suite re-run caught no regression.** Step 5 deliberately re-ran *all ten* of TASK-016's cases rather than just the changed one: in-scope allow, two out-of-scope blocks, inert-by-default, Read pass-through, and the `report_directory` override (including confirming the index exception still applies *under* an override). All pass — the `index_exception` change did not disturb the block or inert paths.
- **The exception is now a nested path, and the prefix logic still holds.** `docs/knowledge/knowledge_index.md` contains a `/` that the previous exception did not. The guard compares the exception by exact normalised equality (not prefix), so the nesting is inert to the matching logic; the `report_directory` prefix `case` remains independent. Verified by the override case, where the exception survives a changed report directory.
- **Diffs are pure substitutions.** SKILL.md 4/4, snippet 1/1, hook 2/2, footer 1/1 — no incidental edits. The already-written `report-2026-07-05.md` and its (correct) index entry were untouched, per AC#6.

### Documents Updated

- None (mandated documents). TASK-021 corrects the codified index path in four supervisor files under the tracked `./shannon/` source (deployed to `./.claude/`), and clarifies the *Supervisor Reports*-section indexing convention in `SKILL.md` § Report Pipeline step 6.

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

- **2026-07-10** — APPROVED (Gate 3 approved). Independent verification subagent re-derived all 6 ACs and **re-ran the write-guard across 12 cases**; all PASS. **AC#1**: repo-wide grep for the bare wrong path returns zero; all eight corrected sites confirmed (`SKILL.md` 38/83/85/91, `pretool-writeguard.sh` 7 + the functional 18, snippet `_comment`, `footer.md` 4). **AC#2**: re-run — real index `docs/knowledge/knowledge_index.md` → **exit 0** (was 2); old wrong path `docs/knowledge_index.md` → exit 2 (correctly blocked); in-scope 0; out-of-scope 2; signal-absent inert 0; Read pass-through 0; `report_directory` override honoured with the exception surviving; temp override config created and confirmed deleted. **Adversarial widening check (requested)**: `docs/knowledge/other_file.md` → **exit 2 (blocked)** — the verifier confirmed the exception is matched by **exact normalised equality** (`[ "$target" = "$index_exception" ]`, line 53), **not** a prefix, so the newly-nested exception path did not silently widen the allow-list to the whole `docs/knowledge/` directory. This was the one way the fix could have introduced a worse defect than it closed; it did not. **AC#3**: four deployed `./.claude/` copies byte-identical. **AC#4**: `SKILL.md` line 83 names the *Supervisor Reports* section + *Supervisor Report* Type label. **AC#5**: six-target portability across the four files all 0. **AC#6**: commit `6a15765` = exactly six files (bookkeeping + the four supervisor files); no checker / other-template / audit-hook / command / mandated-doc change; the written `report-2026-07-05.md` and `docs/knowledge/knowledge_index.md` untouched; working tree clean. **The defect the first dogfood surfaced is closed in both directions, with no regression and no allow-list widening.** File archived to `./docs/tasks/archive/`; `task_index.md` updated. **All eleven EPIC-009 Tasks are now APPROVED and the supervisor works end-to-end** — EPIC-009 is ready for its own Gate 3 (`/epic-review EPIC-009`). Status: REVIEW → APPROVED.
- **2026-07-10** — IMPLEMENTED: All 6 Steps executed; **write-guard suite 10/10 pass**. **Steps 1–3**: all eight codified `docs/knowledge_index.md` references corrected to `docs/knowledge/knowledge_index.md` across four files — `SKILL.md` (§ /shannon-report contract line 38, § Report Pipeline step 6 + closing line 83/85, § Hook Integration PreToolUse bullet line 91), `scripts/pretool-writeguard.sh` (header comment line 7 **and the functional `index_exception=` line 18**), `hooks/pretooluse.settings.json` `_comment`, `templates/footer.md` line 4. AC#4's clarification applied at § Report Pipeline step 6 (the entry lands under a *Supervisor Reports* section, with *Supervisor Report* as the entry's Type label). AC#1, AC#4 closed. **Step 4**: four files deployed to `./.claude/`, `diff` byte-identical, hook executable, snippet still valid JSON. AC#3 closed. **Step 5 (AC#2) — the decisive test**: re-ran TASK-016's **full** ten-case suite — **the real index `docs/knowledge/knowledge_index.md` now returns exit 0 (was exit 2 in the TASK-018 demonstration)**; the old wrong path `docs/knowledge_index.md` now correctly returns exit 2; and every regression case is unchanged (in-scope allow 0; out-of-scope `docs/scratchpad.md` and `src/app.ts` block 2; signal-absent inert 0; Read pass-through 0; `report_directory` override honoured, with the index exception surviving under the override). 10/10 pass, tested before commit. AC#2 closed. **Step 6**: repo-wide grep for the bare wrong path returns **0** hits, with all eight corrected sites listed (AC#1); six-target portability across the four files aggregate 0 (AC#5); `git diff` shows only the four files as pure substitutions (4/4, 1/1, 2/2, 1/1) — no checker, no `header.md`/`finding-section.md`, no `posttool-auditlog.sh`, no command file, no mandated doc, and the written `report-2026-07-05.md` + its index entry untouched (AC#6). **The defect the first dogfood surfaced is closed, in both directions, with no regression.** Ready for Gate 3 review via `/task-review TASK-021`.
- **2026-07-10** — IMPLEMENTING: Started the 6-Step correction (four files → deploy → full write-guard suite re-run → verification).
- **2026-07-09** — PLANNED (Gate 2 approved). Six-Step mechanical correction-and-retest Plan: (1) correct `SKILL.md`'s four references + apply the AC#4 indexing-convention clarification; (2) correct the **functional** site `pretool-writeguard.sh` `index_exception=` + its header comment; (3) correct the snippet `_comment` + `templates/footer.md`; (4) deploy the four files to `./.claude/`, `diff` identical; (5) **re-run TASK-016's full unit suite** — the real index path must flip 2→0 while out-of-scope stays 2 and inert-by-default is unchanged (test before commit); (6) zero-bare-path repo grep + six-target portability + `git diff` scope. Three risks named (partial fix → repo-wide zero-grep; write-guard regression → full suite re-run, not just the changed case; convention scope creep → AC#4 is prose-only). No cascade docs amended. Dependencies confirmed: TASK-018/011/015/016/019 APPROVED. Status: ELABORATED → PLANNED.
- **2026-07-06** — ELABORATED (Gate 1 — pending directing-party approval). Corrective Task created and elaborated in one pass following the TASK-018 dogfood finding. Six ACs: AC#1 (correct the path at every codified site — SKILL.md ×4, `pretool-writeguard.sh` ×2, snippet ×1, `footer.md` ×1 — verified by a zero-bare-`docs/knowledge_index.md` grep); AC#2 (re-test the write-guard: real index now exit 0, out-of-scope still exit 2 — reversing the demonstrated bug, tested before commit); AC#3 (deploy to `./.claude/`, byte-identical); AC#4 (clarify the `Type` vs *Supervisor Reports*-section indexing nuance); AC#5 (six-target portability); AC#6 (scope-bounded — four supervisor files only, superseding but not re-opening TASK-011/015/016). Each AC carries a `Derives from` line. The three source Tasks stay APPROVED; this Task supersedes only the path string. Status: → ELABORATED.
- **2026-07-06** — DRAFT: Corrective Task created (fast capture) to fix the knowledge-index path mismatch surfaced by TASK-018's first dogfood run. Parent: EPIC-009.
