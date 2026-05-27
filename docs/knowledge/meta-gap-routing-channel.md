# Meta-Gap Routing Channel

## Metadata

- **Type**: Extension
- **Related To**: `docs/development_guide.md` § Testing Strategy → Pre-Commit Checklist (the canonical checklist line); `docs/development_guide.md` § Git Workflow → Push Cadence (the paired cadence convention); `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2) + § Process: Review (Gate 3) (the step-adjoining soft prompts)
- **Tags**: #framework #development-guide #work-items #meta-gap #routing-channel #FEAT-008 #EPIC-008 #EPIC-007
- **Created**: 2026-05-27
- **Last Updated**: 2026-05-27

---

This note records the codification and first formal exercise of the **meta-gap routing channel** — the framework convention by which framework-general ambiguities surfaced during work-item planning or implementation are routed back into the framework's mandated documents and skills rather than being lost or re-derived. The channel was established by EPIC-008 (Development Conventions Surfaced Through Dogfooding) under [FEAT-008](../features/FEAT-008-development-discipline.md), with [EPIC-007](../epics/EPIC-007-work-item-conventions-from-dogfooding.md) (Work-Item Conventions Surfaced Through Dogfooding) under [FEAT-003](../features/FEAT-003-unified-work-item-model.md) as the contemporaneous sibling exercise.

---

## 1. The Previously-Missing Channel and Its Codification

### The Meta-Gap

Work items routinely resolve framework-general ambiguities during their own planning or implementation — but until 2026-05-27 the framework had no convention for *routing* those resolutions back into the framework itself. The mechanisms existed (re-review of mandated documents, re-elaboration of work items, scratchpad capture); the missing piece was the **discipline / prompt at the moments of action** — at planning, at review — that would prompt the implementer to notice a framework-general resolution and route it to a mandated-doc amendment, knowledge note, or scratchpad item.

The pattern surfaced repeatedly during EPIC-005 + EPIC-006 dogfooding: TASK-003 alone resolved three framework-general ambiguities (editing order, commit-hash timing in re-elaboration, bundled re-elaboration) that sat only in its Plan § Approach and would archive with the Task; the meta-gap surfaced explicitly at TASK-003 Gate 2 (2026-05-22) and was captured in `scratchpad.md`.

### The Codification — Two-Touch

EPIC-008 AC#3 establishes the routing channel at the **lightest viable resolution** — a two-touch:

**Touch (a) — the canonical checklist line** at `development_guide.md` § Testing Strategy → Pre-Commit Checklist (line 114, landed by TASK-007 APPROVED 2026-05-24 commit `eac486b`):

> Did this work resolve a **framework-general ambiguity surfaced during this work — a convention, workflow gap, or rule clarification that future work items would otherwise re-derive**? If yes, capture it in `scratchpad.md` for promotion or open a follow-up work item against the relevant mandated document. (See also the matching soft prompts in `shannon/skills/work-items/skill.md` § Process: Plan and § Process: Review.)

**Touch (b) — the step-adjoining soft prompts** at `shannon/skills/work-items/skill.md` (landed by TASK-010 APPROVED 2026-05-27 commit `9c45433`), each mirroring the verbatim trigger phrase as plain prose:

- **§ Process: Plan (Gate 2)** at line 174 — directing the planning subagent at *the moment of planning*
- **§ Process: Review (Gate 3)** at line 236 — directing the review subagent at *the moment of review*

Both halves cross-reference each other: the checklist line names both skill anchors; the skill prompts each cross-reference `development_guide.md` § Testing Strategy → Pre-Commit Checklist. The bidirectional pair is textually complete.

### Three Observed Surfacing Modes

Per EPIC-008 AC#3's framing, the channel handles three observed modes by which framework-general ambiguities surface:

1. **Implementer notices the ambiguity in their own reasoning while drafting** — the TASK-003 editing-order pattern.
2. **Directing party flags a missing convention in feedback** — the push-cadence pattern (the directing party asked "have we pushed?" several times across the session).
3. **Review uncovers a recurring shape that previous work items also tripped on** — the cross-type scope-guard pattern (TASK-002 AC#6, AC#8; TASK-003 AC#9).

Known residual blind spots are honest at this lightweight resolution: ambiguities that resolve silently inside the implementer's reasoning without a textual artefact, and ambiguities recognised only retrospectively several work items later. These are acceptable; deeper instrumentation is forward work.

---

## 2. EPIC-007 and EPIC-008 as the First Two Formal Exercises

The recursive-dogfood character of the EPIC-007 + EPIC-008 pair is structural: **both Epics were themselves promoted via the same kind of resolution-routing the channel is designed to make routine.** The seven items addressed across the two Epics were captured in scratchpad during EPIC-005 / EPIC-006 work, then surfaced for promotion when the framework's evolution reached the point of formalising the channel itself.

| Epic | Feature | Items addressed | APPROVED |
|---|---|---|---|
| [EPIC-007](../epics/EPIC-007-work-item-conventions-from-dogfooding.md) | [FEAT-003](../features/FEAT-003-unified-work-item-model.md) | Commit-hash timing in re-elaboration; bundled re-elaboration; descriptive naming (no opaque plan-letter labels); cross-type scope-guard AC convention | 2026-05-27 commit `cffb1ab` |
| [EPIC-008](../epics/EPIC-008-development-conventions-from-dogfooding.md) | [FEAT-008](../features/FEAT-008-development-discipline.md) | Editing-order convention; Push Cadence directive; meta-gap routing channel itself | 2026-05-27 (Gate 3 with this knowledge note) |

EPIC-008 has the additional property that it **both codifies the channel and is itself a product of the channel**. The Pre-Commit Checklist line and skill prompts are *the channel*; EPIC-008 reached approval via the same routing mechanism (scratchpad capture → Epic creation → ratification into mandated doc + skill).

A particularly pleasing structural recursion played out at TASK-010's Gate 3: the review subagent reading `shannon/skills/work-items/skill.md` § Process: Review (Gate 3) encountered the very step-adjoining soft prompt the Task lands at line 236 — directed at itself — asking whether *this work* resolved a framework-general ambiguity. The honest answer at Gate 3 was yes: the work resolves the framework-general meta-gap of "how do framework-general resolutions reach the framework at the moments of action"; the channel codified is the resolution. **The channel processes its own implementing Task.**

---

## 3. Cross-References

### Mandated documents and skills extended

- `docs/development_guide.md` § Testing Strategy → Pre-Commit Checklist (line 114) — the canonical checklist line
- `docs/development_guide.md` § Git Workflow → Push Cadence (lines 149–156) — the paired cadence convention
- `docs/development_guide.md` § Version History v1.3 (lines 190–199) — names EPIC-008 by ID + EPIC-007 as contemporaneous sibling exercise (AC#7(i))
- `shannon/skills/work-items/skill.md` § Process: Plan (Gate 2), step-adjoining at line 174 — Gate-2 soft prompt
- `shannon/skills/work-items/skill.md` § Process: Review (Gate 3), step-adjoining at line 236 — Gate-3 soft prompt
- `.claude/skills/work-items/skill.md` — re-synced byte-identical from source per TASK-005 precedent

### Work items

- [EPIC-007 — Work-Item Conventions Surfaced Through Dogfooding](../epics/EPIC-007-work-item-conventions-from-dogfooding.md)
- [EPIC-008 — Development Conventions Surfaced Through Dogfooding](../epics/EPIC-008-development-conventions-from-dogfooding.md)
- [TASK-007 (archived) — Amend `development_guide.md`](../tasks/archive/TASK-007-amend-development-guide-new-conventions.md) — landed AC#1, AC#2, AC#3a, AC#4 + AC#5 outbound at `development_guide.md`
- [TASK-008 (archived) — Amend `conceptual_design.md`](../tasks/archive/TASK-008-amend-conceptual-design-work-item-conventions.md) — landed EPIC-007 doc-half
- [TASK-009 (archived) — Add work-items skill step-internal prompts](../tasks/archive/TASK-009-add-work-items-skill-prompts-and-resync-claude.md) — landed EPIC-007 skill-half
- [TASK-010 (archived) — Add meta-gap step-adjoining prompts](../tasks/archive/TASK-010-add-meta-gap-skill-prompts-and-resync-claude.md) — landed EPIC-008 AC#3b + AC#5 inbound

### Source scratchpad items (now in § Processed)

- *"Meta-gap: no channel for feeding framework-general resolutions back into the framework"* — addressed entirely by EPIC-008
- *"Push-frequency directive for development_guide"* — addressed entirely by EPIC-008
- *"Framework clarifications buried in TASK-003's Plan"* (sub-item (a) editing-order) — addressed by EPIC-008 / TASK-007; the shared item moved at EPIC-008 Gate 3 via the second-approver-moves rule

---

## 4. Related Framework-General Observation: Section-Boundary-Uniqueness Edit-Anchor Technique

A small framework-general observation surfaced during TASK-010's implementation and is recorded here alongside the channel because it surfaced *during* exactly the kind of work the channel exists to capture.

### The problem

When editing a skill or document with multiple sections that share repeating subsection names — e.g. `shannon/skills/work-items/skill.md` has `### 1. Identify Target` appearing under **both** `## Process: Plan (Gate 2)` AND `## Process: Review (Gate 3)` (and under other `## Process: *` sections too) — using a subsection name alone as an Edit-tool anchor is unsafe. The Edit tool may match the wrong section, partially overlap an adjacent landing, or silently revise text the implementer did not intend to touch.

### The technique

Use the **section-boundary uniqueness** of the parent section header combined with the subsection start as the Edit-tool anchor:

```
## Process: Plan (Gate 2)

### 1. Identify Target
```

and

```
## Process: Review (Gate 3)

### 1. Identify Target
```

The full-section-header prefix disambiguates and confines the match to the empty header-to-first-subsection gap (or whichever boundary the implementer is targeting). The implementer can then insert step-adjoining prose between the section header and the first subsection without risk of matching elsewhere.

### Where the technique applies

- Editing skill files where step names repeat across `## Process: *` sections
- Editing mandated documents where subsection names recur (e.g. *Identify Target* might appear under multiple sections)
- Any Markdown source where structural symmetry produces non-unique substrings

### Worked example

TASK-010 applied this technique to land two step-adjoining soft prompts at `shannon/skills/work-items/skill.md` § Process: Plan (line 174) and § Process: Review (line 236) without disturbing the four pre-existing TASK-009 step-internal prompts (lines 187 + 195 in the post-TASK-010 state) that sit within the same § Process: Plan section.

### Why it belongs in this knowledge note

The technique is **a framework-general observation surfaced during EPIC-008's implementing work** — TASK-010 noticed it during planning and applied it during execution. It is therefore itself an example of the very pattern the channel exists to capture. Recording it here closes the loop: the channel is the convention; TASK-010 used the channel implicitly (the observation reached this knowledge note via EPIC-008's Gate 3 AC#7); future Tasks editing skill files with repeating subsection names will find this technique here rather than re-deriving it.
