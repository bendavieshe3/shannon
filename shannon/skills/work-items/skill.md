---
name: work-items
description: Manage human-governed Features and agent-managed delivery, with optional Epic, Task and Spike records. Preserve Vision/document alignment, traceability, independent review and honest evidence.
---
# Skill: work-items

When invoked, start with “Activating work-items skill for [type] [verb].”

## Purpose and inputs

Commands supply Type (`feature`, `epic`, `task`, `spike`, or `scratchpad` with verbs `add` and `process`), Verb (`create`, `elaborate`, `plan`, `implement`, `review`) and Target ID or hint. Resolve an unambiguous target from current context; ask only when ambiguity affects scope. Read `conceptual_design.md` § Business Rules, the target Feature and relevant documents before affected work. Resolve any other skills by name from the session catalogue.

## Authority and traceability

Everything extends traceably from `docs/vision.md`. Read the Feature's Vision Reference and relevant governing design/Guide sections, then inspect actual implementation. Changes and tests cite the Feature they serve. Maintenance may cite a governing engineering rule and its product purpose without creating a new Feature. A scratchpad item or optional execution record supplies context, not authority.

The human owns Vision and Feature gates. Agents choose execution below approved Features; there are no mandatory Epic, Task or Spike gates. Do not introduce a replacement work-order abstraction. Preserve six documents, their alignment and the meaning of explicit decisions. Independent technical review is distinct from implementation/self-tests and from human acceptance. Respect separately recorded project holds and external-action/access/cost permissions.

## Feature lifecycle

`DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`

The three human Feature gates are requirements/acceptance criteria (Gate 1), approach/consequential trade-offs (Gate 2) and delivered capability (Gate 3). Reuse explicit approval already given for the exact change, recording its source; silence or a reviewer approving code is not human Feature acceptance.

### Create

Read the Feature index immediately before allocation. Allocate the next real `FEAT-NNN` ID and descriptive slug, instantiate `templates/feature.md`, capture Vision Reference/context, and update the existing index after the body. Do not overwrite another writer. Features remain persistent capabilities.

### Elaborate — Gate 1

Read the Vision, relevant governing documents and actual capability. Draft requirements, user stories and observable Feature acceptance criteria; cite governing rules rather than worked examples or stale version pins. Check scope criteria by failure mode rather than literal changed-file counts. Do this directly, or use separately authorised helpers when useful. Present the concrete scope and uncertainties for human approval; only actual approval marks ELABORATED.

For re-elaboration, follow `conceptual_design.md` § Re-elaborating a Work Item: record trigger, source revision where applicable and changed meaning. A substantive Feature scope change returns to DRAFT and re-passes the affected human gates. Optional execution notes do not re-pass those gates merely because their plan changes.

### Plan — Gate 2

Read the Feature requirements, relevant Conceptual/Technical Design, Technology Stack and Guides. Propose the approach, consequential trade-offs, constraints, dependencies and verification/independent-review plan. The human approves these decisions, not a mandatory list of children. Only actual approval marks PLANNED. Epics/Tasks/Spikes may be identified when helpful; do not create speculative child files or require per-child gate commands.

### Implement — agent-managed delivery

Confirm approved Feature scope and approach; respect any named hold. Set Feature Activity ACTIVE while delivering, even without an Epic. Choose and revise the plan/decomposition within those limits. `/feature-implement` performs implementation directly; it must not merely redirect to `/epic-implement` or stop because no Task exists.

Run the agreed checks and useful regressions, maintain affected documents within approved meaning, and capture consequential decisions and reusable knowledge. Stop affected work if scope, acceptance, material design, cost or access must change; explain the decision and options. Continue independent authorised work where useful. Do not weaken requirements/tests to manufacture success.

Keep enough progress evidence for a fresh session: actual revision/diff, decisions and sources, checks/results or unrun checks, remaining work and next action. Link it from the Feature; no duplicate status journal is required. Retain existing identifiers and history; do not bulk migrate or delete records.

### Review — Gate 3

Inspect the resulting implementation against Feature criteria. Record actual tests, independent technical-review identity/verdict and unresolved defects. A Feature is ready for human acceptance only with the required verification and independent review. Independent technical judgement must come from a reviewer who did not implement or push the change. The implementer cannot approve its own work. Present delivered behaviour and limitations; only explicit human Feature acceptance marks APPROVED. Activity is STABLE only when no implementation remains active. Do not infer Feature acceptance from optional-child statuses or a merged pull request.

## Optional Epic, Task and Spike operations

All existing command names/templates remain usable, but these records are optional aids. No fixed status sequence or human approval is required to create, elaborate, plan, implement or review one. Do not refuse a verb merely because an old progress label is not ELABORATED or PLANNED. Verify the governing Feature authority or maintenance rule before execution; missing authority is a real blocker.

Keep descriptive titles, real IDs where records are created and current body-before-index references. Reuse legacy progress labels honestly; a self-tested result can be IMPLEMENTED, but cannot claim independent review or human approval. Existing APPROVED labels/logs remain historical evidence and are not rewritten automatically. A Spike has a question, time-box and durable knowledge output; an inconclusive result is valid.

Optional child completion must not advance the parent to APPROVED. Feature acceptance stays human. Optional decomposition must not hide an unapproved product decision.

## Scratchpad

`./docs/scratchpad.md` (from `templates/scratchpad.md`) is the pre-workflow capture point: one line per item, optional tags, no IDs, no status. It supplies context, not authority.

### Add

Append the item under § Items as one line, `- **Short title** — what and why. #tags`, keeping the user's wording. Create the file from the template if it is missing. Do not classify, plan or act on the item. When you notice a framework-general ambiguity or idea during other work that has no clear home, capture it the same way.

### Process

Read § Items (or the requested subset), the Feature index and the relevant Features. Give each item exactly one disposition, following `conceptual_design.md` § Key Workflows → *Processing the Scratchpad*:

- **Act within approved intent** — an existing approved Feature or governing rule covers it: do it, or note it on that Feature, citing the item.
- **Promote** — new or changed Feature scope needs the human: draft a DRAFT Feature or a re-elaboration and present it; nothing is approved by promotion. An optional Epic, Task or Spike may be created when existing approved intent covers it.
- **Knowledge** — a durable finding moves to a knowledge note through `/document-create knowledge`.
- **Drop** — no longer relevant; record why.
- **Keep** — not ready; leave it, and add a one-line dated note only if something changed.

Move each disposed item to § Processed with the date, disposition and a pointer (Feature or record ID, note path, or drop reason). Present the dispositions in one summary and batch any human decisions into one ask. Never delete an item without recording its disposition.

## Optional archive and existing indexes

Only archive when authorised and useful; no automatic archive/migration is necessary for this release. If a Task is moved to `docs/tasks/archive/`, rewrite its own relative links for the extra depth, including open-Task siblings (`../TASK-…`) and archived siblings (`./TASK-…`). Repoint inbound references and any existing index in the same operation and verify every affected link. Preserve content and history. Missing optional indexes/directories are not defects; indexes that exist must agree with their bodies.

Keep the Feature `(Partial)` suffix consistent with its `Initial Implementation: Partial` metadata. Update both whenever the underlying claim changes. Meaningful unfinished work remains visible on the Feature.

## Failure handling and return

Name missing required context, conflicting authority, failed checks or concurrent writes precisely. Do not silently overwrite, assume a DRAFT document is authoritative or substitute missing approval. For a routine detail already settled by the governing sources, resolve and cite it rather than re-asking.

Return concrete changes, checks, remaining work and the relevant decision/Feature reference. Brief progress updates are sufficient; do not ask routine lower-level approvals. Resume the user's conversation after the requested action.
