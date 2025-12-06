# Script tu dong them 2-3 cham ngon moi vao buoi sang
# Tac gia: Dasi
# Chay 1 lan moi ngay vao buoi sang

# File log de track da them cham ngon hom nay chua
$logFile = Join-Path $PSScriptRoot "cham_ngon_log.txt"
$chamNgonFile = Join-Path $PSScriptRoot "cham_ngon_cuoc_song.txt"

# Kiem tra da them cham ngon hom nay chua
$today = Get-Date -Format "yyyy-MM-dd"
$lastUpdate = $null

if (Test-Path $logFile) {
    $lastUpdate = Get-Content $logFile -Tail 1
}

# Neu da them hom nay roi thi thoi
if ($lastUpdate -eq $today) {
    Write-Host "Da them cham ngon hom nay roi. Khong can them nua." -ForegroundColor Gray
    exit 0
}

# Chi chay vao buoi sang (5h - 12h)
$hour = (Get-Date).Hour
if ($hour -lt 5 -or $hour -ge 12) {
    Write-Host "Khong phai buoi sang. Chi them cham ngon vao buoi sang (5h-12h)." -ForegroundColor Gray
    exit 0
}

# Danh sach cham ngon moi (co the mo rong)
$chamNgonMoi = @(
    "Hãy bắt đầu ngày mới với nụ cười và lòng biết ơn.",
    "Mỗi buổi sáng là cơ hội để viết lại câu chuyện của bạn.",
    "Hãy sống hôm nay như thể đây là ngày quan trọng nhất của bạn.",
    "Thức dậy sớm là cách bạn chiến thắng ngày hôm đó.",
    "Hãy làm những việc nhỏ với tình yêu lớn.",
    "Mỗi ngày mới là một trang sách trắng, hãy viết nó thật đẹp.",
    "Hãy sống với lòng can đảm và trái tim rộng mở.",
    "Đừng để nỗi sợ hãi ngăn cản bạn bước về phía trước.",
    "Hãy tin rằng mọi thứ đều có thể nếu bạn dám thử.",
    "Thành công bắt đầu từ việc bạn quyết định đứng dậy mỗi sáng.",
    "Hãy sống với đam mê và làm việc với mục đích rõ ràng.",
    "Mỗi ngày là một cơ hội để trở nên tốt hơn ngày hôm qua.",
    "Hãy yêu thương bản thân và những người xung quanh bạn.",
    "Đừng chờ đợi điều kiện hoàn hảo, hãy bắt đầu ngay bây giờ.",
    "Hãy sống với lòng biết ơn và tâm trí tích cực.",
    "Mỗi buổi sáng là một món quà, hãy tận dụng nó.",
    "Hãy làm những gì bạn có thể, với những gì bạn có.",
    "Thành công không đến từ may mắn, mà từ sự nỗ lực.",
    "Hãy sống với niềm tin rằng ngày mai sẽ tốt đẹp hơn.",
    "Đừng để quá khứ đánh cắp hiện tại của bạn.",
    "Hãy sống với sự chân thành và lòng tốt.",
    "Mỗi ngày mới là một cơ hội để học hỏi và phát triển.",
    "Hãy làm những gì khiến bạn tự hào.",
    "Thành công là khi bạn hài lòng với những gì bạn đã làm.",
    "Hãy sống với mục đích và làm việc với đam mê.",
    "Đừng sợ thất bại, hãy sợ không dám thử.",
    "Hãy yêu thương cuộc sống và cuộc sống sẽ yêu thương bạn.",
    "Mỗi ngày là một trang mới trong cuốn sách cuộc đời bạn.",
    "Hãy sống với lòng can đảm và trái tim kiên định.",
    "Thành công không phải là đích đến, mà là hành trình bạn đi."
)

# Chon ngau nhien 2-3 cham ngon (dua tren ngay trong thang de on dinh)
$dayOfMonth = (Get-Date).Day
$random = New-Object System.Random($dayOfMonth)
$soLuong = $random.Next(2, 4)  # 2 hoac 3 cham ngon

# Chon cham ngon moi
$selectedChamNgon = @()
$usedIndices = @()

for ($i = 0; $i -lt $soLuong; $i++) {
    do {
        $index = $random.Next(0, $chamNgonMoi.Count)
    } while ($usedIndices -contains $index)
    
    $usedIndices += $index
    $selectedChamNgon += $chamNgonMoi[$index]
}

# Doc file cham ngon hien tai
$existingChamNgon = @()
if (Test-Path $chamNgonFile) {
    $content = [System.IO.File]::ReadAllText($chamNgonFile, [System.Text.Encoding]::UTF8)
    $existingChamNgon = $content -split "`r?`n" | Where-Object { $_ -notmatch '^\s*$' -and $_.Length -gt 0 }
}

# Kiem tra cham ngon moi co trung khong
$chamNgonToAdd = @()
foreach ($cn in $selectedChamNgon) {
    if ($existingChamNgon -notcontains $cn) {
        $chamNgonToAdd += $cn
    }
}

# Neu khong co cham ngon moi thi thoi
if ($chamNgonToAdd.Count -eq 0) {
    Write-Host "Khong co cham ngon moi de them (co the da co trong danh sach)." -ForegroundColor Gray
    # Van ghi log de khong chay lai
    "$today" | Out-File -FilePath $logFile -Append -Encoding UTF8
    exit 0
}

# Them cham ngon moi vao file
$newContent = $existingChamNgon + $chamNgonToAdd
$finalContent = $newContent -join "`n"
[System.IO.File]::WriteAllText($chamNgonFile, $finalContent, (New-Object System.Text.UTF8Encoding $false))

# Ghi log
"$today - Da them $($chamNgonToAdd.Count) cham ngon moi" | Out-File -FilePath $logFile -Append -Encoding UTF8

# Thong bao
Write-Host "Da them $($chamNgonToAdd.Count) cham ngon moi vao thu vien!" -ForegroundColor Green
Write-Host "Cac cham ngon moi:" -ForegroundColor Yellow
foreach ($cn in $chamNgonToAdd) {
    Write-Host "  - $cn" -ForegroundColor Cyan
}


