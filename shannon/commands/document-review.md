# /document-review

Review and approve a mandated document (Gate 1).

You MUST invoke the `project-documentation` skill to perform this work.

Pass:
- **Action**: `review`
- **Target**: The document path from `$ARGUMENTS` (e.g. `vision.md`, `docs/technical_design.md`)

If `$ARGUMENTS` is empty, ask the user which document to review.

The skill will:
1. Run an alignment subagent across the document authority graph
2. Present alignment findings (drift, gaps)
3. Ask the user to explicitly approve the document for the DRAFT → APPROVED transition

If the `project-documentation` skill does not activate, report:
"Error: project-documentation skill failed to activate. Please confirm `./.claude/skills/project-documentation/skill.md` is present."

After approval, suggest re-reviewing any lower documents in the authority graph that are already APPROVED — they may now be misaligned.
