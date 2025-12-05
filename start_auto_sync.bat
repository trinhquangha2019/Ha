@echo off
REM Script chạy auto sync GitHub nền - không hiển thị cửa sổ
REM Tác giả: Dasi

echo Starting auto sync GitHub in background...
cd /d "%~dp0"
start "" /B powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0auto_sync_github_background.ps1"
echo Auto sync started! Check auto_sync_log.txt for status.
timeout /t 2 /nobreak >nul
if exist "auto_sync_log.txt" (
    echo Log file created successfully!
    type "auto_sync_log.txt"
) else (
    echo Warning: Log file not created yet. Script may still be starting...
)

