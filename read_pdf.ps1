# Tool đọc PDF bằng PowerShell (không cần Python)
# Sử dụng .NET libraries để extract text từ PDF

param(
    [Parameter(Mandatory=$true)]
    [string]$PdfPath
)

Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "TOOL ĐỌC FILE PDF" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan

# Kiểm tra file có tồn tại không
if (-not (Test-Path $PdfPath)) {
    Write-Host "❌ Không tìm thấy file: $PdfPath" -ForegroundColor Red
    exit 1
}

Write-Host "`n📄 Đang đọc file: $PdfPath" -ForegroundColor Yellow

# Thử đọc với iTextSharp hoặc PDFSharp (cần cài đặt qua NuGet)
# Hoặc dùng cách đơn giản hơn: sử dụng Google Cloud Vision API hoặc OCR

Write-Host "`n⚠️  PowerShell không có thư viện PDF tích hợp sẵn." -ForegroundColor Yellow
Write-Host "`n💡 Giải pháp:" -ForegroundColor Green
Write-Host "   1. Cài đặt Python và dùng read_pdf_tool.py" -ForegroundColor White
Write-Host "   2. Dùng online tool: https://www.ilovepdf.com/pdf_to_txt" -ForegroundColor White
Write-Host "   3. Dùng Microsoft Word để mở PDF và Save As .txt" -ForegroundColor White
Write-Host "   4. Dùng Adobe Acrobat Reader để export text" -ForegroundColor White

Write-Host "`n📋 Hoặc bạn có thể:" -ForegroundColor Green
Write-Host "   - Tải Python từ python.org" -ForegroundColor White
Write-Host "   - Sau đó chạy: python read_pdf_tool.py `"$PdfPath`"" -ForegroundColor White

Write-Host "`n💡 Mẹo nhanh để dùng với NotebookLM:" -ForegroundColor Green
Write-Host "   - Upload file PDF trực tiếp lên NotebookLM tại: https://notebooklm.google.com" -ForegroundColor White
Write-Host "   - Hoặc convert PDF sang Word/Docx rồi upload" -ForegroundColor White




