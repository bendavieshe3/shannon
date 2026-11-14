# tests/

Case scripts for the executables Shannon ships. These implement the *Shipped-executable test* level in `docs/development_guide.md` § Testing Strategy. They are run by hand before committing a change to the script they cover. They are repository tooling: `/shannon-setup` never deploys them into a project.

Each script works in a new temporary directory, so it neither reads nor changes this checkout's `docs/` or `.claude/`. Each one prints one `PASS` or `FAIL` line per case, then a `passed=N failed=M` total, and exits non-zero if any case failed. Run them from the repository root. You need `bash`, `jq` and `git`.

| Script | Covers | Cases |
|---|---|---|
| `supervisor/writeguard-cases.sh` | `scripts/pretool-writeguard.sh` | Inert outside scope; relative and absolute paths into the report directory; nested worktree; the knowledge-index exception; refusal of other project files, paths outside the project, the prefix trick, `..` escapes; NotebookEdit's `notebook_path`; reads pass |
| `supervisor/stop-precompact-cases.sh` | `scripts/stop-flushcheck.sh`, `scripts/precompact-marker.sh` | Per-run directories: block once with fragments and no report; `stop_hook_active`; a same-day rerun ignores the earlier report; PreCompact marks only the open run; runs older than 24 hours ignored; a report directory containing a space |
| `supervisor/cadence-run-cases.sh` | `scripts/cadence-run.sh` | Uses a fake `claude`, so no model runs. Failed run (branch deleted, attempt recorded); throttled retry; successful run commits only the report and index; state fields; a report without an index is still committed |

```bash
bash tests/supervisor/writeguard-cases.sh
bash tests/supervisor/stop-precompact-cases.sh
bash tests/supervisor/cadence-run-cases.sh
```

Two supervisor scripts have no case script yet. `posttool-auditlog.sh` and `sessionstart-summary.sh` were tested when they were built, and their cases are recorded in TASK-017 and TASK-025. Before changing either script, add a case script for it here.
