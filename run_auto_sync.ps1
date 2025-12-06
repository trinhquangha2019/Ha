# Script chạy auto sync trong background job
$scriptPath = "C:\AI"
Set-Location $scriptPath

# Chạy script trong background job
$job = Start-Job -ScriptBlock {
    Set-Location "C:\AI"
    & "C:\AI\auto_sync_github_background.ps1"
}

Write-Host "Auto sync đã được khởi động trong background job (ID: $($job.Id))"
Write-Host "Kiểm tra log file: auto_sync_log.txt"




