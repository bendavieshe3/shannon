# Shannon — System Overview

**Version**: 5.0
**Last Updated**: 2026-11-01

Shannon preserves project intent and context while agents handle execution. Everything extends traceably from the Vision. Human decisions remain at the Vision and Feature level; lower-level activity needs useful evidence, not more handholding.

## Six core documents

Keep `vision.md`, `technology_stack.md`, `conceptual_design.md`, `technical_design.md`, `development_guide.md` and `ux_guide.md` under `docs/`. Read the relevant documents before affected work. Knowledge notes preserve reusable research, cautions and rationale.

### Document Authority Graph

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

Lower documents must align to and enable higher documents. If the Vision describes a web application, the Technology Stack cannot specify desktop-only technology. The framework treats drift between layers as a defect, and `/document-review` checks for it.

Agents maintain factual documentation within approved intent. Consequential changes to approved meaning, scope, design, acceptance, access or cost return to the human. A DRAFT document is tentative context, not permission.

## Features and human decisions

Features are persistent product capabilities linked to the Vision and relevant governing decisions. Their lifecycle remains:

`DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`

1. **Gate 1** — human approval of requirements and observable acceptance criteria.
2. **Gate 2** — human approval of approach and consequential trade-offs.
3. **Gate 3** — human acceptance of delivered capability against verification and independent-review evidence.

Reuse actual explicit approval rather than asking twice. Silence, self-tests, technical approval and merge cannot substitute for human acceptance.

## Delivery below a Feature

`/feature-implement` delivers directly after requirements and approach approval. Agents choose and revise decomposition, execution order and tests within approved scope. Epics, Tasks and Spikes are optional aids with no required status sequence or human gates. Existing names, commands, identifiers, logs and archives remain valid; do not bulk migrate or delete them. Explicit project holds still need disposition.

Read actual implementation, run appropriate checks, maintain affected documents, capture decisions and obtain independent technical review from someone who did not implement the work. Stop affected work for consequential divergence, and continue independent authorised work where useful.

## Traceability and resumption

Link significant changes, verification and review to the Feature they serve. Maintenance may cite the governing engineering rule and its product purpose without creating a new Feature. Keep actual revision/diff, decisions and sources, test results or unrun checks, unresolved defects and next action accessible from the Feature. Do not require an identifier for every internal action or a duplicate journal.

## Commands and skills

Commands remain thin entry points; the work-items skill holds delivery behaviour. `/feature-create`, `/feature-elaborate`, `/feature-plan`, `/feature-implement` and `/feature-review` cover the Feature flow. Existing Epic/Task/Spike verbs operate optional records. Missing optional folders/indexes are not defects; existing indexes must agree with bodies.

`/document-create` and `/document-review` maintain governing documents and knowledge. `/shannon-report` audits health. `/shannon-goal` proposes source-linked candidates without executing or writing them. Implementation helpers are optional and require separate authorisation. A supervisor has no delegated Feature approval power; legacy gate-authority configuration cannot invent lower-level gates.

## Adoption and verification

Copy the source commands, skills and guides into the project's `.claude/` directory when deployment is authorised, then run `/shannon-setup`. Existing deployments do not update themselves when source changes. Preserve real repository, publication, deployment, external-action, credentials and spending permissions.

Use a direct Feature exercise and an optional-record exercise to check the boundary: preserve intent and evidence, avoid routine lower-level approvals, and stop on material divergence. Source checks, independent review, merge, live exercise and human acceptance are separate claims.

See [command reference](../commands/README.md), [work-items skill](../skills/work-items/skill.md) and the project's six core documents for details.
