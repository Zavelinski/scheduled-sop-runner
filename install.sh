#!/usr/bin/env bash
# Install the scheduled-sop-runner skill into ~/.claude (or $CLAUDE_CONFIG_DIR).
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

mkdir -p "$claude_dir/skills/scheduled-sop-runner"
cp "$repo/skills/scheduled-sop-runner/SKILL.md" "$claude_dir/skills/scheduled-sop-runner/SKILL.md"

echo ""
echo "scheduled-sop-runner installed into $claude_dir"
echo "Restart Claude Code, then ask to 'schedule this SOP' (or /scheduled-sop-runner)."
