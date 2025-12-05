# HƯỚNG DẪN KẾT NỐI GITHUB

**Tác giả:** Dasi  
**Ngày tạo:** 04/12/2025

---

## 📋 MỤC LỤC

1. [Cài đặt Git](#1-cài-đặt-git)
2. [Tạo tài khoản GitHub](#2-tạo-tài-khoản-github)
3. [Cấu hình Git lần đầu](#3-cấu-hình-git-lần-đầu)
4. [Tạo SSH Key (Khuyến nghị)](#4-tạo-ssh-key-khuyến-nghị)
5. [Kết nối Repository](#5-kết-nối-repository)
6. [Các lệnh Git cơ bản](#6-các-lệnh-git-cơ-bản)

---

## 1. CÀI ĐẶT GIT

### Kiểm tra Git đã cài chưa:

```bash
git --version
```

### Nếu chưa có, tải Git:

- **Windows:** [git-scm.com/download/win](https://git-scm.com/download/win)
- Cài đặt mặc định, chọn "Git Bash Here"

---

## 2. TẠO TÀI KHOẢN GITHUB

1. Truy cập: [github.com](https://github.com)
2. Click **Sign up**
3. Điền email, mật khẩu
4. Xác nhận email

---

## 3. CẤU HÌNH GIT LẦN ĐẦU

Mở **Git Bash** hoặc **PowerShell**, chạy:

```bash
# Cấu hình tên
git config --global user.name "Tên của bạn"

# Cấu hình email (dùng email GitHub)
git config --global user.email "your-email@example.com"

# Kiểm tra cấu hình
git config --list
```

---

## 4. TẠO SSH KEY (KHUYẾN NGHỊ)

### Bước 1: Tạo SSH Key

```bash
# Tạo SSH key
ssh-keygen -t ed25519 -C "your-email@example.com"

# Nhấn Enter để lưu tại: C:\Users\YourName\.ssh\id_ed25519
# Nhấn Enter 2 lần (không đặt passphrase, hoặc đặt tùy ý)
```

### Bước 2: Copy SSH Key

**Windows (PowerShell):**

```powershell
# Copy nội dung file public key
Get-Content ~\.ssh\id_ed25519.pub | Set-Clipboard
```

**Hoặc mở file:** `C:\Users\YourName\.ssh\id_ed25519.pub`  
Copy toàn bộ nội dung (bắt đầu bằng `ssh-ed25519...`)

### Bước 3: Thêm SSH Key vào GitHub

1. Vào GitHub → **Settings** (góc phải trên)
2. Click **SSH and GPG keys** (bên trái)
3. Click **New SSH key**
4. **Title:** Đặt tên (ví dụ: "My Laptop")
5. **Key:** Paste nội dung đã copy
6. Click **Add SSH key**

### Bước 4: Kiểm tra kết nối

```bash
ssh -T git@github.com
```

Nếu thấy: `Hi username! You've successfully authenticated...` → **Thành công!**

---

## 5. KẾT NỐI REPOSITORY

### CÁCH 1: Clone Repository có sẵn

```bash
# Clone qua SSH (khuyến nghị)
git clone git@github.com:username/repository-name.git

# Hoặc clone qua HTTPS
git clone https://github.com/username/repository-name.git
```

### CÁCH 2: Tạo Repository mới từ folder local

#### Bước 1: Tạo Repository trên GitHub

1. Vào GitHub → Click **+** (góc phải trên) → **New repository**
2. Đặt tên repository
3. Chọn **Public** hoặc **Private**
4. **KHÔNG** tích "Initialize with README"
5. Click **Create repository**

#### Bước 2: Kết nối folder local với GitHub

```bash
# Di chuyển vào folder dự án
cd C:\AI

# Khởi tạo Git (nếu chưa có)
git init

# Thêm tất cả file
git add .

# Commit lần đầu
git commit -m "Initial commit"

# Thêm remote (thay username và repository-name)
git remote add origin git@github.com:username/repository-name.git

# Hoặc dùng HTTPS
git remote add origin https://github.com/username/repository-name.git

# Push lên GitHub
git branch -M main
git push -u origin main
```

---

## 6. CÁC LỆNH GIT CƠ BẢN

### Kiểm tra trạng thái:

```bash
git status
```

### Thêm file vào staging:

```bash
# Thêm tất cả file
git add .

# Thêm file cụ thể
git add filename.txt
```

### Commit (lưu thay đổi):

```bash
git commit -m "Mô tả thay đổi"
```

### Push lên GitHub:

```bash
# Push lần đầu
git push -u origin main

# Push các lần sau
git push
```

### Pull từ GitHub:

```bash
git pull
```

### Xem lịch sử:

```bash
git log
```

### Tạo branch mới:

```bash
# Tạo và chuyển sang branch mới
git checkout -b ten-branch

# Hoặc (Git 2.23+)
git switch -c ten-branch
```

---

## 🔐 XỬ LÝ LỖI THƯỜNG GẶP

### Lỗi: "Permission denied (publickey)"

**Nguyên nhân:** SSH key chưa được thêm vào GitHub

**Giải pháp:**
1. Kiểm tra SSH key đã thêm vào GitHub chưa
2. Chạy lại: `ssh -T git@github.com`

---

### Lỗi: "fatal: remote origin already exists"

**Giải pháp:**

```bash
# Xóa remote cũ
git remote remove origin

# Thêm lại
git remote add origin git@github.com:username/repository-name.git
```

---

### Lỗi: "Authentication failed" (khi dùng HTTPS)

**Giải pháp:**

1. **Dùng Personal Access Token:**
   - GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Generate new token
   - Chọn quyền: `repo`
   - Copy token
   - Khi push, dùng token thay vì mật khẩu

2. **Hoặc chuyển sang SSH** (khuyến nghị)

---

## 📝 TÓM TẮT QUY TRÌNH

```bash
# 1. Cấu hình Git
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"

# 2. Tạo SSH key (nếu chưa có)
ssh-keygen -t ed25519 -C "your-email@example.com"

# 3. Thêm SSH key vào GitHub (qua web)

# 4. Kiểm tra kết nối
ssh -T git@github.com

# 5. Clone hoặc tạo repository
git clone git@github.com:username/repo.git
# HOẶC
git init
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:username/repo.git
git push -u origin main
```

---

## ✅ CHECKLIST KẾT NỐI GITHUB

- [ ] Đã cài Git
- [ ] Đã tạo tài khoản GitHub
- [ ] Đã cấu hình `user.name` và `user.email`
- [ ] Đã tạo SSH key
- [ ] Đã thêm SSH key vào GitHub
- [ ] Đã test kết nối: `ssh -T git@github.com`
- [ ] Đã clone hoặc push repository thành công

---

**Lưu ý:** Nếu gặp vấn đề, cho tôi biết lỗi cụ thể để tôi hỗ trợ! 🦐


