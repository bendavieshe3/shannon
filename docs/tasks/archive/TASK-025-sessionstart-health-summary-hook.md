# TASK-025: SessionStart Health-Summary Hook

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #sessionstart #reporting
- **Created**: 2026-07-18
- **Updated**: 2026-08-24

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

- [x] **AC#1 — Hook body + registration snippet authored in `./shannon/`; live `settings.json` wired.** Body at `./shannon/skills/shannon-supervisor/scripts/sessionstart-summary.sh`; tracked snippet at `./shannon/skills/shannon-supervisor/hooks/sessionstart.settings.json` (a SessionStart entry in Claude Code `settings.json` shape); `SKILL.md` § Hook Integration additively updated so the SessionStart bullet reads as implemented rather than as sibling forward work; body deployed to `./.claude/skills/shannon-supervisor/scripts/` and the SessionStart entry merged into the live `./.claude/settings.json` alongside the shipped PreToolUse and PostToolUse entries. *Derives from* `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (SessionStart row); EPIC-009 TASK-016 / TASK-017 hook-authoring precedent + the shipping-source DECISION 2026-06-27.

- [x] **AC#2 — Resolves "most recent" report honouring the same-day suffix.** The hook selects the highest ISO date under the configured report directory (default `./docs/supervisor/`, per `SKILL.md` § Configuration — the hook reuses those default-and-override semantics rather than inventing a second configuration path), then the highest `-N` suffix among same-day reports, so `report-2026-08-20-2.md` wins over `report-2026-08-20.md`. *Derives from* parent EPIC-010 AC#3; `technical_design.md` v1.2 § Data Model → *Supervisor Report Files*; `SKILL.md` § Report Pipeline step 5 (same-day-suffix convention).

- [x] **AC#3 — Terse summary leads with the Drift-category count, read from the per-category header line.** The injected summary carries the same terse three-count form as the report header — a leading count, then stuck-or-stale items, then push lag — but leads with the **Drift-category count alone**, not the total. It reads that count from the per-category counts line TASK-028 adds to the report header; this Task **consumes** that line and does not create it. Where the line is absent — every report written before TASK-028 lands, including both reports currently on disk — the summary says the per-category breakdown is unavailable and names the total instead. It does **not** infer a Drift count by counting body sections or bullets: the body narrates only the highest-signal findings, its additional-findings list is prose whose category labels are not uniform, and on `report-2026-07-05.md` the enumerated items do not reconcile with the header's own total — a derived count would be a lower bound presented as a count, which is the ambiguity `ux_guide.md` v1.3 § Command Surface → *Supervisor Failure Modes* forbids. *Derives from* `ux_guide.md` v1.3 § Interaction Patterns → *Supervisor Report Presentation* (the header-leads-with-total versus session-start-leads-with-Drift distinction); `SKILL.md` § Presentation (landed by sibling TASK-023); sibling TASK-028 (the data source); parent EPIC-010 AC#3 + AC#2(b).

- [x] **AC#4 — Gate-notification pathway wired but dormant.** The *Supervisor-Approved Gate Notification* one-liner is present in the injection logic but produces no output, with an inline comment naming delegated gate-exercise — a later Epic under FEAT-009 — as its future activator. Nothing shipped records supervisor-exercised gates, so there is no data for it to present. *Derives from* parent EPIC-010 AC#3 (dormant clause); `ux_guide.md` v1.3 § Interaction Patterns → *Supervisor-Approved Gate Notification*; FEAT-009 § User Stories → *Discovering Decisions Made Between Sessions* (forward work).

- [x] **AC#5 — The summary is never ambiguously quiet.** Each quiet outcome states which kind of quiet it is, and each is distinguishable from the others in the injected text: (a) **no report exists** under the report directory — the summary names the directory and says no supervisor report has been written yet; (b) **a clean run** — the report's `Findings: 0` is presented as a positive result carrying the run's own checker line ("3 checkers ran cleanly; nothing surfaced"), never as an omitted or blank summary; (c) **a partial run** — a report whose header reads `Checkers run: 2 of 3` has that shortfall carried into the summary, so a partial run is never presented at session start as a whole one; (d) **an unreadable or malformed report** — the summary names the offending file path and says it could not be read, rather than falling back to a zero or to silence. A bare zero is never emitted for a count the hook could not determine. *Derives from* `ux_guide.md` v1.3 § Command Surface → *Supervisor Failure Modes* (all four faces) and § Interaction Patterns → *Supervisor Report Presentation* (the clean-run paragraph); `SKILL.md` § Report Pipeline step 3 (landed by sibling TASK-024).

- [x] **AC#6 — The report's identity and age are always named.** Every non-empty summary names the report it is reading — its date, and how old that report is at session open. Counts from a report six weeks stale describe the project as it was, not as it is, and a summary that presents them undated invites the directing party to act on them as current. This Task fixes no staleness threshold and emits no warning wording: it states the age and leaves the judgement with the directing party, because no approved document codifies an expected cadence interval (`technical_design.md` § Cadence names the invocation contract and leaves the scheduler to the project). *Derives from* `ux_guide.md` v1.3 § Command Surface → *Supervisor Failure Modes* (the supervisor is never ambiguously quiet); `technical_design.md` v1.2 § Data Model → *Supervisor Report Files* (the report's ISO date is its identifier) and § Cadence → *Scheduler*.

- [x] **AC#7 — Fires in normal sessions, not scope-gated, unit-tested before commit.** Unlike the write-guard and audit-log hooks, SessionStart is deliberately **not** gated on `SHANNON_SUPERVISOR_SCOPE` — read-only session orientation is its whole purpose, and a scope-gated summary would never fire for the directing party it exists to orient. The mute lever is instead the optional Cadence State file per `technical_design.md` v1.2 § Data Model → *Cadence State*; a missing or corrupt state file leaves the hook firing normally. The hook writes nothing and always exits 0. Its logic is unit-tested by running the script directly against representative inputs before commit: (a) most-recent resolution including the `-N` suffix; (b) the Drift-lead terse shape against a report carrying the per-category line; (c) a legacy report carrying no per-category line; (d) each of AC#5's four quiet outcomes; (e) the AC#6 age line. Live auto-firing inside a real Claude Code session is honestly deferred to EPIC-011, per the EPIC-009 precedent. *Derives from* the directing-party disposition ratified at EPIC-010 Gate 2 (2026-07-18); `technical_design.md` v1.2 § Data Model → *Cadence State*; `development_guide.md` v1.4 § Testing Strategy and the global test-before-commit rule.

- [x] **AC#8 — Plain-prose discipline and scope-bounded edit.** Any phrase this Task commits to grep-verifying lands as plain prose, not inside a table cell or a fenced block (parent AC#7). Per the cross-type guard (parent AC#8), this Task creates the SessionStart script body and registration snippet, additively updates `SKILL.md` § Hook Integration, and merges the live settings entry. It does **not** modify any template under `templates/` — the per-category header line is TASK-028's, and this Task must not pre-empt or duplicate it — nor the PreToolUse or PostToolUse hooks, any checker definition under `checkers/`, the `/shannon-goal` contract, the preCompact hook (TASK-026 territory), or any other skill. It writes nothing under `./docs/supervisor/` and retrofits no existing report. Tracked changes are verified by `git diff`; the gitignored `./.claude/` deployment is verified by `ls` and by reading the files. *Derives from* `conceptual_design.md` v1.7 § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*; parent EPIC-010 AC#7 and AC#8.

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

*Reconciled against the shipped TASK-028 header line and approved at Gate 2 on 2026-08-24 (ELABORATED → PLANNED). The prepared 2026-07-18 draft — which still spoke of "extracting the three counts" — is superseded: TASK-028 landed the `**By category:**` line on 2026-08-21, so the Drift-lead is now live rather than inert, and the plan below adopts the exact selection method TASK-028 verified.*

### Approach

Follow the shipped EPIC-009 hook precedent exactly (`pretool-writeguard.sh`, `posttool-auditlog.sh`): a Bash body reading the hook event JSON on stdin, using `jq` where it needs a field, emitting to stdout, and exiting 0. Author in `./shannon/`, deploy to `./.claude/`, merge the registration snippet into the live `settings.json`, per the source/deploy split (DECISION 2026-06-27). The body resolves the most-recent report, reads the four header lines, and prints the terse Drift-lead summary; the quiet-outcome and legacy branches produce the honest fallback text rather than a bare number.

**One divergence from the write-guard precedent, and it is deliberate (AC#7):** this hook is **not** gated on `SHANNON_SUPERVISOR_SCOPE`. The write-guard exits 0 immediately when scope is unset; this hook must fire in ordinary sessions, because orienting the directing party at session open is its whole purpose. Its mute lever is instead the optional Cadence State file `./.claude/supervisor/state.json` (`technical_design.md` § Data Model → *Cadence State*); a missing or corrupt state file leaves the hook firing normally.

Verification is by **running the script directly against representative report fixtures** before commit — the logic is real Bash and genuinely testable, unlike the prompt-prose pipeline TASK-028 changed. Live auto-firing inside a real Claude Code session is honestly deferred to EPIC-011, per the EPIC-009 precedent (TASK-016/017 verified hook logic, not runtime integration).

### The selection method TASK-028 handed over

TASK-028's implementation verified and recorded exactly how a consumer reads the line; this plan adopts it rather than re-deriving it:

- **Anchor on the line prefix, never a bare category word.** Select the line by the fixed string `**By category:**`, then read the integer following `Drift` *within that line*. A bare `Drift` search is unsafe — it also matches the header's own `Checkers run: 3 of 3 — Alignment, Lifecycle, Drift` line and every `### Drift — …` finding heading. The anchor is the prefix; the AC binds it.
- **The separator is a non-ASCII middot (`·`).** The extraction must not assume ASCII whitespace/punctuation around the counts.
- **Absent line ⇒ legacy path.** A report with no `**By category:**` line (both reports currently on disk) yields no Drift count; the summary says the per-category breakdown is unavailable and leads with the total instead. No count is ever derived by parsing the body.

### Steps

1. **Author `./shannon/skills/shannon-supervisor/scripts/sessionstart-summary.sh`.**
   - Read the SessionStart event JSON on stdin (following precedent); the body needs no field from it beyond existing, but consumes stdin so the hook contract is clean.
   - **Mute check first**, cheaply: if `./.claude/supervisor/state.json` exists, is valid JSON, and records the session-start summary as muted, exit 0 silently. A missing or malformed state file is *not* a mute — fall through and fire (AC#7).
   - **Resolve the most-recent report** under the configured `report_directory` (default `docs/supervisor`, read from `./.claude/shannon-supervisor.json` with the same override semantics the write-guard uses — `configured // default`): highest ISO date, then highest `-N` same-day suffix, so `report-2026-08-20-2.md` beats `report-2026-08-20.md` (AC#2).
   - **Quiet outcome — no report** (AC#5a): if the directory is empty or absent, print that no supervisor report has been written yet, naming the directory. Exit 0.
   - **Quiet outcome — unreadable** (AC#5d): if the resolved file cannot be read, name the offending path and say so. Exit 0. Never fall back to a zero.
   - **Parse the header**: the total (principal integer of `**Findings:**`, before any `(+N uncertain)`), stuck-or-stale (principal integer), push lag, and the checkers-succeeded `N of 3` from `**Checkers run:**`.
   - **Drift count**: select the `**By category:**` line by its fixed prefix; read the integer after `Drift`. If the line is absent, mark the breakdown unavailable (legacy path, AC#3).
   - **Compose the terse summary** — the same three-count form as the report header, leading with the **Drift count** (or, on the legacy path, the total, flagged as such): `Drift N · stuck M · push lag K`, then the report identity and age line.
   - **Quiet outcome — clean run** (AC#5b): a report whose total is `0` is presented as a positive result carrying its own checker line ("3 checkers ran cleanly; nothing surfaced"), never blank.
   - **Quiet outcome — partial run** (AC#5c): a `Checkers run: 2 of 3` header carries the shortfall into the summary.
   - **Age line** (AC#6): name the report's date and its age in days at session open (`date` minus the report's ISO date). State the age; set no threshold, emit no warning wording.
   - **Dormant gate-notification branch** (AC#4): present in the logic, produces no output, with an inline comment naming delegated gate-exercise (a later FEAT-009 Epic) as its future activator.
   - **Writes nothing; always exits 0** (AC#7).

2. **Author `./shannon/skills/shannon-supervisor/hooks/sessionstart.settings.json`** — a `SessionStart` entry in Claude Code `settings.json` shape, matching the `_comment` + `hooks` snippet form of `pretooluse.settings.json` / `posttooluse.settings.json`. **Additively update `SKILL.md` § Hook Integration** so the SessionStart bullet reads as implemented rather than as sibling forward work, and § Presentation's SessionStart reference (lines 139–141) is confirmed accurate against the shipped line (no rewrite of TASK-023's prose).

3. **Deploy and wire**: copy the body to `./.claude/skills/shannon-supervisor/scripts/`, merge the `SessionStart` entry into the live `./.claude/settings.json` alongside the shipped PreToolUse and PostToolUse entries, and confirm source/deployed parity by `diff` and by reading the merged settings (AC#1).

4. **Unit-test before commit** by running the script against fixtures covering: (a) most-recent resolution including the `-N` suffix; (b) the Drift-lead terse shape against a synthetic report carrying the `**By category:**` line; (c) `report-2026-08-20.md` and `report-2026-07-05.md` as-is — both legacy, exercising AC#3's fallback and AC#6's age line; (d) each of AC#5's four quiet outcomes (no report, clean run, partial run, unreadable file); (e) a report whose Drift count is a two-digit number, to confirm positional extraction is not fooled by the middot. Record the fixture runs in § Implementation Notes (AC#7).

5. **Plain-prose grep** (AC#8 / parent AC#7): confirm any phrase the ACs grep-verify lands as plain prose, not in a table cell or fence.

6. **Scope check** (AC#8): `git diff` confirms the tracked change set is exactly the new script, the new snippet, and the additive `SKILL.md` edit; the gitignored `./.claude/` deployment is confirmed by `ls` and by reading the merged `settings.json`. No template under `templates/` is touched (the header line is TASK-028's), no checker, no PreToolUse/PostToolUse hook, no `/shannon-goal` contract, no preCompact surface (TASK-026), nothing under `./docs/supervisor/`.

### Dependencies

- **Satisfied**: TASK-028 (the `**By category:**` line) APPROVED 2026-08-21 — the Drift-lead now has a live data source; TASK-023 (documented terse shape) and TASK-024 (clean-run shape) APPROVED 2026-08-02; EPIC-009 shipped the reports to read and the `SKILL.md` skeleton and the hook precedent.
- **Deferred downstream**: live auto-firing inside a real session → EPIC-011.
- **Not blocking**: TASK-026 (preCompact) and TASK-027 (`/shannon-goal` resync) touch different surfaces.

### Risks

- **Parsing brittleness against report format.** The hook reads four header lines by shape; a future header reword could break extraction silently. Mitigation: anchor on the fixed line prefixes TASK-028 established (`**Findings:**`, `**By category:**`, `**Checkers run:**`), and unit-test against both real reports plus a synthetic current-format one, so a legacy report and a current one are both covered.
- **Drift-lead reads as all-clear on a Drift-light report.** On `report-2026-08-20.md` the Drift count is 0 while two real Gap findings stand; a Drift-lead summary there leads with "Drift 0". This is the open scratchpad question, **not reopened here** — the evidence across the two real reports is equivocal (07-05's own lead finding was a Drift finding; 08-20's were Gaps), which does not meet the bar to churn a day-old approved Guide decision. The ACs specify Drift-lead per `ux_guide.md` v1.3, and the plan builds to it. If the lead count is later changed, it changes via `/document-review ux_guide.md`, and this hook's lead-count line is the single place that follows.
- **Session-start noise.** A summary that fires every session could become wallpaper. Mitigation: the terse form and the Cadence State mute lever; the hook stays one line plus the age line.
- **Runtime auto-firing unverified.** Honestly deferred to EPIC-011 per the EPIC-009 precedent; this Task verifies logic, and § Implementation Notes will say so plainly.

### Framework-general capture

*Gate 2 soft prompt.* No new framework-general ambiguity surfaced at this gate. The three routed at TASK-025's Gate 1 (Drift-as-lead; the `development_guide.md` "no units" claim against hook Tasks that unit-test scripts; report bodies not reconciling with their header counts) remain in `docs/scratchpad.md`. The Drift-as-lead item gained a second, equivocating data point during TASK-028's implementation and stays there, not escalated.

---

## Implementation Notes

*Filled during implementation, 2026-08-24.*

### What was built

- `shannon/skills/shannon-supervisor/scripts/sessionstart-summary.sh` — Bash body following the shipped `pretool-writeguard.sh` precedent (reads the event JSON on stdin, uses `jq` for config/state fields, exits 0). Resolves the most-recent report (highest ISO date, then highest zero-padded `-N` suffix), reads the four header lines by their fixed prefixes, and prints the terse Drift-lead line plus the report identity/age line.
- `shannon/skills/shannon-supervisor/hooks/sessionstart.settings.json` — registration snippet in the `_comment` + `hooks` shape of the two shipped snippets, with a `SessionStart` entry and no `matcher` (SessionStart takes none).
- `SKILL.md` § Hook Integration — the SessionStart bullet rewritten from forward work to an implemented description. One stale parenthetical in § Presentation (line 139, "(sibling work item)") corrected to plain text now that this is the work item; TASK-023's presentation logic itself is untouched.
- Deployed to `.claude/skills/shannon-supervisor/scripts/`; the `SessionStart` entry merged into the live `.claude/settings.json` beside PreToolUse and PostToolUse. Source and deployed copies are byte-identical (`diff`).

### The selection method, as implemented

The Drift count is read by anchoring on the `**By category:**` line (`grep -m1 '^\*\*By category:\*\*'`), then extracting the integer following `Drift` **within that line** — never a bare `Drift` search, which would also match the `**Checkers run:** … Drift` line and every `### Drift — …` heading. The extraction is positional and does not depend on the non-ASCII middot separator. A report with no such line takes the legacy path: the summary names the total and says the per-category breakdown is unavailable.

### Verification — fixture runs before commit (AC#7)

Logic verified by running the script against fixtures. What is proven is the script's behaviour on representative inputs; live auto-firing inside a real Claude Code session is honestly deferred to EPIC-011, per the EPIC-009 hook precedent.

| Fixture | Result |
|---|---|
| Most-recent resolution — `report-2026-08-20-2.md` present with a distinct Drift count | picks the `-2` suffix (AC#2) |
| Current-format report with `**By category:**` line | `Drift N · M stuck · push lag K (of T findings total)` (AC#3) |
| Two-digit Drift (`Drift 12`) | extracts `12` — middot does not fool positional read |
| `report-2026-08-20.md` and `report-2026-07-05.md` (both real, legacy) | legacy path: names total, "breakdown unavailable"; ages read 4 and 50 days (AC#3, AC#6) |
| No report under the directory | names the directory, "no report written yet" (AC#5a) |
| Unreadable file (`chmod 000`) | names the path, "could not be read" — no zero fallback (AC#5d) |
| Clean run (`Findings: 0`) | "0 findings … 3 of 3 checkers ran cleanly; nothing surfaced" (AC#5b) |
| Partial run (`Checkers run: 2 of 3`) | carries "only 2 of 3 checkers ran — this is a partial run" (AC#5c) |
| Mute lever (`state.json` `mute_session_start: true`) | no output, exit 0 (AC#7) |
| Malformed `state.json` | not a mute — fires normally (AC#7) |

Every run exited 0 and wrote nothing outside stdout.

### Deviations from Plan

- **§ Presentation line 139 parenthetical corrected** — not in the plan's step list, but leaving "(sibling work item)" in place would have been a now-false statement. A one-phrase factual fix, not a rewrite of TASK-023's prose.

### Gotchas

- **Age uses the report's filename date, not any date in the body.** The report's ISO date is its identifier (`technical_design.md` § Data Model → *Supervisor Report Files*), so a fixture whose body carried a different date still ages by its filename — correct, and worth noting for anyone reading a hand-built fixture.
- **The `Findings: 0` clean-run branch is checked before the Drift branch**, so a clean run never falls through to "Drift 0" — the two are different messages by design.

### Documents Updated

- `SKILL.md` § Hook Integration (SessionStart bullet → implemented); § Presentation line 139 (stale parenthetical corrected).

---

## Review

*Gate 3 verification, 2026-08-24 (self-approved on supervisor authority per the SIT-026 standing directive — Task gates are supervisor-authority; approver ≠ implementer is not in force in a solo configuration, so this is the directing-party-delegated gate the directive covers).*

### Verification

- [x] All acceptance criteria met
- [x] Code follows development_guide.md (Bash + jq per the shipped hook precedent; source-of-truth body before deployed copy)
- [x] Tests added or updated, passing (ten fixture runs before commit; § Implementation Notes)
- [x] Relevant documents updated (SKILL.md § Hook Integration; § Presentation parenthetical)
- [x] Knowledge captured where useful (selection-method reuse and the legacy-path discipline recorded in Implementation Notes)

| AC | Result | Evidence |
|---|---|---|
| AC#1 authored + wired | Pass | body + snippet in `shannon/`; `SessionStart` merged into live `settings.json`; SKILL.md reads as implemented |
| AC#2 most-recent incl. suffix | Pass | fixture picks `report-2026-08-20-2.md` over the bare date |
| AC#3 Drift-lead from header line; legacy fallback | Pass | current-format fixture leads with Drift; both real reports take the legacy path naming the total |
| AC#4 gate-notification dormant | Pass | branch present as commented-out logic naming its future activator; emits nothing |
| AC#5 never ambiguously quiet | Pass | all four outcomes distinguishable in fixture output; no bare zero for an undetermined count |
| AC#6 identity + age | Pass | every non-empty line names the report date and age (4 and 50 days on the real reports) |
| AC#7 fires unscoped, exit 0, unit-tested | Pass | `SHANNON_SUPERVISOR_SCOPE` appears only in a comment; mute is the state file; every fixture exited 0, wrote nothing |
| AC#8 prose + scope guard | Pass | tracked change set is exactly the script, snippet, and additive SKILL.md; no template/checker/other-hook/`/shannon-goal` touched |

### Review Notes

The hook does what a session-start orientation line should: one terse line, honest about what it cannot know. The two behaviours worth noting are both about not lying. First, the legacy path — every report that exists today predates the `**By category:**` line, so the hook's real-world behaviour *right now* is the fallback, and it names the total and says the breakdown is unavailable rather than deriving a Drift count from prose. Second, the age line — `report-2026-07-05` reads "50 day(s) old", which is exactly the signal a reader needs before acting on its counts, and the hook states it without inventing a staleness threshold no document authorises.

What is not proven is live auto-firing inside a real Claude Code session; that is EPIC-011's, and the verification here is the hook's logic against fixtures, consistent with how EPIC-009 verified its own hooks. The first real `/shannon-report` run will also be the first report to carry the `**By category:**` line, at which point the Drift-lead path leaves the fixtures and meets real data.

---

## Activity Log

- **2026-08-24** — REVIEW → APPROVED (Gate 3, self-approved on supervisor authority per the standing directive). All eight ACs verified against the files and the fixture runs; verification table in § Review. Task archived to `docs/tasks/archive/`. EPIC-010 now 5 of 7 Tasks APPROVED; TASK-026 (preCompact) is the last implementation Task before the Epic reaches IMPLEMENTED.
- **2026-08-24** — IMPLEMENTING → IMPLEMENTED. Authored `scripts/sessionstart-summary.sh` and `hooks/sessionstart.settings.json`, updated `SKILL.md` § Hook Integration, deployed to `.claude/` and merged the SessionStart entry into the live `settings.json`. All eight ACs verified; the hook logic was run against ten fixtures before commit (most-recent-incl-suffix, current-format Drift-lead, two-digit Drift, both real legacy reports, no-report, unreadable, clean run, partial run, mute-active, malformed-state) — every run exited 0 and wrote nothing. The two real on-disk reports correctly take the legacy path (total named, breakdown unavailable) with ages of 4 and 50 days. Live auto-firing inside a real session is deferred to EPIC-011 per the EPIC-009 precedent; this Task verifies logic.
- **2026-08-24** — PLANNED (Gate 2, self-approved on supervisor authority per the SIT-026 standing directive of 2026-08-24; Task gates are supervisor-authority). The prepared 2026-07-18 plan — still written around "extracting the three counts" — was superseded and rewritten to reconcile against the `**By category:**` header line **TASK-028 shipped on 2026-08-21**, which turns the Drift-lead from inert to live. The reconciled plan adopts the exact selection method TASK-028 verified: anchor on the fixed `**By category:**` line prefix (never a bare `Drift`, which also matches the header's `Checkers run:` line and every Drift finding heading), read the integer positionally, do not assume ASCII around the non-ASCII middot separator, and treat an absent line as the legacy path. Six steps against the shipped EPIC-009 hook precedent (Bash + `jq`, stdin event JSON, exit 0), the deliberate non-scope-gating with the Cadence State mute lever, unit-test-before-commit against both real reports plus a synthetic current-format fixture, and live auto-firing honestly deferred to EPIC-011. **The Drift-as-lead question was not reopened at this gate**: on checking both reports properly the evidence is equivocal — `report-2026-07-05`'s own lead finding was a Drift finding and Drift was its plurality problem category, while `report-2026-08-20` renders Drift 0 against two real Gaps — which does not meet the bar to churn a day-old approved Guide decision. It stays in `docs/scratchpad.md`; the ACs' Drift-lead per `ux_guide.md` v1.3 stands, and if the lead count ever changes it changes via `/document-review`, not here. No new framework-general ambiguity surfaced at Gate 2.

- **2026-08-21** — ELABORATED (Gate 1 approved). Prepared draft reviewed against current reality by an elaboration subagent; refreshed and approved DRAFT → ELABORATED. **Refresh trigger**: `ux_guide.md` reached v1.3 on 2026-08-21, one day before this gate, stating that the report header leads with the total across all four finding categories while the session-start summary leads with the Drift-category count alone — deliberately not interchangeable. The prepared AC#3 had required the summary to carry a Drift count "matching the report-header counts shape", which v1.3 makes self-contradictory. **The material finding**: the Drift-category count is not recoverable from any shipped report surface — `templates/header.md` renders a single total — and deriving it by parsing report bodies is unsound, because the body narrates only the highest-signal findings by design, its additional-findings labels are not uniform, and `report-2026-07-05.md`'s enumerated items do not reconcile with its own header total. A parsed count would be a lower bound presented as a count, the exact ambiguity v1.3 § Supervisor Failure Modes forbids; on `report-2026-08-20.md` it yields Drift 0 for a report whose two lead findings are real. **Directing-party rulings** (four): (1) add the count to the header rather than parse it, and **split that into TASK-028**, sequenced before this Task — a report-format change is consumed by every future reader, where this Task changes one hook; AC#3 and AC#8 rewritten so this Task consumes the line, must not create it, and handles its absence by naming the total and saying the breakdown is unavailable; (2) existing reports are **not** retrofitted, so the legacy path is live in every session until the next `/shannon-report` run; (3) staleness is stated, not judged — AC#6 names the report's date and age and sets no threshold, because no approved document codifies an expected cadence interval and a Task may not invent one; (4) the Drift-as-lead choice itself is questioned but not reversed — captured in `scratchpad.md` with `report-2026-08-20.md` as first evidence, rather than amending a one-day-old Guide decision on a single data point. **Further refinements applied**: AC#5 expanded from one graceful case to four distinguishable quiet outcomes per v1.3 § Supervisor Failure Modes (no report / clean run / partial run / unreadable report), a bare zero never standing in for a count the hook could not determine; AC#6 added (report identity and age); AC#7 gained the writes-nothing, always-exit-0 requirement, since SessionStart is the only supervisor hook not scope-gated and a failing one degrades every session open; AC#2 gained reuse of `SKILL.md` § Configuration's `report_directory` override semantics per the TASK-016 precedent; all `ux_guide.md` citations refreshed v1.2 → v1.3. **Three framework-general ambiguities routed to `scratchpad.md`** per `development_guide.md:114`: the Drift-lead question above; `development_guide.md` § Testing Strategy claiming Shannon has no units while three hook Tasks cite it for script unit-testing; and supervisor report bodies not reconciling with their own header counts. Plan section carries the prepared draft forward unchanged to `/task-plan TASK-025` (Gate 2) — it still describes extracting counts and needs reconciling against the TASK-028 split. Status: DRAFT → ELABORATED.
- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#3 (and confirms AC#2(b)). Directing-party disposition ratified at EPIC-010 Gate 2: SessionStart deliberately **not** `SHANNON_SUPERVISOR_SCOPE`-gated (read-only session orientation, muted via Cadence State). Gate-notification pathway wired but dormant. Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-025` (Gate 1) and `/task-plan TASK-025` (Gate 2).
