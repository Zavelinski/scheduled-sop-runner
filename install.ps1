# Install the scheduled-sop-runner skill into ~/.claude (or $env:CLAUDE_CONFIG_DIR).
$ErrorActionPreference = 'Stop'

$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$claudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }

New-Item -ItemType Directory -Force -Path (Join-Path $claudeDir 'skills\scheduled-sop-runner') | Out-Null
Copy-Item (Join-Path $repo 'skills\scheduled-sop-runner\SKILL.md') (Join-Path $claudeDir 'skills\scheduled-sop-runner\SKILL.md') -Force

Write-Host ""
Write-Host "scheduled-sop-runner installed into $claudeDir"
Write-Host "Restart Claude Code, then ask to 'schedule this SOP' (or /scheduled-sop-runner)."
