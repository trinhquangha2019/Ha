# HƯỚNG DẪN CHẠY TOOL ĐỌC PDF

## File PDF đã sẵn sàng
- ✅ File: `pdf/1.pdf` đã tồn tại

## Cài đặt Python (nếu chưa có)

### Bước 1: Cài Python
**Cách nhanh nhất:**
1. Mở Microsoft Store
2. Tìm "Python 3.12" 
3. Click "Install"

**Hoặc tải từ python.org:**
1. Truy cập: https://www.python.org/downloads/
2. Tải Python 3.11 hoặc 3.12
3. **QUAN TRỌNG**: Tích chọn "Add Python to PATH"
4. Click "Install Now"

### Bước 2: Đóng và mở lại PowerShell
Sau khi cài Python, đóng PowerShell hiện tại và mở lại.

### Bước 3: Cài đặt thư viện Python
```bash
pip install pdfplumber PyPDF2 openai pdf2image pytesseract
```

### Bước 3b: Cài đặt Tesseract OCR (cho PDF ảnh/scanned)
**QUAN TRỌNG**: Nếu PDF là file ảnh (scanned), cần cài Tesseract OCR:

**Cách 1: Dùng winget (Windows 10/11) - Khuyến nghị**
```bash
winget install --id UB-Mannheim.TesseractOCR
```

**Cách 2: Tải thủ công**
1. Truy cập: https://github.com/UB-Mannheim/tesseract/wiki
2. Tải file `tesseract-ocr-w64-setup-*.exe`
3. Chạy file .exe và cài đặt
4. ✅ **QUAN TRỌNG**: Tích chọn "Add to PATH" khi cài đặt
5. Đóng và mở lại PowerShell

**Kiểm tra đã cài thành công:**
```bash
tesseract --version
```

### Bước 4: Chạy tool
```bash
python read_pdf_with_ai.py "pdf/1.pdf"
```

## Nếu không muốn cài Python

### Giải pháp 1: Dùng NotebookLM (Khuyến nghị)
1. Truy cập: https://notebooklm.google.com
2. Đăng nhập với Google Account
3. Tạo Notebook mới
4. Click "Add sources" > "Upload files"
5. Upload file `pdf/1.pdf`
6. NotebookLM sẽ tự động đọc và phân tích!

### Giải pháp 2: Dùng Online Converter
1. Truy cập: https://www.ilovepdf.com/pdf_to_txt
2. Upload file `pdf/1.pdf`
3. Convert sang .txt
4. Download và mở file text

## Kiểm tra Python đã cài chưa

Mở PowerShell và chạy:
```bash
python --version
```

Nếu hiển thị phiên bản (ví dụ: Python 3.11.5) thì đã thành công!

## Lệnh đầy đủ để chạy tool

```bash
# 1. Cài đặt thư viện (chỉ cần chạy 1 lần)
pip install pdfplumber PyPDF2 openai

# 2. Chạy tool đọc PDF với AI
python read_pdf_with_ai.py "pdf/1.pdf"

# Hoặc nếu dùng py command
py read_pdf_with_ai.py "pdf/1.pdf"
```

## Tính năng mới: OCR cho PDF ảnh

Tool đã được cập nhật với chức năng OCR để đọc PDF ảnh (scanned PDF):

- ✅ Tự động phát hiện PDF không có text
- ✅ Hỏi có muốn dùng OCR không
- ✅ Hỗ trợ tiếng Việt và tiếng Anh
- ✅ Lấy ảnh từ PDF bằng pdfplumber (không cần poppler)

**Cách sử dụng:**
1. Chạy script: `python read_pdf_with_ai.py "pdf/1.pdf"`
2. Nếu PDF không có text, script sẽ hỏi có muốn dùng OCR
3. Nhập `y` để bật OCR
4. Đợi OCR xử lý (có thể mất vài phút)

## Lưu ý

- Tool cần OpenAI API Key để phân tích bằng AI
- Nếu không có API Key, vẫn có thể lưu text ra file
- File text sẽ được lưu trong cùng thư mục với tên `1_extracted.txt`
- File phân tích AI sẽ được lưu với tên `1_analysis.txt`
- **PDF ảnh**: Cần cài Tesseract OCR (xem Bước 3b ở trên)


