# /shannon-goal

Decompose a high-level directing-party intent into candidate work items.

You MUST invoke the `shannon-supervisor` skill to perform this work.

Pass:
- **Verb**: `goal`
- **Intent**: the free-text `[intent]` argument (e.g. *"make onboarding feel less abrupt"*)

`/shannon-goal [intent]` takes a free-text intent hint. The skill discovers the existing artefacts the intent touches by reusing the checker fan-out (read-only), then renders a categorised list of candidate work items: those aligned with existing artefacts (each citing the Feature, Epic, or document section it aligns with by ID) and those surfacing gaps (each flagging whether promotion needs directing-party approval). It is a read-only verb — it writes no report file and no knowledge-index entry.

If the `shannon-supervisor` skill does not activate, report:
"Error: shannon-supervisor skill failed to activate. Please confirm `./.claude/skills/shannon-supervisor/SKILL.md` is present."

When the candidate list is rendered, surface it to the user and resume the original conversation topic.
