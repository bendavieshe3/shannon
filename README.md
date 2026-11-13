# Shannon

**A development framework for AI-assisted software projects with Claude Code.**

Shannon is a workflow and documentation system for solo developers and knowledge workers building software with AI. It takes the context-management burden off the developer by providing a structured documentation system, Feature-led delivery, and explicit human review gates at the highest-leverage moments.

The framework is plain Markdown. No build step. No runtime. Nothing to install but the files themselves.

## When to Use Shannon

Shannon is optional. It suits standalone projects with no upstream requirements owner. A project whose requirements are owned and accepted elsewhere does not need it.

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

This backs up anything it would overwrite, wires the supervisor's hooks, records the installed version, and creates the six mandated documents, the Feature and knowledge directories (optional execution folders may be added when useful), and a project-level `CLAUDE.md` with AI guidance.

### Update

Pull a newer Shannon clone, then in your project:

```
/shannon-update /path/to/shannon/shannon
```

This shows what changed since your installed version (see `shannon/guides/CHANGELOG.md`), asks before replacing any framework file you customised, backs up what it overwrites, and carries existing work items across the version change.

### Start Working

```
/document-review vision.md           # Approve the vision (Gate 1)
/feature-create [hint]               # Capture a feature
/feature-elaborate FEAT-001          # Draft requirements (Gate 1)
/feature-plan FEAT-001               # Approve approach (Gate 2)
/feature-implement FEAT-001          # Deliver directly; optional execution aids
/feature-review FEAT-001             # Evidence, independent review, human acceptance
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

### Features Carry Human Gates; Execution Aids Are Optional

Features are persistent product capabilities with human requirements, approach and delivery gates. Epics, Tasks and Spikes remain available as optional execution aids, without mandatory human gates or a fixed status sequence.

Everything extends traceably from the Vision through relevant governing documents and Features to implementation, verification and independent review. Agents choose decomposition and execution; no child hierarchy or replacement work-order layer is required. Existing identifiers and history remain intact.

### Three Quality Gates

The human approves Feature requirements/acceptance criteria (Gate 1), approach/consequential trade-offs (Gate 2), and delivered capability against evidence (Gate 3). Vision and consequential changes to approved meaning remain human-owned. Agents maintain factual documentation and execution plans within approved intent. Independent technical review remains distinct from implementation, merge and human acceptance.

### Lightweight Idea Capture

`docs/scratchpad.md` takes one-line ideas that aren't ready to be work items. `/scratchpad-add` captures one; `/scratchpad-process` acts on, promotes, files or drops each item and keeps a trail under § Processed.

### Commands + Skills + Subagents

- **Commands** — Thin entry points (`/shannon-setup`, `/[type]-[verb]`, `/document-[verb]`, `/scratchpad-[verb]`, `/shannon-report`, `/shannon-goal`)
- **Skills** — Reusable framework logic with templates (`project-setup`, `project-documentation`, `work-items`, `shannon-supervisor`)
- **Subagents** — Optional, separately authorised help; independent review must come from someone who did not implement the change

## Repository Structure

```
shannon/                       # Deployable source
├── commands/                  # Thin slash commands
├── skills/                    # Framework logic + templates
│   ├── project-setup/
│   ├── project-documentation/
│   ├── work-items/
│   └── shannon-supervisor/
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
