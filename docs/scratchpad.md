# Scratchpad

Capture point for ideas, half-formed work, and unprocessed TODOs that don't yet belong to a work item.

**Process periodically**: promote items to formal work items (Feature, Epic, Task, Spike), move durable findings to knowledge notes, or drop items that no longer matter. The scratchpad is not a backlog — it is pre-workflow. Items that already have a clear home (e.g. a Task under an existing Epic) should be captured there, not here.

**Format**: one line per item. Optional tags. No IDs. No status flow. The whole point is low-friction capture.

---

## Items

- **V6 propagation Epic under FEAT-006** — Now homed in [FEAT-006](./features/FEAT-006-multi-party-supervision.md) as the candidate next Epic. All six mandated documents are V6-aligned. Remaining surface: 3 skill definitions (`shannon/skills/*/skill.md`), the CLAUDE.md template (`shannon/skills/project-setup/templates/CLAUDE.md`), and 22 command files (`shannon/commands/*.md`). Promote to an Epic when ready to do the work #framework #v6 #feat-006
- **Workflow: Alignment Drift Detection (in-review only)** — Vision commits to "drift surfaces in days, not refactors." The new *Re-reviewing an APPROVED Mandated Document* workflow (conceptual_design v1.3) covers drift detection *during* a review via the alignment subagent. What remains open: drift detection *outside* a review, e.g. proactive periodic alignment checks without an explicit trigger. May not be needed; revisit if drift starts slipping through. Originally surfaced as G1 #framework #conceptual-design
- **Business rule: Orphan Tasks** — The Task entity allows `Parent = orphan`, but no business rule sanctions this case. Either add a rule ("Tasks May Be Orphan When the Work Has No Parent Epic") or remove the orphan affordance. Surfaced as C4 #conceptual-design
- **Rationale: Why Guides aren't updated by work items** — The Work Items Consume Guides rule and Higher Work Items May Update Mid-Level Docs rule together imply an asymmetry (Technical Design is updatable; Guides are not). One-line rationale missing. Surfaced as C5 #conceptual-design
- **`/what-next` command** — A command that surfaces the next obvious action for the project based on current state: highest-priority DRAFT docs awaiting review, PLANNED tasks ready to implement, IMPLEMENTED items awaiting Gate 3, scratchpad items that have aged, etc. Strong UX win for solo developers who return to a project after a break. Probably a small feature in its own right #framework #ux #commands
- **Analyse and leverage new Claude Code features** — Survey emerging Claude Code capabilities (e.g. `preCompact` hook for state preservation before context compaction, also any new subagent / skill / settings primitives) and decide which Shannon should adopt. `preCompact` specifically could let Shannon write a session summary into a knowledge note before compaction, preserving in-flight context. Probably a Spike (investigation + recommendation) rather than a Feature directly #framework #claude-code #spike-candidate
- **System Architecture diagram update in technical_design.md** — Current diagram shows Commands → Skills → Subagents but doesn't visualise the directing party / implementer split that V6 makes architecturally important. Would improve clarity but not a blocker. Defer; revisit when a substantive technical_design change is happening anyway #technical-design #v6 #nice-to-have
- **Index update algorithm semantics** — technology_stack §Performance commits to "O(1) appends or in-place edits"; technical_design mentions index updates as a skill responsibility but doesn't describe the algorithm. Worth specifying when implementation work touches the indexes #technical-design
- **Gate Enforcement visibility UX** — When a supervising agent (not a human) approves at a gate, should the framework surface the role distinction in the announcement (e.g. "Approving as the directing party; the implementer is X")? Surfaced during ux_guide Gate 1 review as deferred — too speculative until multi-agent configurations are actually exercised. Revisit when the first multi-agent project ships #ux-guide #v6 #speculative
- **Documentation upkeep ratio surfacing** — Vision § Measurable Targets commits to "<10% of session time in /document-* commands." Currently the directing party has no aggregate metric visible. UX guide deferred surfacing this until instrumentation exists in the project-documentation skill (also captured in development_guide § Instrumentation). Chicken-and-egg: needs both the instrumentation and a UX pattern for surfacing the aggregate #framework #ux-guide #instrumentation
- **Voice differing for human vs agent directing party** — When the directing party is a supervising agent rather than a human, does the implementer's prose style change? Vision is silent; ux_guide deferred as premature speculation. Revisit when agent-as-directing-party becomes real #ux-guide #v6 #speculative

---

## Processed

*(When items are promoted to work items or otherwise resolved, move them here briefly with a pointer to where they live now. Keep this list short — old entries can be cleared once they're solidly part of project history.)*

- **V6-stale text in technical_design.md "single-developer tool"** — Resolved 2026-05-16 during technical_design Gate 1 review. Lines 92 and 176 rewritten to reflect V6 cooperative-access model. See commit `1943f3f`.
- **ux_guide.md inherited PENDING drift** — Resolved 2026-05-17 during ux_guide Gate 1 review. §Cascading Operations rewritten to the "prepared draft surfaces at gate invocation" pattern; PLAN-PENDING references removed. See commit `d4ccc03`.
- **Create lightweight idea capture feature** — Partially resolved 2026-05-18. FEAT-007 created to capture the scratchpad pattern as a Shannon capability. Outstanding work split: Vision update tracked as a separate scratchpad item; deeper formalisation (conceptual_design entry, technical_design notes, possible `/scratchpad-*` commands) tracked as FEAT-007's candidate next Epic.
- **Vision update: add Lightweight Idea Capture as a Key Feature** — Resolved 2026-05-18 in Vision v2.2 (G1 review finding). Lightweight Idea Capture added as 5th Key Feature; FEAT-007's Vision Reference now points at it. Also folded in Retrospective adoption acknowledgement (G2) and "from adoption" Vision Statement wording (S1).
- **Workflow: Re-approval of APPROVED Docs After Upstream Change** — Resolved 2026-05-18. Canonised as the *Re-reviewing an APPROVED Mandated Document* workflow in conceptual_design v1.3. The pattern was prototyped during the Vision v2.2 re-review (commit `3a65a73`) and ratified here. Also partially addresses former G1 (in-review drift detection covered; out-of-review proactive checks still open).
- **Workflow: Re-elaborating a Work Item (F1)** — Promoted 2026-05-19 to EPIC-006 (Work Item Lifecycle Maturation) under FEAT-003. Vision v2.3 § Adaptive Coherence sharpening + FEAT-003 re-elaboration upstream established the aspirational anchor; EPIC-006 will deliver the canonical work-item re-elaboration workflow.
- **Initial Implementation field as a first-class lifecycle position (F2)** — Promoted 2026-05-19 to EPIC-006 (Work Item Lifecycle Maturation) under FEAT-003. Same upstream prerequisites as F1; bundled into the same Epic because both touch the work-item lifecycle metadata surface.
