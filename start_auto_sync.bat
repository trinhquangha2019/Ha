@echo off
REM Script chạy auto sync GitHub nền - không hiển thị cửa sổ
REM Tác giả: Dasi

echo Starting auto sync GitHub in background...
start /B powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0auto_sync_github_background.ps1"
echo Auto sync started! Check task manager to see the process.

