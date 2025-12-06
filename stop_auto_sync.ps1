# Script dừng auto sync GitHub (PowerShell)
# Tác giả: Dasi
# Cách dùng: .\stop_auto_sync.ps1

Write-Host "🛑 Đang dừng auto sync GitHub..." -ForegroundColor Yellow
Write-Host ""

# Tìm tất cả process PowerShell chạy auto sync
$processes = Get-WmiObject Win32_Process | Where-Object {
    $_.CommandLine -like "*auto_sync_github_background.ps1*" -or
    $_.CommandLine -like "*auto_sync_github.ps1*" -or
    $_.CommandLine -like "*auto_sync_instant.ps1*" -or
    $_.CommandLine -like "*auto_sync*"
}

if ($processes) {
    Write-Host "📋 Tìm thấy $($processes.Count) process đang chạy:" -ForegroundColor Cyan
    foreach ($proc in $processes) {
        Write-Host "  - Process ID: $($proc.ProcessId)" -ForegroundColor Gray
        Write-Host "    Command: $($proc.CommandLine.Substring(0, [Math]::Min(80, $proc.CommandLine.Length)))..." -ForegroundColor Gray
        
        try {
            Stop-Process -Id $proc.ProcessId -Force -ErrorAction Stop
            Write-Host "    ✅ Đã dừng!" -ForegroundColor Green
        } catch {
            Write-Host "    ❌ Không thể dừng: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    Write-Host ""
    Write-Host "✅ Đã dừng tất cả auto sync!" -ForegroundColor Green
} else {
    Write-Host "ℹ️  Không tìm thấy process auto sync nào đang chạy." -ForegroundColor Cyan
}

Write-Host ""
Write-Host "🔍 Đang kiểm tra lại..." -ForegroundColor Yellow
$remaining = Get-WmiObject Win32_Process | Where-Object {$_.CommandLine -like "*auto_sync*"}
if ($remaining) {
    Write-Host "⚠️  Vẫn còn $($remaining.Count) process!" -ForegroundColor Red
} else {
    Write-Host "✅ Không còn process nào đang chạy!" -ForegroundColor Green
}




