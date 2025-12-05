# TOOL ĐỌC PDF CHO NOTEBOOKLM

Bộ công cụ hỗ trợ đọc file PDF và chuẩn bị nội dung để sử dụng với NotebookLM.

## Lưu ý quan trọng

NotebookLM hiện tại **chưa có API công khai**, vì vậy các tool này sẽ:
1. Đọc PDF và extract text
2. Lưu ra file text để bạn có thể copy vào NotebookLM
3. Hoặc sử dụng AI API khác để phân tích

## Cài đặt

```bash
pip install PyPDF2 pdfplumber
```

Nếu muốn dùng tính năng AI:
```bash
pip install openai
```

Nếu muốn copy vào clipboard:
```bash
pip install pyperclip
```

## Sử dụng

### Tool 1: read_pdf_tool.py
Tool cơ bản để đọc PDF và extract text

```bash
python read_pdf_tool.py "đường/dẫn/file.pdf"
```

Hoặc chạy và nhập đường dẫn:
```bash
python read_pdf_tool.py
```

**Tính năng:**
- Đọc PDF bằng pdfplumber (chính xác) và PyPDF2 (backup)
- Hiển thị preview nội dung
- Lưu ra file text
- Copy vào clipboard để dán vào NotebookLM

### Tool 2: read_pdf_with_ai.py
Tool đọc PDF và phân tích bằng OpenAI API

```bash
python read_pdf_with_ai.py "đường/dẫn/file.pdf"
```

**Tính năng:**
- Đọc PDF
- Phân tích nội dung bằng OpenAI API
- Lưu cả text gốc và kết quả phân tích

**Cấu hình API Key:**
- Set biến môi trường: `set OPENAI_API_KEY=your_key` (Windows)
- Hoặc nhập khi chạy script

## Cách sử dụng với NotebookLM

### Cách 1: Copy text vào NotebookLM
1. Chạy `read_pdf_tool.py` để extract text
2. Chọn option copy vào clipboard
3. Mở NotebookLM: https://notebooklm.google.com
4. Tạo Notebook mới
5. Click "Add sources" > "Paste text"
6. Paste nội dung đã copy

### Cách 2: Upload file text
1. Chạy tool để lưu ra file `.txt`
2. Mở NotebookLM
3. Upload file text vừa tạo

### Cách 3: Dùng AI API thay thế
1. Chạy `read_pdf_with_ai.py`
2. Sử dụng kết quả phân tích từ OpenAI
3. Không cần NotebookLM

## Hạn chế

- PDF scan (hình ảnh) cần OCR trước
- PDF có bảo vệ/mã hóa có thể không đọc được
- NotebookLM không có API nên phải copy thủ công

## Gợi ý cải thiện

Nếu muốn tự động hóa hơn, có thể:
1. Dùng Selenium để tự động upload lên NotebookLM (phức tạp, không khuyến nghị)
2. Dùng Google Drive API + NotebookLM (nếu Google hỗ trợ)
3. Dùng các AI API khác: Claude, Gemini, etc.

## Ví dụ sử dụng

```bash
# Đọc PDF và lưu text
python read_pdf_tool.py "cong thuc nau an\13784-huong-dan-nau-an-200-mon-truyen-thong-viet-nam-thuviensach.vn.pdf"

# Đọc và phân tích với AI
python read_pdf_with_ai.py "file.pdf"
```




