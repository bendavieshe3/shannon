# TASK-017: PostToolUse Audit-Logging Hook

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #posttooluse #audit-log #gitignore
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-017` (Gate 1).*

### Overview

Implement the PostToolUse hook that audit-logs supervisor operations — records each tool invocation (Bash, Edit, Write) the supervisor performs with timestamp and arguments. The audit log lives under `./.claude/skills/shannon-supervisor/` (the specific filename is codified in `SKILL.md` per TASK-011); the audit log is gitignored per the operational-telemetry framing (not durable project knowledge, per `development_guide.md` v1.4 § Supervisor Report Files' optional-state-file commitment, applied here by analogy per parent Epic AC#5 R-2 amendment). This Task closes parent Epic AC#5. Out of scope: the PreToolUse hook (TASK-016); the report writer (TASK-015); the dogfood run that verifies the audit log carries entries (TASK-018).

### Acceptance Criteria

- **AC#1 — PostToolUse hook configuration lands in `settings.json`.** The PostToolUse hook configuration lives in the project's `settings.json` per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* ("Hook configuration lives in the project's `settings.json` per Claude Code conventions"). The hook body itself lives under `./.claude/skills/shannon-supervisor/scripts/` alongside the PreToolUse hook from TASK-016. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration*.

- **AC#2 — Hook records timestamp, tool name, and arguments for each invocation.** Each tool invocation (Bash, Edit, Write — the three named at `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* PostToolUse row's role) is recorded with an ISO-8601 timestamp, the tool name, and the invocation's arguments. The audit log is append-only — entries accumulate per run; no overwriting. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (PostToolUse role: "Log supervisor operations for audit trail").

- **AC#3 — Audit log lives under `./.claude/skills/shannon-supervisor/` with filename codified in `SKILL.md`.** The audit log lives at a path under `./.claude/skills/shannon-supervisor/` (e.g. `audit.log` or `scripts/audit.log` — the specific filename is codified in `SKILL.md` per TASK-011's convention codification). Derives from parent Epic AC#5 (R-2 amendment).

- **AC#4 — Audit log path is gitignored.** The audit log's path is added to `.gitignore` so the log is a local-only operational record per the spirit of `development_guide.md` v1.4 § Supervisor Report Files' *Optional state file is gitignored* ("operational telemetry, not durable project knowledge"). Verifiable: the audit log path is matched by an entry in `.gitignore`; `git check-ignore` against the path returns the matching rule. Derives from `development_guide.md` v1.4 § Supervisor Report Files (applied by analogy per parent Epic AC#5 R-2 amendment).

- **AC#5 — Project-relative paths throughout.** Same portability discipline as parent Epic AC#1 (G-F extension): hook script body and any inline prose in `SKILL.md` use project-relative paths only. Verifiable: literal grep for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, this repository's absolute path returns zero hits. Derives from parent Epic AC#1 (G-F portability extension).

- **AC#6 — Scope-bounded edit per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task modifies `settings.json` (PostToolUse entry only — leaves TASK-016's PreToolUse entry untouched), adds a hook script body under `./.claude/skills/shannon-supervisor/scripts/`, and adds one line to `.gitignore`. It does **not** modify any checker definition; does **not** modify the report writer (TASK-015 territory); does **not** modify the PreToolUse hook (TASK-016 territory); does **not** write to `./docs/supervisor/` directly. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — Task 7 of 8; closes parent Epic AC#5.
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Five Claude Code hook integration points* (PostToolUse half).
- **Sibling Task** (predecessor): TASK-011 (Skeleton — `scripts/` directory must exist; `SKILL.md` codifies the audit-log filename).
- **Sibling Task** (peer): TASK-016 (PreToolUse hook — same `settings.json`, distinct entry, distinct script).
- **Sibling Task** (downstream): TASK-018 (Dogfood run — verifies the audit log accumulates entries per AC#3 of the parent Epic — the audit-log evidence check tied to the first dogfood run, per the R-5 amendment).
- **Technical Design**: § System Architecture → *Supervisor* → *Hook integration* (PostToolUse row — AC#1, AC#2 source).
- **Development Guide**: § Supervisor Report Files (AC#4 source by analogy — operational-telemetry framing).
- **Scratchpad**: M-6 (Audit-log convention not codified at framework level — candidate `development_guide.md` § Supervisor Report Files extension; surfaced at EPIC-009 Gate 1, revisit after this Task's lived-in evidence).
- **Conceptual Design**: § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#6 source).

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-017` (Gate 2).*

### Approach

A three-file edit: the hook script body under `./.claude/skills/shannon-supervisor/scripts/`, the `settings.json` entry pointing at it, and the `.gitignore` entry that excludes the audit log from version control. Apply the editing-order convention: hook script body is the source-of-truth; `settings.json` and `.gitignore` are derived bookkeeping. Audit-log format is plain text, append-only (no JSON wrapper required — the operational-telemetry framing favours easy `cat` / `tail` reading over machine parseability).

### Steps

1. **Author the hook script body** under `./.claude/skills/shannon-supervisor/scripts/`. Logic: on each tool invocation, append `ISO-8601-timestamp TOOL_NAME ARGUMENTS` to the audit log file at the path codified in `SKILL.md`. Closes AC#2, AC#3.
2. **Add the PostToolUse entry to `settings.json`** pointing at the hook script. Leave the TASK-016 PreToolUse entry untouched. Closes AC#1.
3. **Add the audit log path to `.gitignore`**. Verify with `git check-ignore <audit-log-path>` that the rule matches. Closes AC#4.
4. **Portability discipline verification.** Literal greps for Shannon-self leaks. Closes AC#5.
5. **Scope-bounded-diff verification.** `git status` confirms only `settings.json`, `.gitignore`, and the new hook script are modified. Closes AC#6.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton + `SKILL.md` codifies the audit-log filename).
- **Depended on by**: TASK-018 (dogfood run — verifies audit log accumulates entries per parent Epic AC#3's R-5 amendment).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `development_guide.md` v1.4 (APPROVED — AC#4 source); `conceptual_design.md` v1.7 (APPROVED — AC#6 source).

### Risks

- **Audit log path collision with PreToolUse hook output.** Both hooks write under `./.claude/skills/shannon-supervisor/scripts/`. **Mitigation**: PreToolUse (TASK-016) exits 0 or 2 without writing to disk; PostToolUse (this Task) writes to the audit log only — the two scripts have orthogonal side effects.
- **Audit log growing without bound.** Append-only over many cadence runs accumulates indefinitely. **Mitigation**: gitignored (won't bloat the repo); if local-disk pressure becomes a concern, surface as a follow-up Task post-EPIC-009 — explicit log rotation is out of scope for the first dogfood.
- **`.gitignore` entry missed.** Forgetting AC#4 would leak operational telemetry into version control. **Mitigation**: Step 3's `git check-ignore` verification is the discipline; AC#4 is explicit.
- **Framework-general audit-log convention.** Scratchpad M-6 flags this as a candidate framework convention; this Task lands the operational pattern but does not codify the framework-general rule. Revisit at parent Epic review per the M-6 routing.

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

- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-017`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-017`, the prepared plan surfaces for Gate 2 review. Descriptive title (*PostToolUse Audit-Logging Hook*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-017` (Gate 1).
