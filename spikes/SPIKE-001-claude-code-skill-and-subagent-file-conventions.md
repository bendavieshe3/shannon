# SPIKE-001: Claude Code Skill and Subagent File Conventions

## Metadata

- **Status**: DRAFT
- **Type**: Spike
- **Feature**: [FEAT-009](../docs/features/FEAT-009-supervisor.md)
- **Time-box**: Half a day
- **Created**: 2026-10-17
- **Updated**: 2026-10-17

> **Status** moves through the unified lifecycle, but the meaningful transitions for a spike are `ELABORATED → IMPLEMENTED` (investigation done) and `APPROVED` (output captured as knowledge note). Spikes are disposable — the knowledge note is the durable artefact.

---

## Requirements

*Initial intent captured at spike creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage. Full elaboration pending `/spike-elaborate SPIKE-001`.*

### Question

What file name, casing and frontmatter keys does Claude Code require for skills and for subagent definitions, and do Shannon's four shipped skills and three supervisor checkers meet them?

### Why This Spike

Shannon is inconsistent with itself and possibly with Claude Code:

- **Casing:** `work-items`, `project-documentation` and `project-setup` ship lowercase `skill.md` *with* `name:`/`description:` frontmatter; `shannon-supervisor` ships uppercase `SKILL.md` *without* frontmatter (its line 1 is a heading). `technical_design.md` names both forms. If discovery is case-sensitive or frontmatter-driven, some skills may not auto-discover on case-sensitive filesystems.
- **Subagent keys:** the checkers (`shannon-supervisor/checkers/*.md`) declare `model:` and `allowed-tools:`. Subagent definitions may use `tools:` instead, and the checkers may be spawned from `SKILL.md` prose rather than registered as subagents, in which case their frontmatter is not enforced at all. TASK-012 and TASK-013 each needed the same Gate 1 refinement to name these keys, so a convention is overdue.

Per CLAUDE.md § Working Conventions → *Research*, this is answered from Claude Code's current documentation, not from memory.

### Expected Output

- A knowledge note in `docs/knowledge/` stating the current conventions, with citations
- A recommendation: whether to rename and add frontmatter (a follow-up Task, confirmed with the directing party before any rename) and where the convention is codified (`technical_design.md` § System Architecture → *Skills*, and a `work-items` skill Plan prompt for Tasks whose ACs touch frontmatter)

### Time-box

Half a day. If the documentation is silent on case sensitivity, test discovery directly in a scratch project and record what was observed.

### Context

- **Feature**: FEAT-009 — Supervisor (checker definitions); the skill-casing half also touches every Shannon skill
- **Relevant documents**: `technical_design.md` § System Architecture → *Skills* and *Supervisor* → *Skill directory layout*; `technology_stack.md` § Supervisor Tooling (*Skill frontmatter control*); `shannon/skills/*/skill.md`; `shannon/skills/shannon-supervisor/checkers/*.md`

---

## Plan

[Filled during planning. The investigation approach.]

### Approach

[How the investigation will proceed. What experiments, comparisons, prototypes, or research steps are involved.]

### Steps

1. [Step]
2. [Step]
3. [Step]

### Risks

- [Risk — mitigation]

---

## Investigation Notes

[Filled during implementation. Raw findings, dead-ends, surprises. This is the working scratchpad. The polished output goes into the knowledge note.]

---

## Output

### Knowledge Note

[Link to the knowledge note this spike produced. The note is the durable artefact; this spike file is just the activity record.]

- [Knowledge note path]

### Recommendation

[The recommendation that emerges from the investigation, in one or two sentences. The full reasoning lives in the knowledge note.]

---

## Review

[Filled during review (Gate 3).]

### Verification

- [ ] Question answered (or confirmed unanswerable within time-box)
- [ ] Knowledge note created and indexed
- [ ] Recommendation captured
- [ ] Follow-up work items created where needed

### Review Notes

[Findings from review. Follow-up work items created as a result.]

---

## Activity Log

[Timestamped entries recording the history. Newest at the top.]

- **2026-10-17** — DRAFT: Spike created from two merged scratchpad items (`SKILL.md` filename casing; canonical frontmatter keys for subagents and skills) by the 2026-10-17 triage, on supervisor promotion authority (Spike ceiling not reserved)
