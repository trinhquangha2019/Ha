@echo off
REM Script dừng auto sync GitHub
REM Tác giả: Dasi

echo Stopping auto sync GitHub...
taskkill /F /FI "WINDOWTITLE eq PowerShell*" /FI "COMMANDLINE eq *auto_sync_github.ps1*" 2>nul
taskkill /F /IM powershell.exe /FI "COMMANDLINE eq *auto_sync_github.ps1*" 2>nul
echo Auto sync stopped!


