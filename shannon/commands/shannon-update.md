# /shannon-update [path]

Upgrade this project's Shannon installation from a newer Shannon source, or report the installed and available versions.

You MUST invoke the `project-setup` skill to perform this work.

Pass:
- **Verb**: `update`
- **Source path**: `$ARGUMENTS` (the `shannon/` directory of a Shannon clone you have pulled; empty reports the installed version and how to upgrade)

The skill shows the changelog entries between the installed and available versions and which framework files you have customised, waits for your go-ahead, backs up before writing, and then walks existing records through each version's *Records* notes.

If the `project-setup` skill does not activate, report:
"Error: project-setup skill failed to activate. Please confirm `./.claude/skills/project-setup/SKILL.md` is present."

When the update finishes, surface the verification results and anything waiting on a human decision, then resume the original conversation topic.
