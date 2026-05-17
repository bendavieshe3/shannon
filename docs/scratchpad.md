# Scratchpad

Capture point for ideas, half-formed work, and unprocessed TODOs that don't yet belong to a work item.

**Process periodically**: promote items to formal work items (Feature, Epic, Task, Spike), move durable findings to knowledge notes, or drop items that no longer matter. The scratchpad is not a backlog — it is pre-workflow. Items that already have a clear home (e.g. a Task under an existing Epic) should be captured there, not here.

**Format**: one line per item. Optional tags. No IDs. No status flow. The whole point is low-friction capture.

---

## Items

- **Create lightweight idea capture feature** — this scratchpad itself wants to become FEAT-002. Currently informal; would benefit from being a documented Shannon capability with a clear "process the scratchpad" workflow #framework
- **V6 propagation: supervisor ≠ implementer constraint** — vision, conceptual_design, and technical_design are now done. Still needs to propagate to all three skill definitions (`shannon/skills/*/skill.md`), the CLAUDE.md template (`shannon/skills/project-setup/templates/CLAUDE.md`), and 22 command files (`shannon/commands/*.md`). Mostly vocabulary edits at this point; the architectural decisions live in technical_design. Epic-scope follow-up, probably under a new feature about supervision #framework #v6
- **Workflow: Alignment Drift Detection** — Vision commits to "drift surfaces in days, not refactors." Conceptual_design has no workflow for *how* drift is detected. Technical_design has a Document Alignment Check algorithm; conceptual_design should have a named workflow describing the process at domain level. Surfaced during conceptual_design Gate 1 review as G1 #framework #conceptual-design
- **Workflow: Re-approval of APPROVED Docs After Upstream Change** — When a higher-authority doc changes (e.g. vision was just updated for V6), lower APPROVED docs may now be misaligned. The skill protocol mentions suggesting re-review, but there is no canonical workflow describing the cascade. Likely shares mechanism with alignment drift detection. Surfaced as G3 #framework #conceptual-design
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
