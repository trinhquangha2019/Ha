# Script kiểm tra auto sync có đang chạy không
# Tác giả: Dasi

Write-Host "🔍 KIỂM TRA AUTO SYNC" -ForegroundColor Cyan
Write-Host "===================`n" -ForegroundColor Cyan

# 1. Kiểm tra process
Write-Host "1️⃣ Kiểm tra process đang chạy..." -ForegroundColor Yellow
$processes = @()
Get-Process powershell -ErrorAction SilentlyContinue | ForEach-Object {
    $cmd = (Get-WmiObject Win32_Process -Filter "ProcessId = $($_.Id)" -ErrorAction SilentlyContinue).CommandLine
    if ($cmd -like "*auto_sync*") {
        $processes += [PSCustomObject]@{
            PID = $_.Id
            CommandLine = $cmd
        }
    }
}

if ($processes.Count -eq 0) {
    Write-Host "   ✅ Không có process auto sync nào đang chạy!" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  Tìm thấy $($processes.Count) process đang chạy:" -ForegroundColor Red
    foreach ($proc in $processes) {
        Write-Host "      - PID: $($proc.PID)" -ForegroundColor Red
        Write-Host "        Command: $($proc.CommandLine.Substring(0, [Math]::Min(100, $proc.CommandLine.Length)))..." -ForegroundColor Gray
    }
}

Write-Host ""

# 2. Kiểm tra log file
Write-Host "2️⃣ Kiểm tra log file..." -ForegroundColor Yellow
$logFile = "auto_sync_log.txt"
if (Test-Path $logFile) {
    $lastLog = Get-Content $logFile -Tail 1 -ErrorAction SilentlyContinue
    $currentTime = Get-Date
    
    if ($lastLog) {
        Write-Host "   📝 Log cuối cùng: $lastLog" -ForegroundColor Gray
        
        # Parse thời gian từ log
        if ($lastLog -match '\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\]') {
            $lastLogTime = [DateTime]::ParseExact($matches[1], "yyyy-MM-dd HH:mm:ss", $null)
            $timeDiff = ($currentTime - $lastLogTime).TotalMinutes
            
            Write-Host "   ⏰ Thời gian log cuối: $($lastLogTime.ToString('HH:mm:ss'))" -ForegroundColor Gray
            Write-Host "   ⏰ Thời gian hiện tại: $($currentTime.ToString('HH:mm:ss'))" -ForegroundColor Gray
            Write-Host "   ⏱️  Cách đây: $([Math]::Round($timeDiff, 1)) phút" -ForegroundColor Gray
            
            if ($timeDiff -gt 2) {
                Write-Host "   ✅ Không có hoạt động mới - Auto sync đã dừng!" -ForegroundColor Green
            } else {
                Write-Host "   ⚠️  Có hoạt động gần đây - Có thể vẫn đang chạy!" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "   ℹ️  Log file rỗng" -ForegroundColor Gray
    }
} else {
    Write-Host "   ℹ️  Không tìm thấy log file" -ForegroundColor Gray
}

Write-Host ""

# 3. Tổng kết
Write-Host "📊 TỔNG KẾT" -ForegroundColor Cyan
Write-Host "===========" -ForegroundColor Cyan

if ($processes.Count -eq 0) {
    Write-Host "✅ Auto sync đã DỪNG hoàn toàn!" -ForegroundColor Green
    Write-Host "   - Không có process nào đang chạy" -ForegroundColor Green
    Write-Host "   - Không có hoạt động mới trong log" -ForegroundColor Green
} else {
    Write-Host "⚠️  Auto sync VẪN ĐANG CHẠY!" -ForegroundColor Red
    Write-Host "   - Tìm thấy $($processes.Count) process" -ForegroundColor Red
    Write-Host "   - Chạy: .\stop_auto_sync.ps1 để dừng" -ForegroundColor Yellow
}

Write-Host ""

