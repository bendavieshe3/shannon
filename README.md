# Shannon

**A documentation framework for AI-assisted development with Claude Code**

Shannon is a complete documentation and workflow system designed for solo developers using AI pair programming. It provides structure for AI context management, strategic human review gates, and complete traceability from product vision to implementation.

## Quick Start

### Install Shannon in Your Project

```bash
# From the Shannon repository
mkdir -p /path/to/your-project/.claude
cp -r shannon/templates /path/to/your-project/.claude/templates
cp -r shannon/commands /path/to/your-project/.claude/commands
cp -r shannon/guides /path/to/your-project/.claude/guides
```

### Initialize Your Project

```bash
cd /path/to/your-project
/project-setup
```

This creates:
- 8 mandated documentation files (product requirements, technical design, style guides, etc.)
- Directory structure for features, tasks, and knowledge base
- CLAUDE.md with AI guidance and Quick Reference

### Start Working

```bash
# Review and approve your product requirements
/document-review product_requirements.md

# Create your first feature
/feature-create

# Plan and work on tasks
/task-create
/task-ready TASK-001
/task-implement TASK-001
```

## What Shannon Provides

### 📚 Complete Template Set
- 8 mandated documents (product requirements, technical design, style guides)
- Feature and task templates with lifecycle management
- Knowledge base structure for implementation notes
- CLAUDE.md template with AI guidance

### 🤖 AI-Optimized Commands
- `/project-setup` - Initialize or update project (idempotent)
- `/task-ready` - AI reads docs and creates implementation plan
- `/feature-phase-plan` - AI breaks features into tasks
- `/document-review` - Human approval workflow
- 10+ slash commands for complete lifecycle

### 🎯 Three Quality Gates
1. **Document Approval** - Review docs before AI uses them
2. **Task Planning** - Review AI's plan before coding
3. **Task Completion** - Review implementation before archiving

### 🔗 Complete Traceability
- Product vision → Features → Tasks → Implementation
- Automated cross-reference maintenance
- Alignment checks catch documentation drift

## Repository Structure

```
shannon/                       # Deployable source files
├── templates/                 # Document templates
├── commands/                  # Slash command definitions
└── guides/                    # How-to documentation

docs/                          # Shannon's own documentation
├── product_requirements.md   # What Shannon is
├── features/                 # Shannon's features
└── tasks/                    # Shannon's tasks

project-a/                     # Working example (simple)
project-b/                     # Working example (complex)
```

## Core Philosophy

Shannon solves **AI context management problems**:

- **Context Amnesia**: AI forgets past decisions → Documented in mandated docs
- **Inconsistent Decisions**: AI makes different choices → Style guides enforce consistency
- **Repetitive Questions**: AI re-asks same things → Knowledge base provides answers
- **Architectural Drift**: Implementation diverges from design → Alignment checks detect drift

## For Whom

### Architect Dev
You have a strong vision and want faithful implementation. Shannon ensures AI reads your conceptual design, respects future requirements, and maintains alignment throughout development.

### Gardener Dev
You're exploring the problem space iteratively. Shannon keeps documentation coherent as your understanding evolves, helping you know when to commit to production quality.

## Key Concepts

### Features vs Tasks

- **Features** are persistent (what the product IS)
  - Example: "Secures User Data"
  - Cycle: STABLE ↔ ACTIVE
  - Never complete - they evolve with phases

- **Tasks** are transient (specific work items)
  - Example: "Add Google OAuth provider"
  - Flow: TODO → READY → IN_PROGRESS → REVIEW → COMPLETED
  - Get archived when done

### Living Documentation

- Documents start as DRAFT
- Human reviews and approves (DRAFT → APPROVED)
- AI reads approved docs for trusted context
- Alignment checks catch drift before it's expensive

## Learn More

- **Complete Overview**: `shannon/guides/shannon_overview.md`
- **Command Reference**: `shannon/commands/README.md`
- **Layer Guides**: `shannon/guides/*_how_to.md`

## Why "Shannon"?

Named after **Claude Shannon** (1916-2001), the father of information theory. Shannon's groundbreaking work on efficient information transmission and storage directly mirrors this framework's approach to AI context management:

- **Shannon's Theory**: How to transmit maximum information with minimum bandwidth
- **Shannon Framework**: How to provide maximum context to AI with minimum overhead

Shannon (the person) proved that you can communicate perfectly despite noise if you structure information correctly. Shannon (the framework) proves you can develop perfectly despite context limits if you structure documentation correctly.

Plus, "Shannon Claude" has a nice ring to it. 😉

## License

[License details TBD]
