---
name: project-setup
description: Install, update and verify the Shannon framework in a project. Invoked by /shannon-setup (first install or reinstall) and /shannon-update (upgrade from a newer Shannon source). Detects existing .claude/ state, backs up before overwriting, deploys commands, skills, guides and the supervisor wiring, instantiates mandated documents in ./docs/, merges a project-level CLAUDE.md, records the installed version, and walks existing records through the changelog's record notes. Use when the directing party runs /shannon-setup or /shannon-update, or asks to set up, install, upgrade or check the version of Shannon.
---

# Skill: project-setup

When invoked, **start your response with**: "Activating project-setup skill for [setup | update]."

## Purpose

This skill takes a project from "Shannon is not installed", or "an older Shannon is installed", to "this Shannon version is installed, wired up and verified". It owns:

- Detecting the project's current state (fresh, existing `.claude/` without Shannon, or an earlier Shannon install)
- Deploying framework files with backups, preserving local customisations
- Wiring the supervisor (hook registrations, configuration, audit-log ignore)
- Instantiating mandated documents and the scratchpad in `./docs/`
- Producing or merging the project-level `CLAUDE.md`
- Recording the installed version and a manifest of deployed files
- Carrying existing records across framework versions (the changelog's *Records* notes)
- Verifying the installation

It does **not** elaborate the vision beyond the first pass or create work items.

## When to Invoke

- `/shannon-setup` — first install, or reinstall over an existing one
- `/shannon-update [path]` — upgrade from a Shannon source tree (a clone the directing party has pulled), or report the installed and available versions
- The directing party asks to set up, install, upgrade or check the version of Shannon

## Inputs

- **Verb** — `setup` or `update`
- **Source path** — the Shannon source tree (a directory containing `commands/`, `skills/` and `guides/`, usually `<clone>/shannon/`). For `setup`, default to the tree this skill was copied from; for `update`, use the path argument, and ask when none is given
- **Project name** — asked if not supplied (setup only)

Shannon makes no network calls. The directing party pulls a newer Shannon clone themselves; this skill reads it from disk.

## Versioning

- The framework version is the newest `## [x.y]` heading in the source's `guides/CHANGELOG.md`. There is no separate version file to keep in step.
- An install records `./.claude/.shannon-version`, holding the version on its first line and then `installed: YYYY-MM-DD` and `source: <path>`.
- An install also records `./.claude/.shannon-manifest`: one line per deployed framework file, `<sha256>  <path relative to .claude/>`. On a later update, a file whose current hash differs from its manifest hash has been **customised locally**.
- Compute hashes with `shasum -a 256` (macOS) or `sha256sum` (Linux).
- Both files are dotfiles. Some file-search tools skip hidden files, so check for them by reading the exact path or with `test -f` before concluding they are missing.

## Process: Setup

### 1. Detect project state

Check for `./.claude/`, `./.claude/.shannon-version`, `./.claude/settings.json`, `./docs/` and any of the six mandated documents, `./CLAUDE.md`, and the project's language markers (`package.json` → Node, `pyproject.toml` / `requirements.txt` / `setup.py` → Python, `go.mod` → Go, `Cargo.toml` → Rust; otherwise generic). Report what you found before changing anything: existing commands and skills that are not Shannon's, existing hooks in `settings.json`, existing documents.

### 2. Confirm intent

- **No Shannon install** — proceed, stating that non-Shannon files under `./.claude/` are left untouched.
- **Shannon already installed** — report the installed version and offer **Update** (prefer `/shannon-update`, which preserves customisations), **Reinstall** (back up, then deploy fresh) or **Abort**.

### 3. Back up

Before overwriting any existing file, copy it to `./.claude/.shannon-backup/YYYY-MM-DD/<same relative path>`. A backup is never deleted by this skill. Add `.claude/.shannon-backup/` to the project's `.gitignore` if the project tracks `.claude/`.

### 4. Deploy framework files

Copy from the source tree into the project:

- `commands/` → `./.claude/commands/`
- `skills/` → `./.claude/skills/`
- `guides/` → `./.claude/guides/`

Never delete a file the source does not ship. Make the supervisor's `scripts/*.sh` executable (`chmod +x`).

### 5. Wire the supervisor

- **Hooks.** Merge each `./.claude/skills/shannon-supervisor/hooks/*.settings.json` snippet into `./.claude/settings.json`. Create the file as `{"hooks": {}}` when missing. For each event, append the snippet's matcher group unless a group with the same `command` is already present. Keep every existing key, event and hook. Drop the snippets' `_comment` keys. Show the merged result.
- **Configuration.** Write `./.claude/shannon-supervisor.json` as `{"report_directory": "docs/supervisor"}` only if it does not exist.
- **Ignores.** Add to the project's `.gitignore` whatever it does not already cover: `.claude/skills/shannon-supervisor/audit.log` (PostToolUse telemetry) and `.claude/supervisor/` (cadence state, run logs and worktrees), unless all of `.claude/` is already ignored; and `<report_directory>/.in-progress/` (a run's working fragments). Reports themselves are committed.
- **Reports.** Create `./docs/supervisor/` when missing.

### 6. Instantiate documents

For each template in `./.claude/skills/project-documentation/templates/` except the knowledge templates, copy it to `./docs/<name>.md` when it does not already exist, set Status to DRAFT and Last Reviewed to today. Never overwrite an existing document.

When a language marker was found in step 1, pre-fill `technology_stack.md`'s language/runtime line from it, and `development_guide.md`'s build and test commands from the marker file's scripts (for example `npm test`), each marked *detected; confirm at review*. Generic projects keep the placeholders.

Create, when missing:

- `./docs/features/` with `feature_index.md`
- `./docs/knowledge/` with `knowledge_index.md`, including a *Supervisor Reports* section
- `./docs/scratchpad.md` from `./.claude/skills/work-items/templates/scratchpad.md`

Optional execution-aid directories (`docs/epics/`, `docs/tasks/`, `spikes/`) are created only when first used. Existing records and indexes are preserved; no bulk migration.

### 7. Produce or merge `CLAUDE.md`

Shannon owns only the text between `<!-- shannon:begin -->` and `<!-- shannon:end -->` in the project's `CLAUDE.md`.

- **No `CLAUDE.md`** — instantiate `templates/CLAUDE.md` and fill in the project name.
- **`CLAUDE.md` without markers** — keep the existing content unchanged and append the template's marked block after it.
- **`CLAUDE.md` with markers** — replace only the marked block.

### 8. Record the version and manifest

Write `./.claude/.shannon-version` and `./.claude/.shannon-manifest` (see § Versioning) for every file deployed in step 4.

### 9. Capture initial vision content

On a first install only, walk the directing party through the Vision template's Problem Statement, Vision Statement, Core Principles, Key Features and Target Users, and write the answers into `./docs/vision.md`. Leave Success Metrics and Future Vision as placeholders.

### 10. Verify

Report each check as pass or fail:

- Every source file is present in the project with its manifest hash
- Each skill directory under `./.claude/skills/` contains a `SKILL.md` whose frontmatter starts on line 1 (Claude Code only loads `SKILL.md`)
- `./.claude/settings.json` is valid JSON and registers each supervisor hook command once
- The six documents, both indexes and the scratchpad exist; `CLAUDE.md` contains exactly one Shannon block
- `./.claude/.shannon-version` names the source version

Finish with the list of created, merged and backed-up files and the next command (on a first install, `/document-review vision.md`). A Claude Code session started before setup will not see new commands or hooks until it is restarted; say so.

## Process: Update

### 1. Report versions

Read `./.claude/.shannon-version` (installed; "unknown" for a pre-versioning install) and the source's `guides/CHANGELOG.md` (available). With no source path, report the installed version, say how to get a newer one (pull a Shannon clone, then `/shannon-update <clone>/shannon`) and stop. When the versions match, say so and stop unless the directing party asks to redeploy.

### 2. Show what changes

List the changelog entries newer than the installed version: each one's summary and its *Records* notes. Then classify each framework file:

- **Unchanged locally** — current hash matches the manifest: safe to replace
- **Customised locally** — current hash differs from the manifest: show the local diff against the new source file and ask, per file, whether to keep the local version, take the new one, or merge the two
- **New** — added by the newer version
- **Retired** — in the manifest but no longer shipped: listed, never deleted automatically

With no manifest (a pre-versioning install), treat every file that differs from the new source as possibly customised and ask once whether to review each one or take the new versions with backups.

Wait for the directing party's go-ahead before writing.

### 3. Apply

Back up (Setup step 3), deploy (step 4) honouring the per-file choices, re-run the supervisor wiring (step 5; it is idempotent), merge `CLAUDE.md` (step 7), and rewrite the version and manifest (step 8). A kept customisation is recorded in the manifest with the *source* hash, so it is detected again next time.

### 4. Carry records across versions

For each applied changelog entry, work through its *Records* notes in order. These are how existing work items and documents absorb framework evolution without being recreated (FEAT-003):

- **Additive notes** (a new optional section, field or convention) — no change is required to existing records. Apply the change when a record is next touched.
- **Notes that change meaning** for existing records — re-elaborate the affected records through `conceptual_design.md` § Re-elaborating a Work Item, with trigger *framework evolution*, citing the Shannon version. Preserve history and identifiers, and bring any change to approved meaning to the human.
- **Document notes** — re-review the named mandated-document sections in the project's own documents. Factual alignment is agent work; a change to approved meaning goes to the human.

Report what was absorbed, and what still waits on a human decision.

### 5. Verify

Run Setup step 10, and confirm that no customised file was overwritten without a choice.

## Quality Gates

Setup and update establish and maintain the framework; they create no work-item gates. The human approves the Vision and any consequential meaning; Feature requirements, approach and delivery keep their human gates.

## Templates

This skill owns one template:

- `templates/CLAUDE.md` — Project-level Claude Code guidance, wrapped in the Shannon block markers

Mandated document templates live in the `project-documentation` skill, and work-item and scratchpad templates in the `work-items` skill. The supervisor's hook snippets live in `shannon-supervisor/hooks/`. This skill deploys them but does not own them.

## Failure Modes

- **Missing source tree** — report "Cannot locate Shannon source. Pass the path to a Shannon clone's `shannon/` directory."
- **Malformed `settings.json`** — stop before merging hooks, show the parse error and leave the file untouched
- **A command or skill name clash with a non-Shannon file** — report it and ask; never overwrite a file absent from the manifest without a choice
- **Directing party aborts mid-run** — restore from the dated backup; do not leave a half-installed state

## Self-Identification

Always begin a response with the activation line above. If you cannot perform this skill's work for any reason, say so explicitly rather than silently doing something else.
