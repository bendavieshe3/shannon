---
name: project-documentation
description: Manage Shannon's six mandated documents (vision, technology_stack, conceptual_design, technical_design, development_guide, ux_guide) and the knowledge base. Owns document creation, review and approval, authority-graph alignment checks, and knowledge note management. Invoked by /document-create and /document-review.
---

# Skill: project-documentation

When invoked, **start your response with**: "Activating project-documentation skill."

## Purpose

This skill owns the mandated documents that describe a project and the knowledge base that captures learnings alongside them. It handles:

- Creating mandated documents from templates
- Creating knowledge notes
- Walking documents through DRAFT → APPROVED with explicit user approval
- Enforcing document authority alignment (lower documents must enable higher ones)
- Maintaining `knowledge_index.md`

This skill does **not** own work items — those are the `work-items` skill's responsibility.

## When to Invoke

- The user runs `/document-create [type]` or `/document-review [path]`
- The user asks to create, review, or approve any of: `vision`, `technology_stack`, `conceptual_design`, `technical_design`, `development_guide`, `ux_guide`, or a knowledge note
- The user asks whether documents are aligned to each other

## Inputs

- **Action** — `create` or `review`
- **Target** — Document type (for create) or path (for review)
- **Working directory** — Inferred from the session

## Templates

This skill owns:

- `templates/vision.md`
- `templates/technology_stack.md`
- `templates/conceptual_design.md`
- `templates/technical_design.md`
- `templates/development_guide.md`
- `templates/ux_guide.md`
- `templates/knowledge_note.md`
- `templates/knowledge_index.md`

## Document Authority Graph

```
                  Vision (supreme)
                 /              \
        Technology Stack    Conceptual Design
                 \              /
                  Technical Design
                        |
              ┌─────────┴─────────┐
        Development Guide      UX Guide
```

**Alignment rule**: Lower documents must align to and enable higher documents. A lower document that contradicts a higher one is a defect.

## Process: Create

### 1. Identify the Target Document

If the user supplied a type, use it. Otherwise, infer from conversation context or ask.

### 2. Check for Existing File

If the target already exists, do not overwrite. Report and ask: "X already exists. Do you want to review the existing one instead?"

### 3. Instantiate Template

Copy the relevant template from `templates/<name>.md` to `./docs/<name>.md`. Set Status to DRAFT and Last Reviewed to today's date.

### 4. Elaborate Content

Spawn a subagent to:

- Read all higher-authority documents that already exist
- Read any work items that reference this document
- Draft content for each section of the template
- Identify sections where user input is required

Subagent writes draft content directly into the document file and returns a structured summary.

### 5. Present and Iterate

Present the drafted document to the user. Iterate based on feedback. The document remains DRAFT until the user explicitly approves it via `/document-review`.

### 6. Update Knowledge Index (for knowledge notes)

When creating a knowledge note, add a line to `./docs/knowledge/knowledge_index.md` under the appropriate section (Research / Implementation Details / Extensions).

## Process: Review

### 1. Identify Target Document

Use the supplied path, or ask if ambiguous.

### 2. Spawn Alignment Subagent

The subagent:

- Reads the target document
- Reads all higher-authority documents in the graph
- Reads all lower-authority documents in the graph
- Identifies misalignments (lower contradicts higher) and gaps (higher mentions something lower doesn't elaborate)
- Returns a structured alignment report

### 3. Present Alignment Findings

Show the user the alignment report:

- ✅ Aligned to higher documents
- ⚠️ Drift detected: [specific items]
- 📝 Gaps in lower documents: [specific items]

### 4. Quality Gate (Gate 1)

Ask explicitly: "Approve this document to mark APPROVED?"

- On approval: Set Status to APPROVED, update Last Reviewed, update Version History
- On rejection: Surface the changes the user wants and iterate

### 5. Cascade Lower-Document Alignment Checks

If the approved document has lower documents in the authority graph, suggest running `/document-review` on each that is currently APPROVED — they may now be misaligned and need updating.

## Quality Gates

- **Gate 1** (DRAFT → APPROVED): Explicit user approval required. AI cannot self-approve.

## Failure Modes

- **Missing higher-authority document** — Cannot review or approve a document if a required higher document is missing. Surface: "Cannot review technical_design.md — conceptual_design.md is missing. Run `/document-create conceptual_design` first."
- **Higher document is DRAFT** — Warn the user that the higher document is not yet authoritative and ask whether to proceed
- **User edits during review** — If the user modifies the document mid-review, restart the alignment subagent against the new content

## Self-Identification

Always begin a response with: "Activating project-documentation skill." If you cannot perform this skill's work for any reason, say so explicitly rather than silently doing something else.
