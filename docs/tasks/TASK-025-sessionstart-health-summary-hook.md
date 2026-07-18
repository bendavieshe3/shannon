# TASK-025: SessionStart Health-Summary Hook

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #sessionstart #reporting
- **Created**: 2026-07-18
- **Updated**: 2026-07-18

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-025` (Gate 1).*

### Overview

Implement the SessionStart hook — body + registration snippet authored in `./shannon/`, deployed/merged to `./.claude/` — that injects a terse health summary (drift count, stuck items count, push lag) at session open by reading the most-recent report under `./docs/supervisor/`, honouring EPIC-009's same-day suffix convention `report-YYYY-MM-DD[-N].md`. The *Supervisor-Approved Gate Notification* one-liner pathway is wired but **dormant** — no shipped capability yet records supervisor-exercised gates (delegated gate-exercise is a later FEAT-009 Epic). Follows the EPIC-009 hook precedent (TASK-016/TASK-017); hook logic unit-tested before commit, with live auto-firing deferred to EPIC-011. Out of scope: the PreToolUse/PostToolUse hooks (shipped), the preCompact hook (TASK-026).

### Acceptance Criteria

- [ ] **AC#1 — Hook body + registration snippet authored in `./shannon/`; live `settings.json` wired.** Body at `./shannon/skills/shannon-supervisor/scripts/sessionstart-summary.sh`; tracked snippet at `./shannon/skills/shannon-supervisor/hooks/sessionstart.settings.json` (SessionStart entry); `SKILL.md` § Hook Integration additively updated (SessionStart row now implemented); deployed to `./.claude/` and merged into live `./.claude/settings.json`. *Derives from* `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (SessionStart row); EPIC-009 TASK-016 hook-authoring precedent + shipping-source DECISION 2026-06-27.
- [ ] **AC#2 — Resolves "most recent" report honouring the same-day suffix.** The hook selects the highest ISO date under `./docs/supervisor/`, then the highest `-N` suffix among same-day reports (`report-YYYY-MM-DD[-N].md`). *Derives from* parent EPIC-010 AC#3; `technical_design.md` § Data Model → *Supervisor Report Files*; EPIC-009 `SKILL.md` § Report Pipeline step 5 (same-day-suffix convention).
- [ ] **AC#3 — Terse summary reuses the hybrid header-counts shape.** The injected summary carries drift count, stuck items count, and push lag, matching the report-header counts shape documented by TASK-023 — realising parent AC#2(b). *Derives from* parent EPIC-010 AC#3 + AC#2(b); `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*; sibling TASK-023.
- [ ] **AC#4 — Gate-notification pathway wired but dormant.** The *Supervisor-Approved Gate Notification* one-liner is present in the injection logic but produces no output (dormant), with an inline comment naming the delegated-gate-exercise Epic as its future activator. *Derives from* parent EPIC-010 AC#3 (dormant clause); `ux_guide.md` § Interaction Patterns → *Supervisor-Approved Gate Notification*; FEAT-009 (delegated gate-exercise is forward work).
- [ ] **AC#5 — Fires in normal sessions, degrades gracefully, unit-tested before commit.** Unlike the write-guard hooks, SessionStart is **not** gated on `SHANNON_SUPERVISOR_SCOPE` — read-only session orientation is its purpose; the mute lever is the optional Cadence State file per `technical_design.md` § Data Model → *Cadence State*. When no report exists under `./docs/supervisor/`, it emits a graceful "no supervisor report yet" line (no crash). Logic unit-tested before commit: (a) most-recent-with-suffix resolution; (b) no-report graceful case; (c) terse-shape output. *Derives from* `development_guide.md` v1.4 § Testing Strategy + the global test-before-commit rule; `technical_design.md` § Data Model → *Cadence State*.
- [ ] **AC#6 — Plain-prose discipline + scope-bounded edit.** Grep-verified phrases as plain prose (parent AC#7); creates the SessionStart script + snippet + the `SKILL.md` § Hook Integration update only — does **not** modify the PreToolUse/PostToolUse hooks, checkers, templates, the goal-skill/command, or any other skill (cross-type-guard, parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary…Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Five Claude Code hook integration points* (SessionStart half) + § User Stories *Cadence-Driven Health Summary at Session Start*
- **Relevant documents**: `technical_design.md` § System Architecture → *Supervisor* → *Hook integration* + § Data Model → *Supervisor Report Files* / *Cadence State*; `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation* / *Supervisor-Approved Gate Notification*
- **Related work**: EPIC-009 hook precedent (TASK-016/017); sibling TASK-023 (documented shape)

---

## Plan

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-plan TASK-025` (Gate 2).*

### Approach

Author in `./shannon/`, deploy/wire to `./.claude/` per the DECISION 2026-06-27. Body resolves the most-recent report (date then `-N`), extracts the three counts, prints the terse summary; dormant gate-notification branch included but silent. Unit-test the resolution + no-report + shape cases before commit; live auto-firing is EPIC-011's.

### Steps

1. Author `sessionstart-summary.sh` (resolve most-recent report incl. suffix; extract counts; print terse summary; dormant gate-notification branch; graceful no-report case).
2. Author `sessionstart.settings.json` snippet; additively update `SKILL.md` § Hook Integration.
3. Deploy body + snippet to `./.claude/`; merge live `settings.json`; `diff`.
4. Unit-test the three cases (AC#5).
5. Plain-prose grep.
6. `git diff` scope check (tracked `./shannon/` + additive SKILL.md; gitignored `./.claude/` via `ls`/read).

### Dependencies

- TASK-023 (documented terse/hybrid shape) + EPIC-009 APPROVED (reports to read + `SKILL.md` skeleton); benefits from TASK-024 (clean-run zero-findings shape). Live auto-firing → EPIC-011.

### Risks

- Same-day suffix mis-resolution picks a stale report — mitigated by AC#2 explicit ordering + unit test.
- Summary becomes session-start noise — mitigated by "terse" + the Cadence State mute lever.
- Runtime auto-firing unverified — honestly deferred to EPIC-011 per EPIC-009 precedent.

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

*Filled during review (Gate 3).*

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

- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#3 (and confirms AC#2(b)). Directing-party disposition ratified at EPIC-010 Gate 2: SessionStart deliberately **not** `SHANNON_SUPERVISOR_SCOPE`-gated (read-only session orientation, muted via Cadence State). Gate-notification pathway wired but dormant. Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-025` (Gate 1) and `/task-plan TASK-025` (Gate 2).
