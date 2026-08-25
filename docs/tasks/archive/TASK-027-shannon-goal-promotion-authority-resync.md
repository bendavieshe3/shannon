# TASK-027: `/shannon-goal` Promotion-Authority Resync and Candidate-Derived Footer

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #shannon-goal #promotion-authority #corrective
- **Created**: 2026-08-21
- **Updated**: 2026-08-25

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated 2026-08-25 (Gate 1). Initial intent was captured at task creation, downstream of the `ux_guide.md` v1.3 Gate 1 approval (2026-08-21).*

### Overview

`ux_guide.md` v1.3 corrected the `/shannon-goal` promotion-authority footer from three promotion targets to four — adding the Spike case that `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority* establishes — and added prose committing the footer to naming the authorities the run's actual candidates implicate rather than printing a fixed legend. The shipped supervisor skill still carries v1.2's three-target form. This Task re-syncs it.

The correction has two halves, and the second is the one that matters:

1. **The factual half.** `shannon/skills/shannon-supervisor/SKILL.md` carries the three-target phrasing in two places — the `/shannon-goal` contract prose at § /shannon-goal — Contract step 3 (*"a Task may be auto-promoted on supervisor authority, but promotion to an Epic or a Feature requires directing-party approval"*), and the fenced example under § Output shape (*"Promote which? (Tasks may be auto-promoted on supervisor authority; Epics and Features require your approval.)"*). Both omit Spike. The deployed copy at `.claude/skills/shannon-supervisor/SKILL.md` is currently identical to the source and must be re-synced after the source edit, per the shipping-source discipline TASK-019 established.

2. **The structural half.** The footer should be **derived from the candidates the run actually produced**, not emitted as a fixed legend. A run whose candidates are all Tasks should say so and mention nothing else; a run that surfaces an Epic candidate names the directing-party requirement because it is live, not because the legend always carries it. This is what `ux_guide.md` v1.3 now specifies, and it is the durable fix — a hardcoded legend drifts again the next time the authority model changes.

### Why this is corrective

The defect's origin is instructive and should be recorded rather than quietly patched. TASK-022 bound the shipped output to *"the ratified example at `ux_guide.md` v1.2"* — treating a **worked example in a UX guide as if it were a specification**. The example was illustrative and abbreviated; copying it verbatim imported its abbreviation as behaviour. The Guide has now been corrected, but the general lesson (an example is not a contract) is framework-general and may warrant a scratchpad item at elaboration, per the meta-gap routing channel.

### Acceptance Criteria

*Drafted at `/task-elaborate TASK-027` (Gate 1, 2026-08-25).*

- [ ] **AC#1 — Contract step 3 names all four promotion authorities.** `shannon/skills/shannon-supervisor/SKILL.md` § /shannon-goal — Contract step 3 states the complete model of `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*: Task supervisor-autonomous; Spike supervisor-autonomous unless the project has reserved Spike authority; Epic and Feature always directing-party. The Spike clause names its condition, not just its default.
- [ ] **AC#2 — The footer is specified as candidate-derived, not a fixed legend.** § Output shape states in prose that the closing footer names only the promotion authorities the run's actual candidates implicate, and that a run whose candidates are all Tasks says so and mentions nothing else. The fenced example remains one worked instance and is labelled as such, so it cannot be re-copied as a specification — the defect this Task corrects.
- [ ] **AC#3 — `spike_gate_authority` is named as the determinant.** The configuration field already documented in § Configuration is named at the point the Spike promotion authority is described, so a reader resolving "is Spike autonomous here?" is sent to the field rather than to the default.
- [ ] **AC#4 — Source and deployed copy re-synced, and no shipping artefact carries the three-target phrasing.** After the source edit, `.claude/skills/shannon-supervisor/SKILL.md` is byte-identical to `shannon/skills/shannon-supervisor/SKILL.md`, and a grep for the v1.2 three-target strings (`Tasks may be auto-promoted`, `promotion to an Epic or a Feature`) across `shannon/` and `.claude/` returns zero. **Scope correction:** the DRAFT's expected wording said *repo-wide*; that criterion is unmeetable and wrong to meet — `docs/tasks/archive/TASK-022-…` § AC#2 and this Task's own § Requirements quote the defective phrasing as historical record, and editing them would destroy the evidence trail. The grep is scoped to shipping artefacts.
- [ ] **AC#5 — Nothing outside `/shannon-goal` changes.** No report-pipeline, checker, hook, template, command, or mandated-document file is modified; within `SKILL.md`, no section other than § /shannon-goal — Contract (including its § Output shape subsection) is edited. Phrased as a cross-type guard per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*; routine bookkeeping (task index, EPIC-010 Tasks line, Activity Log) is expected and not a breach.

### Alignment Findings

*From the Gate 1 alignment pass against `conceptual_design.md` v1.7, `ux_guide.md` v1.3, and parent EPIC-010.*

- **Drift (the Task's subject) — confirmed, two sites.** `shannon/skills/shannon-supervisor/SKILL.md:57` (contract prose) and `:75` (fenced example) carry the three-target form. `ux_guide.md:89` already carries the corrected four-target example and the candidate-derived prose beneath it. The deployed copy at `.claude/skills/shannon-supervisor/SKILL.md` mirrors both defects and is currently byte-identical to source, so a single source edit plus redeploy closes both.
- **Gap — the DRAFT's AC#4 was unmeetable as written.** Corrected in AC#4 above; the scope is shipping artefacts, not the repository.
- **Strength — the upstream document is unambiguous.** `ux_guide.md` v1.3 states the candidate-derived rule in prose immediately beneath its example, precisely so the example cannot again be mistaken for the specification. The Guide supplies the wording this Task ports; no interpretation is required.
- **Framework-general lesson (meta-gap routing).** *An illustrative example in a Guide is not a specification.* This is the second occurrence in the same cluster — `ux_guide.md` v1.3's changelog records TASK-023 deriving the wrong report-header shape from an abbreviated example in the same document. Two occurrences from one document is a pattern, not an accident. Routed to `docs/scratchpad.md` at implementation for promotion consideration, per the meta-gap routing channel; not resolved inside this Task.

### Context

- **Parent Epic**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md) — Synthesis and Reports (IMPLEMENTING). This is the Epic's sixth Task, added corrective mid-implementation, as EPIC-009 took three correctives (TASK-019/020/021).
- **Upstream document**: `ux_guide.md` v1.3 (APPROVED 2026-08-21) § Command Surface → *Supervisor Commands* — the amendment this Task implements.
- **Governing rule**: `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*.
- **Sibling**: [TASK-022](./archive/TASK-022-shannon-goal-decomposition-skill.md) — shipped `/shannon-goal`; its § Implementation Notes records the configuration-phrasing nuance that rode the same `ux_guide` cluster.
- **Discipline**: `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts* — edit `shannon/`, then deploy to `.claude/`.

---

## Plan

*Drafted at `/task-plan TASK-027` (Gate 2, 2026-08-25).*

### Approach

A single-file prose edit to `shannon/skills/shannon-supervisor/SKILL.md` § /shannon-goal — Contract, followed by a redeploy to `.claude/`. No script, checker, hook, or template is involved; the defect is entirely in what the skill instructs the model to emit.

The edit has two distinct shapes, matching the two halves of the defect:

1. **Contract step 3** — replace the two-target clause with the complete four-target model, stating Spike's *condition* (the project has not reserved Spike authority) rather than only its default, and naming `spike_gate_authority` as the field that decides it. This satisfies AC#1 and AC#3 together, because the condition and the field belong in the same sentence.
2. **§ Output shape** — add the candidate-derived rule as prose, and relabel the fenced block so it reads as one worked instance rather than a template. The current prose introduces the block with *"The output carries four elements … and a closing promotion-authority footer"*, which invites verbatim copying; the replacement keeps the four-element structural commitment (that part is genuinely specification) while making the footer's *content* derived. The example's own footer is corrected to the four-target form so a reader who does copy it copies something true — but the prose beneath now states the derivation rule, mirroring how `ux_guide.md` v1.3 defends the same example.

Ordering is source-first per `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts*: edit `shannon/`, verify, then copy to `.claude/`, then verify byte-identity.

### Steps

1. Edit `shannon/skills/shannon-supervisor/SKILL.md` § /shannon-goal — Contract step 3 (AC#1, AC#3).
2. Edit § Output shape — the introducing prose, the fenced example's footer line, and a new sentence stating the candidate-derived rule (AC#2).
3. Verify: grep `shannon/` for `Tasks may be auto-promoted` and `promotion to an Epic or a Feature` → expect zero; grep for `spike_gate_authority` in § /shannon-goal → expect one.
4. Redeploy: copy source `SKILL.md` to `.claude/skills/shannon-supervisor/SKILL.md`; `diff` → expect no output (AC#4).
5. Scope check: `git status --short` limited to the expected set — the source `SKILL.md`, this Task file, `docs/tasks/task_index.md`, `docs/epics/EPIC-010-…md`, and `docs/scratchpad.md` (AC#5). `.claude/` is gitignored and will not appear; verify it by `diff`, not by `git status`.
6. Route the framework-general lesson to `docs/scratchpad.md` — *an illustrative example in a Guide is not a specification*, with both occurrences (TASK-022 and TASK-023) cited as the evidence that it is a pattern.

### Testing

This is a Markdown framework with no build or test runner; verification is by inspection and grep, per `development_guide.md` § Testing Strategy. Concretely:

- **Greps** as in step 3 — mechanical, and they are what AC#4 asserts.
- **`diff` source against deployed** — mechanical, and it is the shipping-source discipline TASK-019 established.
- **Read-back of the edited section against `ux_guide.md:85–91`** — the substantive check. The skill's four-target statement must not merely be four items long; it must match the Guide's conditions (Spike's reservation clause) and the governing rule at `conceptual_design.md:177`.
- **Behavioural spot-check deferred, deliberately.** Running `/shannon-goal` end-to-end would exercise the checker fan-out and produce output whose footer could be inspected. That is the strongest available test, but the verb is read-only and its footer is model-rendered from these instructions — a single run demonstrates one candidate mix, not the derivation rule. Read-back against the two upstream authorities is the tighter check for what this Task actually changes. Noted rather than skipped silently.

### Dependencies

None outstanding. Both upstream authorities are APPROVED: `ux_guide.md` v1.3 (2026-08-21) and `conceptual_design.md` v1.7. Nothing else in EPIC-010 is in flight.

### Risks

- **Over-reach into neighbouring sections.** § Read-only reuse and § Failure modes sit immediately below § Output shape and read as adjacent concerns. AC#5 guards this; the scope check in step 5 is where it is caught.
- **Fixing the example while leaving the invitation to copy it.** The lower-value half of this Task is the footer's wording; the durable half is the prose that stops the next reader treating the block as a contract. If step 2 corrects the fenced text but not its framing, the Task closes and the defect recurs — which is exactly what happened between `ux_guide` v1.2 and TASK-022. Reviewed explicitly at Gate 3.

---

## Implementation Notes

*Implemented 2026-08-25.*

### What changed

Three edits to `shannon/skills/shannon-supervisor/SKILL.md` § /shannon-goal — Contract, then a redeploy to `.claude/skills/shannon-supervisor/SKILL.md`. No other file in `shannon/` or `.claude/` was touched.

1. **Contract step 3** — the two-target clause became the full four-target model, keyed to `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*. Spike is stated with its condition (*unless the project has reserved Spike authority to the directing party*) and `spike_gate_authority` is named in the same sentence, with the explicit instruction that the skill **reads the field rather than assuming the default** — AC#1 and AC#3 land together, which is what the plan intended.
2. **§ Output shape introducing prose** — the four elements are now stated as the structural commitment while the footer's *content* is derived, and the fenced block is labelled **"one worked instance, not a template"**. This is the durable half of the fix: it removes the invitation that TASK-022 accepted.
3. **§ Output shape trailing prose** — new paragraph stating the derivation rule, with the all-Tasks run and the Epic-candidate run as the two worked cases, closing on *"The four-target model at Contract step 3 is what the footer draws from; it is not what the footer prints."*

The fenced example's own footer was corrected to `(The Task may be auto-promoted on supervisor authority; the Feature requires your approval.)` — that run's candidates implicate Task and Feature only.

### Deviation from plan: the example diverges from the Guide's, deliberately

The plan assumed the example's footer would be ported from `ux_guide.md` v1.3. It could not be. **The Guide's own example still prints the fixed legend** — *"(Tasks and Spikes may be auto-promoted on supervisor authority; Epics and Features require your approval.)"* — on a run whose candidates implicate only Task and Feature. That directly contradicts the prose the Guide states one line below it, and it is the same defect v1.3 was written to fix, surviving in the Guide's own worked example.

Porting it verbatim would have reproduced the defect inside the artefact meant to correct it, and would have violated AC#2. Porting the *rule* instead means the shipped `SKILL.md` example is now candidate-derived and the Guide's is not — a real divergence between an APPROVED Guide and the skill it governs, which a Drift Checker should and will flag.

A Task may not amend a Guide (`conceptual_design.md` § Business Rules → *Work Items Consume Guides*), so this is routed to `docs/scratchpad.md` for `/document-review ux_guide.md` rather than fixed here. Recorded prominently because a future reader finding the divergence should find this note, not re-derive it.

### Verification performed

- `grep -rn "Tasks may be auto-promoted\|promotion to an Epic or a Feature" shannon/ .claude/` → zero matches (AC#4).
- `grep -c spike_gate_authority` over § /shannon-goal → 1 (AC#3).
- `diff shannon/…/SKILL.md .claude/…/SKILL.md` → identical (AC#4).
- Read-back of the edited section against `ux_guide.md:85–91` and `conceptual_design.md:177` — the four targets and Spike's reservation condition match the governing rule; the divergence is confined to the fenced example and is documented above.
- `git status --short` limited to the expected set (AC#5) — see § Review.

An end-to-end `/shannon-goal` run was not performed, per the Gate 2 plan's stated reasoning.

### Scratchpad routing

Two items added to `docs/scratchpad.md`:

- **An illustrative example in a Guide is being read as a specification — twice from the same document.** The framework-general lesson, with TASK-022 and TASK-023 as the two occurrences and three candidate routes. Flagged as worth promoting: it has produced two shipped defects.
- **`ux_guide.md` v1.3's own example footer still prints a fixed legend.** The divergence recorded above, routed to `/document-review ux_guide.md`.

---

## Review

*Gate 3, 2026-08-25. Verified on supervisor authority under the SIT-026 standing directive.*

| AC | Verdict | Evidence |
|---|---|---|
| **AC#1** — Contract step 3 names all four promotion authorities | **Met** | `SKILL.md:57` states Task (supervisor), Spike (supervisor *unless reserved*), Epic and Feature (always directing-party), cited to `conceptual_design.md` § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*. Spike carries its condition, not just its default — the specific omission the Task existed to fix. |
| **AC#2** — Footer specified as candidate-derived, not a fixed legend | **Met** | Two edits, both required. The introducing prose at `:62` labels the fenced block *"one worked instance, not a template"* and separates the structural four elements from the derived footer content; the new paragraph at `:79` states the rule with two worked cases and closes *"The four-target model at Contract step 3 is what the footer draws from; it is not what the footer prints."* The example's own footer now names only the two authorities its run implicates, so the block demonstrates the rule rather than contradicting it. This is the criterion the Gate 2 risk register flagged as load-bearing — correcting the example without correcting its framing would have reproduced the original defect — and both halves landed. |
| **AC#3** — `spike_gate_authority` named as the determinant | **Met** | Named inline at `:57`, in the same sentence as Spike's condition, with the instruction that the skill reads the field rather than assuming the default. A reader resolving *"is Spike autonomous here?"* is sent to the field. |
| **AC#4** — Source and deployed re-synced; no shipping artefact carries the three-target phrasing | **Met** | `grep -rn "Tasks may be auto-promoted\|promotion to an Epic or a Feature" shannon/ .claude/` → zero matches. `diff` of source against deployed → identical. The two surviving repository occurrences are `docs/tasks/archive/TASK-022-…` § AC#2 and this file's § Requirements, both quoting the defective phrasing as deliberate historical record — in scope of the criterion as corrected at Gate 1, and deliberately preserved. |
| **AC#5** — Nothing outside `/shannon-goal` changed | **Met** | `git diff -U0` on `SKILL.md` yields four hunks, all within lines 57–79 — inside § /shannon-goal — Contract and its § Output shape subsection; § Read-only reuse, § Failure modes, § Configuration and § Report Pipeline are untouched. `git status --short` shows exactly five files: the source skill, this Task, `task_index.md`, `EPIC-010`, and `scratchpad.md` — the last four being the routine bookkeeping the cross-type guard admits. No template, checker, hook, command, or mandated document modified. `.claude/` is gitignored and was verified by `diff` rather than `git status`. |

### Findings

- **One deviation from plan, upheld.** The fenced example's footer was not ported from `ux_guide.md` v1.3 as the plan assumed, because the Guide's example still prints the fixed legend on a run that does not implicate all four targets — contradicting the prose directly beneath it. Porting it would have breached AC#2 and reproduced the defect inside the fix. The rule was ported instead, and the resulting divergence between the APPROVED Guide and the shipped skill is documented in § Implementation Notes and routed to `docs/scratchpad.md` for `/document-review ux_guide.md`. **The deviation is the right call and is not a defect in this Task** — but it leaves a live Guide-vs-skill drift that a Drift Checker will correctly flag until the Guide is reviewed. Surfaced to the directing party at gate notification rather than buried here.
- **Meta-gap routed, and flagged as promotion-worthy.** *An illustrative example in a Guide is not a specification* now has two shipped defects behind it (TASK-022's footer, TASK-023's report header) from the same document. Captured in `docs/scratchpad.md` with three candidate routes. Two occurrences is a pattern; this is the soft prompt at § Process: Review discharged, not deferred.
- **Archive link depth left at the prevailing convention.** On archiving, this file's `../epics/` and `../features/` parent links resolve one level short, as they do for every archived Task. Matching TASK-022's reasoning, the file is archived consistent with its ~22 siblings rather than diverged; the systemic fix is already an open `docs/scratchpad.md` item.

### Gate 3 disposition

All five acceptance criteria met. **APPROVED** — Task archived to `docs/tasks/archive/`.

---

## Activity Log

- **2026-08-21** — DRAFT: Task created as a corrective, downstream of the `ux_guide.md` v1.3 Gate 1 approval the same day. The Guide's promotion-authority footer was corrected from three targets to four and committed to candidate-derived phrasing; the shipped skill still carries the v1.2 three-target form in two places. Created rather than recorded as an intention, per the directing party's instruction that the cluster's eighteen-day stall was caused by notes naming their own fix and nobody executing it. Full elaboration pending `/task-elaborate TASK-027`.
- **2026-08-25** — DRAFT → ELABORATED: Gate 1 passed on **supervisor authority** (Tasks are always supervisor-authority per `conceptual_design.md` § Business Rules → *Gate Authority Split*; exercised under the SIT-026 standing directive of 2026-08-25). Acceptance criteria drafted as five: four naming the substance of the resync, one scope guard. The DRAFT's expected AC#4 was **corrected during elaboration** — its "repo-wide grep returns zero" is unmeetable, because the archived TASK-022 and this Task's own Requirements quote the defective phrasing as deliberate historical record; the criterion is now scoped to shipping artefacts (`shannon/` and `.claude/`). Alignment pass found the upstream `ux_guide.md` v1.3 wording unambiguous and directly portable. One framework-general lesson logged for scratchpad routing at implementation: an illustrative example in a Guide is not a specification — second occurrence from the same document in this cluster.
- **2026-08-25** — ELABORATED → PLANNED: Gate 2 passed on **supervisor authority** under the SIT-026 standing directive. Plan is a single-file prose edit to `shannon/skills/shannon-supervisor/SKILL.md` § /shannon-goal — Contract plus a redeploy; six steps, verified by grep, `diff`, and read-back against `ux_guide.md` v1.3 and `conceptual_design.md` v1.7. An end-to-end `/shannon-goal` run was **considered and deliberately deferred** — the footer is model-rendered from these instructions, so one run demonstrates one candidate mix rather than the derivation rule; read-back against the two upstream authorities is the tighter check. Two risks recorded, the load-bearing one being that correcting the fenced example without correcting its framing would reproduce the original defect.
- **2026-08-25** — PLANNED → IMPLEMENTING → IMPLEMENTED → REVIEW → APPROVED: implemented and Gate 3 passed on **supervisor authority** under the SIT-026 standing directive. Three edits to `shannon/skills/shannon-supervisor/SKILL.md` § /shannon-goal — Contract, plus redeploy; all five ACs verified (greps zero, `diff` identical, diff hunks confined to lines 57–79, five expected files changed). **One deviation, upheld**: the fenced example's footer was not ported from `ux_guide.md` v1.3, because the Guide's own example still prints the fixed legend its prose forbids — the rule was ported instead, deliberately diverging the skill's example from the Guide's. That divergence is routed to `/document-review ux_guide.md` and surfaced to the directing party. Two scratchpad items added: the framework-general *an example is not a specification* lesson (two shipped defects, flagged promotion-worthy) and the Guide-example drift. Archived to `docs/tasks/archive/`.
