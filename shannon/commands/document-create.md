# /document-create

Create a mandated document or knowledge note.

You MUST invoke the `project-documentation` skill to perform this work.

Pass:
- **Action**: `create`
- **Target**: The document type from `$ARGUMENTS` (e.g. `vision`, `technology_stack`, `conceptual_design`, `technical_design`, `development_guide`, `ux_guide`, or `knowledge`)

If `$ARGUMENTS` is empty, ask the user which document to create.

If the `project-documentation` skill does not activate, report:
"Error: project-documentation skill failed to activate. Please confirm `./.claude/skills/project-documentation/skill.md` is present."

After the document is drafted, resume the original conversation topic. The user can run `/document-review [path]` when ready to approve.
