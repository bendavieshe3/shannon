# Documentation Style Guide

**Status**: DRAFT
**Last Reviewed**: [Current date in YYYY-MM-DD format]

---

**Project Name**: [Name of the product]

## Overview

This guide defines writing standards for all project documentation. It applies to README files, user guides, API documentation, mandated documents (product requirements, technical design, etc.), knowledge base notes, and all other written content.

The goal is clear, consistent, professional documentation that helps readers accomplish tasks quickly.

---

## Scope

### This Guide Applies To:

This guide defines writing quality standards for all project documentation where clarity and consistency matter.

**Documentation types**:
- README.md and installation guides
- User guides and tutorials
- API documentation and reference guides
- **Project documentation** (product requirements, technical design, style guides, etc.)
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
- Action-oriented for how-tos: "Install the app" (not "Installation")
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
To create a feature, run the command:
```bash
create-feature "User Authentication"
```
```

❌ **Bad**:
```markdown
```bash
# Create a feature
create-feature "User Authentication"
```
```

**Exception**: Comments are acceptable for multi-step examples to separate logical sections

---

## Formatting Conventions

### Text Formatting

| Element | Format | Example |
|---------|--------|---------|
| Code (inline) | Backticks | Use `create_feature()` to create |
| File paths | Backticks | Edit `docs/product_requirements.md` |
| UI elements | Bold | Click **Save** button |
| Commands | Code blocks or backticks | Run `npm install` |
| Menu paths | Bold with → | Go to **File → Save As** |
| Emphasis | Italic | This is *important* to remember |
| Strong emphasis | Bold | This is **critical** for success |

### Lists

**Numbered lists**: Use for sequences, steps, or ordered items
1. First, install the application
2. Next, configure your settings
3. Finally, run the initialization command

**Bulleted lists**: Use for unordered items
- Feature overview
- System requirements
- Configuration options

**Formatting**:
- Capitalize first word of each item
- Use periods if items are complete sentences
- No periods for fragments or short phrases
- Use parallel structure (all verbs, all nouns, etc.)

### Links

**Style**: Use descriptive link text (not "click here")

✅ "See the [installation guide](./install.md) for details"
✅ "Read more about [configuration](./config.md#advanced)"

❌ "Click [here](./install.md) for more info"
❌ "More info [here](./config.md)"

### Tables

**When to use**: For structured reference information (not long prose)

**Format**:
- Left-align text columns
- Right-align number columns
- Keep cell content short
- Include header row

| Command | Purpose |
|---------|---------|
| `init` | Initialize project |
| `build` | Build project |
| `test` | Run tests |

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
**Note**: Configuration files use JSON format.

**Warning**: Deleting this file cannot be undone.
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
- **Question headings**: "How do I configure settings?" → "Configure settings"
- **Outdated examples**: Keep examples current with latest version
- **Missing error cases**: Show what success AND failure look like
- **Inconsistent terminology**: Pick one term and stick with it throughout documentation

---

## Special Instructions

<!-- Project-specific writing rules that override or extend the defaults above -->

[Leave this section empty if the defaults work for your project. Add project-specific rules only when needed.]

**Examples of when to add special instructions**:
- Industry-specific terminology requirements
- Brand voice guidelines that differ from defaults
- Regulatory or legal compliance requirements
- Audience-specific adjustments (highly technical vs. beginner-friendly)
- Language localization considerations

---

## Version History

### [YYYY-MM-DD] - v1.0
- Initial documentation style guide created with best-practice defaults
- Status: DRAFT (pending review)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace `[Name of the product]` with your project name
2. Review the defaults - they should work for most projects
3. Only add to "Special Instructions" if you need project-specific overrides
4. Remove this "Notes for Using This Template" section
5. Set Status to DRAFT
6. Update "Last Reviewed" to current date

**Key Philosophy**:
- **Defaults work out-of-the-box** - No customization needed for most projects
- **Customize only when necessary** - Use "Special Instructions" for exceptions
- **Focus on writing quality** - This guide ensures clear, professional prose
- **Templates define structure** - Individual document templates define required sections
