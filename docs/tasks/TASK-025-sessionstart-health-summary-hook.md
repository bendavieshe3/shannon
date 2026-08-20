# TASK-025: SessionStart Health-Summary Hook

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #sessionstart #reporting
- **Created**: 2026-07-18
- **Updated**: 2026-08-21

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-010 planning (2026-07-18); reviewed, refreshed and approved at Gate 1 on 2026-08-21.*

### Overview

Implement the SessionStart hook — body + registration snippet authored in `./shannon/`, deployed and merged into `./.claude/` — that injects a terse health summary at session open by reading the most-recent report under `./docs/supervisor/`, honouring EPIC-009's same-day suffix convention `report-YYYY-MM-DD[-N].md`. The summary is the session-start half of the terse three-count form `SKILL.md` § Presentation codifies: it leads with the **Drift-category count**, where the report header leads with the **total across all four categories**. The two surfaces are deliberately not interchangeable, and `ux_guide.md` v1.3 says so in as many words.

The Drift-category count is not recoverable from what a report currently carries — the header renders a single total, and the body enumerates only the one or two narrated findings plus an unstructured additional-findings list whose category labels are inconsistent and whose items do not reconcile with the header total. Closing that is **TASK-028's job**, split out of this Task's Gate 1 elaboration and sequenced before it: the report header gains a per-category counts line and the pipeline fills it. This Task consumes that line. Reports written before it lands — both of the reports currently on disk — carry no such line, so the summary states that the breakdown is unavailable and falls back to the total rather than deriving or assuming a number.

Because the supervisor is never ambiguously quiet (`ux_guide.md` v1.3 § Command Surface → *Supervisor Failure Modes*), the summary distinguishes the four quiet outcomes it can encounter — no report at all, a clean run, a partial run, and a report old enough that its counts may no longer describe the project — rather than collapsing them into silence or a bare zero.

The *Supervisor-Approved Gate Notification* one-liner pathway is wired but **dormant** — no shipped capability yet records supervisor-exercised gates (delegated gate-exercise is a later FEAT-009 Epic). Follows the EPIC-009 hook precedent (TASK-016 / TASK-017); hook logic unit-tested before commit, with live auto-firing deferred to EPIC-011. Out of scope: the PreToolUse / PostToolUse hooks (shipped), the preCompact hook (TASK-026), and any change to the checkers or to what a checker classifies as Drift.

### Acceptance Criteria

- [ ] **AC#1 — Hook body + registration snippet authored in `./shannon/`; live `settings.json` wired.** Body at `./shannon/skills/shannon-supervisor/scripts/sessionstart-summary.sh`; tracked snippet at `./shannon/skills/shannon-supervisor/hooks/sessionstart.settings.json` (a SessionStart entry in Claude Code `settings.json` shape); `SKILL.md` § Hook Integration additively updated so the SessionStart bullet reads as implemented rather than as sibling forward work; body deployed to `./.claude/skills/shannon-supervisor/scripts/` and the SessionStart entry merged into the live `./.claude/settings.json` alongside the shipped PreToolUse and PostToolUse entries. *Derives from* `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (SessionStart row); EPIC-009 TASK-016 / TASK-017 hook-authoring precedent + the shipping-source DECISION 2026-06-27.

- [ ] **AC#2 — Resolves "most recent" report honouring the same-day suffix.** The hook selects the highest ISO date under the configured report directory (default `./docs/supervisor/`, per `SKILL.md` § Configuration — the hook reuses those default-and-override semantics rather than inventing a second configuration path), then the highest `-N` suffix among same-day reports, so `report-2026-08-20-2.md` wins over `report-2026-08-20.md`. *Derives from* parent EPIC-010 AC#3; `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*; `SKILL.md` § Report Pipeline step 5 (same-day-suffix convention).

- [ ] **AC#3 — Terse summary leads with the Drift-category count, read from the per-category header line.** The injected summary carries the same terse three-count form as the report header — a leading count, then stuck-or-stale items, then push lag — but leads with the **Drift-category count alone**, not the total. It reads that count from the per-category counts line TASK-028 adds to the report header; this Task **consumes** that line and does not create it. Where the line is absent — every report written before TASK-028 lands, including both reports currently on disk — the summary says the per-category breakdown is unavailable and names the total instead. It does **not** infer a Drift count by counting body sections or bullets: the body narrates only the highest-signal findings, its additional-findings list is prose whose category labels are not uniform, and on `report-2026-07-05.md` the enumerated items do not reconcile with the header's own total — a derived count would be a lower bound presented as a count, which is the ambiguity `ux_guide.md` v1.3 § Command Surface → *Supervisor Failure Modes* forbids. *Derives from* `ux_guide.md` v1.3 § Interaction Patterns → *Supervisor Report Presentation* (the header-leads-with-total versus session-start-leads-with-Drift distinction); `SKILL.md` § Presentation (landed by sibling TASK-023); sibling TASK-028 (the data source); parent EPIC-010 AC#3 + AC#2(b).

- [ ] **AC#4 — Gate-notification pathway wired but dormant.** The *Supervisor-Approved Gate Notification* one-liner is present in the injection logic but produces no output, with an inline comment naming delegated gate-exercise — a later Epic under FEAT-009 — as its future activator. Nothing shipped records supervisor-exercised gates, so there is no data for it to present. *Derives from* parent EPIC-010 AC#3 (dormant clause); `ux_guide.md` v1.3 § Interaction Patterns → *Supervisor-Approved Gate Notification*; FEAT-009 § User Stories → *Discovering Decisions Made Between Sessions* (forward work).

- [ ] **AC#5 — The summary is never ambiguously quiet.** Each quiet outcome states which kind of quiet it is, and each is distinguishable from the others in the injected text: (a) **no report exists** under the report directory — the summary names the directory and says no supervisor report has been written yet; (b) **a clean run** — the report's `Findings: 0` is presented as a positive result carrying the run's own checker line ("3 checkers ran cleanly; nothing surfaced"), never as an omitted or blank summary; (c) **a partial run** — a report whose header reads `Checkers run: 2 of 3` has that shortfall carried into the summary, so a partial run is never presented at session start as a whole one; (d) **an unreadable or malformed report** — the summary names the offending file path and says it could not be read, rather than falling back to a zero or to silence. A bare zero is never emitted for a count the hook could not determine. *Derives from* `ux_guide.md` v1.3 § Command Surface → *Supervisor Failure Modes* (all four faces) and § Interaction Patterns → *Supervisor Report Presentation* (the clean-run paragraph); `SKILL.md` § Report Pipeline step 3 (landed by sibling TASK-024).

- [ ] **AC#6 — The report's identity and age are always named.** Every non-empty summary names the report it is reading — its date, and how old that report is at session open. Counts from a report six weeks stale describe the project as it was, not as it is, and a summary that presents them undated invites the directing party to act on them as current. This Task fixes no staleness threshold and emits no warning wording: it states the age and leaves the judgement with the directing party, because no approved document codifies an expected cadence interval (`technical_design.md` § Cadence names the invocation contract and leaves the scheduler to the project). *Derives from* `ux_guide.md` v1.3 § Command Surface → *Supervisor Failure Modes* (the supervisor is never ambiguously quiet); `technical_design.md` v1.2 § Data Model → *Supervisor Report Files* (the report's ISO date is its identifier) and § Cadence → *Scheduler*.

- [ ] **AC#7 — Fires in normal sessions, not scope-gated, unit-tested before commit.** Unlike the write-guard and audit-log hooks, SessionStart is deliberately **not** gated on `SHANNON_SUPERVISOR_SCOPE` — read-only session orientation is its whole purpose, and a scope-gated summary would never fire for the directing party it exists to orient. The mute lever is instead the optional Cadence State file per `technical_design.md` v1.2 § Data Model → *Cadence State*; a missing or corrupt state file leaves the hook firing normally. The hook writes nothing and always exits 0. Its logic is unit-tested by running the script directly against representative inputs before commit: (a) most-recent resolution including the `-N` suffix; (b) the Drift-lead terse shape against a report carrying the per-category line; (c) a legacy report carrying no per-category line; (d) each of AC#5's four quiet outcomes; (e) the AC#6 age line. Live auto-firing inside a real Claude Code session is honestly deferred to EPIC-011, per the EPIC-009 precedent. *Derives from* the directing-party disposition ratified at EPIC-010 Gate 2 (2026-07-18); `technical_design.md` v1.2 § Data Model → *Cadence State*; `development_guide.md` v1.4 § Testing Strategy and the global test-before-commit rule.

- [ ] **AC#8 — Plain-prose discipline and scope-bounded edit.** Any phrase this Task commits to grep-verifying lands as plain prose, not inside a table cell or a fenced block (parent AC#7). Per the cross-type guard (parent AC#8), this Task creates the SessionStart script body and registration snippet, additively updates `SKILL.md` § Hook Integration, and merges the live settings entry. It does **not** modify any template under `templates/` — the per-category header line is TASK-028's, and this Task must not pre-empt or duplicate it — nor the PreToolUse or PostToolUse hooks, any checker definition under `checkers/`, the `/shannon-goal` contract, the preCompact hook (TASK-026 territory), or any other skill. It writes nothing under `./docs/supervisor/` and retrofits no existing report. Tracked changes are verified by `git diff`; the gitignored `./.claude/` deployment is verified by `ls` and by reading the files. *Derives from* `conceptual_design.md` v1.7 § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*; parent EPIC-010 AC#7 and AC#8.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md) — Task 4 of 7; covers AC#3 and confirms AC#2(b)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Five Claude Code hook integration points* (SessionStart half) and *Hybrid report presentation by default*; § User Stories *Cadence-Driven Health Summary at Session Start*
- **UX Guide** (v1.3, APPROVED 2026-08-21 — later than this Task's prepared draft): § Interaction Patterns → *Supervisor Report Presentation* (the header-total versus session-start-Drift distinction, and the clean-run paragraph); § Interaction Patterns → *Supervisor-Approved Gate Notification*; § Command Surface → *Supervisor Failure Modes*
- **Technical Design** (v1.2): § System Architecture → *Supervisor* → *Hook integration*; § Data Model → *Supervisor Report Files* / *Supervisor Configuration* / *Cadence State*; § Cadence → *Scheduler*
- **Development Guide** (v1.4): § Testing Strategy (test-before-commit); § Code Style → *Source-of-truth body before derived artefacts*
- **Shipped surfaces this Task reads or extends**: `shannon/skills/shannon-supervisor/SKILL.md` § Presentation (TASK-023) and § Report Pipeline steps 2, 3 and 5 (TASK-015, TASK-024); `shannon/skills/shannon-supervisor/templates/header.md`
- **Depends on**: [TASK-028](./TASK-028-per-category-finding-counts-in-report-header.md) — supplies the per-category header line AC#3 reads. TASK-025 is implementable before TASK-028 lands (the legacy path is required behaviour either way), but its Drift-lead is inert until it does
- **Related work**: EPIC-009 hook precedent (TASK-016 / TASK-017); sibling TASK-023 (documented terse shape) and TASK-024 (clean-run shape), both APPROVED 2026-08-02; TASK-026 (preCompact) and TASK-027 (`/shannon-goal` resync) still DRAFT
- **Real reports the hook must handle**: `docs/supervisor/report-2026-07-05.md` and `docs/supervisor/report-2026-08-20.md` — both predate the per-category header line, so both exercise AC#3's legacy path and AC#6's age line

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

- **2026-08-21** — ELABORATED (Gate 1 approved). Prepared draft reviewed against current reality by an elaboration subagent; refreshed and approved DRAFT → ELABORATED. **Refresh trigger**: `ux_guide.md` reached v1.3 on 2026-08-21, one day before this gate, stating that the report header leads with the total across all four finding categories while the session-start summary leads with the Drift-category count alone — deliberately not interchangeable. The prepared AC#3 had required the summary to carry a Drift count "matching the report-header counts shape", which v1.3 makes self-contradictory. **The material finding**: the Drift-category count is not recoverable from any shipped report surface — `templates/header.md` renders a single total — and deriving it by parsing report bodies is unsound, because the body narrates only the highest-signal findings by design, its additional-findings labels are not uniform, and `report-2026-07-05.md`'s enumerated items do not reconcile with its own header total. A parsed count would be a lower bound presented as a count, the exact ambiguity v1.3 § Supervisor Failure Modes forbids; on `report-2026-08-20.md` it yields Drift 0 for a report whose two lead findings are real. **Directing-party rulings** (four): (1) add the count to the header rather than parse it, and **split that into TASK-028**, sequenced before this Task — a report-format change is consumed by every future reader, where this Task changes one hook; AC#3 and AC#8 rewritten so this Task consumes the line, must not create it, and handles its absence by naming the total and saying the breakdown is unavailable; (2) existing reports are **not** retrofitted, so the legacy path is live in every session until the next `/shannon-report` run; (3) staleness is stated, not judged — AC#6 names the report's date and age and sets no threshold, because no approved document codifies an expected cadence interval and a Task may not invent one; (4) the Drift-as-lead choice itself is questioned but not reversed — captured in `scratchpad.md` with `report-2026-08-20.md` as first evidence, rather than amending a one-day-old Guide decision on a single data point. **Further refinements applied**: AC#5 expanded from one graceful case to four distinguishable quiet outcomes per v1.3 § Supervisor Failure Modes (no report / clean run / partial run / unreadable report), a bare zero never standing in for a count the hook could not determine; AC#6 added (report identity and age); AC#7 gained the writes-nothing, always-exit-0 requirement, since SessionStart is the only supervisor hook not scope-gated and a failing one degrades every session open; AC#2 gained reuse of `SKILL.md` § Configuration's `report_directory` override semantics per the TASK-016 precedent; all `ux_guide.md` citations refreshed v1.2 → v1.3. **Three framework-general ambiguities routed to `scratchpad.md`** per `development_guide.md:114`: the Drift-lead question above; `development_guide.md` § Testing Strategy claiming Shannon has no units while three hook Tasks cite it for script unit-testing; and supervisor report bodies not reconciling with their own header counts. Plan section carries the prepared draft forward unchanged to `/task-plan TASK-025` (Gate 2) — it still describes extracting counts and needs reconciling against the TASK-028 split. Status: DRAFT → ELABORATED.
- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#3 (and confirms AC#2(b)). Directing-party disposition ratified at EPIC-010 Gate 2: SessionStart deliberately **not** `SHANNON_SUPERVISOR_SCOPE`-gated (read-only session orientation, muted via Cadence State). Gate-notification pathway wired but dormant. Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-025` (Gate 1) and `/task-plan TASK-025` (Gate 2).
