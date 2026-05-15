# /shannon-setup

Initialise a project with the Shannon framework.

You MUST invoke the `project-setup` skill to perform this work.

This command is idempotent. If Shannon is already installed, the skill detects existing state and asks whether to update, reinstall, or abort before changing anything.

If the `project-setup` skill does not activate, report:
"Error: project-setup skill failed to activate. Please confirm `./.claude/skills/project-setup/skill.md` is present."

After setup completes, the skill recommends the next command (typically `/document-review vision.md`). Surface that recommendation to the user.
