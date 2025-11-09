# Development Design

**Status**: DRAFT
**Last Reviewed**: 2025-11-09

---

**Project Name**: Shannon

## Overview

<!--
Brief summary of development practices, tools, and workflows.
1-2 paragraphs explaining the development approach.
-->

[Describe the overall development workflow and philosophy]

**Example**:
> This document defines development practices, tooling, testing strategies, and deployment processes for the project. We follow trunk-based development with short-lived feature branches, automated testing, and continuous deployment to staging. Production deployments require manual approval.

---

## Version Control

### Branching Strategy

**Model**: [Git workflow model]

**Branch Types**:
- **[Branch type]**: [Purpose and naming]

**Example**:
> **Model**: Trunk-based development
>
> **Branch Types**:
> - **main**: Production-ready code, protected, requires PR approval
> - **feature/***: Short-lived (merge within 2 days), naming: `feature/task-123-add-oauth`
> - **fix/***: Bug fixes, naming: `fix/task-456-handle-empty-content`
> - **hotfix/***: Emergency production fixes, naming: `hotfix/critical-auth-bypass`
>
> **Rules**:
> - No long-lived development branches
> - Feature branches merge to main via PR
> - Delete branch after merge
> - No direct commits to main

### Commit Conventions

**Format**: [Commit message format]

**Examples**:

**Example**:
> **Format**: Conventional Commits (https://www.conventionalcommits.org/)
>
> ```
> <type>(<scope>): <subject>
>
> <body>
>
> <footer>
> ```
>
> **Types**:
> - `feat`: New feature
> - `fix`: Bug fix
> - `docs`: Documentation only
> - `style`: Code style (formatting, no logic change)
> - `refactor`: Code change (no new feature or fix)
> - `test`: Add or update tests
> - `chore`: Build, tooling, dependencies
>
> **Scope** (optional): Component or area affected (e.g., `auth`, `ideas`, `api`)
>
> **Examples**:
> ```
> feat(ideas): add tag filtering to search
>
> fix(auth): handle expired OAuth tokens gracefully
>
> docs: update API documentation for collections endpoint
>
> refactor(api): extract validation logic to separate module
> ```
>
> **Breaking Changes**: Include `BREAKING CHANGE:` in footer
> ```
> feat(api): change idea response format
>
> BREAKING CHANGE: Ideas API now returns ISO timestamps instead of Unix epoch
> ```

### Pull Request Process

**Requirements**:
- [Requirement 1]
- [Requirement 2]

**Template**: [What PR description should include]

**Example**:
> **Requirements**:
> - All tests passing in CI
> - Code review approval from maintainer
> - No merge conflicts
> - Branch up to date with main
>
> **Template**:
> ```markdown
> ## Summary
> [What this PR does in 1-2 sentences]
>
> ## Changes
> - [Specific change 1]
> - [Specific change 2]
>
> ## Testing
> - [How this was tested]
>
> ## Related
> - Closes TASK-123
> - See also: #45
> ```
>
> **Review Process**:
> 1. Author creates PR, assigns reviewer
> 2. CI runs automatically (tests, linting)
> 3. Reviewer approves or requests changes
> 4. Author addresses feedback
> 5. Author merges (squash merge preferred)
> 6. Branch auto-deleted after merge

---

## Development Environment

### Prerequisites

**Required**:
- [Tool/Software and version]

**Optional**:
- [Tool/Software and version]

**Example**:
> **Required**:
> - Python 3.11+ (runtime)
> - PostgreSQL 15+ (database)
> - Redis 7+ (caching)
> - Node.js 18+ (frontend build)
>
> **Optional**:
> - Docker (containerized development)
> - pyenv (Python version management)
> - nvm (Node version management)

### Initial Setup

**Steps**:

**Example**:
> **Steps**:
>
> 1. **Clone repository**:
>    ```bash
>    git clone https://github.com/org/repo.git
>    cd repo
>    ```
>
> 2. **Set up Python environment**:
>    ```bash
>    python -m venv venv
>    source venv/bin/activate  # Windows: venv\Scripts\activate
>    pip install -r requirements-dev.txt
>    ```
>
> 3. **Configure environment**:
>    ```bash
>    cp .env.example .env
>    # Edit .env with your local settings
>    ```
>
> 4. **Set up database**:
>    ```bash
>    createdb ideaflow_dev
>    alembic upgrade head  # Run migrations
>    ```
>
> 5. **Install pre-commit hooks**:
>    ```bash
>    pre-commit install
>    ```
>
> 6. **Verify setup**:
>    ```bash
>    pytest  # Run tests
>    ```

### Configuration

**Environment Variables**:

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| [VAR] | [Yes/No] | [Value] | [Description] |

**Example**:
> | Variable | Required | Default | Description |
> |----------|----------|---------|-------------|
> | `DATABASE_URL` | Yes | - | PostgreSQL connection string |
> | `REDIS_URL` | No | `redis://localhost` | Redis connection string |
> | `SECRET_KEY` | Yes | - | Session encryption key |
> | `DEBUG` | No | `false` | Enable debug mode |
> | `LOG_LEVEL` | No | `INFO` | Logging verbosity |

---

## Testing Approach

### Test Pyramid

**Strategy**: [High-level testing philosophy]

**Distribution**:
- [Test type]: [Percentage and purpose]

**Example**:
> **Strategy**: Emphasize fast, isolated unit tests; fewer integration tests; minimal E2E
>
> **Distribution**:
> - **Unit Tests** (70%): Fast, isolated, test individual functions/classes
> - **Integration Tests** (20%): Test component interactions (DB, API, services together)
> - **E2E Tests** (10%): Critical user flows only (expensive to run/maintain)

### Test Organization

**Structure**: [How tests are organized]

**Example**:
> **Structure**: Mirror source structure in `tests/` directory
>
> ```
> tests/
> ├── unit/
> │   ├── test_idea_service.py
> │   ├── test_collection_service.py
> │   └── ...
> ├── integration/
> │   ├── test_api_ideas.py
> │   ├── test_database.py
> │   └── ...
> ├── e2e/
> │   ├── test_idea_workflow.py
> │   └── ...
> └── conftest.py  # Shared fixtures
> ```

### Running Tests

**Commands**:

**Example**:
> **Commands**:
>
> ```bash
> # Run all tests
> pytest
>
> # Run specific test file
> pytest tests/unit/test_idea_service.py
>
> # Run specific test
> pytest tests/unit/test_idea_service.py::test_create_idea
>
> # Run with coverage
> pytest --cov=src --cov-report=term-missing
>
> # Run only fast tests (skip integration/E2E)
> pytest -m "not slow"
>
> # Run in parallel (faster)
> pytest -n auto
> ```

### Coverage Requirements

**Minimum Coverage**: [Percentage]

**Exceptions**: [What's excluded]

**Example**:
> **Minimum Coverage**: 80% overall, 90% for new code
>
> **Exceptions**:
> - Test files themselves
> - Migration scripts
> - Configuration files
> - `__init__.py` files
>
> **Enforcement**: CI fails if coverage drops below threshold

### Test Fixtures & Mocking

**Approach**: [How to handle test data and dependencies]

**Example**:
> **Approach**: Use pytest fixtures for setup, mock external services
>
> **Fixtures** (in `conftest.py`):
> - `db_session`: Database session with automatic rollback
> - `test_user`: Standard test user
> - `test_ideas`: Sample ideas for testing
>
> **Mocking**:
> - Mock external APIs (OAuth providers, etc.)
> - Use in-memory database for unit tests (SQLite)
> - Use Docker containers for integration tests (PostgreSQL)
> - Don't mock what you own (test real code paths)
>
> **Example**:
> ```python
> def test_create_idea_with_tags(db_session, test_user):
>     # Arrange
>     content = "Build spaceship"
>     tags = ["project", "space"]
>
>     # Act
>     idea = create_idea(content, test_user.id, tags)
>
>     # Assert
>     assert idea.content == content
>     assert len(idea.tags) == 2
> ```

---

## Code Quality

### Linting

**Tools**:
- [Tool and purpose]

**Configuration**: [Where configuration lives]

**Example**:
> **Tools**:
> - **Ruff**: Fast Python linter (replaces flake8, isort, etc.)
> - **mypy**: Static type checker
> - **prettier**: Frontend code formatter
> - **eslint**: Frontend linter
>
> **Configuration**:
> - Python: `pyproject.toml` and `mypy.ini`
> - Frontend: `.prettierrc` and `.eslintrc.json`
>
> **Running**:
> ```bash
> # Python
> ruff check .       # Lint
> ruff format .      # Format
> mypy src/          # Type check
>
> # Frontend
> npm run lint       # ESLint
> npm run format     # Prettier
> ```

### Pre-commit Hooks

**Hooks Installed**:
- [Hook 1 and what it checks]

**Example**:
> **Hooks Installed**:
> - `ruff`: Format Python code
> - `mypy`: Type check Python code
> - `trailing-whitespace`: Remove trailing whitespace
> - `end-of-file-fixer`: Ensure files end with newline
> - `check-yaml`: Validate YAML syntax
>
> **Configuration**: `.pre-commit-config.yaml`
>
> **Skip Hooks** (if necessary):
> ```bash
> git commit --no-verify -m "Message"  # Skip all hooks
> SKIP=mypy git commit -m "Message"    # Skip specific hook
> ```

### Code Review Standards

**What Reviewers Check**:
- [Check 1]
- [Check 2]

**Example**:
> **What Reviewers Check**:
> - Code follows style guide (should be enforced by linters)
> - Tests included and passing
> - No obvious bugs or security issues
> - Appropriate error handling
> - Clear naming and structure
> - Documentation updated if needed
>
> **Review Timing**: Reviews within 24 hours (during work week)

---

## CI/CD Pipeline

### Continuous Integration

**Platform**: [CI platform, e.g., GitHub Actions]

**Triggers**:
- [When CI runs]

**Pipeline Steps**:

**Example**:
> **Platform**: GitHub Actions
>
> **Triggers**:
> - Every push to any branch
> - Every pull request
>
> **Pipeline Steps** (`.github/workflows/ci.yml`):
> 1. **Setup**: Install Python, Node, dependencies
> 2. **Lint**: Run ruff, mypy, eslint
> 3. **Test**: Run pytest with coverage
> 4. **Build**: Build frontend assets
> 5. **Security**: Run bandit (security linter)
> 6. **Report**: Upload coverage to Codecov
>
> **Duration**: ~3-5 minutes
>
> **Required Status**: All checks must pass before merge

### Continuous Deployment

**Environments**:

| Environment | Trigger | Approval | URL |
|-------------|---------|----------|-----|
| [Environment] | [When deployed] | [Required?] | [URL] |

**Example**:
> | Environment | Trigger | Approval | URL |
> |-------------|---------|----------|-----|
> | Development | Every commit to main | Auto | dev.example.com |
> | Staging | Every commit to main | Auto | staging.example.com |
> | Production | Manual trigger | Required | example.com |
>
> **Deployment Process**:
> 1. Build Docker image
> 2. Run database migrations (if any)
> 3. Deploy new containers (blue-green)
> 4. Run smoke tests
> 5. Switch traffic to new containers
> 6. Keep old containers for 1 hour (rollback capability)
>
> **Rollback**: Manual trigger, reverts to previous version

---

## Database Management

### Migrations

**Tool**: [Migration tool]

**Workflow**:

**Example**:
> **Tool**: Alembic (SQLAlchemy migrations)
>
> **Workflow**:
>
> 1. **Create migration** (after model changes):
>    ```bash
>    alembic revision --autogenerate -m "Add tags table"
>    ```
>
> 2. **Review migration file** (in `migrations/versions/`):
>    - Check generated SQL makes sense
>    - Add data migrations if needed
>    - Test locally
>
> 3. **Apply migration**:
>    ```bash
>    alembic upgrade head  # Local
>    ```
>
> 4. **Rollback** (if needed):
>    ```bash
>    alembic downgrade -1  # Undo last migration
>    ```
>
> **CI/CD**: Migrations run automatically during deployment (before new code deploys)

### Backups

**Strategy**: [Backup approach]

**Example**:
> **Strategy**: Automated daily backups, retained for 30 days
>
> **Schedule**:
> - Full backup: Daily at 2 AM UTC
> - Incremental: Every 6 hours
>
> **Retention**:
> - Daily: 7 days
> - Weekly: 4 weeks
> - Monthly: 12 months
>
> **Restore Process**: [Link to runbook or knowledge note]

---

## Monitoring & Logging

### Logging

**Levels**: [Log levels and when to use]

**Format**: [Log format]

**Example**:
> **Levels**:
> - `DEBUG`: Detailed diagnostic info (dev only)
> - `INFO`: General informational messages
> - `WARNING`: Warning messages (nothing broken, but attention needed)
> - `ERROR`: Error messages (something failed)
> - `CRITICAL`: Critical errors (system unstable)
>
> **Format**: Structured JSON logging
> ```json
> {
>   "timestamp": "2025-10-21T10:30:00Z",
>   "level": "INFO",
>   "message": "Idea created",
>   "user_id": 42,
>   "idea_id": 123,
>   "request_id": "abc-123"
> }
> ```
>
> **Sensitive Data**: Never log passwords, tokens, or PII

### Monitoring

**Tools**: [Monitoring tools]

**Metrics Tracked**:
- [Metric 1]

**Example**:
> **Tools**: Prometheus (metrics), Grafana (dashboards), Sentry (errors)
>
> **Metrics Tracked**:
> - Request rate (req/sec)
> - Response time (p50, p95, p99)
> - Error rate (%)
> - Database query time
> - Cache hit rate
> - Active users
>
> **Alerts**:
> - Error rate > 1%
> - P95 latency > 500ms
> - Database connections > 80%

---

## Development Workflow

### Day-to-Day Workflow

**Example**:
> 1. **Pick a task**: From task tracker, assign to yourself
> 2. **Create branch**: `git checkout -b feature/task-123-description`
> 3. **Develop**:
>    - Write code
>    - Write tests
>    - Run tests locally: `pytest`
>    - Run linter: `ruff check .`
> 4. **Commit**: Follow commit conventions
> 5. **Push**: `git push origin feature/task-123-description`
> 6. **Create PR**: Include summary, testing notes, task reference
> 7. **Address review feedback** (if any)
> 8. **Merge**: Squash and merge when approved
> 9. **Verify**: Check staging environment after auto-deploy

### Common Tasks

**Commands**:

**Example**:
> ```bash
> # Start development server
> uvicorn src.main:app --reload
>
> # Run tests
> pytest
>
> # Format code
> ruff format .
>
> # Type check
> mypy src/
>
> # Create migration
> alembic revision --autogenerate -m "Description"
>
> # Apply migrations
> alembic upgrade head
>
> # Start services (Docker)
> docker-compose up -d
> ```

---

## Troubleshooting

### Common Issues

**Issue**: [Problem description]
**Solution**: [How to fix]

**Example**:
> **Issue**: Tests fail with database connection error
> **Solution**: Ensure PostgreSQL is running and `DATABASE_URL` is set correctly
>
> **Issue**: Pre-commit hooks fail
> **Solution**: Run `pre-commit install` to reinstall hooks
>
> **Issue**: Migrations fail to apply
> **Solution**: Check for conflicting migrations, may need to rollback and recreate

---

## Version History

<!--
Track significant changes to development practices.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial development design created
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.1
> - Added pre-commit hooks
> - Updated CI pipeline to include security scanning
> - Changed from feature-branch to trunk-based development
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial development design created
> - Status: APPROVED (2025-10-07)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Set Status to DRAFT
5. Update "Last Reviewed" to current date

**Key Reminders**:
- Be **specific** with commands and processes
- Keep it **current** as workflows evolve
- Link to **external docs** for complex setups
- Document **common issues** as they arise
- Include **actual commands** that developers will run

**What Goes Here vs. Other Docs**:
- ✅ Development workflow, branching, commits
- ✅ Testing strategy and requirements
- ✅ CI/CD pipeline and deployment
- ✅ Development environment setup
- ✅ Monitoring and logging approach
- ❌ Code style rules (→ code_style_guide.md)
- ❌ Architecture details (→ technical_design.md)
- ❌ Technology choices (→ technology_stack.md)
