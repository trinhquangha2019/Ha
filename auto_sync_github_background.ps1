# Script tự động sync GitHub chạy nền (không hiển thị cửa sổ)
# Tác giả: Dasi
# Chạy nền: powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File .\auto_sync_github_background.ps1

# Ghi log vào file
$logFile = "$PSScriptRoot\auto_sync_log.txt"
$syncCount = 0
$lastSyncTime = Get-Date

function Write-Log {
    param($message, $color = "White")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] $message"
    Add-Content -Path $logFile -Value $logMessage
    Write-Host $logMessage -ForegroundColor $color
}

# Ghi log khởi động
Write-Log "🔄 Auto Sync GitHub - Bắt đầu chạy nền" "Cyan"
Write-Log "📁 Thư mục: $PSScriptRoot" "Gray"
Write-Log "⏰ Kiểm tra mỗi 5 phút`n" "Yellow"

while ($true) {
    try {
        $currentTime = Get-Date
        
        # Kiểm tra có thay đổi không
        $status = git status --porcelain
        
        if (-not [string]::IsNullOrWhiteSpace($status)) {
            Write-Log "📝 Phát hiện thay đổi! Đang sync..." "Yellow"
            
            # Add tất cả file
            git add . | Out-Null
            
            # Commit với timestamp
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $commitMessage = "Auto sync: $timestamp"
            
            $commitResult = git commit -m $commitMessage 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Log "💾 Commit thành công!" "Green"
                
                # Push lên GitHub
                $pushResult = git push 2>&1
                
                if ($LASTEXITCODE -eq 0) {
                    $syncCount++
                    $lastSyncTime = Get-Date
                    Write-Log "✅ Sync thành công! (Lần: $syncCount)" "Green"
                } else {
                    Write-Log "❌ Lỗi khi push: $pushResult" "Red"
                }
            } else {
                Write-Log "⚠️ Không có gì để commit" "Gray"
            }
        } else {
            # Chỉ log mỗi 30 phút để không spam log
            $minutesSinceLastSync = ($currentTime - $lastSyncTime).TotalMinutes
            if ($minutesSinceLastSync -ge 30) {
                Write-Log "✅ Không có thay đổi (đã kiểm tra $syncCount lần)" "Gray"
                $lastSyncTime = $currentTime
            }
        }
        
    } catch {
        Write-Log "❌ Lỗi: $_" "Red"
    }
    
    # Đợi 5 phút (300 giây)
    Start-Sleep -Seconds 300
}

