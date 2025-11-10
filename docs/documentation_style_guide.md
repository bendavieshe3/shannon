# Documentation Style Guide

**Status**: DRAFT
**Last Reviewed**: 2025-11-09

---

**Project Name**: Shannon

## Overview

This guide defines writing standards for all Shannon documentation. It applies to README files, user guides (shannon/guides/), command documentation (shannon/commands/), mandated documents (product requirements, technical design, etc.), knowledge base notes, and all other written content.

The goal is clear, consistent, professional documentation that helps developers accomplish tasks quickly.

---

## Scope

### This Guide Applies To:

This guide defines writing quality standards for all Shannon documentation where clarity and consistency matter.

**Documentation types**:
- README.md and installation guides
- User guides and tutorials (shannon/guides/)
- Command documentation (shannon/commands/)
- **Mandated documents** (product_requirements.md, technical_design.md, code_style_guide.md, ux_style_guide.md, documentation_style_guide.md, development_design.md, technology_stack.md, conceptual_design.md)
- Knowledge base notes and how-to articles
- Release notes and changelogs
- Troubleshooting guides

**Writing quality covered**:
- Voice & tone
- Active vs. passive voice
- Sentence structure and clarity
- Text formatting (bold, italic, code, links)
- List and table formatting
- Common writing pitfalls to avoid

### This Guide Does NOT Cover:

- **Code comments and docstrings** → See code_style_guide.md
- **Markdown syntax basics** → Assumes basic markdown knowledge
- **API response formats** → See technical_design.md or API specifications
- **Commit message format** → See development_design.md

---

## Writing Style

### Voice & Tone

**Voice**: Professional but approachable, like a helpful colleague

**Tone**: Varies by context:
- **Tutorials**: Encouraging and supportive
- **Reference docs**: Neutral and precise
- **Error messages**: Solution-focused and clear
- **Release notes**: Matter-of-fact with enthusiasm for major features

### Person & Perspective

**Use**: Second person ("you/your") for user-facing documentation

✅ "You can create a feature by running `/feature-create`"
✅ "Your data is stored in the docs/ directory"

**Avoid**:
- ❌ Third person: "The user can create features..." (too formal)
- ❌ First person plural: "We can create features..." (ambiguous who "we" is)
- ❌ Passive voice: "Features can be created..." (unclear who does it)

### Active vs. Passive Voice

**Preference**: Active voice (subject performs action)

✅ "Run `/project-setup` to initialize the project"
✅ "The system deletes completed tasks after 90 days"

❌ "The project can be initialized by running `/project-setup`"
❌ "Completed tasks are deleted after 90 days"

**Exception**: Use passive when the actor is unknown or unimportant
- ✅ "Your data is encrypted at rest" (who encrypts doesn't matter to the user)

### Sentence Structure

**Guidelines**:
- **Short sentences**: Aim for 15-20 words per sentence
- **One idea per sentence**: Don't cram multiple concepts together
- **Simple words**: Use "use" not "utilize", "help" not "facilitate", "start" not "initiate"
- **Concrete nouns**: Prefer specific terms over abstract language
- **Action verbs**: "Create", "Run", "Edit", "Delete" (not "perform", "execute", "conduct")

---

## Document Structure

### Headings

**Hierarchy**:
- H1 (`#`): Document title (one per page)
- H2 (`##`): Major sections
- H3 (`###`): Subsections
- H4 (`####`): Rare, only if truly necessary

**Style**:
- Use sentence case: "Getting started with features" (not "Getting Started With Features")
- Be descriptive: "Create your first feature" (not "Next steps")
- Action-oriented for how-tos: "Install Shannon" (not "Installation")
- Front-load keywords for scanning: "Features: Create and manage" (not "Create and manage features")

### Working with Template Documents

**When filling in mandated documents from templates**:

**Progressive approach** (recommended):
- Fill in sections as you develop understanding
- When you add actual content to a section, remove that section's example block
- Keep examples for unfilled sections as reference
- Mark document DRAFT until substantially complete
- Gradually refine and approve sections over time

**What to remove when filling in sections**:
- Example blocks (marked with "**Example**:")
- Placeholder text (marked with `[placeholders]`)
- Template instructions that don't apply to your project

---

## Code Examples

### Format

**Language specification**: Always specify language in code blocks

````markdown
```python
def create_feature(name: str) -> Feature:
    return Feature(name=name)
```
````

**Context**: Include enough context to be runnable or understandable
- ✅ Show imports if needed
- ✅ Show variable declarations
- ✅ Use realistic values from your domain
- ❌ Don't use generic placeholders like `foo`, `bar` - use domain terms

### Explanation

**Approach**: Explain before or after the code block, not in code comments

✅ **Good**:
```markdown
To create a feature, run the `/feature-create` command:
```
/feature-create "Easy to Setup"
```
```

❌ **Bad**:
```markdown
```bash
# Create a feature
/feature-create "Easy to Setup"
```
```

**Exception**: Comments are acceptable for multi-step examples to separate logical sections

---

## Formatting Conventions

### Text Formatting

| Element | Format | Example |
|---------|--------|---------|
| Code (inline) | Backticks | Use `/feature-create` to create |
| File paths | Backticks | Edit `docs/product_requirements.md` |
| UI elements | Bold | Click **Save** button |
| Commands | Code blocks or backticks | Run `/project-setup` |
| Menu paths | Bold with → | Go to **File → Save As** |
| Emphasis | Italic | This is *important* to remember |
| Strong emphasis | Bold | This is **critical** for success |

### Lists

**Numbered lists**: Use for sequences, steps, or ordered items
1. First, run `/project-setup`
2. Next, review the generated documents
3. Finally, approve with `/document-review`

**Bulleted lists**: Use for unordered items
- Automated context management
- Strategic human review gates
- Complete traceability

**Formatting**:
- Capitalize first word of each item
- Use periods if items are complete sentences
- No periods for fragments or short phrases
- Use parallel structure (all verbs, all nouns, etc.)

### Links

**Style**: Use descriptive link text (not "click here")

✅ "See the [feature creation guide](./features_how_to.md) for details"
✅ "Read more about [task lifecycle](./tasks_how_to.md#lifecycle)"

❌ "Click [here](./features_how_to.md) for more info"
❌ "More info [here](./tasks_how_to.md)"

### Tables

**When to use**: For structured reference information (not long prose)

**Format**:
- Left-align text columns
- Right-align number columns
- Keep cell content short
- Include header row

| Command | Purpose |
|---------|---------|
| `/project-setup` | Initialize project structure |
| `/feature-create` | Create new feature |
| `/task-ready` | Plan task implementation |

---

## Special Elements

### Admonitions / Callouts

**Types**:
- **Note**: Additional information (helpful but not critical)
- **Tip**: Suggestions for better results
- **Warning**: Important caveats (could cause problems if ignored)
- **Caution**: Potential data loss or security issues

**Format**:
```markdown
**Note**: Documents start as DRAFT and require human approval.

**Warning**: Deleting a feature does not delete its tasks.
```

### Screenshots & Diagrams

**When to include**:
- Complex UI workflows (show don't tell)
- Architecture overviews
- Visual concepts difficult to describe in text

**Format**:
- PNG for screenshots
- SVG for diagrams (editable, scales well)
- Include alt text for accessibility
- Add caption below image
- Store in appropriate directory (e.g., `./docs/images/`)

---

## Common Pitfalls

**Avoid**:
- **Jargon without explanation**: Define technical terms on first use
- **Assuming knowledge**: State prerequisites explicitly
- **Vague words**: "Simply", "just", "easy" (what's easy for you might not be for readers)
- **Future tense in instructions**: "You will click..." → "Click..." (use imperative)
- **Question headings**: "How do I create a feature?" → "Create a feature"
- **Outdated examples**: Keep examples current with latest version
- **Missing error cases**: Show what success AND failure look like
- **Inconsistent terminology**: Pick one term and stick with it (e.g., "feature" vs "capability", "task" vs "work item")

---

## Special Instructions

<!-- Project-specific writing rules that override or extend the defaults above -->

None at this time. The defaults above apply to all Shannon documentation.

---

## Version History

### 2025-11-09 - v2.0
- Radically simplified template with best-practice defaults
- Added "Working with Template Documents" section with progressive approach guidance
- Changed scope to explicitly include mandated documents for writing quality
- Added "Special Instructions" section for project-specific overrides
- Removed all placeholder/example structure - now has complete defaults
- Status: DRAFT (pending review)

### 2025-11-09 - v1.0
- Initial documentation style guide created
- Status: DRAFT (pending review)
