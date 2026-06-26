# Skill: shannon-supervisor

When invoked, **start your response with**: "Activating shannon-supervisor skill for [verb]."

The self-identification line above is emitted **only** for direct slash-command invocations (currently `/shannon-report`; additional verbs may be added by sibling work items). Hook-event activations (PreToolUse, PostToolUse, SessionStart, preCompact, Stop) and autonomous-cadence invocations are not user-message responses and do not emit a self-identification line.

## Purpose

This skill is the supervisor — the third role in the Shannon role taxonomy alongside the directing party and the implementer. The supervisor performs continuous health vigilance on the project: detecting document-vs-implementation drift, auditing work-item lifecycle state, surfacing operational drift (scratchpad pressure, uncommitted changes, branch lag), and synthesising findings into reports for the directing party to act on.

The supervisor is invokable both interactively (via slash commands) and autonomously (on a cadence the project configures; autonomous invocation lives in a sibling work item).

## When to Invoke

- `/shannon-report` — interactively, when the directing party wants a current health report. Contract codified below.
- Autonomous cadence runs (forward work — invoked by a sibling work item's headless contract).
- Hook events (forward work — sibling work items configure PreToolUse, PostToolUse, SessionStart, preCompact, and Stop).

## Skill Directory Layout

The skill lives at `./.claude/skills/shannon-supervisor/` with four entries:

- `SKILL.md` — this file; supervisor logic and slash-command contracts.
- `templates/` — report templates (header, finding sections, footer). Populated by a sibling work item.
- `checkers/` — definitions for the three checker subagents (Alignment, Lifecycle, Drift). Populated by sibling work items.
- `scripts/` — helper scripts (git log parsers, index validators, hook bodies). Populated by sibling work items.

## /shannon-report — Contract

Invocation: `/shannon-report` (takes no arguments).

The skill:

1. Reads the supervisor configuration per § Configuration below to determine the report directory and any directing-party-reserved gate authorities.
2. Spawns three checker subagents in parallel — Alignment, Lifecycle, Drift — each returning a structured finding fragment using the canonical four-category schema: Drift, Gap, Internal contradiction, Strength.
3. Aggregates the fragments into a single dated report at `./docs/supervisor/report-YYYY-MM-DD.md` (or under the configured `report_directory` if overridden).
4. Indexes the report in `./docs/knowledge_index.md` with Type marked as *Supervisor Report* per the Knowledge Note subtype convention.

The report follows the hybrid-presentation default: a diagnostic header (counts of findings, stuck items, push lag) followed by a one- or two-finding narrative body.

The implementation body of the report-writing pipeline — template instantiation, same-day-suffix handling for repeated runs, knowledge-index update flow — is forward work to be added by a sibling work item as a § Report Pipeline section appended below the Configuration section.

## Configuration

The supervisor reads `./.claude/shannon-supervisor.json` for project-specific configuration. The file is optional.

**Default values** — applied when the file is absent or a specific field is absent:

| Field | Default |
|---|---|
| epic_gate_authority | supervisor |
| spike_gate_authority | supervisor |
| report_directory | docs/supervisor |

**Override semantics**:

- File absent → all fields take defaults; the skill must not crash on a missing file.
- File present but empty (`{}`) → all fields take defaults; the skill must not crash on an empty file.
- File present with a subset of fields → named fields override defaults; absent fields take the default value.
- File present with all fields → each field's value is honoured uniformly.

The supervisor handles file-not-found and empty-JSON-document cases gracefully — no exception raised, defaults applied silently.

The `report_directory` value is interpreted as a path relative to the project root. The `epic_gate_authority` and `spike_gate_authority` fields each take the value `supervisor` (the default, meaning the supervisor may approve the corresponding gate autonomously) or `directing_party` (meaning the gate is reserved to the directing party). Task gates are always supervisor authority and not configurable per the *Gate Authority Split* business rule. The fixed-floor gates (Vision, Features) are always directing-party authority and not configurable.

## Hook Integration

The supervisor integrates with five Claude Code hook points; each is implemented by a sibling work item:

- **PreToolUse** — write-guard refusing writes outside the configured `report_directory`, with an explicit exception for `./docs/knowledge_index.md`.
- **PostToolUse** — audit log recording each tool invocation with timestamp and arguments.
- **SessionStart** — terse health summary at session open.
- **preCompact** — snapshot of in-flight findings to disk before context compaction.
- **Stop** — completion check on autonomous runs (warn on context threshold or unflushed findings).

Hook event activations are not user-message responses and do not emit the self-identification line — the supervisor performs its hook role silently and writes its output to the relevant location (the audit log for PostToolUse, the report findings buffer for preCompact, etc.).

## Failure Modes

- **Configuration file malformed** — If `./.claude/shannon-supervisor.json` exists but is not valid JSON, surface the parse error explicitly and refuse to run rather than silently fall back to defaults. A malformed configuration is a directing-party error and should be visible.
- **`report_directory` writable but outside scope** — If the configured `report_directory` is outside the project tree, the PreToolUse hook will refuse writes; surface the configuration mismatch explicitly.
- **Checker subagent failure** — If one of the three checkers fails to return a finding fragment, surface the failure in the report header (counts of successful checkers) rather than failing the entire run.

## Self-Identification

The self-identification line — *"Activating shannon-supervisor skill for [verb]."* — is emitted **only** when this skill activates in response to a direct slash-command invocation (`/shannon-report`). Hook-event activations and autonomous-cadence invocations do not emit the self-identification line; they are not user-message responses.

If this skill cannot perform its work for any reason, it must say so explicitly rather than silently doing something else.
