# Script tự động đồng bộ lên GitHub
# Tác giả: Dasi
# Cách dùng: .\sync_github.ps1

Write-Host "🔄 Đang kiểm tra thay đổi..." -ForegroundColor Cyan

# Kiểm tra có thay đổi không
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "✅ Không có thay đổi nào!" -ForegroundColor Green
    exit 0
}

Write-Host "📝 Các file thay đổi:" -ForegroundColor Yellow
git status --short

# Hỏi xác nhận
$confirm = Read-Host "`nBạn có muốn commit và push lên GitHub? (y/n)"
if ($confirm -ne 'y' -and $confirm -ne 'Y') {
    Write-Host "❌ Đã hủy!" -ForegroundColor Red
    exit 0
}

# Tạo commit message với timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "Auto sync: $timestamp"

Write-Host "`n📦 Đang add files..." -ForegroundColor Cyan
git add .

# Force add file HTML quan trọng nếu bị ignore
if (Test-Path "De_xuat_content_website_2025.html") {
    git add -f De_xuat_content_website_2025.html 2>&1 | Out-Null
}

Write-Host "💾 Đang commit..." -ForegroundColor Cyan
git commit -m $commitMessage

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Commit thành công!" -ForegroundColor Green
    
    Write-Host "🚀 Đang push lên GitHub..." -ForegroundColor Cyan
    git push
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✅ Hoàn thành! Đã sync lên GitHub!" -ForegroundColor Green
    } else {
        Write-Host "`n❌ Lỗi khi push!" -ForegroundColor Red
    }
} else {
    Write-Host "`n❌ Lỗi khi commit!" -ForegroundColor Red
}


