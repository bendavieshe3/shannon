# Shannon Commands

Commands are thin entry points to skills. The core chain is Vision → governing documents and Features → implementation and verification.

## Feature delivery

- `/feature-create [hint]` captures a persistent capability.
- `/feature-elaborate [ID]` drafts requirements/acceptance criteria for human Gate 1.
- `/feature-plan [ID]` drafts the approach and consequential trade-offs for human Gate 2.
- `/feature-implement [ID]` delivers the approved Feature directly; agents choose decomposition and update context/evidence.
- `/feature-review [ID]` presents verified, independently reviewed delivery for human Gate 3.

## Optional execution aids

`/epic-*`, `/task-*` and `/spike-*` retain create/elaborate/plan/implement/review verbs for useful execution records. They have no mandatory human gates or fixed progress-label sequence. No children are required to deliver a Feature. Missing optional indexes are not defects; existing indexes must remain consistent.

## Documents and supervision

`/shannon-setup` prepares the six project documents. `/document-create [type]` and `/document-review [path]` maintain their authority/alignment; approved meaning changes remain human decisions, factual upkeep is agent work. `/shannon-report` produces health evidence; `/shannon-goal [intent]` identifies aligned work and genuine new Feature decisions. Neither delegates human Feature authority.

## Installation

Copy this commands directory and sibling skills/guides into the project's `.claude/` through the project's approved installation procedure. Preserve existing project customisations and permissions. A source change or successful copy is not runtime validation or Feature acceptance. Commands invoke skills by name and report missing activation explicitly.
