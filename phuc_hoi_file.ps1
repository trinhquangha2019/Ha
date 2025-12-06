# Script phục hồi file từ Git
# Cách dùng: .\phuc_hoi_file.ps1

param(
    [string]$FileName = "",
    [int]$MinutesAgo = 10
)

Write-Host "🔄 PHỤC HỒI FILE TỪ GIT" -ForegroundColor Cyan
Write-Host "========================`n" -ForegroundColor Cyan

# Kiểm tra có Git không
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git chưa được cài đặt!" -ForegroundColor Red
    exit 1
}

# Hiển thị commit gần đây
Write-Host "📋 Các commit gần đây (trong $MinutesAgo phút):" -ForegroundColor Yellow
$commits = git log --oneline --since="$MinutesAgo minutes ago" --format="%h|%ar|%s"
if ([string]::IsNullOrWhiteSpace($commits)) {
    Write-Host "⚠️  Không tìm thấy commit nào trong $MinutesAgo phút qua!" -ForegroundColor Yellow
    Write-Host "Đang tìm commit gần nhất..." -ForegroundColor Yellow
    $commits = git log -5 --oneline --format="%h|%ar|%s"
}

$commitList = @()
$commits -split "`n" | ForEach-Object {
    if ($_ -match "^([a-f0-9]+)\|(.+)\|(.+)$") {
        $commitList += [PSCustomObject]@{
            Hash = $matches[1]
            Time = $matches[2]
            Message = $matches[3]
        }
    }
}

$index = 1
foreach ($commit in $commitList) {
    Write-Host "[$index] $($commit.Hash) - $($commit.Time) - $($commit.Message)" -ForegroundColor White
    $index++
}

# Nếu có tên file, phục hồi file đó
if ($FileName -ne "") {
    Write-Host "`n📁 Đang phục hồi file: $FileName" -ForegroundColor Yellow
    
    if ($commitList.Count -gt 0) {
        $targetCommit = $commitList[0].Hash
        Write-Host "Đang phục hồi từ commit: $targetCommit" -ForegroundColor Cyan
        
        # Kiểm tra file có tồn tại trong commit không
        $fileExists = git ls-tree -r $targetCommit --name-only | Select-String -Pattern $FileName
        if ($fileExists) {
            git checkout $targetCommit -- $FileName
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Đã phục hồi file: $FileName" -ForegroundColor Green
            } else {
                Write-Host "❌ Lỗi khi phục hồi file!" -ForegroundColor Red
            }
        } else {
            Write-Host "⚠️  File không tồn tại trong commit này!" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "`n💡 Cách sử dụng:" -ForegroundColor Cyan
    Write-Host "   .\phuc_hoi_file.ps1 -FileName 'tên_file' -MinutesAgo 10" -ForegroundColor White
    Write-Host "`n📝 Ví dụ:" -ForegroundColor Cyan
    Write-Host "   .\phuc_hoi_file.ps1 -FileName 'BAI_MAU.txt' -MinutesAgo 10" -ForegroundColor White
    Write-Host "`n🔧 Hoặc phục hồi thủ công:" -ForegroundColor Cyan
    Write-Host "   git checkout <commit_hash> -- <tên_file>" -ForegroundColor White
}




