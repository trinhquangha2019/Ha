# HƯỚNG DẪN PUSH LÊN GITHUB

**Ngày tạo:** 04/12/2025

---

## ✅ ĐÃ HOÀN THÀNH

1. ✅ Cấu hình Git (user.name, user.email)
2. ✅ Tạo SSH key
3. ✅ Khởi tạo repository
4. ✅ Tạo .gitignore
5. ✅ Commit lần đầu (186 files)

---

## 🔑 BƯỚC TIẾP THEO: THÊM SSH KEY VÀO GITHUB

### 1. Copy SSH Public Key

Public key đã được lưu trong file: `SSH_KEY_GITHUB.txt`

Hoặc copy trực tiếp:
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJcxRV88+iDxQFQCMpBWH9bLmmtjfVlG6SWtbPPrktV3 trinhquangha2019@gmail.com
```

### 2. Thêm vào GitHub

1. Truy cập: https://github.com/settings/keys
2. Click **"New SSH key"**
3. Điền:
   - **Title:** "My Laptop" (hoặc tên bạn muốn)
   - **Key:** Paste public key ở trên
4. Click **"Add SSH key"**
5. Nhập mật khẩu GitHub để xác nhận

### 3. Kiểm tra kết nối

```bash
ssh -T git@github.com
```

Nếu thấy: `Hi username! You've successfully authenticated...` → **Thành công!**

---

## 📤 PUSH LÊN GITHUB

### Bước 1: Tạo Repository trên GitHub

1. Vào https://github.com/new
2. Đặt tên repository (ví dụ: `dasi-knowledge-base`)
3. Chọn **Private** hoặc **Public**
4. **KHÔNG** tích "Initialize with README"
5. Click **"Create repository"**

### Bước 2: Kết nối và Push

```bash
# Thêm remote (thay username và repository-name)
git remote add origin git@github.com:trinnhquangha2019/repository-name.git

# Đổi tên branch thành main (nếu cần)
git branch -M main

# Push lên GitHub
git push -u origin main
```

---

## 🔄 CÁC LỆNH THƯỜNG DÙNG

### Xem trạng thái:
```bash
git status
```

### Thêm file:
```bash
git add .
# hoặc
git add filename.md
```

### Commit:
```bash
git commit -m "Mô tả thay đổi"
```

### Push:
```bash
git push
```

### Pull (lấy code mới):
```bash
git pull
```

---

## ⚠️ LƯU Ý

- **KHÔNG commit file nhạy cảm:** mật khẩu, API keys, private keys
- **File .gitignore** đã loại trừ: `*.docx`, `*.pdf`, `*.zip`, `__pycache__/`
- **Commit thường xuyên** với message rõ ràng
- **Pull trước khi Push** nếu làm việc nhóm

---

## 📞 HỖ TRỢ

Nếu gặp lỗi, kiểm tra:
1. SSH key đã thêm vào GitHub chưa?
2. Repository đã tạo trên GitHub chưa?
3. Tên repository và username đúng chưa?

---

**Chúc bạn thành công!** 🦐

