#!/usr/bin/env bash
# Unattended supervisor run for a scheduler (cron, launchd, or any equivalent).
#
# Usage: cadence-run.sh [project-root]      (default: current directory)
#
# 1. Throttles: skips if the last run was less than cadence.min_interval_hours ago
#    (shannon-supervisor.json; default 20) per .claude/supervisor/state.json.
# 2. Creates a git worktree on a new branch supervisor/report-YYYY-MM-DD at HEAD, outside
#    the project (under $SHANNON_WORKTREE_DIR, else $TMPDIR, else /tmp), so an interactive
#    session's working tree is never touched. It must not sit under .claude/: Claude Code
#    treats every path below a .claude/ directory as sensitive and refuses to write there.
#    Copies the project's .claude/ in when it is not tracked by git.
# 3. Runs Claude Code headless with SHANNON_SUPERVISOR_SCOPE set, so the write-guard,
#    audit log, PreCompact and Stop hooks are active. The model gets read-only tools plus
#    Write/Edit (fenced to the report directory by the write-guard). It never gets git
#    commit or push: this script does those itself.
# 4. Commits only the report directory and the knowledge index: one commit per run,
#    "Supervisor report YYYY-MM-DD". Pushes the branch only if cadence.push is true and an
#    origin remote exists. The report reaches the main branch through the project's
#    normal review route (for Shannon itself, a reviewed pull request).
# 5. Removes the worktree, keeps the branch, records last_run, and exits with the run's
#    status. Needs: git, jq, claude on PATH, and Claude Code authentication available to
#    the scheduler's environment.
set -euo pipefail

root="$(cd "${1:-.}" && git rev-parse --show-toplevel)"
cd "$root"

config=".claude/shannon-supervisor.json"
state=".claude/supervisor/state.json"
min_hours=20
push=false
report_dir="docs/supervisor"
if [ -f "$config" ]; then
  jq empty "$config" 2>/dev/null || { echo "cadence-run: malformed $config" >&2; exit 2; }
  min_hours="$(jq -r '.cadence.min_interval_hours // 20' "$config")"
  push="$(jq -r '.cadence.push // false' "$config")"
  report_dir="$(jq -r '.report_directory // "docs/supervisor"' "$config")"
fi
report_dir="${report_dir#./}"; report_dir="${report_dir%/}"

now="$(date +%s)"
if [ -f "$state" ] && jq empty "$state" 2>/dev/null; then
  last="$(jq -r '.last_run_epoch // 0' "$state")"
  if [ $(( now - last )) -lt $(( min_hours * 3600 )) ]; then
    echo "cadence-run: skipped; last run under ${min_hours}h ago"
    exit 0
  fi
fi

today="$(date +%Y-%m-%d)"
branch="supervisor/report-$today"
n=2
while git show-ref --verify --quiet "refs/heads/$branch"; do
  branch="supervisor/report-$today-$n"; n=$((n + 1))
done
wt_parent="${SHANNON_WORKTREE_DIR:-${TMPDIR:-/tmp}}"
wt_parent="${wt_parent%/}"
wt="$wt_parent/shannon-$(basename "$root")-${branch//\//-}-$$"
git worktree add -q -b "$branch" "$wt" HEAD

cleanup() { cd "$root"; git worktree remove --force "$wt" 2>/dev/null || true; }
trap cleanup EXIT

if [ -z "$(git ls-files .claude | head -n 1)" ]; then
  mkdir -p "$wt/.claude"
  (cd .claude && tar cf - --exclude=./supervisor --exclude=./.shannon-backup .) | (cd "$wt/.claude" && tar xf -)
fi

log_dir=".claude/supervisor/logs"
mkdir -p "$log_dir"
log="$root/$log_dir/run-$today-$$.json"

cd "$wt"
set +e
SHANNON_SUPERVISOR_SCOPE=cadence claude -p "/shannon-report" \
  --allowedTools "Skill,Agent,Task,Read,Glob,Grep,Write,Edit,Bash(git status*),Bash(git log*),Bash(git diff*),Bash(git rev-list*),Bash(git branch*),Bash(git rev-parse*),Bash(date*),Bash(ls*)" \
  --output-format json < /dev/null > "$log" 2> "${log%.json}.err"
status=$?
set -e

git add -- "$report_dir" docs/knowledge/knowledge_index.md 2>/dev/null || true
git reset -q -- "$report_dir/.in-progress" 2>/dev/null || true
if ! git diff --cached --quiet; then
  git -c user.name="${SHANNON_SUPERVISOR_GIT_NAME:-Shannon supervisor}" \
      -c user.email="${SHANNON_SUPERVISOR_GIT_EMAIL:-supervisor@localhost}" \
      commit -q -m "Supervisor report $today" -m "Unattended cadence run (scripts/cadence-run.sh); claude exit status $status."
  if [ "$push" = "true" ] && git remote get-url origin >/dev/null 2>&1; then
    git push -q -u origin "$branch" || status=3
  fi
  echo "cadence-run: committed report on $branch"
else
  echo "cadence-run: no report produced (claude exit status $status); see $log" >&2
  cd "$root"; git worktree remove --force "$wt"; git branch -q -D "$branch"
  [ "$status" -eq 0 ] && status=4
fi

cd "$root"
mkdir -p "$(dirname "$state")"
if [ -f "$state" ] && jq empty "$state" 2>/dev/null; then
  jq --argjson t "$now" --arg b "$branch" --argjson s "$status" '.last_run_epoch=$t | .last_run_branch=$b | .last_run_status=$s' "$state" > "$state.tmp"
else
  jq -n --argjson t "$now" --arg b "$branch" --argjson s "$status" '{last_run_epoch:$t, last_run_branch:$b, last_run_status:$s}' > "$state.tmp"
fi
mv "$state.tmp" "$state"
exit "$status"
