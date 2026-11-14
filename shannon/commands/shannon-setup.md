# /shannon-setup

Initialise a project with the Shannon framework.

You MUST invoke the `project-setup` skill to perform this work.

Pass:
- **Verb**: `setup`

This command is idempotent. If Shannon is already installed, the skill reports the installed version and asks whether to update (prefer `/shannon-update`), reinstall, or abort before changing anything. It backs up any file before overwriting it, merges rather than replaces `CLAUDE.md` and `.claude/settings.json`, and wires the supervisor's hooks and configuration.

If the `project-setup` skill does not activate, report:
"Error: project-setup skill failed to activate. Please confirm `./.claude/skills/project-setup/SKILL.md` is present."

After setup completes, the skill recommends the next command (typically `/document-review vision.md`). Surface that recommendation to the directing party.
