# Shannon Commands

This directory contains slash command definitions for the Shannon framework. Commands are thin entry points — each delegates to a skill in `../skills/` for the actual work.

## Command Reference

### Project Setup

| Command | Purpose |
|---|---|
| `/shannon-setup` | Initialise (or update) a project with Shannon |

### Document Management

| Command | Purpose | Gate |
|---|---|---|
| `/document-create [type]` | Create a mandated document or knowledge note | — |
| `/document-review [path]` | Review and approve a document | Gate 1 |

### Work Item Lifecycle

Every work item type follows the same five-verb pattern. Substitute `[type]` with one of `feature`, `epic`, `task`, or `spike`.

| Verb | Command | Status Transition | Gate |
|---|---|---|---|
| Create | `/[type]-create [hint]` | → DRAFT | — |
| Elaborate | `/[type]-elaborate [ID]` | DRAFT → ELABORATED | Gate 1 |
| Plan | `/[type]-plan [ID]` | ELABORATED → PLANNED | Gate 2 |
| Implement | `/[type]-implement [ID]` | PLANNED → IMPLEMENTING ↔ IMPLEMENTED | — |
| Review | `/[type]-review [ID]` | IMPLEMENTED/REVIEW → APPROVED | Gate 3 |

Full unified lifecycle:

```
DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED
     │           │          │                                       │
   Gate 1     Gate 2    (iterative zone)                         Gate 3
```

## How Commands Work

Each command is a thin Markdown file that:

1. States explicitly which skill to invoke ("You MUST invoke the X skill")
2. Passes the relevant parameters (type, verb, target, hint)
3. Includes fallback wording if the skill fails to activate
4. Returns the user to the original conversation topic when done

The actual workflow logic — reading documents, drafting elaborations, enforcing gates, updating indexes — lives in the skills, not the commands.

## Installation

Copy this directory and its sibling `skills/` and `guides/` directories into your project's `.claude/`:

```
cp -r shannon/commands /path/to/project/.claude/commands
cp -r shannon/skills   /path/to/project/.claude/skills
cp -r shannon/guides   /path/to/project/.claude/guides
```

Then run `/shannon-setup` inside the project to instantiate documentation.
