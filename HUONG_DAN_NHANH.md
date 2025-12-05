# HƯỚNG DẪN NHANH - ĐỌC PDF VỚI NOTEBOOKLM

## ⚠️ TÌNH TRẠNG HIỆN TẠI
- Python chưa được cài đặt trên hệ thống
- File PDF: `pdf/1.pdf` đã sẵn sàng

## 🚀 GIẢI PHÁP NHANH NHẤT: Dùng NotebookLM

### Bước 1: Truy cập NotebookLM
👉 https://notebooklm.google.com

### Bước 2: Đăng nhập
- Sử dụng tài khoản Google của bạn

### Bước 3: Tạo Notebook mới
- Click nút "Create Notebook" hoặc "+ New"
- Đặt tên notebook (ví dụ: "Phan tich PDF")

### Bước 4: Upload PDF
- Click "Add sources" hoặc "Add sources +"
- Chọn "Upload files"
- Chọn file: `pdf/1.pdf` từ máy tính
- Chờ NotebookLM xử lý (vài giây đến vài phút tùy kích thước file)

### Bước 5: Đặt câu hỏi và phân tích
Sau khi upload xong, bạn có thể:
- Hỏi bất kỳ câu hỏi nào về nội dung PDF
- Yêu cầu tóm tắt
- Yêu cầu phân tích
- Tạo outline, study guide, v.v.

**Ví dụ câu hỏi:**
- "Hãy tóm tắt nội dung chính của tài liệu này"
- "Những điểm quan trọng nhất là gì?"
- "Tạo outline cho tài liệu này"

## 💡 ƯU ĐIỂM CỦA NOTEBOOKLM
✅ Không cần cài đặt Python
✅ Không cần cài đặt thư viện
✅ Giao diện dễ sử dụng
✅ Hỗ trợ nhiều định dạng: PDF, DOC, TXT, Google Docs, v.v.
✅ AI phân tích mạnh mẽ
✅ Miễn phí (với Google Account)

## 🔧 NẾU VẪN MUỐN DÙNG TOOL PYTHON

### Cài đặt Python (bắt buộc):

**Cách 1: Microsoft Store**
1. Mở Microsoft Store
2. Tìm "Python 3.12"
3. Click "Install"
4. Đợi cài đặt xong
5. **Đóng và mở lại PowerShell**

**Cách 2: python.org**
1. Truy cập: https://www.python.org/downloads/
2. Tải Python 3.11 hoặc 3.12
3. Chạy installer
4. **QUAN TRỌNG**: Tích chọn "Add Python to PATH" ⚠️
5. Click "Install Now"
6. **Đóng và mở lại PowerShell**

### Sau khi cài Python:

```bash
# Cài đặt thư viện
pip install pdfplumber PyPDF2 openai

# Chạy tool
python read_pdf_with_ai.py "pdf/1.pdf"
```

**Lưu ý:** Tool với AI cần OpenAI API Key. Nếu không có, dùng tool cơ bản:
```bash
python read_pdf_tool.py "pdf/1.pdf"
```

---

## 📝 TÓM TẮT

**Khuyến nghị:** Dùng NotebookLM (không cần Python, dễ dùng, miễn phí)

**Nếu muốn tự động hóa:** Cài Python và dùng tool script




