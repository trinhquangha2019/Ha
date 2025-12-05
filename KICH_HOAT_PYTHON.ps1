# Script hướng dẫn và kích hoạt Python

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "KICH HOAT PYTHON VA CAI DAT TOOL DOC PDF" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Kiểm tra Python
Write-Host "Kiem tra Python..." -ForegroundColor Yellow
$pythonCheck = Get-Command python -ErrorAction SilentlyContinue

if ($pythonCheck) {
    Write-Host "[OK] Python da duoc cai dat!" -ForegroundColor Green
    python --version
    Write-Host ""
    
    Write-Host "Cai dat cac thu vien can thiet..." -ForegroundColor Yellow
    pip install pdfplumber PyPDF2 openai
    
    Write-Host ""
    Write-Host "Hoan thanh! Bay gio ban co the chay:" -ForegroundColor Green
    Write-Host "  python read_pdf_with_ai.py `"pdf/1.pdf`"" -ForegroundColor Cyan
} else {
    Write-Host "[ERROR] Python chua duoc cai dat!" -ForegroundColor Red
    Write-Host ""
    
    Write-Host "CAC BUOC CAI DAT PYTHON:" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------"
    Write-Host ""
    
    Write-Host "CACH 1: Cai tu Microsoft Store (De nhat)" -ForegroundColor Cyan
    Write-Host "  1. Mo Microsoft Store" -ForegroundColor White
    Write-Host "  2. Tim 'Python 3.12'" -ForegroundColor White
    Write-Host "  3. Click 'Install'" -ForegroundColor White
    Write-Host ""
    
    $openStore = Read-Host "Ban co muon mo Microsoft Store ngay bay gio? (y/n)"
    if ($openStore -eq "y" -or $openStore -eq "Y") {
        Start-Process "ms-windows-store://pdp/?ProductId=9NRWMJP3717K"
        Write-Host ""
        Write-Host "Microsoft Store da duoc mo!" -ForegroundColor Green
        Write-Host "Sau khi cai dat Python:" -ForegroundColor Yellow
        Write-Host "  1. DONG PowerShell nay" -ForegroundColor White
        Write-Host "  2. MO lai PowerShell" -ForegroundColor White
        Write-Host "  3. Chay lai script nay hoac: pip install pdfplumber PyPDF2 openai" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "CACH 2: Tai tu python.org (Khuyen nghi)" -ForegroundColor Cyan
    Write-Host "  Truy cap: https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "  Luu y: Tich chon 'Add Python to PATH' khi cai dat!" -ForegroundColor Red
    Write-Host ""
    
    $openWeb = Read-Host "Ban co muon mo trang download Python? (y/n)"
    if ($openWeb -eq "y" -or $openWeb -eq "Y") {
        Start-Process "https://www.python.org/downloads/"
    }
    
    Write-Host ""
    Write-Host "GIAI PHAP THAY THE: Dung NotebookLM (Khong can Python)" -ForegroundColor Green
    Write-Host "  Truy cap: https://notebooklm.google.com" -ForegroundColor White
    Write-Host "  Upload truc tiep file pdf/1.pdf" -ForegroundColor White
    Write-Host ""
    
    $openNotebookLM = Read-Host "Ban co muon mo NotebookLM? (y/n)"
    if ($openNotebookLM -eq "y" -or $openNotebookLM -eq "Y") {
        Start-Process "https://notebooklm.google.com"
    }
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan




