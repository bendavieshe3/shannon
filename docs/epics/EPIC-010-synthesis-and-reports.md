# EPIC-010: Synthesis and Reports

## Metadata

- **Status**: ELABORATED
- **Type**: Epic
- **Parent**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Created**: 2026-05-30
- **Updated**: 2026-07-17
- **Tags**: #supervisor #phase-3 #goal-decomposition #hooks #presentation

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*Elaborated and approved at Gate 1 on 2026-07-17 (DRAFT → ELABORATED).*

### Overview

EPIC-010 delivers the **synthesis and goal-decomposition layer** on top of EPIC-009's reporting surface: the `/shannon-goal [intent]` skill for decomposing directing-party intents into candidate work items, the reuse of EPIC-009's report-aggregation pipeline for `/shannon-goal`'s reference-to-existing-artefacts category and the documentation of report-presentation customisation (EPIC-009 already shipped the hybrid-presentation default), the SessionStart hook for injecting a terse health summary at session open, and the preCompact hook for snapshotting in-flight findings before context compaction. The Epic delivers against FEAT-009 § Ideal State bullets *Goal decomposition via `/shannon-goal`*, *Hybrid report presentation by default*, and the SessionStart + preCompact halves of *Five Claude Code hook integration points*.

Out of scope for this Epic: autonomous headless invocation (EPIC-011); PreToolUse / PostToolUse hooks (EPIC-009); Stop hook (allocated to EPIC-011). Builds on EPIC-009 (APPROVED 2026-07-11), which shipped the interactive `/shannon-report` surface — three-checker fan-out, the dated report-writing pipeline with the hybrid-presentation default, and the PreToolUse/PostToolUse hooks; goal-decomposition reuses that aggregation.

### Acceptance Criteria

- **AC#1 — `/shannon-goal [intent]` decomposes intent into categorised candidates.** The `/shannon-goal` skill — authored in the tracked source `./shannon/skills/shannon-supervisor/SKILL.md` and deployed to `./.claude/skills/shannon-supervisor/` per the source/deploy split established by TASK-019 — accepts a free-text intent argument (e.g. *"make onboarding feel less abrupt"*) and produces a categorised list of candidate work items: (a) candidates aligned with existing artefacts (with citations); (b) candidates surfacing gaps (with explicit indication of directing-party approval required for promotion to Feature / Epic per `conceptual_design.md` § Business Rules → *Gate Authority Split*). Output shape matches `ux_guide.md` v1.2 § Command Surface → *Supervisor Commands* example. Verifiable: an invocation against a known intent produces output matching the ux_guide shape with both categories present (or an explicit "no candidates in category X" line).

- **AC#2 — Report-presentation customisation documented; SessionStart injection reuses the shipped hybrid default.** EPIC-009 already landed the hybrid-presentation default for `/shannon-report` (shipped `SKILL.md § Report Pipeline`) — a diagnostic header (counts of findings, stuck items, push lag) followed by a one- or two-finding narrative body, per `ux_guide.md` v1.2 § Interaction Patterns → *Supervisor Report Presentation*. This AC adds (a) prose in `./shannon/skills/shannon-supervisor/SKILL.md` documenting the diagnostic-only and conversational-only customisations, defaulting to hybrid, and (b) confirmation that the SessionStart injection (AC#3) reuses the hybrid/terse shape. Verifiable: the customisation prose lands in `SKILL.md`; the SessionStart injection matches the header-counts shape.

- **AC#3 — SessionStart hook injects terse summary at session open.** The supervisor's SessionStart hook (per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration*) injects a terse health summary at session start: drift count, stuck items count, push lag count. The summary reads from the most recent supervisor report under `./docs/supervisor/` (honouring EPIC-009's same-day suffix convention `report-YYYY-MM-DD[-N].md` when resolving "most recent"). The one-line *Supervisor-Approved Gate Notification* pathway (per `ux_guide.md` v1.2 § Interaction Patterns) is wired but **dormant** until delegated gate-exercise ships (a later Epic under FEAT-009): EPIC-009 delivered the reporting surface only, not the recording of supervisor-exercised gates, so no shipped capability yet produces the "gates approved since last session" data the notification would present.

- **AC#4 — preCompact hook snapshots in-flight findings.** The supervisor's preCompact hook captures any in-flight findings (during a long `/shannon-report` run that approaches context compaction) to disk so the findings survive compaction and can be flushed into the final report. Snapshot location named in `SKILL.md`; the snapshot is automatically incorporated into the report at write time.

- **AC#5 — Zero-findings degenerate-case presentation pattern lands.** Per the framework-general ambiguity surfaced at FEAT-009 elaboration (scratchpad item M-2 — *zero-findings supervisor-report presentation pattern*), a `/shannon-report` run that surfaces zero findings produces an explicit positively-stated diagnostic ("3 checkers ran cleanly; nothing surfaced") rather than a blank or zero-count report. This satisfies the *Honest Failure Modes — Supervisor Finds Nothing* User Story in FEAT-009 § User Stories. The pattern is documented in `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation* if landing the pattern requires an additive ux_guide amendment; otherwise it lives in `SKILL.md` template prose.

- **AC#6 — Goal-decomposition skill cites existing artefacts where alignment exists.** The `/shannon-goal` skill's *aligned with existing artefacts* category cites the specific Feature, Epic, or document section it aligns with. Verifiable: a test invocation against an intent that maps to an existing Feature produces output naming that Feature by ID.

- **AC#7 — Plain-prose substring discipline honoured.** Same as EPIC-009 AC#7 — any verbatim phrase the ACs commit to grep-verifying lands as plain prose.

- **AC#8 — Scope-guard phrasing applied to any scope-asserting ACs.** Same as EPIC-009 AC#8 — applies retrospectively at Gate 1 review.

### Context

- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md)
- **Sibling Epic** (predecessor): [EPIC-009 — Health Reporting Surface](EPIC-009-health-reporting-surface.md) — **APPROVED 2026-07-11**; shipped the `/shannon-report` surface, three checkers, the dated report pipeline, the hybrid-presentation default, and the PreToolUse/PostToolUse hooks that this Epic builds on
- **Vision**: § Core Principles #5 *Continuous Health Vigilance*; § Key Features *Supervisor Role*
- **Conceptual Design**: § Business Rules → *Gate Authority Split* (scratchpad promotion authority — Task autonomous, Epic / Feature requires directing-party approval; goal-decomposition surfaces this)
- **Technology Stack**: § Supervisor Tooling (Hooks, Skill frontmatter control)
- **Technical Design**: § System Architecture → *Supervisor* → *Slash-command surface* (`/shannon-goal` contract) + *Hook integration* (SessionStart + preCompact rows); § API Design → *Supervisor Verbs*
- **UX Guide**: § Command Surface → *Supervisor Commands* (`/shannon-goal` output shape example); § Interaction Patterns → *Supervisor Report Presentation* (hybrid default); § Interaction Patterns → *Supervisor-Approved Gate Notification*
- **Phase-0 Spike**: § 3 (Slash Commands — `/shannon-goal` composition pattern); § 11 (Context Compaction & Memory — preCompact hook)
- **Scratchpad source**: M-2 (zero-findings degenerate-case presentation pattern, deferred from FEAT-009 elaboration to EPIC-010)

---

## Plan

*Prepared during FEAT-009 planning, not yet reviewed. Surfaces at `/epic-plan EPIC-010` (Gate 2).*

### Approach

Decompose into Tasks along the natural surfaces: goal-decomposition logic (the `/shannon-goal` skill), aggregation pattern + presentation (the hybrid default + zero-findings case), two hooks (SessionStart, preCompact). The aggregation-pattern Task is the natural home for the zero-findings degenerate-case work (AC#5) because that case is about how aggregation presents its zero result.

Skill structure builds on EPIC-009's `./.claude/skills/shannon-supervisor/` — `/shannon-goal` is a new entry-point in the same skill (per `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Slash-command surface* which already names both `/shannon-report` and `/shannon-goal` at the same skill). The aggregation-pattern Task does not produce a separate file; it lives in `SKILL.md` and the report templates under `templates/`.

### Tasks

*Task candidates — descriptive titles from the outset.*

1. **Goal-decomposition prompt + skill** — Implement the `/shannon-goal [intent]` skill entry-point in `./.claude/skills/shannon-supervisor/SKILL.md`. The prompt decomposes the intent into the two categorised lists per AC#1 and AC#6; output shape matches `ux_guide.md` v1.2 § Command Surface → *Supervisor Commands*.
2. **Aggregation prompt patterns + hybrid-presentation default** — Implement the report-aggregation logic (reused by both `/shannon-report` and `/shannon-goal`'s reference-to-existing-artefacts category) and codify the hybrid-presentation default in the report templates at `./.claude/skills/shannon-supervisor/templates/`. Covers AC#2.
3. **Zero-findings degenerate-case presentation pattern** — Land the zero-findings explicit positively-stated diagnostic per AC#5; closes scratchpad item M-2. If the pattern requires additive amendment to `ux_guide.md` § Interaction Patterns → *Supervisor Report Presentation*, this Task lands that amendment.
4. **SessionStart hook implementation** — Implement the SessionStart hook per AC#3; reads the most recent supervisor report and injects the terse summary plus the *Supervisor-Approved Gate Notification* one-liner when relevant.
5. **preCompact hook implementation** — Implement the preCompact hook per AC#4; snapshots in-flight findings to a disk location named in `SKILL.md` so they survive compaction.
6. **Report-presentation prose patterns** — Refine the report template prose (header counts wording, narrative-body lead phrasing) to match the `ux_guide.md` v1.2 hybrid default and to flow naturally into the SessionStart injection format. Covers any final consistency work across AC#2, AC#3, AC#5.

### Dependencies

**Depends on**: EPIC-009 APPROVED — the report-writing pipeline must exist before goal-decomposition reuses it and before SessionStart can read a "most recent report"; the supervisor skill at `./.claude/skills/shannon-supervisor/` must exist before `/shannon-goal` adds a second entry-point.

**Depended on by**: EPIC-011 (Autonomic Invocation) — autonomous runs benefit from the SessionStart hook (next session opens already oriented to the autonomous run's findings) and the hybrid-presentation default, but neither is strictly required for autonomous reporting to function; EPIC-011 may ship without EPIC-010 if the directing party prefers the phase-by-phase commitment.

### Risks

- **Goal-decomposition heuristic producing low-promotion-rate candidates.** The *Goal decomposition usefulness* Directional Target in FEAT-009 measures this: low promotion rate after multiple invocations indicates the heuristic needs tuning. **Mitigation**: AC#1 verifies the shape; the heuristic's quality is measured directionally after first dogfood use; if the rate is low, surface as a follow-up Epic rather than blocking this Epic's Gate 3.
- **Hybrid-presentation default vs. customisation tension.** Projects may want diagnostic-only or conversational-only presentations from the outset; making customisation easy without obscuring the framework default is a design judgement. **Mitigation**: AC#2 names the default explicitly and allows documented customisation in `SKILL.md`; first dogfood pass on Shannon-self uses the default.
- **SessionStart hook injecting noise.** A terse summary that fires at every session start (including short interactive ones) could become noise. **Mitigation**: AC#3 specifies "terse"; if the summary becomes burdensome, the directing party can mute via the optional Cadence State file per `technical_design.md` v1.2 § Data Model → *Cadence State*.
- **Zero-findings pattern propagating to multiple files inconsistently.** AC#5 may require additive amendment to `ux_guide.md` plus a template change in `./.claude/skills/shannon-supervisor/templates/`. If those two land out of sync, the framework default and the actual rendered shape diverge. **Mitigation**: Task 3 lands both in a single Gate-3 cycle; bidirectional cross-reference if the amendment is substantive enough to require one.

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

- **2026-07-17** — ELABORATED (Gate 1 approved): Prepared elaboration draft reviewed against current reality by an alignment subagent, refreshed, and approved DRAFT → ELABORATED. Trigger for refresh: EPIC-009 reached APPROVED (2026-07-11) since the draft was written, changing what EPIC-010's residual scope is. Findings (four-category schema): **Drift** — (1) authored-deliverable paths named `./.claude/` but TASK-019 established tracked `./shannon/` source-of-truth with `./.claude/` as deployed copy; (2) Overview + AC#2 overclaimed delivery of the aggregation pipeline and hybrid-presentation default that EPIC-009 already shipped; (3) stale future-tense references to EPIC-009 approval. **Gap** — AC#3's Supervisor-Approved Gate Notification presumed a record of supervisor-exercised gates that no shipped capability produces (delegated gate-exercise is FEAT-009 implementation-forward). **Strengths** — doc citations, version numbers, and `SKILL.md` casing all correct; no stale knowledge-index path imported; AC#5 (zero-findings) exemplary. Edits applied (all **ADDITIVE**, Epic stayed ready-to-elaborate): re-scoped AC#2 to the customisation-docs residual; named `./shannon/` source in AC#1; refreshed EPIC-009 references to past tense; added same-day report-suffix awareness to AC#3. **Directing-party decision**: AC#3 gate-notification pathway marked **dormant** until delegated gate-exercise ships (rather than scoping its data source into this Epic). Plan section still carries prepared draft (obsolete Task 2 + `./.claude/` authoring paths) to be reconciled at `/epic-plan EPIC-010` (Gate 2).
- **2026-05-30** — DRAFT: Epic stub created with **prepared elaboration draft** (Requirements section) and **prepared plan draft** (Plan section) during FEAT-009 planning (Gate 2). Phase 3 of the spike-inherited phase structure. Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/epic-elaborate EPIC-010`, the prepared elaboration surfaces for Gate 1 review; when they run `/epic-plan EPIC-010`, the prepared plan surfaces for Gate 2 review. AC#5 closes the framework-general ambiguity routed to scratchpad as M-2 (zero-findings degenerate case) at FEAT-009 elaboration. Descriptive title (*Synthesis and Reports*) used from the outset. EPIC-009 must reach APPROVED before this Epic's elaboration begins (per FEAT-009 Plan § Approach — one Epic at a time). Full elaboration pending `/epic-elaborate EPIC-010` (Gate 1).
