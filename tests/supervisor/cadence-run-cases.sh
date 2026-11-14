#!/bin/bash
# Shipped-executable cases for scripts/cadence-run.sh, with a fake `claude` on PATH
# (development_guide.md § Testing Strategy). No model is called. Usage:
#   tests/supervisor/cadence-run-cases.sh [path/to/cadence-run.sh] [work-dir]
# Defaults: the script in this checkout, and a new temporary directory (removed on exit).
export GIT_AUTHOR_NAME=shannon-tests GIT_AUTHOR_EMAIL=tests@example.invalid GIT_COMMITTER_NAME=shannon-tests GIT_COMMITTER_EMAIL=tests@example.invalid
C=$(cd "$(dirname "${1:-shannon/skills/shannon-supervisor/scripts/cadence-run.sh}")" && pwd)/$(basename "${1:-cadence-run.sh}"); pass=0; fail=0
if [ -n "$2" ]; then W=$2; else W=$(mktemp -d); trap 'rm -rf "$W"' EXIT; fi
ck(){ if [ "$2" = "$3" ]; then pass=$((pass+1)); echo "PASS $1"; else fail=$((fail+1)); echo "FAIL $1 got[$3]"; fi; }
mkdir -p "$W/bin" "$W/wt"
cat > "$W/bin/claude" <<'EOF'
#!/bin/bash
[ "${FAKE_MODE:-ok}" = "ok" ] || { echo '{"is_error":true}'; exit 1; }
mkdir -p docs/supervisor docs/knowledge
echo "# report" > "docs/supervisor/report-$(date +%Y-%m-%d).md"
echo "stray" > docs/stray.md
[ "${FAKE_INDEX:-yes}" = yes ] && echo "- report" >> docs/knowledge/knowledge_index.md
echo '{"result":"ok"}'
EOF
chmod +x "$W/bin/claude"
mkdir -p "$W/p"; cd "$W/p"; git init -q; git commit -q --allow-empty -m init
mkdir -p .claude; echo '{"report_directory":"docs/supervisor","cadence":{"min_interval_hours":20}}' > .claude/shannon-supervisor.json
echo ".claude/" > .gitignore; git add .gitignore; git commit -q -m ignore
export PATH="$W/bin:$PATH" SHANNON_WORKTREE_DIR="$W/wt"
FAKE_MODE=fail bash "$C" >/dev/null 2>&1; rc=$?
st=.claude/supervisor/state.json
ck "failed run exits non-zero" "1" "$([ $rc -ne 0 ] && echo 1)"
ck "failed run records attempt epoch" "true" "$(jq '.last_run_epoch > 0' $st)"
ck "failed run names no branch" "null:null" "$(jq -r '.last_run_branch // "null"' $st):$(jq -r '.last_report_branch // "null"' $st)"
ck "failed run branch deleted" "0" "$(git branch --list 'supervisor/*' | wc -l | tr -d ' ')"
FAKE_MODE=ok bash "$C" >/dev/null 2>&1; ck "second attempt within interval is skipped" "0" "$(git branch --list 'supervisor/*' | wc -l | tr -d ' ')"
jq '.last_run_epoch=0' $st > $st.t && mv $st.t $st
FAKE_MODE=ok bash "$C" >/dev/null 2>&1; rc=$?
ck "successful run exits 0" "0" "$rc"
b=$(jq -r '.last_report_branch' $st)
ck "last_report_branch names an existing branch" "1" "$(git branch --list "$b" | wc -l | tr -d ' ')"
ck "commit holds only report and index" "docs/knowledge/knowledge_index.md docs/supervisor/report-$(date +%Y-%m-%d).md" "$(git show --name-only --format= "$b" | sort | tr '\n' ' ' | sed 's/ $//')"
ck "status 0 recorded" "0" "$(jq '.last_run_status' $st)"
jq '.last_run_epoch=0' $st > $st.t && mv $st.t $st; git branch -q -D "$b"
FAKE_INDEX=no FAKE_MODE=ok bash "$C" >/dev/null 2>&1; rc=$?
ck "report without index is still committed" "0:docs/supervisor/report-$(date +%Y-%m-%d).md" "$rc:$(git show --name-only --format= "$(jq -r .last_report_branch $st)" | tr '\n' ' ' | sed 's/ $//')"
echo "passed=$pass failed=$fail"; [ $fail -eq 0 ]
