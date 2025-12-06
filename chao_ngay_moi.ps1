# Script chao hoi va hien thi cham ngon moi ngay
# Tac gia: Dasi
# Cach dung: .\chao_ngay_moi.ps1

# Fix encoding de hien thi tieng Viet dung
try {
    chcp 65001 | Out-Null
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.Encoding]::UTF8
} catch {}

# Tu dong them cham ngon moi vao buoi sang (1 lan moi ngay)
$hour = (Get-Date).Hour
if ($hour -ge 5 -and $hour -lt 12) {
    $themChamNgonScript = Join-Path $PSScriptRoot "them_cham_ngon_moi.ps1"
    if (Test-Path $themChamNgonScript) {
        & powershell -ExecutionPolicy Bypass -File $themChamNgonScript -WindowStyle Hidden
    }
}

# Mau sac
$colorCyan = "Cyan"
$colorYellow = "Yellow"
$colorGreen = "Green"
$colorGray = "Gray"

# Lay ten nguoi dung
$userName = $env:USERNAME

# Lay thoi gian hien tai
$currentTime = Get-Date
$hour = $currentTime.Hour
$dayOfWeek = (Get-Culture).DateTimeFormat.GetDayName($currentTime.DayOfWeek)
$dateStr = $currentTime.ToString("dd/MM/yyyy")

# Xac dinh loi chao theo gio
if ($hour -ge 5 -and $hour -lt 12) {
    $greeting = "Chao buoi sang"
} elseif ($hour -ge 12 -and $hour -lt 18) {
    $greeting = "Chao buoi chieu"
} elseif ($hour -ge 18 -and $hour -lt 22) {
    $greeting = "Chao buoi toi"
} else {
    $greeting = "Chao dem khuya"
}

# Doc file cham ngon
$chamNgonFile = Join-Path $PSScriptRoot "cham_ngon_cuoc_song.txt"
if (Test-Path $chamNgonFile) {
    $content = [System.IO.File]::ReadAllText($chamNgonFile, [System.Text.Encoding]::UTF8)
    $allChamNgon = $content -split "`r?`n" | Where-Object { $_ -notmatch '^\s*$' -and $_.Length -gt 0 }
    
    # Chon cham ngon dua tren ngay trong thang de moi ngay co mot cau khac nhau
    $dayOfMonth = $currentTime.Day
    $index = ($dayOfMonth - 1) % $allChamNgon.Count
    $chamNgon = $allChamNgon[$index]
} else {
    $chamNgon = "Hay song moi ngay nhu the do la ngay cuoi cung cua ban."
}

# Hien thi
Write-Host ""
Write-Host "============================================================" -ForegroundColor $colorCyan
Write-Host "                                                          " -ForegroundColor $colorCyan
Write-Host "  $greeting, $userName!" -ForegroundColor $colorCyan
Write-Host "                                                          " -ForegroundColor $colorCyan
Write-Host "  Hom nay la: $dayOfWeek, $dateStr" -ForegroundColor $colorYellow
Write-Host "                                                          " -ForegroundColor $colorCyan
Write-Host "============================================================" -ForegroundColor $colorCyan
Write-Host "                                                          " -ForegroundColor $colorCyan
Write-Host "  CHAM NGON HOM NAY:" -ForegroundColor $colorYellow
Write-Host "                                                          " -ForegroundColor $colorCyan
Write-Host "  $chamNgon" -ForegroundColor $colorGreen
Write-Host "                                                          " -ForegroundColor $colorCyan
Write-Host "============================================================" -ForegroundColor $colorCyan
Write-Host ""

# Loi chuc
$wishMessage = "Chuc ban mot ngay lam viec hieu qua va day nang luong!"
Write-Host $wishMessage -ForegroundColor $colorYellow
Write-Host ""
