# HƯỚNG DẪN CÀI ĐẶT PYTHON VÀ SỬ DỤNG TOOL

## Bước 1: Cài đặt Python

### Cách 1: Tải từ Microsoft Store (Dễ nhất)
1. Mở Microsoft Store
2. Tìm "Python 3.12" hoặc "Python 3.11"
3. Click "Install"
4. Chờ cài đặt xong

### Cách 2: Tải từ python.org (Khuyến nghị)
1. Truy cập: https://www.python.org/downloads/
2. Tải Python 3.11 hoặc 3.12 (Windows installer)
3. Chạy file .exe vừa tải
4. ⚠️ **QUAN TRỌNG**: Tích chọn "Add Python to PATH"
5. Click "Install Now"
6. Đợi cài đặt xong

## Bước 2: Kiểm tra Python đã cài đặt

Mở PowerShell hoặc Command Prompt và gõ:
```bash
python --version
```

Nếu hiển thị phiên bản (ví dụ: Python 3.11.5) thì đã thành công!

## Bước 3: Cài đặt thư viện

```bash
pip install pdfplumber PyPDF2
```

## Bước 4: Sử dụng tool

### Tool 1: Đọc PDF cơ bản
```bash
python read_pdf_tool.py "đường/dẫn/file.pdf"
```

Ví dụ:
```bash
python read_pdf_tool.py "cong thuc nau an\13784-huong-dan-nau-an-200-mon-truyen-thong-viet-nam-thuviensach.vn.pdf"
```

### Tool 2: Đọc PDF với AI phân tích
```bash
# Cài đặt thêm
pip install openai

# Chạy tool
python read_pdf_with_ai.py "đường/dẫn/file.pdf"
```

## Nếu vẫn không chạy được

1. **Thử `py` thay vì `python`:**
   ```bash
   py read_pdf_tool.py "file.pdf"
   ```

2. **Kiểm tra PATH:**
   - Mở System Properties > Environment Variables
   - Thêm đường dẫn Python vào PATH nếu chưa có

3. **Restart PowerShell/Terminal** sau khi cài Python

## Giải pháp thay thế (Không cần Python)

### 1. Dùng NotebookLM trực tiếp
- Truy cập: https://notebooklm.google.com
- Đăng nhập với Google Account
- Click "Create Notebook"
- Click "Add sources" > Upload PDF trực tiếp
- ✅ NotebookLM sẽ tự động đọc PDF!

### 2. Dùng Microsoft Word
1. Mở Microsoft Word
2. File > Open > Chọn file PDF
3. Word sẽ convert PDF sang text
4. File > Save As > Chọn định dạng .txt
5. Copy nội dung vào NotebookLM

### 3. Dùng Online Converter
- https://www.ilovepdf.com/pdf_to_txt
- https://www.adobe.com/acrobat/online/pdf-to-txt.html
- Upload PDF > Convert > Download .txt > Copy vào NotebookLM

## Mẹo với NotebookLM

NotebookLM hỗ trợ upload PDF trực tiếp, không cần extract text trước:
1. Vào https://notebooklm.google.com
2. Tạo Notebook mới
3. Click "Add sources"
4. Chọn "Upload files" > Chọn file PDF
5. Đợi NotebookLM xử lý
6. Bắt đầu đặt câu hỏi về nội dung PDF

**Lưu ý:** NotebookLM có thể gặp khó khăn với PDF scan (hình ảnh), trong trường hợp đó cần OCR trước.




