# scheduled-sop-runner for Claude Code

[![License: MIT](https://img.shields.io/github/license/Zavelinski/claude-code-scheduled-sop-runner)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Zavelinski/claude-code-scheduled-sop-runner?style=flat)](https://github.com/Zavelinski/claude-code-scheduled-sop-runner/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Zavelinski/claude-code-scheduled-sop-runner)](https://github.com/Zavelinski/claude-code-scheduled-sop-runner/commits)
[![Claude Code skill](https://img.shields.io/badge/Claude%20Code-skill-8A2BE2)](https://claude.com/claude-code)

A [Claude Code](https://claude.com/claude-code) skill that turns a repeatable task or SOP into a **quiet, self-checking scheduled routine**. It runs on a cadence, checks whether the run actually succeeded, and **only pings you when something fails** or a success condition is not met. No news is good news.

## Prerequisites

Claude Code with `/plugin` support (v2.x+) and a shell if you use the manual fallback.

## Install

### Option 1 — Claude Code plugin marketplace (recommended)

```bash
/plugin marketplace add Zavelinski/claude-code-skills
/plugin install scheduled-sop-runner@claude-code-skills
```

Registered hooks (if any) install through the Claude Code consent UI, with no manual edit to `~/.claude/settings.json`.

### Option 2 — Manual fallback (run it yourself)

> **Security note.** This script mutates `~/.claude/settings.json` directly. Claude Code auto-mode blocks it because a third-party `UserPromptSubmit` hook that injects text into every prompt is a known risk vector. The script is benign and local-only (no network), but you must review and run it yourself. Prefer Option 1.

```bash
git clone https://github.com/Zavelinski/claude-code-scheduled-sop-runner.git
cd claude-code-scheduled-sop-runner
bash install.sh        # macOS / Linux
.\install.ps1          # Windows (PowerShell)
```

## Uninstall

```bash
/plugin uninstall scheduled-sop-runner@claude-code-skills    # Option 1
bash uninstall.sh                                # Option 2 (or uninstall.ps1 on Windows)
```

## Update

```bash
/plugin marketplace update claude-code-skills    # Option 1
# Option 2: pull the latest commit and re-run the manual fallback.
```

## Why it exists

Platform schedulers (`/schedule`, `/loop`, cron, scheduled-tasks) run things on a timer — but on their own they do not define what *success* means for a run, and they happily notify you on every run. This skill adds the missing layer:

- a **success predicate** (a verifiable check, not "it worked"),
- a **notify-only-on-exception** contract (silent on healthy runs), and
- a **run log** so a silent week is still auditable.

## What it does

1. **Capture** the routine as a small spec (`run`, `schedule`, `success_when`, `notify`, `retain`).
2. **Make success verifiable** — refuses vague success; extracts a concrete check (HTTP status, exit code, row count, file written today, string present).
3. **Pick the best available scheduler** in your environment (cloud Routines / `/schedule`, `/loop`, a cron MCP, or `CronCreate`) and says which it used.
4. **Wire quiet-unless-needed** — evaluates `success_when` after each run; stays silent on success, notifies with the failing check + log tail on failure.
5. **Recovery-first** — anything sensitive or hard to reverse is *proposed for approval*, never auto-run.

## Example

```
You: every morning at 7, run my "db backup verify" SOP and only ping me if it fails.
```
The skill captures it as:
```yaml
name: db-backup-verify
schedule: "0 7 * * *"
run: run the db-backup-verify SOP
success_when: "last night's backup file exists and restores a test row"
notify: { when: on_exception, channel: chat, include: failing check + last 10 log lines }
retain: 30
```
Then it wires it to your scheduler and goes quiet — you only hear from it the morning a backup didn't verify.

## License

MIT. See [LICENSE](LICENSE). Original work.

Part of the **[claude-code-skills](https://github.com/Zavelinski/claude-code-skills)** collection: a suite of focused, original Claude Code skills.