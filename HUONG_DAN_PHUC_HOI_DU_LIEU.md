# 🔄 HƯỚNG DẪN PHỤC HỒI DỮ LIỆU TRONG CURSOR

**Ngày tạo:** 05/12/2025

---

## 🎯 CÁC CÁCH PHỤC HỒI DỮ LIỆU

### 1️⃣ PHỤC HỒI TỪ GIT (Nếu có Git repository)

#### A. Xem lịch sử commit gần đây:

```powershell
# Xem commit 10-15 phút trước
git log --oneline --since="15 minutes ago"

# Xem chi tiết commit
git log --since="15 minutes ago"
```

#### B. Phục hồi file cụ thể từ commit trước:

```powershell
# Xem file đã thay đổi như thế nào
git diff HEAD~1 <tên_file>

# Phục hồi file về version trước đó
git checkout HEAD~1 -- <tên_file>

# Hoặc phục hồi về commit cụ thể
git checkout <commit_hash> -- <tên_file>
```

#### C. Phục hồi tất cả file về commit trước:

```powershell
# Phục hồi tất cả về commit trước (CẨN THẬN!)
git reset --hard HEAD~1

# Hoặc về commit cụ thể
git reset --hard <commit_hash>
```

#### D. Xem nội dung file từ commit trước:

```powershell
# Xem nội dung file từ commit trước
git show HEAD~1:<tên_file>

# Xem nội dung từ commit cụ thể
git show <commit_hash>:<tên_file>
```

---

### 2️⃣ PHỤC HỒI TỪ LOCAL HISTORY (Cursor/VS Code)

Cursor tự động lưu Local History của các file đã chỉnh sửa.

#### Cách 1: Dùng Command Palette

1. Mở file cần phục hồi
2. Nhấn `Ctrl + Shift + P`
3. Gõ: **"Local History: Find Entry to Restore"**
4. Chọn version bạn muốn phục hồi

#### Cách 2: Click chuột phải

1. Mở file cần phục hồi
2. Click chuột phải vào file trong Explorer
3. Chọn **"Local History"** → **"Find Entry to Restore"**
4. Chọn version từ danh sách

#### Cách 3: Xem Timeline

1. Mở file cần phục hồi
2. Click vào icon **Timeline** (ở sidebar bên trái)
3. Xem các version đã lưu
4. Click vào version muốn phục hồi

---

### 3️⃣ PHỤC HỒI TỪ RECYCLE BIN (Windows)

Nếu file bị xóa:

1. Mở **Recycle Bin** (Thùng rác)
2. Tìm file đã xóa
3. Click chuột phải → **Restore**

Hoặc dùng PowerShell:

```powershell
# Xem file trong Recycle Bin
Get-ChildItem 'C:\$Recycle.Bin' -Recurse -Force | Where-Object {$_.LastWriteTime -gt (Get-Date).AddMinutes(-15)}

# Phục hồi file (cần quyền admin)
Restore-Item -Path "đường_dẫn_file_trong_recycle_bin"
```

---

### 4️⃣ PHỤC HỒI TỪ AUTO-SAVE (Cursor)

Cursor tự động lưu file khi bạn chỉnh sửa.

1. Đóng file (không save)
2. Mở lại file
3. Cursor sẽ hỏi: **"Do you want to restore the previous content?"**
4. Chọn **"Restore"**

---

## 🚀 LỆNH NHANH PHỤC HỒI TỪ GIT

### Phục hồi file cụ thể về 10 phút trước:

```powershell
# Tìm commit 10 phút trước
git log --oneline --since="10 minutes ago" --until="now"

# Phục hồi file về commit đó
git checkout <commit_hash> -- <tên_file>
```

### Phục hồi tất cả về commit gần nhất (10 phút trước):

```powershell
# Xem commit gần nhất
git log -1 --oneline

# Phục hồi về commit đó (CẨN THẬN!)
git reset --hard HEAD
```

---

## ⚠️ LƯU Ý QUAN TRỌNG

1. **Luôn backup trước khi reset:**
   ```powershell
   # Tạo branch backup
   git branch backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')
   ```

2. **Kiểm tra thay đổi trước khi phục hồi:**
   ```powershell
   git diff HEAD~1
   ```

3. **Nếu đã commit và push:**
   - Cần force push (cẩn thận!)
   - Hoặc tạo commit mới để phục hồi

---

## 📋 CHECKLIST PHỤC HỒI

- [ ] Xác định file nào cần phục hồi
- [ ] Kiểm tra Git log để tìm commit
- [ ] Thử Local History trong Cursor
- [ ] Kiểm tra Recycle Bin nếu file bị xóa
- [ ] Backup trước khi reset Git
- [ ] Phục hồi file
- [ ] Kiểm tra lại nội dung

---

## 🔧 SCRIPT TỰ ĐỘNG PHỤC HỒI

Tôi có thể tạo script để tự động phục hồi file từ Git commit gần nhất.




