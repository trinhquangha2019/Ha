# HƯỚNG DẪN TỰ ĐỘNG SYNC GITHUB MỖI 5 PHÚT

**Ngày tạo:** 04/12/2025

---

## 🎯 MỤC ĐÍCH

Tự động đồng bộ code lên GitHub **mỗi 5 phút** mà không cần can thiệp thủ công.

---

## 📋 CÁCH 1: CHẠY SCRIPT TRỰC TIẾP (Đơn giản nhất)

### Bước 1: Mở PowerShell

### Bước 2: Chạy script

```powershell
cd C:\AI
powershell -ExecutionPolicy Bypass -File .\auto_sync_github.ps1
```

### Bước 3: Để chạy nền

Script sẽ chạy liên tục, tự động kiểm tra và sync mỗi 5 phút.

**Để dừng:** Nhấn `Ctrl + C`

---

## 📋 CÁCH 2: TẠO TASK SCHEDULER (Chạy tự động khi khởi động)

### Bước 1: Mở Task Scheduler

1. Nhấn `Win + R`
2. Gõ: `taskschd.msc`
3. Nhấn Enter

### Bước 2: Tạo Task mới

1. Click **"Create Task"** (bên phải)
2. Tab **General:**
   - **Name:** `Auto Sync GitHub`
   - **Description:** `Tự động sync code lên GitHub mỗi 5 phút`
   - ✅ **Run whether user is logged on or not**
   - ✅ **Run with highest privileges**

### Bước 3: Tab Triggers

1. Click **"New"**
2. **Begin the task:** `At startup`
3. ✅ **Repeat task every:** `5 minutes`
4. ✅ **Indefinitely**
5. Click **OK**

### Bước 4: Tab Actions

1. Click **"New"**
2. **Action:** `Start a program`
3. **Program/script:** `powershell.exe`
4. **Add arguments:**
   ```
   -ExecutionPolicy Bypass -File "C:\AI\auto_sync_github.ps1"
   ```
5. **Start in:** `C:\AI`
6. Click **OK**

### Bước 5: Tab Settings

- ✅ **Allow task to be run on demand**
- ✅ **Run task as soon as possible after a scheduled start is missed**
- ✅ **If the task fails, restart every:** `1 minute`
- **Stop the task if it runs longer than:** `Indefinitely`

### Bước 6: Lưu

1. Click **OK**
2. Nhập mật khẩu Windows (nếu cần)

---

## 📋 CÁCH 3: CHẠY NỀN VỚI BACKGROUND JOB

### Tạo background job:

```powershell
$job = Start-Job -ScriptBlock {
    cd C:\AI
    while ($true) {
        git add . 2>$null
        git commit -m "Auto sync: $(Get-Date)" 2>$null
        git push 2>$null
        Start-Sleep -Seconds 300
    }
}
```

### Xem trạng thái:

```powershell
Get-Job
```

### Dừng job:

```powershell
Stop-Job $job
Remove-Job $job
```

---

## ⚙️ CẤU HÌNH TÙY CHỈNH

### Thay đổi thời gian sync:

Mở file `auto_sync_github.ps1`, tìm dòng:

```powershell
Start-Sleep -Seconds 300  # 300 giây = 5 phút
```

**Thay đổi:**
- 1 phút: `60`
- 10 phút: `600`
- 30 phút: `1800`
- 1 giờ: `3600`

---

## 📊 THEO DÕI LOG

Script sẽ hiển thị:
- ⏰ Thời gian kiểm tra
- 📝 File thay đổi
- ✅ Kết quả sync
- ❌ Lỗi (nếu có)

---

## ⚠️ LƯU Ý

1. **Git phải được cấu hình đúng:**
   ```bash
   git config --global user.name "trinnhquangha2019"
   git config --global user.email "trinhquangha2019@gmail.com"
   ```

2. **SSH key phải được thêm vào GitHub**

3. **Repository phải được kết nối:**
   ```bash
   git remote -v
   ```

4. **Không commit file nhạy cảm:**
   - Kiểm tra `.gitignore`
   - Không commit mật khẩu, API keys

---

## 🛑 DỪNG TỰ ĐỘNG SYNC

### Nếu chạy script trực tiếp:
- Nhấn `Ctrl + C`

### Nếu dùng Task Scheduler:
1. Mở Task Scheduler
2. Tìm task **"Auto Sync GitHub"**
3. Click chuột phải → **Disable** hoặc **Delete**

### Nếu dùng Background Job:
```powershell
Get-Job | Stop-Job
Get-Job | Remove-Job
```

---

## ✅ KIỂM TRA HOẠT ĐỘNG

### Xem lịch sử commit:

```bash
git log --oneline -10
```

### Xem trạng thái:

```bash
git status
```

### Xem remote:

```bash
git remote -v
```

---

**Chúc bạn thành công!** 🦐

