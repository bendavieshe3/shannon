# EPIC-011: Autonomic Invocation

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Created**: 2026-05-30
- **Updated**: 2026-05-30
- **Tags**: #supervisor #phase-4 #headless #scheduler #cadence

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Prepared during FEAT-009 planning, not yet reviewed. Surfaces at `/epic-elaborate EPIC-011` (Gate 1).*

### Overview

EPIC-011 delivers the **autonomous-cadence path**: headless invocation of the supervisor skill via `claude --bare -p ...`, worktree-isolation for read-only audits that overlap with interactive sessions, the supervisor-batch commit cadence (one commit per autonomous run, not per gate inside the run) per `development_guide.md` v1.4 § Commit Cadence, the third-trigger push at the end of each autonomous run per `development_guide.md` v1.4 § Push Cadence, the Stop hook that runs the autonomous-run completion check (closing out the five-hook integration set), and — critically — the **named scheduler choice for the Shannon-self project**, deferred from `development_guide.md` v1.4 to this Epic's elaboration. The Epic delivers against FEAT-009 § Ideal State bullets *Cadence-driven operation* (autonomous half), *Five Claude Code hook integration points* (Stop hook half — the final hook the cascade names), *Honest deferral boundary* (the 5-committed-primitives architecture exercised end-to-end), and the *Portability to non-Shannon-self projects* claim's autonomous-run dimension.

This Epic is the **G-2 resolution point** flagged at FEAT-009 elaboration: `development_guide.md` v1.4 deferred the Shannon-self scheduler choice here; if EPIC-011 cannot resolve it, the autonomous-cadence path never ships for Shannon-self. EPIC-011 elaboration must produce a named scheduler choice (host cron / launchd / OpenClaw / other) as a directing-party decision at Gate 1.

Out of scope for this Epic: cross-project supervision (Phase 5+ forward work, not within FEAT-009's scope); Managed Agents path (deferred per `technology_stack.md` v1.3); Cloud Routines (deferred per `technology_stack.md` v1.3 — Phase 4 stays on host scheduler + headless per spike § 6 recommendation). Depends on EPIC-009 APPROVED; EPIC-010 is helpful (SessionStart hook surfaces autonomous-run findings to the next session) but not strictly required for autonomous reporting to function.

### Acceptance Criteria

- **AC#1 — Headless invocation runs end-to-end.** A `claude --bare -p "<supervisor prompt>" --allowedTools "Read,Bash(git *)" --output-format json` invocation per `technical_design.md` v1.2 § Cadence → *Headless invocation contract* runs the supervisor end-to-end against this repository (Shannon-self dogfood), producing a valid dated report at `./docs/supervisor/report-YYYY-MM-DD.md`. The `--allowedTools` allow-list is extended at report-write time to include `Write(docs/supervisor/*)` per the technical_design contract; the PreToolUse hook (EPIC-009) enforces scope at runtime.

- **AC#2 — Worktree isolation pattern engaged for overlapping cadence.** When the autonomous cadence overlaps with an interactive directing-party session, the supervisor runs in a temporary worktree per `technical_design.md` v1.2 § Cadence → *Worktree isolation* (e.g. `claude --worktree audit-check-YYYYMMDD ...`). The worktree is auto-cleaned after the run if no commits or uncommitted changes remain. Verifiable: a documented dogfood run with overlap engages the worktree; the worktree is cleaned post-run.

- **AC#3 — Supervisor-batch commit cadence honoured.** The autonomous run produces **one commit per run, not per gate** per `development_guide.md` v1.4 § Commit Cadence → *Supervisor cadence runs*. The commit's subject follows `Supervisor report YYYY-MM-DD`; the body enumerates any gate transitions the run ratified by work item ID. Interactive `/shannon-report` invocations continue to follow the standard per-gate cadence (not changed by this Epic). Verifiable: a dogfood autonomous run produces exactly one commit; subject matches the format; if any gate transitions occurred, body enumerates them.

- **AC#4 — Third-trigger push cadence honoured.** The autonomous run pushes local commits to the remote at the end of the run per `development_guide.md` v1.4 § Push Cadence (third trigger). This is what makes the SessionStart hook (from EPIC-010, if shipped) reflect the latest cadence findings rather than stale local state. Verifiable: a dogfood autonomous run completes with `git push` exit code 0; the remote reflects the supervisor-batch commit.

- **AC#5 — Shannon-self scheduler choice named and documented.** The directing party names a specific scheduler for the Shannon-self project at this Epic's Gate 1 (the G-2 resolution flagged at FEAT-009 elaboration). The chosen scheduler is documented in `development_guide.md` § Git Workflow (or a new sub-section as the implementing Task judges) with: (a) the scheduler name (host cron / launchd / OpenClaw / other); (b) the configured cadence interval; (c) the invocation command (the literal `claude --bare ...` line the scheduler runs); (d) a one-paragraph rationale for the choice. This closes the `development_guide.md` v1.4 deferral. Verifiable: the section exists in `development_guide.md`; the named scheduler is the one actually used in AC#1's dogfood run; the deferral note at `development_guide.md` v1.4 § Version History → "Scheduler choice for the Shannon-self project — DEFERRED" is updated or annotated as resolved.

- **AC#6 — Cadence state file created on first muted finding.** The optional Cadence State file at `./.claude/supervisor/state.json` (per `technical_design.md` v1.2 § Data Model → *Cadence State*) is created the first time the directing party mutes a finding. The file is gitignored per `development_guide.md` v1.4 § Supervisor Report Files. The state file's schema matches the two named concerns (muted findings + throttling). Verifiable: a documented mute action produces the file; `.gitignore` includes the path; subsequent runs honour the mute.

- **AC#7 — Stop hook completes the five-hook integration.** The supervisor's Stop hook (per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration*) runs a completion check at the end of each autonomous run: warns if context is still over the threshold (per Phase-0 spike § 1, default 80%) or if findings remain unflushed (not written to `./docs/supervisor/report-YYYY-MM-DD.md`). For interactive `/shannon-report` runs the hook is a no-op (no autonomous-run completion semantics apply). With AC#7 landed, the five hook integration points named at `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (SessionStart, PreToolUse, PostToolUse, preCompact, Stop) are all allocated and implemented across EPIC-009 (PreToolUse, PostToolUse), EPIC-010 (SessionStart, preCompact), and EPIC-011 (Stop). Verifiable: a dogfood autonomous run that completes cleanly logs no Stop-hook warnings; a synthetic test scenario with simulated unflushed findings triggers an explicit warning naming the unflushed findings. Closes Gap G-A surfaced at FEAT-009 Gate 2.

- **AC#8 — Plain-prose substring discipline honoured.** Same as EPIC-009 AC#7.

- **AC#9 — Scope-guard phrasing applied to any scope-asserting ACs.** Same as EPIC-009 AC#8. Particularly relevant here because this Epic touches `development_guide.md` (AC#5's scheduler documentation amendment) — any AC asserting boundaries around that amendment uses cross-type-guard phrasing.

- **AC#10 — `development_guide.md` amendments are additive.** AC#5's amendment naming the scheduler is additive per `conceptual_design.md` § Re-elaborating → *Status semantics*. `development_guide.md` stays APPROVED through the amendment. The amendment gets a § Version History entry (`v1.4 → v1.5`) naming EPIC-011, the new scheduler section, and classifying additive.

### Context

- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md)
- **Sibling Epic** (predecessor): [EPIC-009 — Health Reporting Surface](EPIC-009-health-reporting-surface.md) — must reach APPROVED; EPIC-010 helpful (SessionStart hook surfaces autonomous-run findings) but not strictly required
- **Vision**: § Core Principles #5 *Continuous Health Vigilance*; § Key Features *Supervisor Role* ("invokable both interactively … and autonomously … on a cadence the project configures")
- **Conceptual Design**: § Business Rules → *Gate Authority Split* (delegated gate authority exercised on the autonomous cadence); § Business Rules → *Supervisor Distinct From Implementer* (agent-identity constraint still applies during autonomous runs — the supervisor commit must not ratify work the same agent implemented)
- **Technology Stack**: § Supervisor Tooling → *Committed primitives* → *Headless mode + external scheduler*, *Worktree isolation* (the two primitives this Epic exercises end-to-end)
- **Technical Design**: § Cadence → *Headless invocation contract*, *Worktree isolation*, *Scheduler*, *Cost note*; § Data Model → *Cadence State* (the optional state file for muted findings + throttling)
- **Development Guide**: § Commit Cadence → *Supervisor cadence runs* (one commit per run; subject format); § Push Cadence (third trigger); § Supervisor Report Files (reports committed; same-day suffix; optional state file gitignored); § Version History v1.4 entry → "Scheduler choice for the Shannon-self project — DEFERRED" — **this Epic resolves the deferral**
- **UX Guide**: § Interaction Patterns → *Supervisor-Approved Gate Notification* (the one-line notification at next session start when supervisor-approved gates have occurred — driven by EPIC-010's SessionStart hook if shipped; otherwise visible on next interactive command)
- **Phase-0 Spike**: § 1 (Hooks — Stop hook contract); § 5 (Headless mode); § 6 (Scheduled Tasks & Cloud Routines — host scheduler recommendation); § 7 (Worktree isolation)
- **FEAT-009 Risks**: this Epic carries the *Scheduler-choice deferral blocking autonomous cadence* risk — AC#5 is the resolution

---

## Plan

*Prepared during FEAT-009 planning, not yet reviewed. Surfaces at `/epic-plan EPIC-011` (Gate 2).*

### Approach

Decompose into Tasks along the natural surfaces: headless invocation script (the literal command the scheduler runs); worktree-isolation pattern (the wrapper that engages `--worktree` when needed); supervisor-batch commit logic (the single end-of-run commit producing the `Supervisor report YYYY-MM-DD` subject); third-trigger push integration (paired with the supervisor-batch commit); the Stop hook implementation (the autonomous-run completion check); the **Shannon-self scheduler choice** (a directing-party decision at Gate 1 of this Epic — surfaces as a Plan-phase decision Task that produces the documented choice); the `development_guide.md` amendment naming the chosen scheduler; the first dogfood autonomous run.

The scheduler choice is structurally a Gate-1 decision (the directing party names it during EPIC-011 elaboration per AC#5) but its operational landing happens in Tasks (the scheduler is configured; the invocation command tested). Gate 2 planning should not predict the choice — it should preserve the AC's commitment to surface the choice at elaboration and leave Tasks to implement against whichever scheduler is named.

The first dogfood autonomous run is its own Task because it exercises the full chain (scheduler → headless invocation → checker fan-out → report write → supervisor-batch commit → third-trigger push → Stop hook completion check) end-to-end and is the Epic's primary acceptance evidence.

### Tasks

*Task candidates — descriptive titles from the outset.*

1. **Headless invocation script** — Produce the literal `claude --bare -p "<supervisor prompt>" --allowedTools "Read,Bash(git *)" --output-format json` invocation script per `technical_design.md` v1.2 § Cadence → *Headless invocation contract*. Includes the `--allowedTools` extension to `Write(docs/supervisor/*)` at report-write time.
2. **Worktree-isolation pattern** — Implement the wrapper that engages `--worktree audit-check-YYYYMMDD` when overlap with an interactive session is detected; auto-cleanup logic post-run.
3. **Supervisor-batch commit logic** — Implement the end-of-run commit producing exactly one commit with subject `Supervisor report YYYY-MM-DD` per `development_guide.md` v1.4 § Commit Cadence; body enumerates gate transitions by work item ID.
4. **Third-trigger push integration** — Implement the post-commit `git push` at end of autonomous run per `development_guide.md` v1.4 § Push Cadence (third trigger); paired with Task 3's commit logic.
5. **Stop hook implementation** — Implement the Stop hook per AC#7; runs the completion check at end of autonomous runs; warns if context still over threshold (per Phase-0 spike § 1 default 80%) or if findings remain unflushed. No-op for interactive `/shannon-report` runs.
6. **Shannon-self scheduler choice** — Directing-party decision at this Epic's Gate 1; named here as a Task for traceability. The Task's output is the named scheduler (host cron / launchd / OpenClaw / other), the cadence interval, and the literal invocation command. **This Task carries the G-2 resolution.**
7. **`development_guide.md` amendment naming the chosen scheduler** — Land Task 6's named scheduler in `development_guide.md` per AC#5 and AC#10 (additive amendment; `v1.4 → v1.5`); update the v1.4 deferral note as resolved.
8. **First dogfood autonomous run** — Configure the chosen scheduler with the invocation script; trigger the first autonomous run; verify the end-to-end chain (report written; supervisor-batch commit produced; push succeeded; Stop hook ran cleanly; SessionStart hook from EPIC-010 (if shipped) reflects the new findings on next session open). This is the primary acceptance evidence for AC#1, AC#3, AC#4, AC#7.

### Dependencies

**Depends on**: EPIC-009 APPROVED — the `./.claude/skills/shannon-supervisor/` skill must exist before headless mode invokes it; the report-writing pipeline must exist before the supervisor-batch commit has anything to commit; the PreToolUse write-guard from EPIC-009 enforces scope on `--allowedTools` writes. EPIC-010 helpful but not strictly required — autonomous reporting works without `/shannon-goal` or SessionStart, but the SessionStart hook from EPIC-010 is what makes the autonomous run's findings visible at the next interactive session open.

**Depended on by**: Phase 5+ Cross-Project supervisor (forward work beyond FEAT-009 scope); future framework-wide observability work (deferred speculation).

### Risks

- **G-2 — scheduler choice cannot be resolved at this Epic's Gate 1.** AC#5 requires the directing party to name a scheduler at elaboration. If the choice cannot be made (e.g. all four named options have substantive blockers), the autonomous-cadence path never ships for Shannon-self and FEAT-009's *Cadence-driven operation* Ideal State bullet's autonomous half stays aspirational. **Mitigation**: FEAT-009 § Plan → Risks names this as a top-level Risk; EPIC-011 elaboration surfaces it as a directing-party decision point at Gate 1, not as silent deferral; if unresolvable, surface to the FEAT-009 directing party as a Feature-level decision (FEAT-009 itself may pause at this Epic).
- **Scheduler-choice lock-in for Shannon-self.** Once the scheduler choice lands in `development_guide.md`, future-project scheduler choices are anchored against the Shannon-self precedent. **Mitigation**: `development_guide.md` v1.4 (carried forward to v1.5 by this Epic's AC#10 amendment) already commits to "each project documents its scheduler choice in its own `development_guide.md`" — the Shannon-self choice is named explicitly as the Shannon-self choice, not as a framework-wide default.
- **Headless invocation `--allowedTools` allow-list drift.** The contract at `technical_design.md` v1.2 § Cadence requires `Read,Bash(git *)` baseline plus `Write(docs/supervisor/*)` extension at report-write time. A sloppy implementation could grant broader tool access. **Mitigation**: AC#1 verifies the literal allow-list; the PreToolUse hook (EPIC-009 AC#4) enforces scope at runtime as a second line of defence.
- **Worktree leak.** A worktree-isolated run that fails partway could leave the worktree directory uncleaned. **Mitigation**: AC#2 verifies auto-cleanup; the Task 2 wrapper includes an unconditional cleanup branch that engages even on failure.
- **Supervisor-batch commit ratifying same-agent work.** Per `conceptual_design.md` § Business Rules → *Supervisor Distinct From Implementer*, the supervisor commit must not ratify work the same agent implemented. In a solo (directing-party-as-supervisor) configuration this is a discipline rather than a technical guarantee. **Mitigation**: the supervisor-batch commit logic (Task 3) refuses self-approval flows by protocol per `technical_design.md` v1.2 § Security Model → *Gate Enforcement*; the directing party is responsible for not approving gates on work they themselves implemented.
- **First dogfood autonomous run revealing cost overrun.** The per-run 6–7× single-session cost band (per `technical_design.md` v1.2 § Cadence → *Cost note*) is the spike's prediction, not measured evidence. The first dogfood run may exceed the band, triggering FEAT-009's *Cost compounding* Risk. **Mitigation**: AC#1's dogfood run captures `/usage` output (per FEAT-009 § Success Metrics → Cadence run cost); if cost exceeds 7×, surface as a finding at this Epic's Gate 3 and route to scratchpad for follow-up tuning.

---

## Implementation Notes

*Filled during implementation.*

### Cross-Task Decisions

- *None yet.*

### Documents Updated

- *None yet.*

---

## Review

*Filled at Gate 3.*

### Verification

- [ ] All tasks APPROVED
- [ ] Epic acceptance criteria met
- [ ] Parent feature updated with epic outcome
- [ ] Relevant documents updated and approved

### Review Notes

*Filled at Gate 3.*

---

## Activity Log

- **2026-05-30** — DRAFT: Epic stub created with **prepared elaboration draft** (Requirements section) and **prepared plan draft** (Plan section) during FEAT-009 planning (Gate 2). Phase 4 of the spike-inherited phase structure. Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/epic-elaborate EPIC-011`, the prepared elaboration surfaces for Gate 1 review (where the **Shannon-self scheduler choice — AC#5** is the central directing-party decision, resolving the G-2 deferral from `development_guide.md` v1.4); when they run `/epic-plan EPIC-011`, the prepared plan surfaces for Gate 2 review. AC#7 (Stop hook) added at FEAT-009 Gate 2 to close inline Gap G-A (Stop hook previously unallocated across the three Epics); a new Task 5 *Stop hook implementation* added correspondingly; Tasks 5/6/7 shifted to 6/7/8 with internal cross-references updated. Descriptive title (*Autonomic Invocation*) used from the outset. EPIC-009 must reach APPROVED before this Epic's elaboration begins; EPIC-010 helpful but not strictly required (per FEAT-009 Plan § Approach — one Epic at a time discipline applies). This Epic carries the *Scheduler-choice deferral blocking autonomous cadence* Risk named at FEAT-009 § Plan → Risks. Full elaboration pending `/epic-elaborate EPIC-011` (Gate 1).
