# Feature Index

- [FEAT-001](./FEAT-001-easy-to-setup.md) — ELABORATED — STABLE — Easy to Setup #core #setup
- [FEAT-002](./FEAT-002-mandated-project-documentation.md) — ELABORATED — STABLE — Mandated Project Documentation #core #documentation
- [FEAT-003](./FEAT-003-unified-work-item-model.md) — ELABORATED — STABLE — Unified Work Item Model (Partial) #core #work-items
- [FEAT-004](./FEAT-004-three-quality-gates.md) — ELABORATED — STABLE — Three Quality Gates #core #review
- [FEAT-005](./FEAT-005-knowledge-base.md) — ELABORATED — STABLE — Knowledge Base #core #knowledge
- [FEAT-006](./FEAT-006-multi-party-supervision.md) — ELABORATED — STABLE — Multi-Party Supervision (Partial) #core #v6
- [FEAT-007](./FEAT-007-lightweight-idea-capture.md) — ELABORATED — STABLE — Lightweight Idea Capture (Partial) #scratchpad #vision-gap
- [FEAT-008](./FEAT-008-development-discipline.md) — DRAFT — STABLE — Development Discipline (Partial) #framework #development-guide #conventions

---

## Notes

**Format**: `[FEAT-ID](./path.md) — STATUS — ACTIVITY — Feature Name [(Partial)] #tags`

**Status**: `DRAFT | ELABORATED | PLANNED | IMPLEMENTING | IMPLEMENTED | REVIEW | APPROVED`

**Activity** (only meaningful for APPROVED features): `STABLE` (no epic in progress) | `ACTIVE` (epic in progress)

**Partial suffix**: A Feature whose body carries `Initial Implementation: Partial` gets a trailing `(Partial)` token after the Feature Name (before `#tags`) — e.g. `Unified Work Item Model (Partial)`. The suffix is present **iff** the body field reads `Partial`, and is added or removed by the `work-items` skill whenever a Feature's `Initial Implementation` field changes — never by manual convention. `grep "(Partial)" feature_index.md` therefore returns every partially-implemented Feature.

**When to update**: Adjust status and activity as the feature progresses. Flat list — no grouping.
