# Feature-level governance

**Decision date:** 2026-11-01. Human-approved design and implementation approach; source implementation and independent review do not by themselves establish live behaviour or Feature acceptance.

## Rationale and boundary

Preserve all six documents, their authority graph, alignment and traceability from the Vision. Human judgement belongs at Feature requirements/acceptance criteria, approach/consequential trade-offs, and delivered capability. Agents can plan, decompose, implement, test and maintain factual documentation within that approved intent. Adding a second mandatory work-order layer would reproduce the overhead this change removes.

Epics, Tasks and Spikes remain optional familiar aids, with no required sequence or human gates. Direct Feature implementation needs no children. Significant changes and checks link to their Feature; maintenance may cite its governing engineering rule and product purpose. Keep actual decisions, revisions, results, review verdict, unresolved issues and next action accessible without a duplicate journal.

Independent technical review is distinct from implementation/self-tests and human acceptance. Meaning-changing document updates and material scope, design, acceptance, access or cost decisions return to the human. Real contribution/publication/deployment permissions and explicit project holds survive. Legacy gate-authority fields grant no new power. Preserve identifiers, history and archives; source changes do not automatically migrate records or refresh installations.

## Implementation map

- Governing rules: six documents under `docs/`, especially Conceptual Design business rules and Technical Design lifecycle/gate sections.
- Executable instructions: [work-items](../../shannon/skills/work-items/SKILL.md), twenty type/verb commands, project setup/documentation skills and their templates.
- Supervisor: report/goal authority and lifecycle-checker interpretation; report format and hook scripts remain intact.
- Navigation: root README, source/project CLAUDE guidance, overview, existing Feature definitions and index.

## Verification and limits

Pre-commit validation passed 140 source/fixture checks across 52 changed Markdown files: parser rendering, fences, no new broken concrete links, historical-content conservation, twenty command routes, governance assertions with three planted regressions, fresh six-document/Feature-only installation and optional DRAFT Task instantiation. Existing hook scripts/configuration and deployed runtime files were unchanged. One historical broken link and five example path placeholders remain in conserved text. Validation details and limitations are recorded in the pull request. Exercise source/template instantiation in an isolated fixture with direct Feature delivery, an optional Task with an old progress label, material divergence, existing holds and independent-review/acceptance separation. Inspect actual diff and links, including negative controls that plant lower-level gate regressions. These source checks are not a live model-behaviour trial or deployment acceptance. Existing unrelated testing-strategy and unattended-operation proposals remain separate.
