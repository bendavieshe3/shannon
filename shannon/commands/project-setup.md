# /project-setup

Initialize or update project documentation system.

**Idempotent**: Safe to run multiple times. Detects what exists and only updates what's needed.

## Configuration

**Shannon installation paths** (change these if using global installation):

```
SHANNON_TEMPLATE_PATH="./.claude/templates"
SHANNON_COMMANDS_PATH="./.claude/commands"
SHANNON_GUIDES_PATH="./.claude/guides"
```

For global installation, use: `~/.claude/shannon/templates`, `~/.claude/shannon/commands`, `~/.claude/shannon/guides`

## Pre-Execution Check

**Before proceeding, check if project is under version control**:

1. Run `git status` to check for uncommitted changes
2. If there are uncommitted changes:
   ```
   ⚠️ You have uncommitted changes in your repository.

   It's recommended to commit your work before running /project-setup.
   This creates a clean checkpoint to revert to if needed.

   Options:
   a) Commit changes now (recommended)
   b) Stash changes and proceed
   c) Proceed anyway (not recommended)
   d) Cancel /project-setup

   Your choice: _
   ```

3. If user chooses (a), pause and wait for commit, then resume
4. If user chooses (b), run `git stash` before proceeding
5. If user chooses (c), warn and continue
6. If user chooses (d), exit command

**If not under version control**:
- Note: "Project is not a git repository. Consider running `git init` to track documentation changes."
- Proceed normally

## What it does (intelligent detection)

This command adapts based on what already exists in your project:

### Detection Phase

1. **Check ./docs/ directory**:
   - Doesn't exist → Full setup mode
   - Exists but empty → Create structure and documents
   - Exists with documents → Update mode

2. **Check mandated documents** (in ./docs/):
   - For each: product_requirements.md, technology_stack.md, conceptual_design.md, technical_design.md, code_style_guide.md, ux_style_guide.md, documentation_style_guide.md, development_design.md
   - Missing → Create from template
   - Exists → Skip (don't overwrite, unless user requests update)

3. **Check CLAUDE.md**:
   - Doesn't exist → Create from template
   - Exists without doc system → Merge in documentation sections
   - Exists with doc system → Update sections, check contradictions, refresh Quick Reference
   - Exists and current → Only refresh Quick Reference

4. **Check index files**:
   - Missing → Create empty
   - Exists → Verify format, offer to update if outdated

5. **Check directory structure**:
   - ./docs/features/, ./docs/tasks/, ./docs/tasks/archive/, ./docs/knowledge/, ./docs/knowledge/research/, ./docs/knowledge/implementation-details/

### Execution Phase

Based on detection results, execute appropriate actions:

#### Scenario 1: First-Time Setup (./docs/ doesn't exist)

1. **Gather project information**:
   - Ask: Project name
   - Ask: Product vision (1-2 sentences)
   - Ask: Primary language/framework
   - Ask: Additional technologies (optional)

2. **Create directory structure**:
   ```
   ./docs/
   ├── product_requirements.md
   ├── technology_stack.md
   ├── conceptual_design.md
   ├── technical_design.md
   ├── code_style_guide.md
   ├── ux_style_guide.md
   ├── documentation_style_guide.md
   ├── development_design.md
   ├── features/
   │   └── feature_index.md
   ├── tasks/
   │   ├── task_index.md
   │   └── archive/
   └── knowledge/
       ├── knowledge_index.md
       ├── research/
       ├── implementation-details/
       └── [doc-name]-extra/  (created as needed)
   ```

3. **Instantiate mandated documents**:
   - Copy from SHANNON_TEMPLATE_PATH
   - Replace [placeholders]:
     * [Your Project Name] → {project name}
     * [Brief description] → {product vision}
     * [Primary language] → {language/framework}
   - Remove example blocks (marked "**Example**:")
   - Remove "Notes for Using This Template" sections
   - Set Status: DRAFT
   - Set "Last Reviewed": {current date}

4. **Deploy templates to home directories**:
   - Copy TASK-XXX.md → ./docs/tasks/TASK-XXX.md (task template)
   - Copy FEAT-XXX.md → ./docs/features/FEAT-XXX.md (feature template)
   - Copy knowledge_note.md → ./docs/knowledge/knowledge_note.md (knowledge note template)
   - Copy task_index.md → ./docs/tasks/task_index.md (empty, just headers)
   - Copy feature_index.md → ./docs/features/feature_index.md (empty, just headers)
   - Copy knowledge_index.md → ./docs/knowledge/knowledge_index.md (empty, just headers)
   - These templates can be customized per-project (e.g., add security checklist to TASK-XXX.md)

5. **Create CLAUDE.md**:
   - Copy from SHANNON_TEMPLATE_PATH/CLAUDE.md
   - Fill in project name and vision
   - **Generate Quick Reference** (see Quick Reference Generation below)
   - Remove example blocks

6. **Create/update .gitignore**:
   - Add language-specific patterns
   - Ensure ./docs/ is NOT ignored (commit documentation)
   - Ensure CLAUDE.md is NOT ignored (commit AI guidance)

7. **Report results**:
   - ✅ Created ./docs/ with 8 mandated documents (all DRAFT)
   - ✅ Created CLAUDE.md with documentation system guidance
   - ✅ Deployed templates to ./docs/tasks/, ./docs/features/, ./docs/knowledge/
   - ✅ Created index files
   - **Next steps**:
     * Review/approve: `/document-review product_requirements.md`
     * Create first feature: `/feature-create`

#### Scenario 2: Existing Project (./docs/ exists, no CLAUDE.md doc system)

1. **Scan existing setup**:
   - List existing mandated documents
   - List missing mandated documents
   - Check if CLAUDE.md exists

2. **Create missing documents**:
   - For each missing mandated doc:
     * Ask: "Create {doc_name}.md from template?"
     * If yes: Create with placeholders (Status: DRAFT)
     * If no: Skip

3. **Handle CLAUDE.md**:

   **If CLAUDE.md doesn't exist**:
   - Create from template (same as Scenario 1)
   - Generate Quick Reference from existing style guides

   **If CLAUDE.md exists**:
   - Read existing content
   - Parse into sections
   - Check for documentation system markers:
     * `## Documentation System`
     * `## Critical Guardrails`
     * `## Three Quality Gates`
     * Mentions of `/task-ready`, `/feature-create`, etc.

   **If NO doc system markers found**:
   - Show: "Your CLAUDE.md exists but doesn't include documentation system guidance."
   - Ask: "Add documentation system sections?"
   - If yes:
     * Parse existing sections
     * Append documentation system sections:
       - ## Quick Reference (auto-generated)
       - ## Documentation System
       - ## Critical Guardrails
       - ## Three Quality Gates
       - ## Workflow Examples
       - ## Common Mistakes to Avoid
     * Add separator (---) before new sections
     * Preserve ALL existing content
     * Create backup: CLAUDE.md.backup.{timestamp}

   **If doc system markers found**:
   - Proceed to Scenario 3 (update existing)

4. **Create missing directories**:
   - Check for ./docs/features/, tasks/, knowledge/ etc.
   - Create if missing

5. **Report results**:
   - List what was created/updated
   - List what was skipped
   - Next steps

#### Scenario 3: Update Existing (./docs/ exists, CLAUDE.md has doc system)

1. **Detect current state**:
   - Parse CLAUDE.md sections
   - Identify template sections vs custom sections
   - Check Quick Reference freshness (compare to style guides)
   - Detect potential contradictions

2. **Check for contradictions**:

   **Contradiction patterns to detect**:
   - "Skip documentation" / "Don't document" → Contradicts system
   - "Just implement" / "Quick fixes without planning" → Missing Gate 2
   - "No tests needed" → Contradicts style guides
   - "Bypass review" / "Direct commits" → Missing Gate 3
   - "Don't create tasks" → Contradicts workflow

   **For each contradiction found**:
   ```
   ⚠️ Potential contradiction detected in section "## {Section Name}"

   Existing content:
   ┌─────────────────────────────────────────────────
   │ {contradictory text excerpt}
   └─────────────────────────────────────────────────

   This may contradict the documentation system which requires:
   {explanation of what system requires}

   Options:
   a) Review section (show full content, edit manually)
   b) Remove section (delete contradictory content)
   c) Keep as-is (override - not recommended)
   d) Skip for now (leave unchanged)

   Your choice: _
   ```

3. **Update Quick Reference**:
   - Read current style guides (code_style_guide.md, ux_style_guide.md, documentation_style_guide.md)
   - Extract quick reference rules (see Quick Reference Generation below)
   - Update ## Quick Reference section in CLAUDE.md
   - Preserve any custom additions user made to Quick Reference

4. **Update template sections** (if template changed):
   - Ask: "Documentation system template has updates. Review changes?"
   - If yes:
     * Show diff for each template section
     * Options per section:
       a) Update to latest (replace with template version)
       b) Keep current (preserve existing)
       c) Show full diff (detailed comparison)
   - Create backup before updating: CLAUDE.md.backup.{timestamp}

5. **Preserve custom sections**:
   - Any section NOT matching template headers → Keep unchanged
   - Project Overview (if different from template) → Keep
   - Project-Specific Notes → Keep
   - Custom Guidelines → Keep

6. **Report results**:
   - ✅ Updated Quick Reference from style guides
   - ✅ Updated {N} template sections
   - ✅ Preserved {N} custom sections
   - ✅ Backup saved: CLAUDE.md.backup.{timestamp}
   - ⚠️ Found {N} potential contradictions (reviewed: {N}, skipped: {N})

### Quick Reference Generation

When creating/updating Quick Reference section:

1. **Read style guides**:
   - ./docs/code_style_guide.md
   - ./docs/ux_style_guide.md
   - ./docs/documentation_style_guide.md

2. **Extract rules**:

   **For code_style_guide.md**:
   - Language/version (from ## {Language} Style or technology_stack.md)
   - Naming conventions (look for "Naming Conventions" table or section)
   - Type hints policy (look for "Type Hints" section)
   - Test requirements (look for "Testing Standards" section)
   - Pre-commit commands (look for "Linting" or "Running Checks")

   **For ux_style_guide.md**:
   - Primary colors (from "Color Palette" section)
   - Typography (from "Typography" section)
   - Spacing system (from "Spacing" section)
   - Component library (from overview or frameworks mentioned)
   - Accessibility requirements (from "Accessibility" section)

   **For documentation_style_guide.md**:
   - Voice/tone (from "Voice & Tone" or "Person & Perspective")
   - Sentence structure rules (from "Sentence Structure")
   - Code block formatting (from "Code Examples")
   - Example approach (from "Code Examples" or general guidance)

3. **Generate Quick Reference**:
   - Format as bulleted list (max 5 items per guide)
   - Keep each bullet to one line (~60-80 chars)
   - Use concrete values, not descriptions
   - Link to full guide

4. **Insert into CLAUDE.md**:
   - Replace content between `<!-- QUICK_REF_START: {guide} -->` and `<!-- QUICK_REF_END: {guide} -->`
   - Preserve markers (used for future updates)

### Section Detection

**Template sections** (identified for update):
- `## Quick Reference` (auto-generated)
- `## Documentation System`
- `## Critical Guardrails`
- `## Three Quality Gates`
- `## Workflow Examples`
- `## Common Mistakes to Avoid`
- `## Getting Help`

**Custom sections** (preserved):
- Any section with header NOT in template list
- `## Project Overview` (if content differs from template)
- `## Project-Specific Notes`
- Any section starting with "Project", "Custom", or technology names

**Heuristic rules**:
- Exact header match → Template section (update)
- Contains "/task-" or "/feature-" commands → Template section
- Contains project-specific tech/tools → Custom section
- When uncertain → Ask user

### Merge Strategy

```
[Preserved: Existing CLAUDE.md header and Project Overview]

---

## Quick Reference
[Auto-generated from style guides]

## Documentation System
[Template - updated if changed]

## Critical Guardrails
[Template - updated if changed]

## Three Quality Gates
[Template - updated if changed]

## Workflow Examples
[Template - updated if changed]

## Common Mistakes to Avoid
[Template - updated if changed]

[Preserved: Any custom sections from existing CLAUDE.md]

---

## Getting Help
[Template - updated if changed]

[Preserved: Any trailing custom content]
```

## Example Usage

### New Project
```bash
/project-setup
```
Prompts for project info, creates everything from scratch.

### Existing Project (Adding Doc System)
```bash
/project-setup
```
Detects existing CLAUDE.md, offers to merge in doc system sections.

### Refresh After Template Update
```bash
/project-setup
```
Detects current setup, updates Quick Reference, offers to update template sections.

### After Changing Style Guides
```bash
/project-setup
```
Auto-updates Quick Reference in CLAUDE.md from modified style guides.

## Safety Features

1. **Git safety checks** (if under version control)
   - Checks for uncommitted changes before starting
   - Offers to commit or stash before proceeding
   - Prompts to commit documentation system after completion
   - Creates clean checkpoints for easy rollback

2. **Always creates backup** before modifying CLAUDE.md
   - Format: `CLAUDE.md.backup.YYYY-MM-DD-HH-MM-SS`
   - Timestamped to prevent overwriting previous backups

3. **Shows preview** before major changes
   - Displays what will be added/modified
   - User confirmation required

4. **Never overwrites** mandated documents
   - If document exists, asks before updating
   - Offers to show template changes

5. **Detects contradictions** before merging
   - Reviews each contradictory section with user
   - Options to resolve (edit, remove, keep, skip)

6. **Idempotent operation**
   - Running multiple times is safe
   - Only updates what changed
   - Preserves custom content

## Post-Execution: Commit Changes

**After successful completion, commit the documentation system**:

1. **Review what changed**:
   ```bash
   git status
   git diff
   ```

2. **Show summary of created/modified files**:
   ```
   ✅ /project-setup completed successfully!

   Created/modified files:
   - ./docs/*.md (8 mandated documents)
   - ./docs/tasks/TASK-XXX.md, task_index.md
   - ./docs/features/FEAT-XXX.md, feature_index.md
   - ./docs/knowledge/knowledge_note.md, knowledge_index.md
   - CLAUDE.md [created|updated]

   Recommendation: Commit these changes to create a documentation checkpoint.
   ```

3. **Prompt for commit**:
   ```
   Ready to commit documentation system? (y/n): _
   ```

4. **If yes, create commit**:
   ```bash
   git add ./docs/ CLAUDE.md .gitignore
   git commit -m "Add Shannon documentation system

   - Created 8 mandated documents (all DRAFT status)
   - Deployed templates to ./docs/tasks/, ./docs/features/, ./docs/knowledge/
   - [Created|Updated] CLAUDE.md with documentation system guidance

   Next steps:
   - Review/approve: /document-review product_requirements.md
   - Create first feature: /feature-create

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

5. **If no**:
   ```
   Skipped commit. Remember to commit these changes before continuing development.
   ```

**If not under version control**:
- Remind: "Consider running `git init` and committing to track documentation changes over time."

## Notes

- **First run**: Creates complete documentation system
- **Subsequent runs**: Updates only what changed (Quick Reference, template sections if updated)
- **Rollback**: Restore from `CLAUDE.md.backup.{timestamp}` if needed
- **Template location**: Configured in SHANNON_TEMPLATE_PATH (default: `./.claude/templates/`)
- **Safe frequency**: Run after template updates or style guide changes
- **Status**: All new mandated documents created with Status: DRAFT

## What This Command Does NOT Do

- ❌ Overwrite existing mandated documents without asking
- ❌ Delete custom sections from CLAUDE.md
- ❌ Modify code or implementation files
- ❌ Create features or tasks (use dedicated commands)
- ❌ Auto-approve DRAFT documents (use `/document-review`)
