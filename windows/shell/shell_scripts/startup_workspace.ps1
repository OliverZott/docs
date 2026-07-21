# --- Developer Workspace Auto-Restore Script ---
# This script reopens your full dev environment after reboot
# No 3rd party tools required

Write-Host "Restoring developer workspace..."

# --- VS Code ---
$vsCodePath = "C:\Program Files\Microsoft VS Code\Code.exe"
if (Test-Path $vsCodePath) {
    Start-Process $vsCodePath
    Start-Sleep -Seconds 2
}

# --- Visual Studio 2026 ---
$vsPath = "C:\Program Files\Microsoft Visual Studio\2026\Community\Common7\IDE\devenv.exe"
if (Test-Path $vsPath) {
    Start-Process $vsPath
    Start-Sleep -Seconds 3
}

# --- Postman ---
$postmanPath = "$env:LOCALAPPDATA\Postman\Postman.exe"
if (Test-Path $postmanPath) {
    Start-Process $postmanPath
    Start-Sleep -Seconds 2
}

# --- Microsoft Edge (restore last session) ---
Start-Process "msedge.exe" "--restore-last-session"
Start-Sleep -Seconds 2

Write-Host "All apps launched. You can now create your virtual desktops."
