# TASK-017: PostToolUse Audit-Logging Hook

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #posttooluse #audit-log #gitignore
- **Created**: 2026-05-30
- **Updated**: 2026-06-27

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-017` (Gate 1).*

### Overview

Implement the PostToolUse hook that audit-logs **supervisor-scoped** tool operations — records each Bash/Edit/Write invocation with an ISO-8601 timestamp and a compact argument summary, appended to an audit log. Like the PreToolUse write-guard (TASK-016, APPROVED), the hook is **inert during ordinary interactive development** and logs only when the `SHANNON_SUPERVISOR_SCOPE` signal is present — otherwise it would flood the log with the directing party's normal work (the role is "Log *supervisor* operations for audit trail" per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* PostToolUse row). The audit log is operational telemetry — local-only, not durable project knowledge: it lives at the runtime path `./.claude/skills/shannon-supervisor/audit.log`, which in this repo is **already gitignored** by the blanket `*.claude/` rule (so no new `.gitignore` entry is needed in Shannon-self; the shippable *targeted* ignore for projects that track `.claude/skills/` is the framework convention, routed to scratchpad M-6). Authored in the tracked `./shannon/` source per the scratchpad shipping-source DECISION 2026-06-27, reusing TASK-016's hook conventions (registration snippet under `hooks/`, live `./.claude/settings.json` merge — the existing PreToolUse entry left untouched; the `hooks/` layout entry already named by TASK-016). This Task closes parent Epic AC#5. Out of scope: the PreToolUse hook (TASK-016, APPROVED); the report writer (TASK-015, APPROVED); the production wiring that *sets* the scope signal during real cadence runs (EPIC-011 forward work); the dogfood run that verifies the log accumulates entries live (TASK-018).

### Acceptance Criteria

- **AC#1 — Hook body + registration snippet authored in tracked `./shannon/`; live `settings.json` merged.** The PostToolUse hook **body** is authored at `./shannon/skills/shannon-supervisor/scripts/posttool-auditlog.sh` (deployed to `./.claude/`), alongside TASK-016's `pretool-writeguard.sh`. The **registration** is a tracked shippable snippet at `./shannon/skills/shannon-supervisor/hooks/posttooluse.settings.json` (the `hooks/` layout entry already named by TASK-016 — no further `SKILL.md` § Skill Directory Layout amendment needed). The PostToolUse entry is **merged** into the existing live `./.claude/settings.json` **without disturbing TASK-016's PreToolUse entry**. Per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* ("Hook configuration lives in the project's `settings.json` per Claude Code conventions; specific hook bodies ship with the supervisor skill"). Derives from `technical_design.md` v1.2 § Hook integration, the scratchpad shipping-source DECISION 2026-06-27, and TASK-016 (hook conventions reused).

- **AC#2 — Hook is inert outside supervisor scope; logs only when the supervisor-scope signal is present.** Like the PreToolUse hook (TASK-016 AC#2), the hook reads `SHANNON_SUPERVISOR_SCOPE`: when **absent or empty** (ordinary interactive development) it writes nothing and exits 0 — the role is to log *supervisor* operations, not the directing party's normal work, so an ungated log would be both noisy and a scope violation. When **present**, each Bash/Edit/Write invocation (the three named at `technical_design.md` v1.2 § Hook integration PostToolUse role) is appended to the audit log. The same signal both hooks read is the convention routed to scratchpad (the `SHANNON_SUPERVISOR_SCOPE` item). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (PostToolUse role: "Log supervisor operations for audit trail") and TASK-016 AC#2 (the shared scope-signal gating).

- **AC#3 — Each entry records ISO-8601 timestamp, tool name, and a compact argument summary; append-only; filename codified in `SKILL.md`.** When active, the hook appends one line per invocation — `ISO-8601-timestamp  TOOL_NAME  <compact-args>` (for Bash, the command; for Write/Edit, the `file_path` — not the full content, to keep the log readable) — to `./.claude/skills/shannon-supervisor/audit.log`. The log is **append-only**: a second invocation adds a second line, never overwriting. The audit-log path is codified in `SKILL.md` (an additive amendment to the § Hook Integration PostToolUse bullet, per TASK-011's convention-codification pattern). Derives from `technical_design.md` v1.2 § Hook integration (PostToolUse role) and parent Epic AC#5 (R-2 amendment).

- **AC#4 — Audit log is local-only (not version-controlled).** The audit log is operational telemetry, not durable project knowledge (per the spirit of `development_guide.md` v1.4 § Supervisor Report Files' *Optional state file is gitignored* — "operational telemetry, not durable project knowledge"). It lives under `./.claude/`, which in this repo is **already gitignored** by the existing `*.claude/` rule — so **no new `.gitignore` entry is added in Shannon-self** (a redundant line would be noise). Verifiable: `git check-ignore ./.claude/skills/shannon-supervisor/audit.log` returns a matching rule (`*.claude/`). The shippable *targeted* ignore pattern — for a deploying project that tracks `.claude/skills/` and so does not blanket-ignore it — is the framework convention this Task surfaces, routed to scratchpad M-6 (and is part of the deferred `/shannon-setup` deploy work, not added here). Derives from `development_guide.md` v1.4 § Supervisor Report Files (operational-telemetry framing), parent Epic AC#5 (R-2 amendment), and the scratchpad `.claude/`-gitignore-is-Shannon-self-specific clarification (DECISION 2026-06-27).

- **AC#5 — Project-relative paths throughout.** Same portability discipline as parent Epic AC#1 (G-F extension): the hook script body and the registration snippet use project-relative paths only. Verifiable: literal grep of `posttool-auditlog.sh`, `posttooluse.settings.json`, and the `SKILL.md` amendment for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path returns zero hits. The six-target set matches the lived precedent at TASK-012/013/014/015/016 Gate 3. Derives from parent Epic AC#1 (G-F portability extension) and prior-Task six-target precedent.

- **AC#6 — Hook logic unit-tested directly before commit.** As with TASK-016, the hook body is executable, so its logic is verified by running it directly against representative inputs **before commit** (the global "don't commit before testing" rule and `development_guide.md` v1.4 § Testing Strategy): (a) signal absent → no log entry written (inert), exit 0; (b) signal present + a Write invocation → one line appended matching `ISO-8601  Write  <file_path>`; (c) append-only — a second active invocation appends a second line without truncating the first; (d) the timestamp matches an ISO-8601 shape and the tool name + compact args are present. Tests write to a temp log path (cleaned up after) so the real audit log is not polluted. Full Claude Code runtime hook-firing (PostToolUse actually invokes the script; the signal propagates to the subprocess) is exercised at TASK-018's dogfood. Derives from `development_guide.md` v1.4 § Testing Strategy and the global test-before-commit discipline.

- **AC#7 — Scope-bounded edit per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates the hook body `./shannon/skills/shannon-supervisor/scripts/posttool-auditlog.sh` (deployed to `./.claude/`), the registration snippet `./shannon/skills/shannon-supervisor/hooks/posttooluse.settings.json`, additively amends the `SKILL.md` § Hook Integration PostToolUse bullet (naming the audit-log path), and merges the PostToolUse entry into the live `./.claude/settings.json`. It does **not** modify any checker definition; does **not** modify the report writer or templates (TASK-015 territory, APPROVED); does **not** modify TASK-016's `pretool-writeguard.sh` or its PreToolUse `settings.json` entry (TASK-016 territory, APPROVED); does **not** write to `./docs/supervisor/` (TASK-018 territory); does **not** add a redundant `.gitignore` line (AC#4). The tracked files (body, snippet, `SKILL.md` amendment) are verified via `git diff`; the live `./.claude/settings.json` merge is gitignored and verified via `ls`/read. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

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

Author in the tracked `./shannon/` source, deploy/merge to `./.claude/` (per the DECISION 2026-06-27), reusing TASK-016's hook conventions. The hook script body (`./shannon/skills/shannon-supervisor/scripts/posttool-auditlog.sh`) first checks `SHANNON_SUPERVISOR_SCOPE` — if absent/empty, exit 0 writing nothing (inert, safe for interactive dev); if present, append `ISO-8601-timestamp  TOOL_NAME  <compact-args>` to `./.claude/skills/shannon-supervisor/audit.log`. The registration ships as a tracked snippet (`./shannon/.../hooks/posttooluse.settings.json`); the PostToolUse entry is merged into the live `./.claude/settings.json` without disturbing TASK-016's PreToolUse entry; the `SKILL.md` § Hook Integration PostToolUse bullet is additively amended to name the audit-log path. No new `.gitignore` line (the log is already excluded by `*.claude/` in this repo — AC#4). Audit-log format is plain text, append-only (the operational-telemetry framing favours easy `cat`/`tail` over machine parseability). Because the body is executable, **unit-test it directly before commit**.

### Steps

1. **Author the hook script body** at `./shannon/skills/shannon-supervisor/scripts/posttool-auditlog.sh`. Logic: check `SHANNON_SUPERVISOR_SCOPE` (absent/empty → exit 0, no write); else read the PostToolUse event JSON, extract tool name + a compact arg summary (Bash → command; Write/Edit → `file_path`), append `ISO-8601-timestamp  TOOL_NAME  <args>` to `./.claude/skills/shannon-supervisor/audit.log`. Closes AC#2, AC#3 (logic side).
2. **Author the registration snippet + amend SKILL.md + merge live settings.** Create `./shannon/skills/shannon-supervisor/hooks/posttooluse.settings.json` (PostToolUse entry, matcher `Bash|Edit|Write`); additively amend the `SKILL.md` § Hook Integration PostToolUse bullet to name the audit-log path; merge the entry into `./.claude/settings.json` alongside the existing PreToolUse entry (PreToolUse untouched). Closes AC#1, AC#3 (codification side).
3. **Deploy the body to the active copy.** Copy `posttool-auditlog.sh` to `./.claude/skills/shannon-supervisor/scripts/` (executable); `diff` confirms identical.
4. **Unit-test the hook logic directly.** Run against AC#6's cases (inert → no entry; active + Write → one ISO-8601/tool/args line; append-only → second line added; format check) using a temp log path, cleaned up after. Closes AC#6.
5. **Portability + gitignore verification.** Six-target greps against body + snippet + `SKILL.md` amendment (each 0); `git check-ignore ./.claude/skills/shannon-supervisor/audit.log` returns `*.claude/`. Closes AC#5, AC#4.
6. **Scope-bounded-edit verification.** `git diff` shows only the tracked `./shannon/` additions (body, snippet) + the additive `SKILL.md` amendment + lifecycle bookkeeping; `ls`/read confirms the deployed `./.claude/` body + the merged live `./.claude/settings.json` (gitignored, PreToolUse entry intact). Absence checks: no `checkers/*`, no report-writer/template change (TASK-015), no `pretool-writeguard.sh` or PreToolUse-entry change (TASK-016), no `./docs/supervisor/` write, no redundant `.gitignore` line. Closes AC#7.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton); TASK-019 APPROVED (the tracked `./shannon/skills/shannon-supervisor/` source); TASK-016 APPROVED (the hook conventions reused — `hooks/` layout entry, the live `./.claude/settings.json` this Task merges into, and the shared `SHANNON_SUPERVISOR_SCOPE` signal).
- **Depended on by**: TASK-018 (dogfood run — verifies audit log accumulates entries per parent Epic AC#3's R-5 amendment).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED); `development_guide.md` v1.4 (APPROVED — AC#4 source); `conceptual_design.md` v1.7 (APPROVED — AC#6 source).

### Risks

- **Logging the directing party's normal work (the inherited safety concern).** An ungated PostToolUse hook would append every tool use in every interactive session to the log — noisy and a scope violation (the role is *supervisor* operations). **Mitigation**: AC#2 makes the hook **inert unless `SHANNON_SUPERVISOR_SCOPE` is set** — the same gate TASK-016 established; AC#6 test case (a) verifies the inert path writes nothing before commit.
- **`settings.json` merge clobbering TASK-016's PreToolUse entry.** Both hooks share the live `./.claude/settings.json`. **Mitigation**: AC#1/AC#7 require the PostToolUse entry to be *merged* alongside the existing PreToolUse entry; Step 6 verifies the PreToolUse entry is intact post-merge.
- **Audit log growing without bound.** Append-only over many cadence runs accumulates indefinitely. **Mitigation**: gitignored (won't bloat the repo); if local-disk pressure becomes a concern, surface as a follow-up Task post-EPIC-009 — explicit log rotation is out of scope for the first dogfood.
- **Audit log leaking into version control.** Operational telemetry must stay local. **Mitigation**: the log lives under `./.claude/`, already excluded by the `*.claude/` rule in this repo; Step 5's `git check-ignore` verifies the match. The *shippable* targeted-ignore (for projects that track `.claude/skills/`) is the framework convention routed to scratchpad M-6 / the deferred `/shannon-setup` deploy work — not this Task's to land, but flagged so it is not lost.
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

- **2026-06-27** — ELABORATED (Gate 1 — pending directing-party approval). The audit-log sibling of TASK-016; most hook conventions inherit directly, so the refinements are lighter than TASK-016's. **(R-2, the inherited safety catch)** the prepared AC#2 said the hook "records each tool invocation the supervisor performs" but never defined how it knows an operation is the supervisor's — an ungated PostToolUse hook would log the directing party's *every* tool use in *every* session (noisy + a scope violation; the role is "Log *supervisor* operations"). Reworked to the same **inert-by-default** gating TASK-016 established: writes nothing unless `SHANNON_SUPERVISOR_SCOPE` is set. **(R-5, the AC#4 simplification)** the prepared AC#4 said "add the audit log path to `.gitignore`" — but the log lives under `./.claude/`, **already excluded by the blanket `*.claude/` rule** in this repo, so a new Shannon-self `.gitignore` line is redundant (would be noise). AC#4 reframed: verify via `git check-ignore` (returns `*.claude/`); the *shippable targeted-ignore* for projects that track `.claude/skills/` is the framework convention, routed to scratchpad M-6 (and part of the deferred `/shannon-setup` deploy work). This is the same general-vs-Shannon-self `.claude/`-gitignore distinction surfaced in the DECISION 2026-06-27. **(R-1)** author-in-`./shannon/`: body at `scripts/posttool-auditlog.sh` (deploy to `./.claude/`), registration snippet at `hooks/posttooluse.settings.json` (the `hooks/` layout entry already named by TASK-016 — no further layout amendment), PostToolUse entry **merged** into the live `./.claude/settings.json` leaving TASK-016's PreToolUse entry intact. **(R-3, new AC#6)** the hook body is executable → unit-test the logic directly before commit (inert / logs-when-active / append-only / ISO-8601 format), to a temp log path cleaned up after. **(R-4)** AC#5 grep widened to six targets. **(R-6)** AC#3 codifies the audit-log path `./.claude/skills/shannon-supervisor/audit.log` via an additive amendment to the `SKILL.md` § Hook Integration PostToolUse bullet. **(R-7)** AC#7 scope guard updated — tracked files via `git diff`, live merged `settings.json` (gitignored) via `ls`/read, PreToolUse entry verified intact, no redundant `.gitignore` line. Plan reworked to match; Dependencies updated (TASK-019 + TASK-016 APPROVED); Risks reframed (inherited inert-by-default; settings-merge-must-not-clobber-PreToolUse). **Framework-general routing**: scratchpad M-6 (audit-log convention) updated with the lived finding — the log lives at `./.claude/skills/shannon-supervisor/audit.log`, already gitignored in Shannon-self; the shippable targeted-ignore is the open convention. No *new* signal convention beyond the `SHANNON_SUPERVISOR_SCOPE` item already routed at TASK-016. Status: DRAFT → ELABORATED.
- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-017`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-017`, the prepared plan surfaces for Gate 2 review. Descriptive title (*PostToolUse Audit-Logging Hook*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-017` (Gate 1).
