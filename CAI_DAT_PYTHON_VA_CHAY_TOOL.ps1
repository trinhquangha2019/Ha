# Script tự động cài đặt Python và chạy tool đọc PDF

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "HUONG DAN CAI DAT PYTHON VA SU DUNG TOOL DOC PDF" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

Write-Host "`nBUOC 1: KIEM TRA PYTHON" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------"

try {
    $pythonVersion = python --version 2>&1
    Write-Host "[OK] Python da duoc cai dat: $pythonVersion" -ForegroundColor Green
    
    Write-Host "`nBUOC 2: CAI DAT THU VIEN" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------"
    
    Write-Host "Dang cai dat pdfplumber, PyPDF2..." -ForegroundColor White
    pip install pdfplumber PyPDF2
    
    Write-Host "`nDang cai dat openai..." -ForegroundColor White
    pip install openai
    
    Write-Host "`n[OK] Da cai dat xong cac thu vien!" -ForegroundColor Green
    
    Write-Host "`nBUOC 3: SU DUNG TOOL" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------"
    
    Write-Host "`nTool 1: Doc PDF co ban (extract text)" -ForegroundColor Cyan
    Write-Host "   python read_pdf_tool.py `"duong/dan/file.pdf`"" -ForegroundColor White
    
    Write-Host "`nTool 2: Doc PDF voi AI phan tich" -ForegroundColor Cyan
    Write-Host "   python read_pdf_with_ai.py `"duong/dan/file.pdf`"" -ForegroundColor White
    
    Write-Host "`nVi du:" -ForegroundColor Yellow
    $examplePath = "cong thuc nau an\13784-huong-dan-nau-an-200-mon-truyen-thong-viet-nam-thuviensach.vn.pdf"
    if (Test-Path $examplePath) {
        Write-Host "   python read_pdf_tool.py `"$examplePath`"" -ForegroundColor White
    }
    
} catch {
    Write-Host "`n[ERROR] Python chua duoc cai dat!" -ForegroundColor Red
    Write-Host "`nHUONG DAN CAI DAT PYTHON:" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------"
    
    Write-Host "`nCACH 1: Cai tu Microsoft Store (De nhat)" -ForegroundColor Cyan
    Write-Host "1. Mở Microsoft Store" -ForegroundColor White
    Write-Host "2. Tìm 'Python 3.12' hoặc 'Python 3.11'" -ForegroundColor White
    Write-Host "3. Click 'Install'" -ForegroundColor White
    Write-Host "4. Sau khi cài xong, mở lại PowerShell và chạy script này" -ForegroundColor White
    
    Write-Host "`nCACH 2: Tai tu python.org (Khuyen nghi)" -ForegroundColor Cyan
    Write-Host "1. Truy cap: https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "2. Tai Python 3.11 hoac 3.12" -ForegroundColor White
    Write-Host "3. Chay installer" -ForegroundColor White
    Write-Host "4. [QUAN TRONG] Tich chon 'Add Python to PATH'" -ForegroundColor Red
    Write-Host "5. Click 'Install Now'" -ForegroundColor White
    Write-Host "6. Sau khi cai xong, mo lai PowerShell va chay script nay" -ForegroundColor White
    
    Write-Host "`nSAU KHI CAI PYTHON:" -ForegroundColor Yellow
    Write-Host "- Dong va mo lai PowerShell" -ForegroundColor White
    Write-Host "- Chay lai script nay de cai dat thu vien" -ForegroundColor White
    
    Write-Host "`nGIAI PHAP THAY THE: Dung NotebookLM truc tiep" -ForegroundColor Green
    Write-Host "NotebookLM co the upload PDF truc tiep, khong can Python!" -ForegroundColor White
    Write-Host "1. Truy cập: https://notebooklm.google.com" -ForegroundColor White
    Write-Host "2. Đăng nhập với Google Account" -ForegroundColor White
    Write-Host "3. Tạo Notebook mới" -ForegroundColor White
    Write-Host "4. Click 'Add sources' > 'Upload files'" -ForegroundColor White
    Write-Host "5. Chọn file PDF" -ForegroundColor White
    Write-Host "6. NotebookLM sẽ tự động đọc và phân tích!" -ForegroundColor White
}

Write-Host "`n============================================================" -ForegroundColor Cyan
Write-Host "Hoan thanh!" -ForegroundColor Cyan

