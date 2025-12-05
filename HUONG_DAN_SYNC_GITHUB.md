# HƯỚNG DẪN ĐỒNG BỘ FILE LÊN GITHUB

**Ngày tạo:** 04/12/2025

---

## ❌ GIT KHÔNG TỰ ĐỘNG CẬP NHẬT

**Git KHÔNG tự động sync file lên GitHub.** Bạn phải thực hiện **3 bước thủ công:**

1. **`git add`** - Thêm file vào staging
2. **`git commit`** - Lưu thay đổi
3. **`git push`** - Đẩy lên GitHub

---

## 📋 QUY TRÌNH THỦ CÔNG

### Bước 1: Kiểm tra file mới/thay đổi

```bash
git status
```

### Bước 2: Thêm file vào staging

```bash
# Thêm tất cả file
git add .

# Hoặc thêm file cụ thể
git add filename.md
```

### Bước 3: Commit (lưu thay đổi)

```bash
git commit -m "Mô tả thay đổi"
```

### Bước 4: Push lên GitHub

```bash
git push
```

---

## 🤖 TẠO SCRIPT TỰ ĐỘNG HÓA

Tôi có thể tạo script để tự động hóa 3 bước trên:

### Script PowerShell: `sync_github.ps1`

```powershell
# Tự động add, commit, push
git add .
git commit -m "Auto sync: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push
```

**Cách dùng:**
```bash
.\sync_github.ps1
```

---

## ⚡ LỆNH NHANH (1 dòng)

```bash
git add . && git commit -m "Update files" && git push
```

**Lưu ý:** PowerShell không hỗ trợ `&&`, dùng script hoặc chạy từng lệnh.

---

## 🔄 TẦN SUẤT ĐỒNG BỘ

| Tần suất | Khi nào |
|----------|---------|
| **Ngay lập tức** | File quan trọng, cần backup |
| **Hàng ngày** | Cuối ngày làm việc |
| **Hàng tuần** | Tổng kết công việc |
| **Trước khi tắt máy** | Đảm bảo không mất dữ liệu |

---

## ⚠️ LƯU Ý

1. **Luôn kiểm tra trước khi push:**
   ```bash
   git status
   git diff
   ```

2. **Không commit file nhạy cảm:**
   - Mật khẩu
   - API keys
   - Private keys
   - File `.env`

3. **Commit message rõ ràng:**
   - ❌ `git commit -m "update"`
   - ✅ `git commit -m "Thêm bài viết SEO cá mú đỏ"`

---

## 🛠️ TẠO SCRIPT TỰ ĐỘNG

Bạn muốn tôi tạo script tự động hóa không?

**Script sẽ:**
- ✅ Tự động add tất cả file
- ✅ Tự động commit với timestamp
- ✅ Tự động push lên GitHub
- ✅ Hiển thị kết quả

**Chạy bằng:** `.\sync_github.ps1`

---

**Tóm lại:** Git **KHÔNG tự động**, bạn phải **chủ động** sync! 🦐

