---
name: project-setup
description: Initialise a project with the Shannon framework. Invoked by /shannon-setup. Detects existing .claude/ state, deploys templates from this skill and its sibling skills, instantiates mandated documents in ./docs/, and produces a project-level CLAUDE.md. Use when a user runs /shannon-setup or asks to "set up Shannon in this project".
---

# Skill: project-setup

When invoked, **start your response with**: "Activating project-setup skill."

## Purpose

This skill takes a project from "Shannon is not installed" to "Shannon is installed and the documentation skeleton exists." It owns:

- Detecting the project's current state (fresh vs. existing `.claude/`)
- Deploying templates from this skill and its siblings into the project
- Instantiating mandated documents in `./docs/`
- Producing a project-level `CLAUDE.md` from this skill's template
- Verifying the installation completed successfully

This skill does **not** elaborate vision or create work items — those happen after setup via `/document-create`, `/feature-create`, and friends.

## When to Invoke

- The user runs `/shannon-setup`
- The user asks to "set up Shannon" or "install Shannon" in a project
- The user is in a directory with no `.claude/` and asks how to start using Shannon

## Inputs

- **Working directory** — Inferred from the current Claude Code session
- **Project name** — Asked of the user if not supplied
- **Project type hint** *(optional)* — e.g. "web app", "CLI tool", "library"

## Process

### 1. Detect Project State

- Check whether `./.claude/` exists
- Check whether `./docs/` exists and contains any mandated documents
- Check whether `./.claude/.shannon-version` exists (indicates a prior install)

Report findings to the user before changing anything.

### 2. Confirm Intent

If existing Shannon state is detected, explicitly confirm with the user whether to:

- **Update** — Preserve existing customisations, refresh framework files
- **Reinstall** — Back up existing state, install fresh
- **Abort** — Stop without changes

If no existing state, proceed to deployment.

### 3. Deploy Framework Files

Copy from this skill's parent `shannon/` source tree (or from the deployed `./.claude/` skills directory, depending on invocation context) into the project:

- `shannon/commands/` → `./.claude/commands/`
- `shannon/skills/` → `./.claude/skills/`
- `shannon/guides/` → `./.claude/guides/` *(optional, recommended)*

For updates, back up existing files before overwriting. Surface a diff summary to the user.

### 4. Instantiate Mandated Documents

For each mandated document template in `./.claude/skills/project-documentation/templates/`:

- Copy to `./docs/<name>.md` if it does not already exist
- Skip if it exists (do not overwrite user content)
- Set Status to DRAFT
- Set Last Reviewed to today's date

Create these directories with their index files:

- `./docs/features/` with `feature_index.md`
- `./docs/epics/` with `epic_index.md`
- `./docs/tasks/` with `task_index.md` and `tasks/archive/`
- `./docs/knowledge/` with `knowledge_index.md`
- `./spikes/` with `spike_index.md` (project root, not under `docs/`)

### 5. Produce Project CLAUDE.md

Instantiate `CLAUDE.md` in the project root from this skill's template at `templates/CLAUDE.md`. Fill in the project name. Preserve any existing user content if a `CLAUDE.md` already exists — merge, do not overwrite.

### 6. Capture Initial Vision Content

Walk the user through the Vision template's sections:

- Problem Statement
- Vision Statement
- Core Principles
- Key Features
- Target Users

Write their answers into `./docs/vision.md`. Leave Success Metrics and Future Vision as placeholders for the user to fill in later.

### 7. Verify

- Confirm all expected files exist
- Confirm `CLAUDE.md` is readable and references the right paths
- Confirm index files are present and well-formed

Report verification results to the user with a list of created files and the next recommended command (typically `/document-review vision.md`).

## Quality Gates

This skill operates **before** the work item lifecycle, so no Gates 1–3 apply directly. The vision content captured here will pass through Gate 1 when the user runs `/document-review vision.md`.

## Templates

This skill owns one template:

- `templates/CLAUDE.md` — Project-level Claude Code guidance file

Mandated document templates live in the `project-documentation` skill; work item templates live in the `work-items` skill. This skill orchestrates their deployment but does not own them.

## Failure Modes

- **Existing `.claude/` with conflicting structure** — Report the conflict, ask the user whether to merge, back up and replace, or abort
- **Missing source tree** — If invoked from a context where `shannon/skills/` or `./.claude/skills/` cannot be found, report the error: "Cannot locate Shannon source. Confirm Shannon was cloned or installed."
- **User aborts mid-setup** — Roll back any in-progress changes; do not leave the project in a half-installed state

## Self-Identification

Always begin a response with: "Activating project-setup skill." If you cannot perform this skill's work for any reason, say so explicitly rather than silently doing something else.
