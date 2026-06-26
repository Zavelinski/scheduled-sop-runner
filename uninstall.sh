#!/usr/bin/env bash
# Remove the scheduled-sop-runner skill from ~/.claude (or $CLAUDE_CONFIG_DIR).
set -euo pipefail
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
rm -rf "$claude_dir/skills/scheduled-sop-runner"
echo "scheduled-sop-runner uninstalled from $claude_dir."
