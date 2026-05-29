# TASK-016: PreToolUse Write-Guard Hook

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #pretooluse #write-guard #scope
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-016` (Gate 1).*

### Overview

Implement the PreToolUse hook that write-guards the supervisor scope — refuses any write whose target is outside the configured `report_directory` (default `./docs/supervisor/`), with an explicit exception for `./docs/knowledge_index.md` per parent Epic AC#4 R-3 (the indexing convention TASK-015 exercises). The hook returns exit code 2 (blocking semantic) per the Phase-0 spike § 1 contract. This Task closes parent Epic AC#4. Out of scope: the PostToolUse audit-logging hook (TASK-017); the report writer itself (TASK-015); the dogfood run that exercises both writes-allowed and writes-blocked cases (TASK-018).

### Acceptance Criteria

- **AC#1 — Hook configuration lands in `settings.json` per Claude Code conventions.** The PreToolUse hook configuration lives in the project's `settings.json` per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* ("Hook configuration lives in the project's `settings.json` per Claude Code conventions; specific hook bodies ship with the supervisor skill"). The hook body itself lives under `./.claude/skills/shannon-supervisor/scripts/` (the `scripts/` subdirectory TASK-011 created). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration*.

- **AC#2 — Hook refuses writes outside the configured `report_directory`.** When the supervisor scope is active, any Write or Edit invocation whose target path is outside `./docs/supervisor/` (or the project's configured `report_directory` per `technical_design.md` v1.2 § Data Model → *Supervisor Configuration*) is refused. The refusal returns exit code 2 (blocking) per Phase-0 spike § 1's hook-exit-code contract. The error message names the supervisor scope explicitly (per `ux_guide.md` v1.2 § Voice and Tone — concise, specific failure framing — and the *Supervisor Commands* section's failure-mode commitment). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* and Phase-0 spike § 1.

- **AC#3 — Explicit exception for `./docs/knowledge_index.md` writes.** The hook permits Write/Edit operations targeting `./docs/knowledge_index.md` — the explicit exception required by the report-indexing convention at parent Epic AC#4 R-3. The exception is encoded in the hook's allow-list, not as silent bypass; the configuration is discoverable by reading `settings.json` plus the hook script body. Derives from parent Epic AC#4 (R-3 amendment).

- **AC#4 — Configured `report_directory` override is honoured.** If a project has set `report_directory` in `./.claude/shannon-supervisor.json` (per TASK-011 AC#4's configuration handling), the hook reads that override and scopes writes accordingly. If the configuration file is absent or the field is absent, the default `./docs/supervisor/` applies. Derives from `technical_design.md` v1.2 § Data Model → *Supervisor Configuration* and parent Epic AC#6.

- **AC#5 — Project-relative paths throughout.** Same portability discipline as parent Epic AC#1 (G-F extension): hook script body uses project-relative paths only. Verifiable: literal grep of the hook script and any inline configuration prose in `SKILL.md` for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension).

- **AC#6 — Scope-bounded edit per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task modifies `settings.json` (PreToolUse hook entry only — no other settings) and adds a hook script body under `./.claude/skills/shannon-supervisor/scripts/`. It does **not** modify any checker definition; does **not** modify the report writer (TASK-015 territory); does **not** modify the PostToolUse hook (TASK-017 territory); does **not** write to `./docs/supervisor/` directly. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — Task 6 of 8; closes parent Epic AC#4.
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Five Claude Code hook integration points* (PreToolUse half).
- **Sibling Task** (predecessor): TASK-011 (Skeleton — `scripts/` directory must exist; `SKILL.md` configuration handling provides the `report_directory` override path).
- **Sibling Task** (peer): TASK-015 (Report writer — must be able to write to `./docs/knowledge_index.md` per AC#3 exception); TASK-017 (PostToolUse hook — distinct hook, distinct scope).
- **Sibling Task** (downstream): TASK-018 (Dogfood run — verifies both an in-scope write succeeds and an out-of-scope write is blocked).
- **Technical Design**: § System Architecture → *Supervisor* → *Hook integration* (PreToolUse row — AC#1, AC#2 source); § Data Model → *Supervisor Configuration* (AC#4 source — `report_directory` field).
- **UX Guide**: § Voice and Tone (failure-mode framing — concise, specific); § Command Surface → *Supervisor Commands* (failure-mode commitment).
- **Phase-0 Spike**: § 1 (Hooks — exit code 2 blocking semantic; PreToolUse contract — AC#2 source).
- **Conceptual Design**: § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#6 source).

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-016` (Gate 2).*

### Approach

A two-file edit: the `settings.json` entry pointing at the hook script, and the hook script body under `./.claude/skills/shannon-supervisor/scripts/`. The hook script reads the configuration override (if `./.claude/shannon-supervisor.json` exists with a `report_directory` field, use that; otherwise default `./docs/supervisor/`), checks the tool invocation's target path against the scope plus the `./docs/knowledge_index.md` exception, and exits 0 (allow) or 2 (block) per the Phase-0 spike § 1 contract. Apply the editing-order convention: hook script body is the source-of-truth; `settings.json` is the derived pointer; edit body first, then settings, then verify.

### Steps

1. **Author the hook script body** under `./.claude/skills/shannon-supervisor/scripts/` (filename per `SKILL.md` convention from TASK-011 — likely `pretool_writeguard.sh` or similar). Logic: read `./.claude/shannon-supervisor.json` if present (use `report_directory` field; fall back to default if absent); check target path; permit the `./docs/knowledge_index.md` exception; exit 0 or 2. Closes AC#2, AC#3, AC#4.
2. **Add the PreToolUse entry to `settings.json`** pointing at the hook script. Closes AC#1.
3. **Portability discipline verification.** Literal greps for Shannon-self leaks across the hook script body and any inline prose in `SKILL.md`. Closes AC#5.
4. **Scope-bounded-diff verification.** `git status` confirms only `settings.json` and the new hook script are modified. Closes AC#6.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton + configuration-handling logic); TASK-015 ELABORATED (so the `./docs/knowledge_index.md` exception's purpose is documented before this hook's exception is encoded).
- **Depended on by**: TASK-018 (dogfood run).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED — AC#1, AC#2, AC#4 source); Phase-0 spike § 1 (AC#2 source — exit code 2 contract); `conceptual_design.md` v1.7 (APPROVED — AC#6 source).

### Risks

- **Hook over-restrictive — blocking the `knowledge_index.md` exception.** The most-likely failure mode: forgetting the AC#3 exception breaks the TASK-015 pipeline at the index-update step. **Mitigation**: AC#3 is explicit; TASK-018's dogfood run will catch this immediately because the report writer cannot complete; the parent Epic § Plan § Risks paragraph 3 (PreToolUse over-restrictive) already flags this as a top concern with AC-traceable mitigation.
- **Hook under-restrictive — permitting writes outside the scope.** A wildcard match or path-prefix bug could let writes to `./docs/scratchpad.md` (or worse) through. **Mitigation**: AC#2 is explicit about the path-prefix check; TASK-018's dogfood run includes an explicit negative test (attempted write outside scope is blocked).
- **`report_directory` override not honoured.** A hardcoded default that ignores the configuration field would break AC#4. **Mitigation**: AC#4 names the override path explicitly; the configuration-handling logic from TASK-011 is the source-of-truth this hook re-uses.

---

## Implementation Notes

*Filled during implementation.*

### Deviations from Plan

- *None yet.*

### Gotchas

- *None yet.*

### Documents Updated

- *None yet.*

---

## Review

*Filled at Gate 3.*

### Verification

- [ ] All acceptance criteria met
- [ ] Code follows development_guide.md
- [ ] Tests added or updated, passing
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

*Filled at Gate 3.*

---

## Activity Log

- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-016`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-016`, the prepared plan surfaces for Gate 2 review. Descriptive title (*PreToolUse Write-Guard Hook*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-016` (Gate 1).
