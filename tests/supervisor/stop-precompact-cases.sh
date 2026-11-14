#!/bin/bash
# Shipped-executable cases for scripts/stop-flushcheck.sh and scripts/precompact-marker.sh
# (development_guide.md § Testing Strategy). Usage:
#   tests/supervisor/stop-precompact-cases.sh [scripts-dir] [work-dir]
# Defaults: the supervisor's scripts in this checkout, and a new temporary directory.
D=$(cd "${1:-shannon/skills/shannon-supervisor/scripts}" && pwd); W=${2:-$(mktemp -d)}; pass=0; fail=0
ck(){ if [ "$2" = "$3" ]; then pass=$((pass+1)); echo "PASS $1"; else fail=$((fail+1)); echo "FAIL $1 got[$3]"; fi; }
setup(){ mkdir -p "$W/$1/.claude" "$W/$1/docs/my reports"; cd "$W/$1"; echo '{"report_directory":"docs/my reports"}' > .claude/shannon-supervisor.json; R="docs/my reports"; }
st(){ printf '%s' "${1:-{\}}" | SHANNON_SUPERVISOR_SCOPE=1 bash "$D/stop-flushcheck.sh" | jq -r '.decision // empty' 2>/dev/null; }
pc(){ printf '{"trigger":"%s"}' "$1" | SHANNON_SUPERVISOR_SCOPE=1 bash "$D/precompact-marker.sh"; }

setup a
ck "no in-progress: silent" "" "$(st)"
ck "out of scope silent" "" "$(echo '{}' | bash "$D/stop-flushcheck.sh")"
pc auto; ck "precompact with no run is a no-op" "0" "$(find "$R" -name COMPACTED | wc -l)"
r1="$R/.in-progress/2026-11-14-090000"; mkdir -p "$r1"; date > "$r1/RUN"; sleep 1
echo a > "$r1/alignment.md"; echo d > "$r1/drift.md"
ck "run1 fragments, no report: block" "block" "$(st)"
ck "stop_hook_active allows" "" "$(st '{"stop_hook_active":true}')"
pc manual; ck "precompact marks run1" "1" "$(grep -c manual "$r1/COMPACTED")"
sleep 1; echo rep > "$R/report-2026-11-14.md"
ck "run1 report written: allow" "" "$(st)"
sleep 1; r2="$R/.in-progress/2026-11-14-100000"; mkdir -p "$r2"; date > "$r2/RUN"; sleep 1
echo a2 > "$r2/alignment.md"
ck "same-day run2: earlier report does not count: block" "block" "$(st)"
pc auto; ck "precompact marks run2 only" "1:1" "$(grep -c . "$r2/COMPACTED"):$(grep -c . "$r1/COMPACTED")"
sleep 1; echo rep2 > "$R/report-2026-11-14-2.md"
ck "run2 report: allow" "" "$(st)"

setup b
r3="$R/.in-progress/2026-11-10-100000"; mkdir -p "$r3"; date > "$r3/RUN"; echo x > "$r3/drift.md"
touch -d '3 days ago' "$r3/RUN"
ck "run older than 24h ignored" "" "$(st)"
pc auto; ck "precompact ignores stale run" "0" "$(find "$R" -name COMPACTED | wc -l)"
r4="$R/.in-progress/2026-11-14-110000"; mkdir -p "$r4"; date > "$r4/RUN"
ck "open run, no fragments yet: silent" "" "$(st)"
echo "passed=$pass failed=$fail"; [ $fail -eq 0 ]
