# Remove the scheduled-sop-runner skill from ~/.claude (or $env:CLAUDE_CONFIG_DIR).
$ErrorActionPreference = 'Stop'
$claudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }
Remove-Item -Recurse -Force (Join-Path $claudeDir 'skills\scheduled-sop-runner') -ErrorAction SilentlyContinue
Write-Host "scheduled-sop-runner uninstalled from $claudeDir."
