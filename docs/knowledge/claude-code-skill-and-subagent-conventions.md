# Claude Code Skill and Subagent File Conventions

**Type**: Research
**Produced by**: [SPIKE-001](../../spikes/SPIKE-001-claude-code-skill-and-subagent-file-conventions.md)
**Date**: 2026-11-13
**Related**: `technical_design.md` § System Architecture → *Skills* and *Supervisor*; FEAT-001, FEAT-009

## Question

What file name, casing and frontmatter does Claude Code need for skills and subagent definitions, and do Shannon's four skills and three supervisor checkers meet it?

## Findings

**Skill file name.** Claude Code's skills documentation (https://code.claude.com/docs/en/skills) says every skill needs a `SKILL.md` file. It does not say whether lowercase works, so it was tested directly (Claude Code 2.1.325, headless `claude -p`, a scratch project with Shannon's source copied into `.claude/`):

- With `.claude/skills/work-items/SKILL.md` (lowercase, as shipped), `/scratchpad-add` could not activate the skill. The agent reported that "the loader expects `SKILL.md`", then read the file by hand and followed it.
- After renaming the file to `SKILL.md`, the same command invoked the Skill tool with `skill: "work-items"`, and the skill's self-identification line appeared ("Activating work-items skill for scratchpad add.").

So `work-items`, `project-documentation` and `project-setup` do not load as skills today. Every command that delegates to them works only because the model falls back to reading the file. Only `shannon-supervisor`, which ships `SKILL.md`, loads properly.

**Skill frontmatter.** All fields are optional. `description` is recommended, and without it Claude Code uses the first non-empty line of the body. An omitted `name` defaults to the directory name. Frontmatter is read only when `---` is the file's first line. `shannon-supervisor/SKILL.md` has no frontmatter, so its description becomes "# Skill: shannon-supervisor", which gives the model nothing to match on.

**Commands.** Custom commands have been merged into skills. `.claude/commands/<name>.md` still works, and a skill with the same name takes precedence (https://code.claude.com/docs/en/slash-commands). Shannon's thin commands remain valid.

**Subagents.** Subagents are registered from `.claude/agents/` (project) and `~/.claude/agents/` (user). They need `name` and `description`, list tools under `tools` (not `allowed-tools`), take a model alias (`haiku`, `sonnet`, `opus`, `inherit`) or a full ID, and ignore unknown keys silently (https://code.claude.com/docs/en/sub-agents). The supervisor's checkers live in `.claude/skills/shannon-supervisor/checkers/`, so they are **not** registered subagents. Their `model:` and `allowed-tools:` frontmatter is enforced only if the supervisor passes them when it spawns the checker. As written, the Haiku/Sonnet split and the tool restrictions are advisory.

**Headless.** `--bare` skips discovery of hooks, skills, custom commands, subagents, plugins, MCP servers, auto memory and CLAUDE.md, and needs `ANTHROPIC_API_KEY` (https://code.claude.com/docs/en/headless). The supervisor's documented headless contract (`claude --bare -p ...`) therefore cannot find the supervisor skill or fire its hooks. Unattended runs must drop `--bare` or pass the skill and settings explicitly. In `-p` mode the `Skill` tool must also be allowed for a command to activate its skill.

## Recommendations

All four were applied on 2026-11-14 in Shannon 5.1 (PR #16): the rename with the directing party's go-ahead, and the rest under FEAT-001 and FEAT-009.

1. Rename the three lowercase `skill.md` files to `SKILL.md` in `shannon/skills/` and update live references. Historical records keep their wording. On a case-insensitive filesystem, rename through a temporary name.
2. Give `shannon-supervisor/SKILL.md` `name`/`description` frontmatter.
3. Have the supervisor spawn each checker with the model alias from its frontmatter (`haiku`/`sonnet`), and write checker tool limits as `tools`. Registering checkers under `.claude/agents/` is the stronger option, but it adds an install step; revisit it with `/shannon-setup` supervisor deployment.
4. Revise the headless contract in `technical_design.md` § Cadence: no `--bare`, and `Skill` in `--allowedTools`.
