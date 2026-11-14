# FEAT-006: Multi-Party Supervision

## Metadata

- **Status**: IMPLEMENTED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Core Principles #2 ("Strategic External Review")
- **Initial Implementation**: Partial — prior vocabulary delivery is recorded below; this governance revision still needs independent review and live validation. Earlier Met/Remaining details are historical context; current requirements supersede delegated gate authority.
  - **Met:** Document-layer V6 alignment — the six mandated documents use directing-party / implementer vocabulary; the *Supervisor Distinct From Implementer* business rule is named; cooperative-access conventions are documented. **Plus (EPIC-005 APPROVED):** the implementation-layer vocabulary sweep of the 3 skill definitions + the CLAUDE.md template, including the self-approval-refusal language in those skills.
  - **Remaining:** None in source; human Gate 3 acceptance is outstanding. The command sweep is done (the Feature-level governance revision rewrote every command; the 2026-11-14 pass replaced the last "the user" with "the directing party"), and the multi-agent configuration has been exercised in practice (see Activity Log, 2026-11-14).
- **Created**: 2026-05-18
- **Updated**: 2026-11-14

---

## Requirements

### Overview

The human owns Vision and Feature decisions. An agent implements and tests; a distinct reviewer supplies independent technical judgement. An optional supervisor audits health and synthesises findings without approving Features or creating mandatory lower-level gates.

### Ideal State

- Commands, skills and project guidance consistently distinguish human acceptance, implementation/self-tests and independent review.
- The implementer cannot supply independent approval by changing role labels. Human acceptance of agent-produced work is valid and required at Feature Gate 3.
- Delegation is optional and separately authorised; concurrent writers coordinate and preserve history.
- Existing multi-agent projects can adopt the boundary without replacing identifiers or historical records.
- Factual documentation upkeep remains agent-managed; consequential meaning, scope, access and cost decisions return to the human.

### User Stories

As the human directing party, I delegate execution while preserving my product decisions and independent technical scrutiny. As a concurrent agent, I reconcile current changes before writing rather than silently overwriting another session.

### Context

`vision.md` § Three roles, configurably separable; `conceptual_design.md` § Supervisor Distinct From Implementer; `technical_design.md` § Cooperative Access and Gate Enforcement; `development_guide.md` § Multi-Agent Coordination. [Supervisor](FEAT-009-supervisor.md) supplies the health-reporting surface, not delegated Feature authority.

## Plan

**2026-11-01:** retained entries below describe earlier delivery/backlog. Per-child gate assumptions are superseded by the approved Feature-level design. Current source alignment is under independent review; historical acceptance is not acceptance of this revision. A live multi-agent exercise remains unverified.

### Epics

The candidate next-Epic surface splits cleanly into two work units with different review profiles. Recommend creating them as separate Epics rather than one bundled effort.

- [EPIC-005](../epics/EPIC-005-v6-skills-and-claude-template.md) — APPROVED — V6 Vocabulary in Skills and CLAUDE.md Template — Three skill definitions (`shannon/skills/*/skill.md`) and the project-level CLAUDE.md template need semantic updates. Each touches gate language, self-approval prevention, and the directing-party / implementer distinction; not pure find-and-replace. Requires per-file review judgement. Elaboration also folded in a correction: `work-items/SKILL.md` still has `PLAN-PENDING` references that contradict technical_design v1.1, now part of EPIC-005's scope.
  - **Success criterion**: `rg "\b[Uu]sers?\b" shannon/skills/ shannon/skills/project-setup/templates/CLAUDE.md` returns only intentional "human reader" or "Target Users" occurrences; every gate-related sentence uses directing-party / implementer vocabulary correctly; no `*-PENDING` references remain.
- [EPIC-013](../epics/EPIC-013-v6-vocabulary-in-command-files.md) — DRAFT, superseded 2026-11-13 by the Feature-level governance revision, which rewrote every command file — V6 Vocabulary in Command Files (was Candidate Epic B; created 2026-10-18 from the scratchpad triage). The surface is now 26 command files, and they also misstate gate authority ("explicit user approval" for every gate)
  - **Success criterion**: `rg "\buser\b" shannon/commands/` returns only intentional "human reader" occurrences; every command's wording about gate approval names the authority *Gate Authority Split* assigns

Promote each candidate to a real Epic via `/epic-create` when ready to schedule the work.

### Dependencies

**Depends on**: FEAT-003 (Unified Work Item Model), FEAT-004 (Three Quality Gates) — human Feature decisions use verification and independent-review evidence

**Depended on by**: Future enterprise / multi-developer adoption of Shannon

### Risks

- **Convention-only enforcement** — Until technical gate enforcement exists, an implementer that ignores the skill protocol could self-approve. Acceptable today (a deliberate AI doing this is a different threat model); revisit when multi-agent configurations are actually exercised
- **Vocabulary creep back** — "User" is the natural default in CLI prose; without ongoing discipline, future contributions may reintroduce it where "directing party" is correct. Mitigation: the dev_guide and ux_guide patterns make the distinction visible
- **No real-world validation yet** — Multi-agent configurations have not been exercised against Shannon. The convention may break in ways not anticipated; expect refinement when the first multi-agent project ships

---

## Success Metrics

- **Vocabulary consistency** — "User" appears in framework prose only where it means "human terminal reader"; "directing party" / "implementer" used otherwise (skills + CLAUDE.md template complete via EPIC-005 APPROVED; the 22 command files remain — candidate Epic B)
- **Self-approval prevention** — Zero observed cases of an implementer approving its own work across a gate
- **Multi-agent project shipped** — At least one Shannon project successfully operated by a supervisor + implementer pair distinct from the human at the top

---

## Activity Log

- **2026-11-14** — ELABORATED → IMPLEMENTED under the directing party's approval of 2026-11-14 ("pending decisions as recommended", then "Just do it. Just do it all"). Command vocabulary: every command file names the directing party; none asks a human to approve a lower-level gate. Live multi-agent exercise, on Shannon itself: an implementer session built PR #16; two reviewers that neither wrote nor pushed it reviewed each head, the gDDS developer bot (Daria; findings fixed, approved at db33cc0) and the PR-reviewer routine (FAIL then PASS across four heads); the directing party decides acceptance; the supervisor's `/shannon-report` audits health without gate authority. Separate sessions coordinated on disjoint pull requests (#11, #12, #13, #15, #16) and reconciled overlaps by porting rather than overwriting. Awaiting Gate 3.
- **2026-11-13** — Plan bookkeeping (no status change): EPIC-013 is superseded. The Feature-level governance revision rewrote all twenty work-item commands, and no command now says "explicit user approval". The command-file half of *Remaining* is therefore met in source, pending that revision's acceptance. A multi-agent configuration exercised in practice is still open.
- **2026-11-12** — Clarification of the approved governance revision: approval of its requirements and implementation approach is not acceptance of this Feature's whole delivered capability. Overall Status remains ELABORATED; this repair records no Feature Gate 3 acceptance. Independent review and any remaining delivery or live-validation work remain outstanding.


- **2026-11-01** — Human approved current role/Feature boundary and implementation approach. Requirements reconciled; earlier delivered/remaining claims retained as dated metadata/history. Source update does not establish live multi-agent validation or human delivery acceptance. See [rationale](../knowledge/feature-level-governance.md).

- **2026-10-18** — Plan bookkeeping (no status change): Candidate Epic B is created as [EPIC-013](../epics/EPIC-013-v6-vocabulary-in-command-files.md) (DRAFT), on directing-party approval of the 2026-10-17 scratchpad triage.
- **2026-07-11** — Re-elaborated (additive). **Trigger**: downstream-gap — a sibling Feature, **FEAT-009 (Supervisor)**, now exists as the concrete implementing Feature for the supervisor role, and its first Epic **EPIC-009 (Health Reporting Surface) reached APPROVED** (commit `cc78667`); FEAT-009's own Activity Log flagged this FEAT-006 re-elaboration as owed. (The trigger fits the *downstream-gap*-adjacent "sibling Feature implements part of my scope" case that scratchpad M-1 notes is not yet a perfectly-fitting canonical trigger category — a pending `conceptual_design.md` § Re-elaborating refinement.) **Change** — four additive refreshes, no previously-approved requirement or scope claim contradicted (verified by an independent alignment subagent, four-category findings): (1) **added a Related-Feature cross-reference to FEAT-009** in § Context with the scope split (FEAT-006 = the multi-party pattern + role-independence constraint; FEAT-009 = the operational supervisor); (2) **refreshed all § Context and Ideal-State doc-version citations to current** (Vision v2.4, conceptual_design v1.7, technical_design v1.2, technology_stack v1.3, development_guide v1.4, ux_guide v1.2); (3) **moved the EPIC-005-delivered work from *Remaining* to *Met*** in the Initial Implementation block and narrowed the two "partly met" Ideal-State annotations accordingly (skills + CLAUDE.md template V6-aligned; only the 22 command files / candidate Epic B remain) — resolving the Metadata-vs-Plan internal contradiction the alignment check found; (4) **re-annotated the *Gate Enforcement visibility UX* Ideal-State bullet from deferred → met**, now shipped by ux_guide v1.2 § Interaction Patterns → *Supervisor-Approved Gate Notification* + the *Gate Approval* refresh. **Deliberately NOT changed**: the *Multi-agent project shipped* Success Metric stays **pending** — EPIC-009 shipped a *single-agent* supervisor reporting surface, not a supervisor directing over a separate implementer, so the multi-party configuration remains unexercised; the core Overview intent and the Risks are preserved verbatim. No previously-approved claim contradicted — additive; status stays ELABORATED.
- **2026-05-22** — Re-elaborated (additive). **Trigger**: framework evolution — EPIC-006 (via TASK-002, commit `09844df`) delivered the queryable Partial-completeness affordance that pre-existing Partial Features must absorb. **Change**: added the `**Met:** / **Remaining:**` sub-block beneath the `Initial Implementation` line, surfacing the Partial state at a glance without an Activity Log dive; applied via TASK-003. No previously-approved claim contradicted — additive; status stays ELABORATED.
- **2026-05-18** — Re-elaborated. Triggered by upstream evolution since initial elaboration (Vision v2.2 added retrospective adoption acknowledgement; conceptual_design v1.3 added the *Re-reviewing an APPROVED Mandated Document* workflow). Changes applied:
  - Context updated to reflect Vision v2.2 and conceptual_design v1.3 (five Key Workflows; ux_guide § Presenting Findings added)
  - Ideal State bullets now annotate which items are met vs partly met vs pending
  - "(deferred — see scratchpad)" parenthetical replaced with explicit naming of the Gate Enforcement visibility deferral
  - New user story: Retrospective Adoption into Existing Multi-Agent Projects, covering Vision v2.2 § Target Users widened scope
  - New Ideal State bullet: retrospective adoption support
  - Candidate next Epic split into two — Epic A (V6 vocabulary in skills + CLAUDE.md template, semantic) and Epic B (V6 vocabulary in command files, mechanical), each with explicit `rg`-based success criteria
  This is the first exercise of work-item re-elaboration; two framework gaps surfaced for follow-up (see scratchpad: F1 work-item re-elaboration workflow, F2 Initial Implementation lifecycle position).
- **2026-05-18** — ELABORATED: Feature created. Partially implemented: the document layer (vision, technology_stack, conceptual_design, technical_design, development_guide, ux_guide) is V6-aligned through commits `6abf672` (vision Gate 1), `f6cddc4` (conceptual_design), `35ccfee` (technology_stack), `1943f3f` (technical_design), `4f3e506` (development_guide), `d4ccc03` (ux_guide). The implementation layer — skill definitions, command files, CLAUDE.md template — still needs the V6 vocabulary sweep. A dedicated Epic for that work is the next step.
