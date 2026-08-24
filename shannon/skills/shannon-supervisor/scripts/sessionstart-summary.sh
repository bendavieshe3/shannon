#!/usr/bin/env bash
# SessionStart health-summary hook for the Shannon supervisor.
#
# Injects a terse health line at session open by reading the most-recent report
# under the configured report_directory (default docs/supervisor). The line leads
# with the Drift-category count — read from the report header's "**By category:**"
# line (TASK-028) — where the report header itself leads with the total. Emits to
# stdout, writes nothing, and always exits 0.
#
# Deliberately NOT gated on SHANNON_SUPERVISOR_SCOPE: read-only session orientation
# is its purpose, so it must fire in ordinary sessions. The mute lever is instead the
# optional Cadence State file .claude/supervisor/state.json; a missing or malformed
# state file leaves the hook firing normally. Reads the SessionStart event JSON on
# stdin per the hook contract, but needs no field from it.
set -u

default_report_dir="docs/supervisor"
config_path=".claude/shannon-supervisor.json"
state_path=".claude/supervisor/state.json"

# Consume stdin so the hook contract is clean, even though no field is needed.
cat >/dev/null 2>&1 || true

# --- Mute lever (AC#7): a valid state file may silence the session-start summary. ---
# A missing or malformed state file is NOT a mute — fall through and fire.
if [ -f "$state_path" ]; then
  muted="$(jq -r '.mute_session_start // false' "$state_path" 2>/dev/null)"
  if [ "$muted" = "true" ]; then
    exit 0
  fi
fi

# --- Resolve report_directory: config override if present, else default. ---
report_dir="$default_report_dir"
if [ -f "$config_path" ]; then
  configured="$(jq -r '.report_directory // ""' "$config_path" 2>/dev/null)"
  [ -n "$configured" ] && report_dir="$configured"
fi
report_dir="${report_dir#./}"
report_dir="${report_dir%/}"

# --- Most-recent report (AC#2): highest ISO date, then highest -N same-day suffix. ---
# Filenames: report-YYYY-MM-DD.md or report-YYYY-MM-DD-N.md. Sorting the date and a
# zero-padded suffix lexically gives the right winner; bare (no -N) sorts as suffix 0.
latest=""
if [ -d "$report_dir" ]; then
  latest="$(
    for f in "$report_dir"/report-*.md; do
      [ -e "$f" ] || continue
      base="$(basename "$f" .md)"                       # report-YYYY-MM-DD[-N]
      rest="${base#report-}"                            # YYYY-MM-DD[-N]
      date_part="${rest:0:10}"                          # YYYY-MM-DD
      suffix="${rest:10}"                               # "" or "-N"
      suffix="${suffix#-}"                              # "" or "N"
      [ -z "$suffix" ] && suffix=0
      printf '%s %010d %s\n' "$date_part" "$suffix" "$f"
    done | sort | tail -n1 | awk '{print $3}'
  )"
fi

# --- Quiet outcome: no report at all (AC#5a). ---
if [ -z "$latest" ]; then
  printf 'Supervisor: no report has been written yet under %s/. Run /shannon-report to generate one.\n' "$report_dir"
  exit 0
fi

# --- Quiet outcome: report unreadable (AC#5d) — name the path, never fall back to a zero. ---
if [ ! -r "$latest" ]; then
  printf 'Supervisor: the most recent report (%s) could not be read.\n' "$latest"
  exit 0
fi

report_date="$(basename "$latest" .md | sed -E 's/^report-([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')"

# Header lines. Each is matched by its fixed prefix (TASK-028 established these anchors).
findings_line="$(grep -m1 '^\*\*Findings:\*\*' "$latest" 2>/dev/null || true)"
checkers_line="$(grep -m1 '^\*\*Checkers run:\*\*' "$latest" 2>/dev/null || true)"
bycat_line="$(grep -m1 '^\*\*By category:\*\*' "$latest" 2>/dev/null || true)"

# Principal integer of a "**Label:** N ..." line — the first run of digits after the label,
# so "9 (+1 uncertain)" reads 9.
principal() { printf '%s' "$1" | grep -oE '[0-9]+' | head -n1; }

total="$(printf '%s' "$findings_line" | sed -E 's/^\*\*Findings:\*\*[^0-9]*([0-9]+).*/\1/')"
stuck="$(printf '%s' "$findings_line" | sed -E 's/.*Stuck or stale items:\*\*[^0-9]*([0-9]+).*/\1/')"
pushlag="$(printf '%s' "$findings_line" | sed -E 's/.*Push lag:\*\*[^0-9]*([0-9]+).*/\1/')"
checkers_ok="$(printf '%s' "$checkers_line" | sed -E 's/^\*\*Checkers run:\*\*[^0-9]*([0-9]+).*/\1/')"

# --- Age line (AC#6): state the report's date and age in days; no threshold, no warning. ---
age_note=""
today="$(date +%Y-%m-%d)"
today_s="$(date -j -f '%Y-%m-%d' "$today" +%s 2>/dev/null || date -d "$today" +%s 2>/dev/null || echo '')"
report_s="$(date -j -f '%Y-%m-%d' "$report_date" +%s 2>/dev/null || date -d "$report_date" +%s 2>/dev/null || echo '')"
if [ -n "$today_s" ] && [ -n "$report_s" ]; then
  age_days=$(( (today_s - report_s) / 86400 ))
  age_note=" ($age_days day(s) old)"
fi

# --- Quiet outcome: clean run (AC#5b) — a zero total is a positive result, not blank. ---
if [ "${total:-}" = "0" ]; then
  printf 'Supervisor report %s%s: 0 findings, %s stuck, push lag %s. %s of 3 checkers ran cleanly; nothing surfaced.\n' \
    "$report_date" "$age_note" "${stuck:-0}" "${pushlag:-0}" "${checkers_ok:-?}"
  # Partial-run note still applies even on a clean run.
  [ -n "${checkers_ok:-}" ] && [ "$checkers_ok" != "3" ] && \
    printf 'Note: only %s of 3 checkers ran — this is a partial run.\n' "$checkers_ok"
  exit 0
fi

# --- Drift-category count (AC#3): anchored on the "**By category:**" line prefix. ---
# NEVER a bare "Drift" search — that also matches the Checkers-run line and finding headings.
# The separator is a non-ASCII middot; read the integer immediately following "Drift".
lead=""
lead_label=""
if [ -n "$bycat_line" ]; then
  drift="$(printf '%s' "$bycat_line" | sed -E 's/.*Drift[[:space:]]+([0-9]+).*/\1/')"
  if printf '%s' "$drift" | grep -qE '^[0-9]+$'; then
    lead="$drift"
    lead_label="Drift"
  fi
fi

if [ -n "$lead" ]; then
  # Current-format report: lead with the Drift-category count.
  printf 'Supervisor report %s%s: Drift %s · %s stuck · push lag %s (of %s findings total).\n' \
    "$report_date" "$age_note" "$lead" "${stuck:-0}" "${pushlag:-0}" "${total:-?}"
else
  # Legacy path (AC#3): no per-category line — name the total, say the breakdown is unavailable.
  printf 'Supervisor report %s%s: %s findings, %s stuck, push lag %s. Per-category breakdown unavailable (report predates the by-category header line).\n' \
    "$report_date" "$age_note" "${total:-?}" "${stuck:-0}" "${pushlag:-0}"
fi

# --- Partial-run shortfall (AC#5c). ---
if [ -n "${checkers_ok:-}" ] && [ "$checkers_ok" != "3" ]; then
  printf 'Note: only %s of 3 checkers ran — this is a partial run.\n' "$checkers_ok"
fi

# --- Dormant gate-notification branch (AC#4). ---
# Delegated gate-exercise (a later FEAT-009 Epic) will record supervisor-approved gates;
# until it ships, nothing produces that data, so this branch emits nothing.
# if [ -n "$gate_notifications" ]; then printf '%s\n' "$gate_notifications"; fi

exit 0
