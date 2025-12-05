# HƯỚNG DẪN KẾT NỐI VỚI NOTEBOOKLM

## 📋 Tổng quan

NotebookLM là công cụ AI của Google giúp phân tích và tương tác với tài liệu. Tool `read_pdf_with_ai.py` đã được tích hợp để export nội dung PDF đã đọc lên NotebookLM.

---

## 🚀 CÁCH SỬ DỤNG NHANH

### Bước 1: Đọc PDF

```bash
python read_pdf_with_ai.py "pdf/your_file.pdf"
```

### Bước 2: Chọn option export NotebookLM

Khi script hỏi, chọn:
- **4**: Export lên NotebookLM
- **5**: Lưu file + Export NotebookLM

### Bước 3: Chọn phương thức export

- **1**: Tạo file text (đơn giản nhất - copy/paste)
- **2**: Upload lên Google Drive (cần setup API)
- **3**: Cả hai

---

## 📝 PHƯƠNG PHÁP 1: COPY/PASTE TEXT (Khuyến nghị cho người mới)

### Ưu điểm:
- ✅ Đơn giản, không cần setup
- ✅ Nhanh chóng
- ✅ Không cần API key

### Cách làm:

1. **Chạy script và chọn option 4 hoặc 5**
   ```bash
   python read_pdf_with_ai.py "pdf/your_file.pdf"
   ```

2. **Chọn phương thức 1 (file text)**

3. **Script sẽ tạo file `*_notebooklm.txt`**

4. **Mở file và copy toàn bộ nội dung** (Ctrl+A, Ctrl+C)

5. **Vào NotebookLM:**
   - Truy cập: https://notebooklm.google.com/
   - Đăng nhập bằng Google account
   - Click "New notebook"
   - Click "Add source"
   - Chọn "Paste text"
   - Paste nội dung vào (Ctrl+V)
   - Click "Add"

6. **Xong!** NotebookLM sẽ tự động phân tích tài liệu

---

## ☁️ PHƯƠNG PHÁP 2: GOOGLE DRIVE (Khuyến nghị cho dùng lâu dài)

### Ưu điểm:
- ✅ Tự động sync khi file thay đổi
- ✅ Dễ quản lý nhiều file
- ✅ Có thể share với team
- ✅ Không cần copy/paste mỗi lần

### Cách setup:

#### Bước 1: Tạo Google Cloud Project

1. Truy cập: https://console.cloud.google.com/
2. Đăng nhập bằng Google account
3. Click "Select a project" → "New Project"
4. Đặt tên project (ví dụ: "NotebookLM Integration")
5. Click "Create"

#### Bước 2: Bật Google Drive API

1. Trong Google Cloud Console, vào "APIs & Services" → "Library"
2. Tìm "Google Drive API"
3. Click "Enable"

#### Bước 3: Tạo OAuth 2.0 Credentials

1. Vào "APIs & Services" → "Credentials"
2. Click "Create Credentials" → "OAuth client ID"
3. Nếu chưa có OAuth consent screen:
   - Chọn "External" → "Create"
   - Điền thông tin cơ bản
   - Click "Save and Continue"
   - Ở "Scopes", click "Save and Continue"
   - Ở "Test users", thêm email của bạn
   - Click "Save and Continue"
4. Ở "Application type", chọn "Desktop app"
5. Đặt tên (ví dụ: "NotebookLM Integration")
6. Click "Create"
7. **QUAN TRỌNG**: Tải file `credentials.json` về
8. Đặt file `credentials.json` vào cùng thư mục với `read_pdf_with_ai.py`

#### Bước 4: Chạy script

```bash
python read_pdf_with_ai.py "pdf/your_file.pdf"
```

1. Chọn option 4 hoặc 5
2. Chọn phương thức 2 (Google Drive)
3. Lần đầu tiên, trình duyệt sẽ mở để bạn đăng nhập và cấp quyền
4. Script sẽ tự động upload file lên Google Drive
5. Bạn sẽ nhận được link Google Drive

#### Bước 5: Import vào NotebookLM

1. Mở https://notebooklm.google.com/
2. Tạo notebook mới
3. Click "Add source" → "Google Drive"
4. Chọn file vừa upload
5. Xong!

**Lưu ý**: File `token.pickle` sẽ được tạo để lưu credentials, không cần đăng nhập lại lần sau.

---

## 🔧 CÀI ĐẶT THƯ VIỆN (Nếu dùng Google Drive)

```bash
pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
```

---

## 📚 CÁC TÍNH NĂNG NOTEBOOKLM

Sau khi import tài liệu vào NotebookLM, bạn có thể:

### 1. **Tóm tắt tự động**
- NotebookLM tự động tạo tóm tắt nội dung

### 2. **Đặt câu hỏi**
- Hỏi bất kỳ câu hỏi nào về nội dung
- NotebookLM sẽ trả lời dựa trên tài liệu

### 3. **Tạo Study Guide**
- Tự động tạo câu hỏi ôn tập
- Tạo outline

### 4. **Tạo Podcast/Video**
- Chuyển đổi nội dung thành audio/video

### 5. **Vẽ Mindmap**
- Tự động tạo sơ đồ tư duy

---

## ❓ TROUBLESHOOTING

### Lỗi: "Module notebooklm_integration không tìm thấy"

**Giải pháp:**
- Đảm bảo file `notebooklm_integration.py` ở cùng thư mục với `read_pdf_with_ai.py`

### Lỗi: "Cần cài đặt thư viện Google Drive API"

**Giải pháp:**
```bash
pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
```

### Lỗi: "Không tìm thấy credentials.json"

**Giải pháp:**
- Tải file `credentials.json` từ Google Cloud Console
- Đặt vào cùng thư mục với script

### Lỗi: "OAuth consent screen chưa được publish"

**Giải pháp:**
- Với tài khoản test, chỉ cần thêm email của bạn vào "Test users"
- Không cần publish app

### File quá lớn không upload được

**Giải pháp:**
- NotebookLM hỗ trợ file tối đa 20MB
- Nếu file quá lớn, chia nhỏ hoặc dùng phương pháp copy/paste

---

## 💡 MẸO SỬ DỤNG

1. **Dùng Google Drive cho nhiều file:**
   - Upload nhiều file lên cùng 1 folder
   - Import tất cả vào 1 notebook
   - NotebookLM sẽ phân tích tất cả cùng lúc

2. **Update file tự động:**
   - Khi file trên Drive thay đổi
   - NotebookLM tự động sync
   - Không cần import lại

3. **Share với team:**
   - Share folder Google Drive với team
   - Mọi người có thể import vào NotebookLM riêng
   - Hoặc share notebook trực tiếp

4. **Kết hợp với OCR:**
   - Nếu PDF là ảnh, dùng OCR trước
   - Sau đó export lên NotebookLM
   - NotebookLM sẽ phân tích tốt hơn với text đã được sửa lỗi

---

## 📞 HỖ TRỢ

Nếu gặp vấn đề, kiểm tra:
1. File `notebooklm_integration.py` có tồn tại không
2. Đã cài đặt đủ thư viện chưa
3. `credentials.json` có đúng không (nếu dùng Google Drive)
4. Đã đăng nhập Google account chưa

---

## 🎯 TÓM TẮT QUY TRÌNH

```
PDF → read_pdf_with_ai.py → Extract text → Export NotebookLM → Phân tích AI
```

**Bước nhanh nhất:**
1. `python read_pdf_with_ai.py "pdf/file.pdf"`
2. Chọn 4 → 1 (file text)
3. Copy/paste vào NotebookLM
4. Xong!

---

**Chúc bạn sử dụng thành công! 🎉**



