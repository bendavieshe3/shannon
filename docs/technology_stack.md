# Technology Stack

**Status**: DRAFT
**Last Reviewed**: 2025-11-09

---

**Project Name**: Shannon

## Overview

Shannon is a documentation framework with no traditional "technology stack" - it consists of markdown templates, command definitions, and guides. The "technologies" used are simply:
- **Markdown** - For all templates and documentation
- **Claude Code** - The platform Shannon runs on (slash commands executed by Claude)
- **Git** - For version control of Shannon itself and projects using it

The philosophy is **extreme simplicity**: plain text markdown files that are human-readable and AI-parseable without any special tooling.

---

## Core Technologies

### Markdown

**Purpose**: All templates, commands, and guides are written in markdown

**Rationale**:
- Human-readable without special tools
- AI (Claude) can easily parse and understand structure
- Git-friendly (diffs work well)
- Universal format supported everywhere
- No build step or dependencies

**Trade-offs**:
- No validation/type-checking of content
- No IDE support for our specific structure
- Manual consistency maintenance

**Alignment**: Supports product_requirements.md � "Project Initialization" - users can read and customize templates without special tools

### Claude Code Slash Commands

**Purpose**: Workflow automation and AI guidance

**Rationale**:
- Native to Claude Code platform
- AI can execute commands and read command definitions for context
- Simple markdown files in `.claude/commands/`
- No additional tooling needed

**Trade-offs**:
- Platform-specific (requires Claude Code)
- No programmatic validation of command logic
- Relies on AI interpretation (not scripted)

**Alignment**: Enables the AI-assisted development workflow in product_requirements.md � "Task Execution"

### Git

**Purpose**: Version control for Shannon and projects using it

**Rationale**:
- Industry standard
- Supports the "Living Documentation" pillar in product_requirements.md
- Enables tracking document evolution (DRAFT � APPROVED)
- Works with plain markdown files

**Trade-offs**:
- Learning curve for non-technical users
- Merge conflicts can occur in documentation

**Alignment**: Critical for product_requirements.md � "Documentation Maintenance" - version control enables tracking documentation evolution

---

## Deployment

Shannon is "deployed" by copying markdown files:

```bash
cp -r shannon/templates /path/to/project/.claude/templates
cp -r shannon/commands /path/to/project/.claude/commands
cp -r shannon/guides /path/to/project/.claude/guides
```

No build process, no dependencies, no runtime.

---

## Non-Technologies

Shannon explicitly **does not use**:

- **Databases** - All data in plain markdown files
- **Build tools** - No compilation, bundling, or processing
- **Package managers** - No npm, pip, cargo, etc.
- **Custom tooling** - No CLI scripts or special commands
- **Configuration files** - Configuration embedded in CLAUDE.md and command files

This is intentional to maintain extreme simplicity and portability.

---

## Version History

### 2025-11-09 - v1.0
- Initial technology stack documented
- Status: DRAFT (pending review)
