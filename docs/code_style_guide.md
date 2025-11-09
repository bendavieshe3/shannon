# Code Style Guide

**Status**: DRAFT
**Last Reviewed**: 2025-11-09

---

**Project Name**: Shannon

## Overview

<!--
Brief summary of the coding standards and philosophy.
1-2 paragraphs explaining the approach to code style.
-->

[Describe the overall code style philosophy]

**Example**:
> This project prioritizes readability and maintainability over cleverness. Code should be self-documenting where possible, with comments explaining "why" not "what". We follow language-specific best practices and use automated tools (linters, formatters) to enforce consistency.

---

## [Language] Style

<!--
Create a section for each language used in the project.
Reference official style guides and note any deviations.
-->

### Base Style

**Follow**: [Official style guide, e.g., "PEP 8", "Google Java Style"]

**Modifications**:
- [Any deviations from the base style]
- [Rationale for each deviation]

**Example**:
> ### Base Style
>
> **Follow**: PEP 8 (Python Enhancement Proposal 8)
>
> **Modifications**:
> - Line length: 100 characters (not 79) - modern screens support it
> - String quotes: Double quotes for strings, single for dict keys
> - Imports: Absolute imports preferred, relative only within package

### Code Formatting

**Tool**: [Formatter being used]

**Key Rules**:
- [Rule 1]
- [Rule 2]
- [Rule 3]

**Example**:
> **Tool**: Ruff (replaces Black + isort + flake8)
>
> **Key Rules**:
> - 4 spaces for indentation (never tabs)
> - 2 blank lines between top-level definitions
> - 1 blank line between method definitions
> - Trailing commas in multi-line structures
> - Maximum line length: 100 characters

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Variables | [Convention] | `[example]` |
| Functions | [Convention] | `[example]` |
| Classes | [Convention] | `[example]` |
| Constants | [Convention] | `[example]` |
| Files | [Convention] | `[example]` |
| Directories | [Convention] | `[example]` |

**Example**:
> | Element | Convention | Example |
> |---------|------------|---------|
> | Variables | snake_case | `user_id`, `max_retries` |
> | Functions | snake_case, verb-noun | `get_user()`, `create_idea()` |
> | Classes | PascalCase, noun | `IdeaRepository`, `AuthService` |
> | Constants | UPPER_SNAKE_CASE | `MAX_RETRIES`, `DEFAULT_TIMEOUT` |
> | Files | snake_case | `idea_repository.py`, `auth_service.py` |
> | Directories | snake_case | `api/`, `domain/`, `persistence/` |
> | Private | prefix with _ | `_internal_helper()`, `_cache` |

### Type Hints

**Approach**: [How type hints are used]

**Requirements**:
- [Where type hints are required]
- [Where they're optional]

**Example**:
> **Approach**: Type hints required for all public functions and methods
>
> **Requirements**:
> - All function signatures must have type hints
> - Return types must be specified (use `-> None` if no return)
> - Complex types use `typing` module (List, Dict, Optional, etc.)
> - Use `TypedDict` or Pydantic models for complex structures
>
> ```python
> from typing import Optional, List
>
> def get_ideas(user_id: int, limit: int = 10) -> List[Idea]:
>     """Retrieve ideas for a user."""
>     ...
>
> def delete_idea(idea_id: int) -> None:
>     """Delete an idea by ID."""
>     ...
> ```

---

## Docstrings & Comments

### Docstring Style

**Format**: [Style to use, e.g., "Google", "NumPy", "reStructuredText"]

**Requirements**:
- [What requires docstrings]
- [What's optional]

**Example**:
> **Format**: Google-style docstrings
>
> **Requirements**:
> - All public modules, classes, functions, and methods
> - Private functions if behavior is non-obvious
> - Optional for simple getters/setters
>
> **Template**:
> ```python
> def create_idea(content: str, user_id: int, tags: Optional[List[str]] = None) -> Idea:
>     """Create a new idea for a user.
>
>     Creates a new idea with the given content and optionally applies tags.
>     The idea is automatically added to the user's inbox collection.
>
>     Args:
>         content: The idea content (markdown supported)
>         user_id: ID of the user creating the idea
>         tags: Optional list of tag names to apply
>
>     Returns:
>         The newly created Idea instance
>
>     Raises:
>         ValueError: If content is empty
>         UserNotFoundError: If user_id doesn't exist
>
>     Example:
>         >>> idea = create_idea("Build a spaceship", user_id=42, tags=["project"])
>     """
>     ...
> ```

### Code Comments

**When to Comment**:
- [Guideline 1]
- [Guideline 2]
- [Guideline 3]

**When NOT to Comment**:
- [Anti-pattern 1]
- [Anti-pattern 2]

**Example**:
> **When to Comment**:
> - Explain **WHY** (not what) - why this approach was chosen
> - Document non-obvious business rules (reference conceptual_design.md)
> - Explain complex algorithms (or link to knowledge note)
> - Mark TODOs with ticket reference: `# TODO(TASK-123): Add caching`
> - Warn about gotchas: `# Note: This mutates the input list`
>
> **When NOT to Comment**:
> - Don't explain what code does (code should be self-documenting)
> - Don't comment obvious things: `x = x + 1  # Increment x`
> - Don't leave commented-out code (use git history instead)
> - Don't write outdated comments (update or delete)
>
> **Good**:
> ```python
> # Use exponential backoff to avoid overwhelming the API
> # See: knowledge/implementation-details/retry-strategy.md
> delay = base_delay * (2 ** attempt)
> ```
>
> **Bad**:
> ```python
> # Calculate delay
> delay = base_delay * (2 ** attempt)
> ```

---

## Code Organization

### File Structure

[Describe how code should be organized within files]

**Example**:
> **Order**:
> 1. Module docstring
> 2. Imports (standard lib, third-party, local)
> 3. Constants
> 4. Type definitions (TypedDict, Protocols, etc.)
> 5. Classes (public first, then private)
> 6. Functions (public first, then private)
>
> **Example**:
> ```python
> """
> Module for idea repository operations.
>
> Provides database access layer for Idea entities.
> """
> import logging
> from typing import List, Optional
>
> from sqlalchemy.orm import Session
>
> from ..models import Idea
> from ..exceptions import IdeaNotFoundError
>
> logger = logging.getLogger(__name__)
>
> MAX_RESULTS = 100
>
> class IdeaRepository:
>     """Repository for Idea entity database operations."""
>     ...
> ```

### Directory Structure

[Describe how code should be organized across directories]

**Example**:
> ```
> src/
> ├── api/              # API layer (FastAPI routes)
> │   ├── routes/       # Route handlers by resource
> │   ├── schemas/      # Pydantic request/response models
> │   └── dependencies/ # FastAPI dependency injection
> ├── domain/           # Domain layer (business logic)
> │   ├── models/       # Domain models
> │   ├── services/     # Business logic services
> │   └── events/       # Domain events
> ├── persistence/      # Persistence layer
> │   ├── repositories/ # Data access objects
> │   └── migrations/   # Database migrations
> └── common/           # Shared utilities
>     ├── config.py
>     ├── logging.py
>     └── exceptions.py
> ```

---

## Error Handling

### Exception Hierarchy

[Describe custom exception structure]

**Example**:
> **Base Exception**: `AppException` (all app exceptions inherit from this)
>
> **Categories**:
> - `ValidationError` - Invalid input
> - `NotFoundError` - Entity not found (subclass per entity: `IdeaNotFoundError`)
> - `AuthenticationError` - Auth failures
> - `AuthorizationError` - Permission denied
>
> **Usage**:
> ```python
> class IdeaNotFoundError(NotFoundError):
>     """Raised when an idea doesn't exist."""
>     def __init__(self, idea_id: int):
>         super().__init__(f"Idea {idea_id} not found")
>         self.idea_id = idea_id
> ```

### Error Handling Patterns

**Principles**:
- [Principle 1]
- [Principle 2]

**Example**:
> **Principles**:
> - Fail fast - validate at boundaries (API layer)
> - Let exceptions propagate - don't swallow errors
> - Use specific exceptions - not generic `Exception`
> - Log errors at handling point - include context
> - Never expose sensitive data in error messages
>
> **Pattern**:
> ```python
> def get_idea(idea_id: int) -> Idea:
>     """Get idea by ID."""
>     idea = db.query(Idea).filter(Idea.id == idea_id).first()
>     if not idea:
>         # Specific exception with context
>         raise IdeaNotFoundError(idea_id)
>     return idea
> ```

---

## Testing Standards

### Test Organization

[How tests are organized and named]

**Example**:
> **Structure**: Mirror source structure in `tests/` directory
>
> ```
> tests/
> ├── api/
> │   └── test_ideas_routes.py
> ├── domain/
> │   └── test_idea_service.py
> └── persistence/
>     └── test_idea_repository.py
> ```
>
> **Naming**:
> - Test files: `test_*.py`
> - Test functions: `test_<function>_<scenario>`
> - Test classes: `Test<ClassName>`

### Test Style

**Framework**: [Testing framework being used]

**Patterns**:
- [Pattern 1]
- [Pattern 2]

**Example**:
> **Framework**: pytest
>
> **Patterns**:
> - Use fixtures for setup/teardown
> - One assertion per test (generally)
> - Descriptive test names: `test_create_idea_with_empty_content_raises_error`
> - Use AAA pattern (Arrange, Act, Assert)
> - Mock external dependencies (database, APIs, etc.)
>
> ```python
> def test_create_idea_adds_to_inbox_collection(db_session, test_user):
>     # Arrange
>     content = "Build a time machine"
>
>     # Act
>     idea = create_idea(content, user_id=test_user.id)
>
>     # Assert
>     assert idea.content == content
>     assert test_user.inbox in idea.collections
> ```

---

## Linting & Static Analysis

### Tools

| Tool | Purpose | Configuration |
|------|---------|---------------|
| [Tool] | [What it checks] | [Config file] |

**Example**:
> | Tool | Purpose | Configuration |
> |------|---------|---------------|
> | ruff | Linting + formatting | `pyproject.toml` |
> | mypy | Type checking | `mypy.ini` |
> | pytest | Testing + coverage | `pyproject.toml` |
> | pre-commit | Git hooks | `.pre-commit-config.yaml` |

### Running Checks

**Commands**:
```bash
[Command to run linter]
[Command to run type checker]
[Command to run tests]
```

**Example**:
> **Commands**:
> ```bash
> # Format code
> ruff format .
>
> # Lint code
> ruff check .
>
> # Type check
> mypy src/
>
> # Run tests with coverage
> pytest --cov=src --cov-report=term-missing
>
> # Run all checks (CI)
> ./scripts/check-all.sh
> ```

---

## Git Commit Conventions

<!--
OPTIONAL: If project uses specific commit message conventions.
Remove if not needed (can go in development_design.md instead).
-->

**Format**: [Commit message format]

**Example**:
> **Format**: Conventional Commits
>
> ```
> <type>(<scope>): <subject>
>
> <body>
>
> <footer>
> ```
>
> **Types**: feat, fix, docs, style, refactor, test, chore
>
> **Examples**:
> ```
> feat(ideas): add tag filtering to search
> fix(auth): handle expired OAuth tokens gracefully
> docs: update API documentation for collections endpoint
> ```

---

## Version History

<!--
Track significant changes to the style guide.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial code style guide created
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.1
> - Changed line length from 88 to 100
> - Added exception hierarchy rules
> - Updated docstring examples
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial code style guide created
> - Status: APPROVED (2025-10-07)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Remove optional sections if not needed
5. Add sections for each language in your stack
6. Set Status to DRAFT
7. Update "Last Reviewed" to current date

**Key Reminders**:
- Be **specific** - vague rules lead to inconsistent code
- Provide **examples** - show good and bad patterns
- Configure **automated tools** - don't rely on manual enforcement
- Reference **official standards** - don't reinvent wheels
- Keep it **current** - update as project evolves
- Link to **knowledge notes** for complex patterns

**What Goes Here vs. Other Docs**:
- ✅ Code formatting, naming, organization
- ✅ Docstring and comment standards
- ✅ Error handling patterns
- ✅ Testing conventions
- ✅ Linting configuration
- ❌ Architecture patterns (→ technical_design.md)
- ❌ Build/deploy processes (→ development_design.md)
- ❌ UI style rules (→ ux_style_guide.md)
