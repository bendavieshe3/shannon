# Shannon

**A development framework for AI-assisted software projects with Claude Code.**

Shannon is a workflow and documentation system for solo developers and knowledge workers building software with AI. It takes the context-management burden off the developer by providing a structured documentation system, a unified work item lifecycle, and explicit human review gates at the highest-leverage moments.

The framework is plain Markdown. No build step. No runtime. Nothing to install but the files themselves.

## Quick Start

### Install Shannon in Your Project

```bash
mkdir -p /path/to/your-project/.claude
cp -r shannon/commands /path/to/your-project/.claude/commands
cp -r shannon/skills   /path/to/your-project/.claude/skills
cp -r shannon/guides   /path/to/your-project/.claude/guides
```

### Initialise

In your project, inside Claude Code:

```
/shannon-setup
```

This creates the six mandated documents, the work item directory structure, and a project-level `CLAUDE.md` with AI guidance.

### Start Working

```
/document-review vision.md           # Approve the vision (Gate 1)
/feature-create [hint]               # Capture a feature
/feature-elaborate FEAT-001          # Draft requirements (Gate 1)
/feature-plan FEAT-001               # Identify epics (Gate 2)
/task-create / -elaborate / -plan / -implement / -review
```

## What Shannon Provides

### Six Mandated Documents

| Document | Purpose |
|---|---|
| **vision.md** | Problem, vision, principles, target users, success metrics |
| **technology_stack.md** | Languages, frameworks, infrastructure, and why |
| **conceptual_design.md** | Domain entities, business rules, key workflows |
| **technical_design.md** | Architecture, data model, API design, key algorithms |
| **development_guide.md** | Code style, testing, git, build, CI/CD, environment |
| **ux_guide.md** | Design principles, components, accessibility |

Documents form an explicit **authority graph** — lower documents must enable higher ones.

### Four Work Item Types, One Lifecycle

| Type | What it is |
|---|---|
| **Feature** | A persistent capability of the product |
| **Epic** | A coherent unit of work under a feature |
| **Task** | An atomic implementation work item |
| **Spike** | A time-boxed investigation producing knowledge |

All four use the same status flow:

```
DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED
     │           │          │                                       │
   Gate 1     Gate 2    (iterative zone)                         Gate 3
```

### Three Quality Gates

Explicit human approval points:

1. **Gate 1** — Requirements complete and aligned (DRAFT → ELABORATED)
2. **Gate 2** — Implementation plan sound (ELABORATED → PLANNED)
3. **Gate 3** — Implementation meets requirements (REVIEW → APPROVED)

Between IMPLEMENTING, IMPLEMENTED, and REVIEW, AI and user iterate freely without crossing a gate.

### Commands + Skills + Subagents

- **Commands** — Thin entry points (`/shannon-setup`, `/[type]-[verb]`, `/document-[verb]`)
- **Skills** — Reusable framework logic with templates (`project-setup`, `project-documentation`, `work-items`)
- **Subagents** — Spawned by skills for context-heavy reading; keep the main conversation lean

## Repository Structure

```
shannon/                       # Deployable source
├── commands/                  # Thin slash commands
├── skills/                    # Framework logic + templates
│   ├── project-setup/
│   ├── project-documentation/
│   └── work-items/
└── guides/                    # User-facing documentation

docs/                          # Shannon's own documentation (dogfooding)
spikes/                        # Disposable exploratory work
```

## Target Users

### Architect Dev

You arrive with a formed product vision and want faithful implementation. Shannon ensures the AI reads your conceptual design, respects future requirements you've anticipated, and maintains alignment throughout development.

### Gardener Dev

You're exploring the problem space iteratively. Shannon keeps documentation coherent as your understanding evolves, and helps you notice when your evolving vision contradicts earlier work.

Both personas share one thing: you don't want to read or review code. The framework's job is to make AI implementation trustworthy enough that code review is the exception, not the norm.

## Why "Shannon"?

Named after **Claude Shannon** (1916–2001), the father of information theory. Shannon's groundbreaking work on efficient information transmission directly mirrors this framework's approach to AI context management:

- **Shannon's theory**: How to transmit maximum information with minimum bandwidth, despite noise
- **Shannon framework**: How to provide maximum context to AI with minimum overhead, despite long-running projects

Shannon (the person) proved you can communicate perfectly despite noise if you structure information correctly. Shannon (the framework) bets you can develop perfectly despite context limits if you structure documentation and workflow correctly.

## Learn More

- **Complete walkthrough** — `shannon/guides/shannon_overview.md`
- **Command reference** — `shannon/commands/README.md`
- **Skill definitions** — `shannon/skills/*/skill.md`
- **Example application** — `docs/` (Shannon's own dogfood documentation)

## License

MIT License — see [LICENSE](LICENSE) for details. Shannon is free and open source.
