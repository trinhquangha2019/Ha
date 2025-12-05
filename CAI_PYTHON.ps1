# Script mở Microsoft Store để cài Python

Write-Host "Dang mo Microsoft Store de cai dat Python..." -ForegroundColor Yellow

# Mở Microsoft Store với Python
Start-Process "ms-windows-store://pdp/?ProductId=9NRWMJP3717K"

Write-Host ""
Write-Host "Microsoft Store da duoc mo!" -ForegroundColor Green
Write-Host "1. Tim 'Python 3.12' trong Store" -ForegroundColor White
Write-Host "2. Click 'Install' hoac 'Get'" -ForegroundColor White
Write-Host "3. Doi cai dat xong" -ForegroundColor White
Write-Host "4. DONG va MO LAI PowerShell" -ForegroundColor Yellow
Write-Host "5. Chay lai: pip install pdfplumber PyPDF2 openai" -ForegroundColor Cyan
Write-Host ""

# Hoặc mở trình duyệt đến trang download Python
$response = Read-Host "Ban co muon mo trang download Python tu python.org? (y/n)"
if ($response -eq "y" -or $response -eq "Y") {
    Start-Process "https://www.python.org/downloads/"
    Write-Host ""
    Write-Host "Da mo trang download Python!" -ForegroundColor Green
    Write-Host "Luu y: Khi cai dat, nho tich chon 'Add Python to PATH'!" -ForegroundColor Red
}




