# Development Guide

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD]

---

**Project Name**: [Name of the product]

## Environment Setup

[Everything a new contributor needs to get the project running locally. Prerequisites, install steps, configuration, secrets, common pitfalls.]

### Prerequisites

- [Tool / runtime — version range]

### First-Time Setup

1. [Step]
2. [Step]
3. [Step]

### Secrets and Configuration

[Where secrets live, how config is sourced, what must be set for local development. Never check secrets into the repo.]

---

## Build and Run

[The commands developers actually run. Group by what they do — develop, test, build, deploy.]

### Develop

```
[command to start local dev]
```

### Test

```
[command to run tests]
```

### Build

```
[command to produce a deployable artefact]
```

---

## Code Style

[Formatting, naming, and file organisation conventions. Defer to tooling where possible — capture the *rules the tooling does not enforce*.]

### Formatting

[Tool and config reference. The formatter is the source of truth.]

### Naming

- [Naming convention for files, modules, classes, functions, variables, constants]

### File Organisation

- [How directories are structured, where new files belong, naming patterns for files]

### Patterns to Follow

- [Project-specific patterns: error handling, logging, dependency injection, etc.]

### Patterns to Avoid

- [Anti-patterns the team has decided against and why]

---

## Testing Strategy

[What gets tested, how, and to what depth. Coverage is an outcome, not a target.]

### Test Levels

- **Unit** — [What unit tests cover; what they don't]
- **Integration** — [Boundaries crossed; what's mocked vs. real]
- **End-to-end** — [Scope and trigger]

### What to Test

- [Required: domain logic, error paths, boundary conditions, contracts]
- [Optional / case-by-case]

### Test Conventions

- [Naming, structure, fixtures, factories]

---

## Git Workflow

### Branching

- **[Branch type]** — [Purpose, naming, lifetime]

### Commits

- [Convention — e.g. Conventional Commits — and rationale]

### Pull Requests

- [What a good PR looks like: size, description, review expectations, required checks]

---

## CI/CD

[Pipeline stages and what happens at each. The shape of the path from commit to production.]

### Pipeline Stages

1. [Stage — what runs and what it gates]
2. [Stage]

### Deployment

- [How releases are cut, promoted, and rolled back]

---

## Version History

### [YYYY-MM-DD] - v1.0

- Initial development guide created
- Status: DRAFT

---

## What Belongs Here (and What Doesn't)

✅ Code style, naming, and conventions
✅ Testing strategy and conventions
✅ Git workflow and PR process
✅ Build, run, and deploy commands
✅ CI/CD pipeline shape
✅ Local environment setup

❌ Architecture and components (→ technical_design.md)
❌ Why technologies were chosen (→ technology_stack.md)
❌ Tutorials or onboarding for the language itself (assumes competence)
❌ Detailed configuration for individual tools (→ knowledge notes)
