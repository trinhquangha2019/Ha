@echo off
REM Script dừng auto sync GitHub
REM Tác giả: Dasi

echo Stopping auto sync GitHub...
echo.

REM Dừng tất cả process PowerShell chạy auto sync script
taskkill /F /FI "COMMANDLINE eq *auto_sync_github_background.ps1*" 2>nul
taskkill /F /FI "COMMANDLINE eq *auto_sync_github.ps1*" 2>nul
taskkill /F /FI "COMMANDLINE eq *auto_sync_instant.ps1*" 2>nul
taskkill /F /FI "COMMANDLINE eq *auto_sync*" 2>nul

REM Dùng PowerShell để dừng chính xác hơn
powershell -Command "Get-WmiObject Win32_Process | Where-Object {$_.CommandLine -like '*auto_sync*'} | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"

echo.
echo Auto sync stopped!
echo.
pause


