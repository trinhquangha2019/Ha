# Script tự động sync GitHub mỗi 5 phút
# Tác giả: Dasi
# Cách dùng: powershell -ExecutionPolicy Bypass -File .\auto_sync_github.ps1

Write-Host "🔄 Auto Sync GitHub - Chạy mỗi 5 phút" -ForegroundColor Cyan
Write-Host "Nhấn Ctrl+C để dừng`n" -ForegroundColor Yellow

$syncCount = 0
$lastSyncTime = Get-Date

while ($true) {
    try {
        $currentTime = Get-Date
        Write-Host "[$($currentTime.ToString('HH:mm:ss'))] Đang kiểm tra thay đổi..." -ForegroundColor Gray
        
        # Kiểm tra có thay đổi không
        $status = git status --porcelain
        
        if (-not [string]::IsNullOrWhiteSpace($status)) {
            Write-Host "📝 Phát hiện thay đổi! Đang sync..." -ForegroundColor Yellow
            
            # Add tất cả file
            git add . | Out-Null
            
            # Commit với timestamp
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $commitMessage = "Auto sync: $timestamp"
            
            $commitResult = git commit -m $commitMessage 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "💾 Commit thành công!" -ForegroundColor Green
                
                # Push lên GitHub
                $pushResult = git push 2>&1
                
                if ($LASTEXITCODE -eq 0) {
                    $syncCount++
                    $lastSyncTime = Get-Date
                    Write-Host "✅ Sync thành công! (Lần: $syncCount)" -ForegroundColor Green
                } else {
                    Write-Host "❌ Lỗi khi push: $pushResult" -ForegroundColor Red
                }
            } else {
                Write-Host "⚠️ Không có gì để commit" -ForegroundColor Gray
            }
        } else {
            Write-Host "✅ Không có thay đổi" -ForegroundColor Gray
        }
        
        # Hiển thị thông tin
        $nextCheck = $currentTime.AddMinutes(5)
        Write-Host "⏰ Lần sync tiếp theo: $($nextCheck.ToString('HH:mm:ss'))`n" -ForegroundColor Cyan
        
    } catch {
        Write-Host "❌ Lỗi: $_" -ForegroundColor Red
    }
    
    # Đợi 5 phút (300 giây)
    Start-Sleep -Seconds 300
}

