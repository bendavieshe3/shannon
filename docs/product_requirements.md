# Product Requirements Document

**Status**: APPROVED
**Last Reviewed**: 2025-11-09
**Approved By**: Ben Davies

---

## Product Vision

**Product Name**: Shannon

Shannon is a development framework for Claude Code enabling low effort and high quality development project outputs. Easy project installation, automatically maintained documentation, and fully traceable aligned implementation make projects built with Shannon rapidly progress while maintaining coherence, code quality, and alignment to requirements.

Built with solo-developers and knowledge workers in mind, Shannon's command-based implementation allows a state of development flow while shouldering the burdens of documentation, context management, and implementation. 


---

## Personas

<!--
Describe the primary users of this product.
- Include 1-3 key personas
- Focus on needs, pain points, and goals
- Reference these personas throughout the document
-->

### Architect Dev: A Solo-developer with a strong existing vision

**Background**:
- The architect starts using Claude Code and Shannon with a strong existing vision about a product or deliverable they wish to create, such as a conceptual model or interaction flow. 
- The architect may have existing artefacts from other tooling or patterns to use in this product
- The architect likes to move methodically from a solid product requirements document and conceptual design to a forward-looking and thoughtful implementation, prepared in advance for the final product to emerge
- Does not want to review or update code

**Needs**:
- Needs ways and places to define the product to be built
- Needs reliable implementation technology that can leverage the context of the wider product to bring the vision to life
- Needs ways to ensure the continued alignment of the implementation to the vision
- Needs the confidence of requirements-aligned and business domain model test coverage 

**Pain Points** (with current solutions):
- Technical implementations not respecting conceptual models
- Future requirements not being considered in implementations
- Inability to judge alignment of the implementation

**Goals**:
- Build high-quality software that faithfully implements their vision
- Maintain alignment between conceptual design and implementation throughout the project
- Avoid technical debt from shortcuts that ignore future requirements

### Gardener Dev: A Solo-developer with only a weak initial vision for the product; looking to explore the problem and feature space over time

**Background**:
- The Gardener has a simple and unrefined product idea they want to explore using Claude and Shannon
- Through iterative development, they seek to refine their requirements and conceptual model of the product they are attempting to make
- They may hold off on testing and other rigour until they commit to bringing a product to completion
- The Gardener relies on the AI to generate the details of initial requirements, conceptual models and implementations
- The Gardener does not write or review code

**Needs**:
- To be able to iteratively provide additional requirements, starting from a simple starting point
- To be able to align and adjust the implementation and documentation as the product's problem and solution space is explored
- To maintain coherence across documentation even as the vision evolves

**Pain Points** (with current solutions):
- Documentation drift as understanding changes over time
- Losing context between sessions when pivoting direction
- Implementations that don't consider extensibility until it's expensive to add
- Difficulty assessing when to commit to quality practices (testing, etc.)

**Goals**:
- Start simple and add complexity as understanding grows
- Maintain coherent vision even through pivots and direction changes
- Know when the product is ready to transition from exploration to production quality

---

## Product Pillars

<!--
Core principles that guide product decisions.
- Typically 3-6 pillars
- These are enduring values, not features
- Reference when making design trade-offs
-->

### 1. **Automated Context Management**
AI reads and maintains documentation, cross-references, and alignment. Human provides direction and reviews at strategic gates. Shannon shoulders the burden of consistency so developers can focus on vision and decisions.

### 2. **Strategic Human Review**
Three quality gates at high-leverage points: document approval, task planning, and task completion. No micromanagement, no reviewing code. Human reviews plans and outcomes, AI handles implementation details.

### 3. **Complete Traceability**
Clear, maintained connections from product vision → features → tasks → implementation. Every piece of code traces back to a user need. Every feature references product requirements. Nothing gets built without understanding why.

### 4. **Living Documentation**
Documentation evolves with understanding. DRAFT → APPROVED workflow ensures AI uses trusted context. Alignment checks catch drift before it becomes expensive. Knowledge notes capture learnings for future reference.

---

## High-Level User Stories

<!--
Section-based user stories (not numbered requirements).
- Organize by capability area or user journey
- Keep stories high-level (detailed stories go in features)
- Cross-reference implementing features
- Update as features are created
-->

### Project Initialization

Developers need to start new projects quickly with all documentation structure in place. Whether starting from scratch or adding Shannon to existing projects, setup should be intelligent, safe, and idempotent. The system should guide developers through establishing their product vision and initial technical decisions.

**Features**: [Leave empty initially, will be populated as features are created]

### Documentation Maintenance

As projects evolve, documentation must stay aligned with implementation. Developers need automated cross-reference updates, alignment checking between layers (requirements → features → tasks), and intelligent merging when updating documentation templates. The system should detect and prevent documentation drift.

**Features**: [Leave empty initially]

### Feature Development

Developers need to manage persistent product characteristics (features) through a phase-based approach. Each feature should trace back to product requirements and break down into manageable tasks. The system should support both planned (Architect) and exploratory (Gardener) development styles while maintaining coherence.

**Features**: [Leave empty initially]

### Task Execution

Developers need a clear workflow from task creation through completion with AI reading relevant documentation before planning implementation. Tasks should be planned and executed making optimal use of the AI to ensure implementation is aligned, using the optimum context, making best use of extended thinking or other AI features, including subagents where defined. Each task should have explicit acceptance criteria and implementation plans reviewed before work begins. The system should enforce quality gates while keeping developers in flow state.

**Features**: [Leave empty initially]

### Quality Assurance

Developers need confidence that implementations align with requirements without manually reviewing code. Strategic review gates at document approval, task planning, and task completion provide leverage points for quality. Alignment checks should catch drift between conceptual design and technical implementation. Implementation and outputs should align to all of the style guides and development_design.md as applicable.

**Features**: [Leave empty initially]

---

## Scope & Constraints

<!--
OPTIONAL: Include if there are important constraints or explicit non-goals.
Remove this section if not needed.
-->

### In Scope
- Documentation templates for AI-assisted development (8 mandated documents)
- Slash commands for project setup, feature/task lifecycle, and document review
- Automated cross-reference maintenance and alignment checking
- Three-gate quality system (document approval, task planning, task completion)
- Knowledge base for research notes and implementation details
- Intelligent CLAUDE.md merging with Quick Reference auto-generation

### Out of Scope (for now)
- Multi-developer collaboration workflows (designed for solo developers)
- IDE integrations beyond Claude Code
- Automated code review or linting (delegates to project's existing tools)
- Project templates for specific frameworks/languages (Shannon is language-agnostic)
- Real-time documentation generation from code (human-directed documentation)

### Constraints
- Must work as Claude Code slash commands (markdown files in .claude/commands/)
- Must be language/framework agnostic (no technology lock-in)
- Must preserve user customizations when updating templates
- Documentation must be readable as plain text (no complex tooling required)
- Must work offline (local files only, no external services)

---

## Success Metrics

<!--
OPTIONAL: How will we know this product is successful?
Remove this section if not needed for your project.
-->

- Project setup completes in under 5 minutes (from /project-setup to first task)
- AI successfully finds relevant documentation context 95%+ of the time when planning tasks
- Alignment checks catch documentation drift within 2-4 weeks (before it becomes expensive)
- Developers spend <10% of time on documentation maintenance (AI handles the rest)
- Task implementation plans are approved without changes 80%+ of the time (indicates AI read docs correctly)
- Developers can resume work after weeks away and have full context within 10 minutes

---

## Version History

<!--
Track significant changes to this document.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### 2025-11-09 - v1.0
- Initial product requirements for Shannon created
- Defined two personas: Architect Dev and Gardener Dev
- Established four product pillars: Automated Context Management, Strategic Human Review, Complete Traceability, Living Documentation
- Identified five capability areas: Project Initialization, Documentation Maintenance, Feature Development, Task Execution, Quality Assurance
- Updated Task Execution to emphasize optimal AI usage (extended thinking, subagents, context)
- Updated Quality Assurance to specify alignment with style guides and development_design.md
- Removed all example blocks per template guidance
- Status: APPROVED (2025-11-09)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Customize sections as needed (add/remove based on project)
5. Set Status to DRAFT
6. Update "Last Reviewed" to current date

**Key Reminders**:
- This is a **living document** - update as product understanding evolves
- Keep it **high-level** - detailed technical decisions go in technical_design.md
- **Section names** become feature references (e.g., § "Organization & Discovery")
- **No numbered requirements** - sections provide enough structure
- Update **Features** field as features are created via `/feature-create`
- Run `/document-review product_requirements` to mark APPROVED after human review

**What Goes Here vs. Other Docs**:
- ✅ Product vision, user needs, why we're building this
- ✅ User personas and pain points
- ✅ High-level capabilities needed
- ❌ Technical architecture (→ technical_design.md)
- ❌ Technology choices (→ technology_stack.md)
- ❌ Domain model details (→ conceptual_design.md)
- ❌ Specific implementation approaches (→ features, tasks)
