# TASK-016: PreToolUse Write-Guard Hook

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #pretooluse #write-guard #scope
- **Created**: 2026-05-30
- **Updated**: 2026-06-27

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-016` (Gate 1).*

### Overview

Implement the PreToolUse hook that write-guards a **supervisor-scoped invocation** — refuses any write whose target is outside the configured `report_directory` (default `./docs/supervisor/`), with an explicit exception for `./docs/knowledge_index.md` per parent Epic AC#4 R-3 (the indexing convention TASK-015, now APPROVED, exercises). Per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (PreToolUse row — "refuse writes outside `docs/supervisor/` from a supervisor-scoped invocation") the guard applies to a *supervisor-scoped invocation*; since EPIC-009 ships the interactive `/shannon-report` path only (autonomous cadence is EPIC-011 per the parent Epic § Overview), the hook must be **inert during ordinary interactive development** and enforce only when a supervisor-scope signal is present — so registering it live in `settings.json` does not block the directing party's normal writes. The hook returns exit code 2 (blocking) when it refuses. Authored in the tracked `./shannon/` source per the scratchpad shipping-source DECISION 2026-06-27, with the registration tracked as a standalone snippet and the live `./.claude/settings.json` wired. This Task closes parent Epic AC#4. Out of scope: the PostToolUse audit-logging hook (TASK-017); the report writer (TASK-015, APPROVED); the production wiring that *sets* the supervisor-scope signal during real headless cadence runs (EPIC-011 forward work); the dogfood run that exercises block/allow live at runtime (TASK-018).

### Acceptance Criteria

- **AC#1 — Hook body + registration snippet authored in tracked `./shannon/`; live `settings.json` wired.** The PreToolUse hook **body** is authored in the tracked source at `./shannon/skills/shannon-supervisor/scripts/pretool-writeguard.sh` and deployed to `./.claude/skills/shannon-supervisor/scripts/`. The hook **registration** is tracked as a standalone shippable snippet at `./shannon/skills/shannon-supervisor/hooks/pretooluse.settings.json` (the PreToolUse entry in Claude Code `settings.json` shape), and `SKILL.md` § Skill Directory Layout is additively amended to name the new `hooks/` entry alongside `templates/`, `checkers/`, `scripts/`. The live registration is merged into `./.claude/settings.json` (created if absent — the **project-shared** settings file, distinct from the personal `settings.local.json`) so the hook is registered at runtime. Per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* ("Hook configuration lives in the project's `settings.json` per Claude Code conventions; specific hook bodies ship with the supervisor skill"). Derives from `technical_design.md` v1.2 § Hook integration and the scratchpad shipping-source DECISION 2026-06-27 (author in tracked `./shannon/`, deploy to `./.claude/`).

- **AC#2 — Hook is inert outside supervisor scope; enforces the write-guard only when the supervisor-scope signal is present.** The hook reads a supervisor-scope activation signal — the environment variable `SHANNON_SUPERVISOR_SCOPE` (set to a non-empty value by a supervisor-scoped invocation; the production signal-setting in real headless cadence runs is EPIC-011 forward work). When the signal is **absent or empty** (ordinary interactive development), the hook exits 0 immediately and does not interfere with any write — this is the safety floor that makes live `settings.json` registration non-disruptive to the directing party's normal development. When the signal is **present**, the hook enforces: a Write/Edit whose resolved target path is outside the configured `report_directory` is refused with **exit code 2** (blocking, per the `technical_design.md` v1.2 hook contract) and a concise stderr message naming the supervisor scope (per `ux_guide.md` v1.2 § Voice and Tone — concise, specific failure framing). Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (PreToolUse row — "refuse writes outside `docs/supervisor/` from a supervisor-scoped invocation") and `ux_guide.md` v1.2 § Voice and Tone.

- **AC#3 — Explicit exception for `./docs/knowledge_index.md` writes.** Even when the supervisor-scope signal is present, the hook permits Write/Edit operations targeting `./docs/knowledge_index.md` — the explicit exception reciprocal to TASK-015 AC#4 (the report-indexing step, now APPROVED) and required by parent Epic AC#4 R-3. The exception is encoded in the hook script's allow-list (and visible in the registration snippet), not a silent bypass. Derives from parent Epic AC#4 (R-3 amendment) and TASK-015 AC#4 (the reciprocal index-write exception).

- **AC#4 — Configured `report_directory` override is honoured.** If a project has set `report_directory` in `./.claude/shannon-supervisor.json` (per TASK-011 AC#4's configuration handling), the hook reads that override and scopes writes accordingly. If the configuration file is absent or the field is absent, the default `./docs/supervisor/` applies. The hook re-uses the same default-and-override semantics TASK-011 codified — it does not invent a second configuration path. Derives from `technical_design.md` v1.2 § Data Model → *Supervisor Configuration*, TASK-011 AC#4, and parent Epic AC#6.

- **AC#5 — Project-relative paths throughout.** Same portability discipline as parent Epic AC#1 (G-F extension): the hook script body and the registration snippet use project-relative paths only. Verifiable: literal grep of `pretool-writeguard.sh`, `pretooluse.settings.json`, and the `SKILL.md` § Skill Directory Layout amendment for `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, and this repository's absolute path returns zero hits. The six-target set matches the lived precedent at TASK-012/013/014/015 Gate 3. Derives from parent Epic AC#1 (G-F portability extension) and TASK-012/013/014/015 AC#5 precedent.

- **AC#6 — Hook logic unit-tested directly before commit.** The hook body is the first executable deliverable, so its logic is verified by running the script directly against representative inputs **before commit** (per the global "don't commit before testing" rule and `development_guide.md` v1.4 § Testing Strategy): (a) signal absent → exit 0 (inert) regardless of target path; (b) signal present + in-scope path (under `report_directory`) → exit 0; (c) signal present + out-of-scope path (e.g. `./docs/scratchpad.md`) → exit 2; (d) signal present + `./docs/knowledge_index.md` → exit 0 (the AC#3 exception); (e) signal present + a configured-override `report_directory` path → honoured. Full Claude Code runtime hook-firing (settings.json honoured; exit 2 actually blocks the tool) is exercised at TASK-018's dogfood. Derives from `development_guide.md` v1.4 § Testing Strategy and the global test-before-commit discipline.

- **AC#7 — Scope-bounded edit per cross-type-guard rule.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates the hook body `./shannon/skills/shannon-supervisor/scripts/pretool-writeguard.sh` (deployed to `./.claude/`), the registration snippet `./shannon/skills/shannon-supervisor/hooks/pretooluse.settings.json`, additively amends `SKILL.md` § Skill Directory Layout (naming the `hooks/` entry), and merges the PreToolUse entry into the live `./.claude/settings.json`. It does **not** modify any checker definition under `checkers/`; does **not** modify the report writer or templates (TASK-015 territory, APPROVED); does **not** add the PostToolUse hook (TASK-017 territory); does **not** write to `./docs/supervisor/` (TASK-018 territory). The tracked files (script body, snippet, `SKILL.md` amendment) are verified via `git diff`; the live `./.claude/settings.json` is gitignored and verified via `ls`/read. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.

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

Author in the tracked `./shannon/` source, deploy/wire to `./.claude/` (per the DECISION 2026-06-27). The hook script body (`./shannon/skills/shannon-supervisor/scripts/pretool-writeguard.sh`) first checks the `SHANNON_SUPERVISOR_SCOPE` signal — if absent/empty, exit 0 immediately (inert, safe for interactive dev); if present, read the configuration override (if `./.claude/shannon-supervisor.json` exists with a `report_directory` field, use that; otherwise default `./docs/supervisor/`), check the tool invocation's target path against the scope plus the `./docs/knowledge_index.md` exception, and exit 0 (allow) or 2 (block) per the `technical_design.md` v1.2 hook contract. The registration ships as a tracked standalone snippet (`./shannon/.../hooks/pretooluse.settings.json`); `SKILL.md` § Skill Directory Layout is additively amended to name the `hooks/` entry; the live entry is merged into `./.claude/settings.json`. Apply the editing-order convention: the hook script body + snippet are source-of-truth; the live `settings.json` is the derived/deployed pointer. Because the body is executable, **unit-test it directly before commit** (the global test-before-commit rule).

### Steps

1. **Author the hook script body** at `./shannon/skills/shannon-supervisor/scripts/pretool-writeguard.sh`. Logic: check `SHANNON_SUPERVISOR_SCOPE` (absent/empty → exit 0 inert); else read `./.claude/shannon-supervisor.json` if present (`report_directory` field; default if absent); check target path; permit the `./docs/knowledge_index.md` exception; exit 0 (allow) or 2 (block). Closes AC#2, AC#3, AC#4 (logic side).
2. **Author the registration snippet + amend the layout + wire live settings.** Create `./shannon/skills/shannon-supervisor/hooks/pretooluse.settings.json` (the PreToolUse entry, shippable); additively amend `SKILL.md` § Skill Directory Layout to name the `hooks/` entry; merge the entry into `./.claude/settings.json` (create if absent). Closes AC#1.
3. **Deploy the body to the active copy.** Copy `pretool-writeguard.sh` to `./.claude/skills/shannon-supervisor/scripts/`; `diff` confirms identical.
4. **Unit-test the hook logic directly.** Run `pretool-writeguard.sh` against the five cases in AC#6 (signal absent → 0; in-scope → 0; out-of-scope → 2; knowledge_index → 0; override honoured) and confirm exit codes. Closes AC#6.
5. **Portability discipline verification.** Six-target greps (`FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, `~/`, absolute repo path) against the body + snippet + `SKILL.md` amendment; each 0. Closes AC#5.
6. **Scope-bounded-edit verification.** `git diff` shows only the tracked `./shannon/` additions (script body, snippet) + the additive `SKILL.md` amendment + lifecycle bookkeeping; `ls`/read confirms the deployed `./.claude/` body + the live `./.claude/settings.json` entry (gitignored). Absence checks: no `checkers/*`, no report-writer/template change (TASK-015), no PostToolUse (TASK-017), no `./docs/supervisor/` write. Closes AC#7.

### Dependencies

- **Depends on**: TASK-011 APPROVED (skeleton + configuration-handling logic); TASK-019 APPROVED (the tracked `./shannon/skills/shannon-supervisor/` source this Task authors into); TASK-015 APPROVED (the `./docs/knowledge_index.md` index-write exception is now codified — AC#3 is its reciprocal).
- **Depended on by**: TASK-018 (dogfood run).
- **Cascade docs**: `technical_design.md` v1.2 (APPROVED — AC#1, AC#2, AC#4 source); Phase-0 spike § 1 (AC#2 source — exit code 2 contract); `conceptual_design.md` v1.7 (APPROVED — AC#6 source).

### Risks

- **Hook blocks normal interactive development (the catastrophic failure).** A globally-registered PreToolUse hook that enforces unconditionally would refuse the directing party's every write outside `./docs/supervisor/` in every session — bricking ordinary development. **Mitigation**: AC#2 makes the hook **inert by default** — it exits 0 immediately unless `SHANNON_SUPERVISOR_SCOPE` is set; enforcement only happens under that signal. AC#6's unit test case (a) verifies the inert path directly before commit, and the signal is absent in normal sessions, so live `settings.json` registration is safe. The production signal-setting is EPIC-011 forward work, so in EPIC-009 the hook is effectively dormant except under the manual signal TASK-018's dogfood sets.
- **Hook over-restrictive — blocking the `knowledge_index.md` exception.** Forgetting the AC#3 exception would break the (APPROVED) TASK-015 pipeline at the index-update step. **Mitigation**: AC#3 is explicit; AC#6 test case (d) verifies it directly; TASK-018's dogfood catches it live because the report writer cannot complete; the parent Epic § Plan § Risks paragraph 3 already flags this with AC-traceable mitigation.
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

- **2026-06-27** — ELABORATED (Gate 1 — pending directing-party approval). The first **hook** Task — surfaced two material findings beyond the routine refinements. **(R-2, the safety catch — Internal Gap)** the prepared AC#2 said the hook refuses out-of-scope writes "when the supervisor scope is active" but never defined the activation mechanism. A globally-registered PreToolUse hook enforcing unconditionally would block the directing party's *every* write outside `./docs/supervisor/` in *every* session — bricking normal development. Aligned to `technical_design.md` v1.2 § Hook integration (PreToolUse row: "from a supervisor-scoped invocation") and the parent Epic § Overview (EPIC-009 is interactive-only; autonomous cadence is EPIC-011): AC#2 reworked so the hook is **inert by default** — exits 0 immediately unless the `SHANNON_SUPERVISOR_SCOPE` env signal is set — and enforces (exit 2, blocking) only under that signal. Production signal-setting in real headless cadence runs is EPIC-011 forward work; TASK-018 sets it manually to test enforcement. **(R-3, test-before-commit)** the hook body is the first **executable** deliverable, so a new **AC#6** requires unit-testing the script logic directly before commit (five cases: inert / in-scope / out-of-scope / knowledge_index exception / override), per the global "don't commit before testing" rule — full Claude Code runtime firing stays deferred to TASK-018. **Directing-party decision (registration tracking)**: asked how to track the hook registration given `.claude/settings.json` is gitignored in Shannon-self; directing party chose the **standalone `./shannon/` snippet** approach. Accordingly **(R-1)** the hook body is authored at `./shannon/skills/shannon-supervisor/scripts/pretool-writeguard.sh` (deployed to `./.claude/`), the registration is a tracked shippable snippet at `./shannon/skills/shannon-supervisor/hooks/pretooluse.settings.json`, `SKILL.md` § Skill Directory Layout is additively amended to name the new `hooks/` entry, and the live entry is merged into `./.claude/settings.json` (project-shared, created if absent). **(R-4)** AC#5 grep widened to six targets (added `~/`), now covering body + snippet + SKILL.md amendment. **(R-5)** AC#3 tied to the now-APPROVED TASK-015 AC#4 (its reciprocal index-write exception). **(R-6)** AC#7 (renumbered from AC#6) scope guard updated — tracked files verified via `git diff`, the gitignored live `./.claude/settings.json` via `ls`/read. Plan reworked to the author-in-`./shannon/` + snippet + signal-gating + unit-test + deploy + `git diff` shape; Dependencies updated (TASK-019 + TASK-015 APPROVED); a new top Risk names the block-normal-development catastrophic failure with the inert-by-default mitigation. **Framework-general routing**: the `SHANNON_SUPERVISOR_SCOPE` activation signal is a convention EPIC-011's cadence launcher and every scope-gated supervisor hook must share — routed to scratchpad. Status: DRAFT → ELABORATED.
- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-016`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-016`, the prepared plan surfaces for Gate 2 review. Descriptive title (*PreToolUse Write-Guard Hook*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-016` (Gate 1).
