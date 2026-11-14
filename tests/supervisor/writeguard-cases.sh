#!/bin/bash
# Shipped-executable cases for scripts/pretool-writeguard.sh (development_guide.md § Testing Strategy).
# Usage: tests/supervisor/writeguard-cases.sh [path/to/pretool-writeguard.sh]
# Works in a fresh temporary git repository; touches nothing in this checkout.
G=$(cd "$(dirname "${1:-shannon/skills/shannon-supervisor/scripts/pretool-writeguard.sh}")" && pwd)/$(basename "${1:-pretool-writeguard.sh}"); T=$(mktemp -d); mkdir -p $T/proj; cd $T/proj; git init -q; mkdir -p wt; git worktree add -q -b w $T/proj/.claude/wt 2>/dev/null || { git commit -q --allow-empty -m i; git worktree add -q -b w $T/proj/.claude/wt; }
P=$PWD; W=$P/.claude/wt; pass=0; fail=0
t(){ printf '%s' "$3" | env $4 $G >/dev/null 2>&1; rc=$?; if [ "$rc" = "$2" ]; then pass=$((pass+1)); echo "PASS $1"; else fail=$((fail+1)); echo "FAIL $1 (rc=$rc)"; fi; }
t "inert without scope" 0 '{"tool_name":"Write","tool_input":{"file_path":"/etc/x"}}' "X=1"
t "relative report path allowed" 0 '{"tool_name":"Write","tool_input":{"file_path":"docs/supervisor/r.md"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "absolute report path allowed (cwd)" 0 '{"tool_name":"Write","cwd":"'$P'","tool_input":{"file_path":"'$P'/docs/supervisor/r.md"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "absolute report path allowed (CLAUDE_PROJECT_DIR)" 0 '{"tool_name":"Write","tool_input":{"file_path":"'$P'/docs/supervisor/.in-progress/d/a.md"}}' "SHANNON_SUPERVISOR_SCOPE=1 CLAUDE_PROJECT_DIR=$P"
t "nested worktree, project dir = main root" 0 '{"tool_name":"Write","cwd":"'$W'","tool_input":{"file_path":"'$W'/docs/supervisor/r.md"}}' "SHANNON_SUPERVISOR_SCOPE=1 CLAUDE_PROJECT_DIR=$P"
t "nested worktree index exception" 0 '{"tool_name":"Edit","cwd":"'$W'","tool_input":{"file_path":"'$W'/docs/knowledge/knowledge_index.md"}}' "SHANNON_SUPERVISOR_SCOPE=1 CLAUDE_PROJECT_DIR=$P"
t "nested worktree other file refused" 2 '{"tool_name":"Edit","cwd":"'$W'","tool_input":{"file_path":"'$W'/docs/vision.md"}}' "SHANNON_SUPERVISOR_SCOPE=1 CLAUDE_PROJECT_DIR=$P"
t "absolute index exception allowed" 0 '{"tool_name":"Edit","cwd":"'$P'","tool_input":{"file_path":"'$P'/docs/knowledge/knowledge_index.md"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "absolute other project file refused" 2 '{"tool_name":"Edit","cwd":"'$P'","tool_input":{"file_path":"'$P'/docs/vision.md"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "absolute path outside project refused" 2 '{"tool_name":"Write","cwd":"'$P'","tool_input":{"file_path":"/etc/passwd"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "prefix trick refused" 2 '{"tool_name":"Write","cwd":"'$P'","tool_input":{"file_path":"'$P'-evil/docs/supervisor/r.md"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "dotdot escape refused" 2 '{"tool_name":"Write","cwd":"'$P'","tool_input":{"file_path":"'$P'/docs/supervisor/../vision.md"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "relative other file refused" 2 '{"tool_name":"Write","tool_input":{"file_path":"src/app.js"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "NotebookEdit outside report dir refused" 2 '{"tool_name":"NotebookEdit","cwd":"'$P'","tool_input":{"notebook_path":"'$P'/nb.ipynb"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "NotebookEdit in report dir allowed" 0 '{"tool_name":"NotebookEdit","cwd":"'$P'","tool_input":{"notebook_path":"'$P'/docs/supervisor/nb.ipynb"}}' "SHANNON_SUPERVISOR_SCOPE=1"
t "Read passes" 0 '{"tool_name":"Read","tool_input":{"file_path":"/etc/passwd"}}' "SHANNON_SUPERVISOR_SCOPE=1"
echo "passed=$pass failed=$fail"; [ $fail -eq 0 ]
