# TASK-028: Per-Category Finding Counts in the Report Header

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #templates #report-pipeline #header #machine-readable
- **Created**: 2026-08-21
- **Updated**: 2026-08-21

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated at Gate 1 on 2026-08-21. Split out of TASK-025's Gate 1 elaboration on 2026-08-21 by directing-party ruling.*

### Overview

A supervisor report's header carries one findings number — the total across all four categories — plus stuck-or-stale items, push lag, and the checkers-succeeded count. It carries no per-category breakdown. This Task adds one line stating the count in each of the four canonical categories (Drift, Gap, Internal contradiction, Strength), rendered by `templates/header.md` and filled by the pipeline at `SKILL.md` § Report Pipeline step 2.

The pipeline already has the data. Each checker returns its fragment in the four-category schema, so the counts exist at aggregation time and are simply not surfaced. This is a rendering gap, not a computation one.

### Why this is its own Task

It surfaced inside TASK-025's Gate 1 elaboration, which found that `ux_guide.md` v1.3's session-start summary — specified to lead with the Drift-category count — had no data source to read from. Folding the fix into TASK-025 was the faster path and was rejected: this is a change to the **report format**, consumed by every future reader of a report, whereas TASK-025 is a change to **one hook**. Giving the format change its own gate keeps each Task's scope guard honest and gives the header change review in its own right rather than as a rider.

It earns its place independently of the hook. A reader who sees `Findings: 9` learns less than one who sees that the nine are two gaps and six strengths — which, on `report-2026-08-20.md`, is the difference between "nine problems" and "two problems and a mostly healthy project".

### The line

Rendered directly beneath the existing counts line, sharing its `**Label:** value  ·  value` style:

```
**Findings:** {{FINDING_COUNT}}  ·  **Stuck or stale items:** {{STUCK_COUNT}}  ·  **Push lag:** {{PUSH_LAG_COMMITS}} commit(s) ahead of remote

**By category:** Drift {{DRIFT_COUNT}}  ·  Gap {{GAP_COUNT}}  ·  Internal contradiction {{CONTRADICTION_COUNT}}  ·  Strength {{STRENGTH_COUNT}}
```

Four properties make it consumable without prose parsing:

- **A unique line prefix.** `**By category:**` occurs nowhere else in any report surface, so a consumer selects the line before reading any number. The bare category words are *not* unique — `Drift` also appears in the header's own `Checkers run:` line and in every Drift finding heading — so a consumer that greps for a category word alone will mis-hit. The prefix is the anchor, and the AC binds it.
- **Fixed category order** — Drift, Gap, Internal contradiction, Strength — matching the canonical schema order used by `ux_guide.md` § Interaction Patterns → *Presenting Findings* and by `technical_design.md` § Document Alignment Check.
- **All four always present.** A category with no findings renders `0`. Never blank, never omitted, never collapsed to a shorter list of the non-zero categories.
- **Bare integers.** No annotations, no ranges, no qualifiers on this line.

### Counting rule

The four counts **partition exactly the finding set that `{{FINDING_COUNT}}`'s principal number counts**, so the four sum to it. Findings the checkers returned as uncertain stay where they already live — as the parenthesised annotation on the `Findings:` total (`9 (+1 uncertain)`, as `report-2026-08-20.md` renders it) — and are excluded from both the total's principal number and the per-category counts. They are not silently folded into a category, and the per-category line grows no annotation syntax of its own.

This keeps the machine-readable line machine-readable and leaves uncertainty visible on the human-facing total, where the supervisor's *never ambiguously quiet* principle is already served. It also gives the pipeline a checkable self-invariant at write time: if the four do not sum to the total, the aggregation is wrong.

### Deliberately NOT in scope

- **Retrofitting existing reports.** `report-2026-07-05.md` and `report-2026-08-20.md` stay exactly as written. They are historical records; rewriting them to satisfy a later format is worse than the gap it closes. Consumers must handle a report with no per-category line — that requirement lands on the consumer (TASK-025), not here.
- **The announcement surface.** `ux_guide.md`'s worked example of the spoken report announcement renders its breakdown inline and non-zero-only (`3 findings (2 drift, 1 gap)`). That is a different surface with a different reader, it is an example rather than a specification, and this Task does not touch it. The two shapes are not required to converge, and reasoning from the example to the file format is the error TASK-027 exists to correct.
- **The choice of which count leads the session-start summary.** That is `ux_guide.md` v1.3's, and a Task may not amend a Guide. See the scratchpad item questioning whether Drift is the right lead.
- **Reconciling the body's enumerated findings with the header's total.** A real defect — `report-2026-07-05.md` says 10 in the header and enumerates 9 — but a separate one, captured in the scratchpad. This Task adds a line and states an invariant for future runs; it does not audit past counting.
- **The `{{...}}` versus `[...]` placeholder divergence.** All three supervisor templates use `{{SLOT}}` where `development_guide.md` § Code Style → *Template Structure* specifies square brackets. This Task follows the local convention of the file it edits rather than introducing a fourth style inside it; the framework-general divergence goes to the scratchpad.

### Acceptance Criteria

- [x] **AC#1 — The line renders.** `shannon/skills/shannon-supervisor/templates/header.md` carries a per-category counts line directly beneath the existing counts line, with the literal prefix `**By category:**`, the four canonical categories in the order Drift, Gap, Internal contradiction, Strength, and one `{{...}}` slot per category.
- [x] **AC#2 — The pipeline fills it.** `shannon/skills/shannon-supervisor/SKILL.md` § Report Pipeline step 2 is **additively** extended to state that the header's per-category counts are filled from the collected checker fragments' four-category schema. The existing step-2 prose — the total, stuck-or-stale items, push lag, checkers-succeeded, and the hybrid-presentation framing — is preserved, not rewritten.
- [x] **AC#3 — The leading total is unchanged.** `{{FINDING_COUNT}}` remains the total across all four categories, per `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation* ("The header's leading count is the total across all four finding categories, not the count of any one of them"). The new line adds to the header; it does not displace, replace, or re-scope the leading count.
- [x] **AC#4 — The counting rule is written down.** The step-2 prose states that the four counts partition the same finding set the leading total's principal number counts, that they therefore sum to it, and that uncertain findings are carried as the annotation on the total rather than inside any category.
- [x] **AC#5 — Zero renders as `0`.** Consistent with the zero-findings discipline TASK-024 established, every category with no findings renders a literal `0`, and all four categories render on a zero-findings run. Verifiable by a dry render against a zero fragment set: the line reads `**By category:** Drift 0  ·  Gap 0  ·  Internal contradiction 0  ·  Strength 0`.
- [x] **AC#6 — A consumer can select the line without parsing prose.** Verifiable on a dry-rendered report: selecting the line by its `**By category:**` prefix and reading the four integers yields the correct counts, and the same selection applied to `report-2026-07-05.md` and `report-2026-08-20.md` yields nothing rather than a wrong number — the absent-line case TASK-025 must handle.
- [x] **AC#7 — Dry render checked against real data.** The changed template is rendered by hand against `report-2026-08-20.md`'s actual fragment counts and read for coherence, per `development_guide.md` § Testing Strategy → *Template review* and *Dogfood pass*. The rendered result is recorded in § Implementation Notes. This is a Markdown template change with no executable body, so no unit test applies.
- [x] **AC#8 — Source before deployed, and re-synced.** `shannon/` is edited first, then the change is deployed to `.claude/skills/shannon-supervisor/`, per `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts*. Verifiable: the two copies of `templates/header.md` and `SKILL.md` are identical after the change.
- [x] **AC#9 — Scope guard.** No existing supervisor report is modified. No checker subagent, hook script or registration snippet, command file, work-item or document template of any type, index, or mandated document is modified. The only files this Task changes are `templates/header.md` and `SKILL.md` in `shannon/skills/shannon-supervisor/`, their deployed counterparts, and this Task file.

### Context

- **Parent Epic**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md) — Synthesis and Reports (IMPLEMENTING). Seventh child Task; sequenced **before** TASK-025, which consumes this line. Enables EPIC-010 **AC#3** by giving the SessionStart summary a Drift count to read; adds no new Epic AC.
- **Consumer**: [TASK-025](./TASK-025-sessionstart-health-summary-hook.md) — the SessionStart summary leads with the Drift count and reads it from this line, and must handle its absence honestly on the two historical reports.
- **Governing documents**: `ux_guide.md` v1.3 § Interaction Patterns → *Supervisor Report Presentation* (the leading count is the total; the clean run still reports); § Interaction Patterns → *Presenting Findings* (canonical four-category schema and its order); § Command Surface → *Supervisor Failure Modes* (never ambiguously quiet).
- **Shipped surfaces extended**: `shannon/skills/shannon-supervisor/templates/header.md` (TASK-015, last amended TASK-024); `shannon/skills/shannon-supervisor/SKILL.md` § Report Pipeline step 2.
- **Unchanged by design**: `templates/footer.md`, whose "The full finding set is reflected in the header counts above" becomes more true, not less, and needs no edit.
- **Discipline**: `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts*; § Testing Strategy → *Template review*, *Dogfood pass*; `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#9 phrasing).

---

## Plan

*Drafted and approved at Gate 2 on 2026-08-21 (ELABORATED → PLANNED).*

### Approach

Two file edits in the tracked source, then two dry renders, then deploy. Both edits are **additive**: the header gains a line beneath the counts line it already has, and § Report Pipeline step 2 gains sentences after the prose it already carries. Nothing existing is reworded. Source-of-truth body first, deployed copy second, per `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts*.

The verification is by hand, because there is nothing here to execute. Shannon's "pipeline" is prompt prose an agent reads, not a program — `development_guide.md` § Testing Strategy is explicit that the framework's correctness is the correctness of templates and prompts. So this Task's evidence is a *template review* plus a *dogfood pass*: render the changed template against real data, read it, and confirm a consumer can select the line. What is verified is that the specification renders correctly and reads unambiguously — not that an executable fills it. That is the same honest scope EPIC-009 set when it verified hook *logic* and deferred live runtime integration to EPIC-011.

### Steps

1. **Edit `shannon/skills/shannon-supervisor/templates/header.md`.** Insert one line after the existing counts line, separated by a blank line:

   ```
   **By category:** Drift {{DRIFT_COUNT}}  ·  Gap {{GAP_COUNT}}  ·  Internal contradiction {{CONTRADICTION_COUNT}}  ·  Strength {{STRENGTH_COUNT}}
   ```

   Two-space padding around the `·` separators, matching the counts line exactly. The template's leading HTML comment needs no change — it already says "Fill the `{{...}}` slots". Satisfies **AC#1**; leaves `{{FINDING_COUNT}}` untouched, satisfying **AC#3**.

2. **Extend `SKILL.md` § Report Pipeline step 2.** Append to the existing step-2 paragraph, preserving every sentence already there (the total, stuck-or-stale items, push lag, checkers-succeeded, and the hybrid-presentation framing). The added prose states two things:
   - the header's per-category counts are filled from the collected fragments' four-category schema, in the fixed order Drift, Gap, Internal contradiction, Strength, with a literal `0` for any category that surfaced nothing (**AC#2**, **AC#5**);
   - the four counts partition exactly the finding set the leading total's principal number counts and therefore sum to it; findings a checker returned as uncertain are carried as the parenthesised annotation on the total, never folded into a category; a set of four that does not sum to the total means the aggregation is wrong (**AC#4**).

3. **Dry render A — real data.** Render the changed header against `report-2026-08-20.md`'s fragment counts, which that report enumerates exhaustively: two narrated Gaps, plus one uncertain and seven Strengths in its § Additional findings. Expected line:

   ```
   **By category:** Drift 0  ·  Gap 2  ·  Internal contradiction 0  ·  Strength 7
   ```

   `0 + 2 + 0 + 7 = 9`, matching that report's `Findings: 9 (+1 uncertain)` principal number with the uncertain item correctly outside the partition. This is the counting rule confirmed against real data rather than asserted. Record the render in § Implementation Notes (**AC#7**).

   *Caveat to record with it*: hand-counting works on this report because it happens to enumerate its full finding set. That is **not** a general property — `report-2026-07-05.md` says 10 in the header and enumerates 9. The dry render is a one-off manual exercise for verification, and must not be read as a sanctioned way to derive counts from a report body. Deriving them that way is precisely what this Task exists to make unnecessary.

4. **Dry render B — the zero case.** Render against an all-zero fragment set and confirm the line reads `**By category:** Drift 0  ·  Gap 0  ·  Internal contradiction 0  ·  Strength 0` — four categories present, four literal zeroes, nothing blank or omitted. Read it alongside the clean-run body line ("3 checkers ran cleanly; nothing surfaced") that TASK-024 shipped, to confirm the two read coherently together rather than redundantly. Completes **AC#5**.

5. **Consumer-selection check.** On both dry renders, select the line by its `**By category:**` prefix and read the four integers; confirm the values are correct and that no other line in the rendered report carries that prefix. Then apply the same selection to `report-2026-07-05.md` and `report-2026-08-20.md` as they stand on disk and confirm it returns **nothing** — the absent-line case TASK-025 must handle honestly. Satisfies **AC#6** and hands TASK-025 a verified selection method rather than an assumed one. Note for TASK-025's consumption: the separator is a non-ASCII middot (`·`) already in use on the counts line, so a consumer's pattern must not assume ASCII.

6. **Deploy.** Copy the two changed files to `.claude/skills/shannon-supervisor/`, then confirm with a recursive diff that source and deployed trees are identical apart from the runtime-generated `audit.log`. Satisfies **AC#8**.

7. **Scope check.** Confirm the changed-file set is exactly: `templates/header.md` and `SKILL.md` under `shannon/skills/shannon-supervisor/`, their two deployed counterparts, and this Task file — plus the index and parent-Epic bookkeeping the gate transition itself requires. No supervisor report, checker, hook script or registration snippet, command file, work-item or document template of any type, or mandated document is touched. Satisfies **AC#9**.

8. **Record and transition.** Write both renders and the caveat into § Implementation Notes, append the Activity Log entry, mark IMPLEMENTED.

### Dependencies

- **Blocks**: [TASK-025](./TASK-025-sessionstart-health-summary-hook.md) — consumes this line; its Gate 2 should follow this Task's implementation so its plan can cite a line that exists.
- **Blocked by**: nothing. `SKILL.md` § Report Pipeline step 2 was last touched by TASK-024, which is APPROVED; there is no in-flight edit to serialise against.
- **Unaffected**: TASK-026 and TASK-027 touch different surfaces (`SKILL.md` § Report Pipeline step 5 / the `/shannon-goal` contract) and need no sequencing against this.

### Risks

- **Rewording step 2 while extending it.** § Report Pipeline step 2 is one long paragraph carrying TASK-024's zero-findings prose; an "improving" edit would silently re-open settled ground. Mitigation: append only, then re-read the whole step and review the diff before deploying.
- **Verifying a specification and calling it a working feature.** No code fills these slots — the next real `/shannon-report` run is the first true exercise. Mitigation: § Implementation Notes says so plainly, and the Task claims specification correctness only.
- **Drift renders `0` on the most recent real report.** Dry render A produces `Drift 0` while both of that report's lead findings are Gaps — fresh evidence on the open scratchpad question of whether Drift is the right lead count for the SessionStart summary. Mitigation: record the observation in § Implementation Notes and leave it in the scratchpad. A Task may not amend a Guide, and one more data point does not settle it.

### Verification summary

| AC | Verified by |
|---|---|
| AC#1 line renders | Step 1; read back in the changed template |
| AC#2 pipeline fills it | Step 2; step-2 prose names the fragment schema as the source |
| AC#3 leading total unchanged | Step 1 diff shows `{{FINDING_COUNT}}` untouched |
| AC#4 counting rule written down | Step 2 prose |
| AC#5 zero renders as `0` | Dry render B (step 4) |
| AC#6 selectable without parsing prose | Step 5, including the returns-nothing case on both shipped reports |
| AC#7 dry render against real data | Dry render A (step 3), recorded with its caveat |
| AC#8 source before deployed, re-synced | Step 6 recursive diff |
| AC#9 scope guard | Step 7 changed-file set |

### Framework-general capture

*Gate 2 soft prompt (`development_guide.md` § Testing Strategy → Pre-Commit Checklist).* One item was surfaced at this Task's Gate 1 and is already routed: the `{{SLOT}}` versus `[Placeholder]` divergence across all three supervisor templates, captured in `scratchpad.md` as a `/document-review development_guide.md` question. Nothing further surfaced at Gate 2.

---

## Implementation Notes

*Filled during implementation, 2026-08-21.*

### What changed

Two files in the tracked source, both edited additively, then deployed:

- `shannon/skills/shannon-supervisor/templates/header.md` — one line inserted beneath the existing counts line (+2 lines including the blank separator). `{{FINDING_COUNT}}` untouched.
- `shannon/skills/shannon-supervisor/SKILL.md` § Report Pipeline step 2 — three sentences appended to the existing paragraph. The prior prose (total, stuck-or-stale items, push lag, checkers-succeeded, hybrid-presentation framing) is preserved verbatim; the diff is a single changed line because the step is one paragraph.

The template's leading HTML comment already read "Fill the `{{...}}` slots" and needed no change. `templates/footer.md` was not touched: its existing "The full finding set is reflected in the header counts above" becomes more accurate, not less.

### Dry render A — real data

Rendered against `report-2026-08-20.md`'s actual fragment counts, hand-counted from its enumerated findings (two narrated Gaps; one uncertain and seven Strengths in § Additional findings):

```
# Supervisor Report — 2026-08-20

**Findings:** 9 (+1 uncertain)  ·  **Stuck or stale items:** 1 (2 uncertain)  ·  **Push lag:** 0 commit(s) ahead of remote

**By category:** Drift 0  ·  Gap 2  ·  Internal contradiction 0  ·  Strength 7

**Checkers run:** 3 of 3 — Alignment, Lifecycle, Drift. All returned successfully.
```

`0 + 2 + 0 + 7 = 9`, matching the leading total's principal number, with the uncertain item correctly outside the partition. The counting rule is confirmed against real data rather than asserted.

**Caveat, recorded deliberately.** Hand-counting succeeded here only because this report happens to enumerate its full finding set. That is not a general property — `report-2026-07-05.md` states 10 in its header and enumerates 9. Step 3 was a one-off verification exercise and is **not** a sanctioned way to derive per-category counts from a report body. Deriving them that way is unsound, and making it unnecessary is why this Task exists.

**Observation on Drift-as-lead.** The render produces `Drift 0` on a report whose two lead findings are both Gaps. This is a second data point against `ux_guide.md` v1.3's choice of the Drift count as the lead for the SessionStart summary — the first being the same report's shape, noted at the v1.3 review. Left in `scratchpad.md`, not acted on: a Task may not amend a Guide, and TASK-025 will meet the question directly.

### Dry render B — the zero case

```
**Findings:** 0  ·  **Stuck or stale items:** 0  ·  **Push lag:** 0 commit(s) ahead of remote

**By category:** Drift 0  ·  Gap 0  ·  Internal contradiction 0  ·  Strength 0
```

Four categories present, four literal zeroes, nothing blank or omitted. Read alongside the clean-run body line TASK-024 shipped ("3 checkers ran cleanly; nothing surfaced"), the two are complementary rather than redundant: the header says which categories were checked and came back empty, the body line says the checkers ran at all.

### Consumer-selection check

Selecting by the literal `**By category:**` prefix on render A returns one line and four integers, `0 2 0 7`, summing to 9. On render B, `0 0 0 0`. The prefix occurs exactly once per report.

The counter-case is worth recording, because it is the defect the Gate 1 ruling avoided. Searching render A for the bare word `Drift` matches **two** lines even within the header alone:

```
6:**By category:** Drift 0  ·  Gap 2  ·  Internal contradiction 0  ·  Strength 7
8:**Checkers run:** 3 of 3 — Alignment, Lifecycle, Drift. All returned successfully.
```

— and in a full report it would also match every Drift finding heading. A consumer anchoring on the category word rather than the line prefix returns a plausible wrong number silently. The prefix is the anchor.

The absent-line case behaves as TASK-025 requires: the same selection applied to `report-2026-07-05.md` and `report-2026-08-20.md` as they stand on disk returns nothing, rather than a wrong number.

**For TASK-025's inheritance**: the separator is a non-ASCII middot (`·`), already in use on the counts line before this Task. A consumer's pattern must not assume ASCII. The verified selection method is: match the fixed-string prefix `**By category:**`, then read the integers in positional order.

### Deploy and scope

`templates/header.md` and `SKILL.md` copied to `.claude/skills/shannon-supervisor/`. A recursive diff of the two trees reports one difference — the runtime-generated `audit.log`, which exists only in the deployed copy by design. Source and deployed are otherwise identical.

Changed-file set: the two source files, plus this Task file and the index/parent-Epic bookkeeping the gate transitions require. `.claude/` is untracked, so the deployed copies do not appear in `git status`. No supervisor report, checker subagent, hook script or registration snippet, command file, work-item or document template of any type, index, or mandated document was modified.

### What is and is not proven

The specification renders correctly and reads unambiguously, and a consumer can select it. That is what a Markdown template change can prove. Nothing here executes: the report pipeline is prompt prose an agent reads, so the first true exercise is the next real `/shannon-report` run, which will be the first report to carry the line. This is the same honest scope EPIC-009 set when it verified hook logic and left runtime integration to EPIC-011. No unit test applies — `development_guide.md` § Testing Strategy, "Shannon has no unit tests because Shannon has no units".

---

## Review

*Gate 3 verification, 2026-08-21. Each criterion checked against the files as they stand, not against the implementation narrative.*

| AC | Result | Evidence |
|---|---|---|
| AC#1 line renders | Pass | `templates/header.md` carries the `**By category:**` prefix with the four categories in schema order and one `{{...}}` slot each |
| AC#2 pipeline fills it | Pass | § Report Pipeline step 2 names the four-category fragment schema as the source; TASK-024's existing sentences survive verbatim |
| AC#3 leading total unchanged | Pass | The header diff for the implementation commit is pure addition — two inserted lines, zero deletions; `{{FINDING_COUNT}}` is untouched |
| AC#4 counting rule written down | Pass | Step 2 states the partition, the sum-to-total consequence, the exclusion of uncertain findings, and the bare-integer constraint |
| AC#5 zero renders as `0` | Pass | Stated in step 2 prose; dry render B produced four literal zeroes |
| AC#6 selectable without parsing prose | Pass | Prefix selection returned `0 2 0 7` on render A and `0 0 0 0` on render B, one matching line each; the same selection returns nothing on both shipped reports |
| AC#7 dry render against real data | Pass | Render A reconciles `0 + 2 + 0 + 7 = 9` against `report-2026-08-20.md`'s principal total; recorded in § Implementation Notes with its caveat |
| AC#8 source before deployed, re-synced | Pass | Both files byte-identical between `shannon/` and `.claude/`; recursive diff reports only the runtime `audit.log` |
| AC#9 scope guard | Pass | Implementation commit touched five files: the two source files plus the Task file, `task_index.md`, and the parent Epic — exactly the specified set plus required bookkeeping |

### Judgement

The Task did what it set out to do, and the two things worth carrying forward are not in the ACs.

**The counting rule survived contact with real data.** It was asserted at Gate 1 and could have shipped unexamined; the dry render reconciled it against a real report instead. Had it not reconciled, the defect would have surfaced in TASK-025's consumption or, worse, in a live report.

**The verification is honest about its own limits.** Nothing here executes. What is proven is that the specification renders and reads unambiguously — the next real `/shannon-report` run is the first true exercise. § Implementation Notes says so plainly rather than letting nine ticked boxes imply a working feature.

Two observations are carried out of the Task rather than closed inside it: the non-ASCII middot separator TASK-025's pattern must not assume away, and a second data point against `ux_guide.md` v1.3's Drift-as-lead choice, left in `scratchpad.md` because a Task may not amend a Guide.

---

## Activity Log

- **2026-08-21** — REVIEW → APPROVED (Gate 3, directing-party approval). All nine ACs verified against the files as they stand; verification table in § Review. The Gate-1 counting rule reconciled against `report-2026-08-20.md`'s real fragments (`0 + 2 + 0 + 7 = 9`), and the consumer-selection counter-case is on record — a bare category-word search collides with the header's own `Checkers run:` line, so the `**By category:**` prefix is the machine anchor and TASK-025 inherits a verified selection method (non-ASCII middot separator included). What is proven is specification correctness, not execution; the next real `/shannon-report` run is the first true exercise. Task archived to `docs/tasks/archive/`. EPIC-010 now 4 of 7 Tasks APPROVED.

- **2026-08-21** — IMPLEMENTING → IMPLEMENTED. Both additive edits applied to the tracked source and deployed; all nine ACs verified. Dry render A against `report-2026-08-20.md`'s enumerated fragments produced `Drift 0  ·  Gap 2  ·  Internal contradiction 0  ·  Strength 7`, summing to 9 and matching that report's leading total's principal number with the uncertain item outside the partition — the counting rule confirmed against real data. Dry render B produced four literal zeroes. The consumer-selection check passed on both renders and returned nothing on the two shipped reports, as TASK-025 requires; the counter-case was recorded, since a bare `Drift` search matches two lines in the header alone and every Drift finding heading in a full report. Deploy verified by recursive diff (only the runtime `audit.log` differs). Recorded honestly in § Implementation Notes: what is proven is that the specification renders and reads unambiguously, not that anything executes — the next real `/shannon-report` run is the first true exercise. Two observations carried forward: the non-ASCII middot separator that TASK-025's pattern must not assume away, and a second data point against `ux_guide.md` v1.3's Drift-as-lead choice, left in the scratchpad rather than acted on.

- **2026-08-21** — PLANNED (Gate 2, directing-party approval). Eight steps: two additive edits (a `**By category:**` line in `templates/header.md`; extension of `SKILL.md` § Report Pipeline step 2 with the fill source and the counting rule), two dry renders, a consumer-selection check, deploy, scope check, and recording. Verification is by hand throughout — Shannon's report pipeline is prompt prose an agent reads, not a program, so the evidence is `development_guide.md` § Testing Strategy's *template review* and *dogfood pass*, and the Task claims specification correctness only, not a working executable. **Dry render A validated the Gate 1 counting rule against real data before it ships**: `report-2026-08-20.md`'s enumerated fragments give Drift 0, Gap 2, Internal contradiction 0, Strength 7, summing to 9 and matching that report's `Findings: 9 (+1 uncertain)` principal number with the uncertain item correctly outside the partition. Recorded with the caveat that hand-counting succeeds there only because that report happens to enumerate exhaustively — `report-2026-07-05.md` does not reconcile with its own total — so step 3 is a verification exercise and must never be read as a sanctioned way to derive counts from a report body. Three risks named: rewording § Report Pipeline step 2 while extending it (append-only, then diff-review); mistaking a verified specification for a working feature; and dry render A producing `Drift 0` while both of that report's lead findings are Gaps — a second data point against `ux_guide.md` v1.3's Drift-as-lead choice for the SessionStart summary, recorded and left in the scratchpad rather than acted on, since a Task may not amend a Guide. Noted for TASK-025's inheritance: the separator is a non-ASCII middot, so a consumer's pattern must not assume ASCII.

- **2026-08-21** — ELABORATED (Gate 1, directing-party approval). Requirements drafted: the header gains one `**By category:**` line carrying the four canonical categories in schema order, rendered by `templates/header.md` and filled by `SKILL.md` § Report Pipeline step 2 from the checker fragments the pipeline already collects. Four directing-party-confirmed rulings: (1) the machine-readable anchor is the literal `**By category:**` line prefix, not the category words — `Drift` also occurs in the header's own `Checkers run:` line and in every Drift finding heading, so a consumer grepping a bare category word mis-hits; (2) the four counts partition exactly the finding set the leading total's principal number counts and therefore sum to it, with uncertain findings left as the annotation on the total (`9 (+1 uncertain)`) rather than folded into a category — this keeps the line bare integers and gives the pipeline a write-time self-invariant; (3) `ux_guide.md`'s worked announcement example (`3 findings (2 drift, 1 gap)` — inline, non-zero-only) is a different surface and an example, deliberately **not** reasoned from as a specification, that inference being the error TASK-027 exists to correct; (4) the Task enables EPIC-010 AC#3 rather than owning an Epic AC of its own, so the line is exercised at TASK-025's verification. Two findings routed rather than fixed: the `{{SLOT}}` versus `[Placeholder]` divergence across all three supervisor templates against `development_guide.md` § Code Style → *Template Structure* (framework-general → scratchpad), and a strength — `templates/footer.md`'s existing claim that the header reflects the full finding set becomes true without the footer being touched.

- **2026-08-21** — DRAFT: Task created by directing-party ruling during TASK-025's Gate 1 elaboration. That elaboration found `ux_guide.md` v1.3's session-start summary specified to lead with a Drift-category count that no shipped report surface carries, and that deriving the count by parsing report bodies is unsound — the body narrates only the highest-signal findings, its additional-findings labels are not uniform, and on `report-2026-07-05.md` the enumerated items do not reconcile with the header's own total. Ruled: add the count to the header rather than parse it, and split that change into its own Task sequenced before TASK-025, keeping the report-format change separate from the hook that consumes it. Full elaboration pending `/task-elaborate TASK-028`.
