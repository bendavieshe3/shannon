# Scratchpad

Capture point for ideas, half-formed work, and unprocessed TODOs that don't yet belong to a work item.

**Process periodically**: promote items to formal work items (Feature, Epic, Task, Spike), move durable findings to knowledge notes, or drop items that no longer matter. The scratchpad is not a backlog — it is pre-workflow. Items that already have a clear home (e.g. a Task under an existing Epic) should be captured there, not here.

**Format**: one line per item. Optional tags. No IDs. No status flow. The whole point is low-friction capture.

---

## Items

- **Create lightweight idea capture feature** — this scratchpad itself wants to become FEAT-002. Currently informal; would benefit from being a documented Shannon capability with a clear "process the scratchpad" workflow #framework
- **V6 propagation: supervisor ≠ implementer constraint** — vision and conceptual_design are now done; still needs to propagate to `technical_design.md` (gates section + how the separation is enforced), all three skill definitions, the CLAUDE.md template, and 22 command files. Epic-scope follow-up, probably under a new feature about supervision #framework #v6
- **Workflow: Alignment Drift Detection** — Vision commits to "drift surfaces in days, not refactors." Conceptual_design has no workflow for *how* drift is detected. Technical_design has a Document Alignment Check algorithm; conceptual_design should have a named workflow describing the process at domain level. Surfaced during conceptual_design Gate 1 review as G1 #framework #conceptual-design
- **Workflow: Re-approval of APPROVED Docs After Upstream Change** — When a higher-authority doc changes (e.g. vision was just updated for V6), lower APPROVED docs may now be misaligned. The skill protocol mentions suggesting re-review, but there is no canonical workflow describing the cascade. Likely shares mechanism with alignment drift detection. Surfaced as G3 #framework #conceptual-design
- **Business rule: Orphan Tasks** — The Task entity allows `Parent = orphan`, but no business rule sanctions this case. Either add a rule ("Tasks May Be Orphan When the Work Has No Parent Epic") or remove the orphan affordance. Surfaced as C4 #conceptual-design
- **Rationale: Why Guides aren't updated by work items** — The Work Items Consume Guides rule and Higher Work Items May Update Mid-Level Docs rule together imply an asymmetry (Technical Design is updatable; Guides are not). One-line rationale missing. Surfaced as C5 #conceptual-design
- **`/what-next` command** — A command that surfaces the next obvious action for the project based on current state: highest-priority DRAFT docs awaiting review, PLANNED tasks ready to implement, IMPLEMENTED items awaiting Gate 3, scratchpad items that have aged, etc. Strong UX win for solo developers who return to a project after a break. Probably a small feature in its own right #framework #ux #commands
- **Analyse and leverage new Claude Code features** — Survey emerging Claude Code capabilities (e.g. `preCompact` hook for state preservation before context compaction, also any new subagent / skill / settings primitives) and decide which Shannon should adopt. `preCompact` specifically could let Shannon write a session summary into a knowledge note before compaction, preserving in-flight context. Probably a Spike (investigation + recommendation) rather than a Feature directly #framework #claude-code #spike-candidate

---

## Processed

*(When items are promoted to work items or otherwise resolved, move them here briefly with a pointer to where they live now. Keep this list short — old entries can be cleared once they're solidly part of project history.)*
