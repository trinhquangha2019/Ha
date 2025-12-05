# Script tự động sync GitHub chạy nền (không hiển thị cửa sổ)
# Tác giả: Dasi
# Chạy nền: powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File .\auto_sync_github_background.ps1

# Xác định thư mục làm việc
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($scriptPath)) {
    $scriptPath = "C:\AI"
}
Set-Location $scriptPath

# Ghi log vào file - tạo file ngay từ đầu
$logFile = Join-Path $scriptPath "auto_sync_log.txt"
$syncCount = 0
$lastSyncTime = Get-Date

# Tạo log file ngay từ đầu
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"[$timestamp] 🔄 Auto Sync GitHub - Bắt đầu chạy nền" | Out-File -FilePath $logFile -Encoding UTF8
"[$timestamp] 📁 Thư mục: $scriptPath" | Out-File -FilePath $logFile -Encoding UTF8 -Append
"[$timestamp] ⏰ Kiểm tra mỗi 5 phút" | Out-File -FilePath $logFile -Encoding UTF8 -Append
"" | Out-File -FilePath $logFile -Encoding UTF8 -Append

function Write-Log {
    param($message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] $message"
    $logMessage | Out-File -FilePath $logFile -Encoding UTF8 -Append
}

while ($true) {
    try {
        $currentTime = Get-Date
        Set-Location $scriptPath
        
        # Kiểm tra có thay đổi không
        $status = git status --porcelain
        
        if (-not [string]::IsNullOrWhiteSpace($status)) {
            Write-Log "📝 Phát hiện thay đổi! Đang sync..."
            
            # Add tất cả file
            git add . 2>&1 | Out-Null
            
            # Commit với timestamp
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $commitMessage = "Auto sync: $timestamp"
            
            $commitResult = git commit -m $commitMessage 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Log "💾 Commit thành công!"
                
                # Push lên GitHub
                $pushResult = git push origin main 2>&1
                
                if ($LASTEXITCODE -eq 0) {
                    $syncCount++
                    $lastSyncTime = Get-Date
                    Write-Log "✅ Sync thành công! (Lần: $syncCount)"
                } else {
                    Write-Log "❌ Lỗi khi push: $pushResult"
                }
            } else {
                Write-Log "⚠️ Không có gì để commit hoặc lỗi: $commitResult"
            }
        } else {
            # Chỉ log mỗi 30 phút để không spam log
            $minutesSinceLastSync = ($currentTime - $lastSyncTime).TotalMinutes
            if ($minutesSinceLastSync -ge 30) {
                Write-Log "✅ Không có thay đổi (đã kiểm tra $syncCount lần)"
                $lastSyncTime = $currentTime
            }
        }
        
    } catch {
        Write-Log "❌ Lỗi: $($_.Exception.Message)"
    }
    
    # Đợi 5 phút (300 giây)
    Start-Sleep -Seconds 300
}


