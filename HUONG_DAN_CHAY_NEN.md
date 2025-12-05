# HƯỚNG DẪN CHẠY AUTO SYNC NỀN (Song song với Cursor)

**Ngày tạo:** 04/12/2025

---

## 🎯 MỤC ĐÍCH

Chạy auto sync GitHub **nền** (background) để không ảnh hưởng đến việc sử dụng Cursor.

---

## 🚀 CÁCH 1: DÙNG FILE .BAT (Đơn giản nhất)

### Bước 1: Chạy auto sync nền

**Double-click file:** `start_auto_sync.bat`

Hoặc chạy trong PowerShell:
```bash
.\start_auto_sync.bat
```

### Bước 2: Kiểm tra đang chạy

Mở **Task Manager** (`Ctrl + Shift + Esc`):
- Tìm process `powershell.exe` với command line chứa `auto_sync_github.ps1`

### Bước 3: Dừng auto sync

**Double-click file:** `stop_auto_sync.bat`

Hoặc:
```bash
.\stop_auto_sync.bat
```

---

## 🚀 CÁCH 2: CHẠY TRỰC TIẾP TRONG POWERSHELL

### Chạy nền (không hiển thị cửa sổ):

```powershell
Start-Process powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"C:\AI\auto_sync_github_background.ps1`""
```

### Kiểm tra đang chạy:

```powershell
Get-Process powershell | Where-Object {$_.CommandLine -like "*auto_sync*"}
```

### Dừng:

```powershell
Get-Process powershell | Where-Object {$_.CommandLine -like "*auto_sync*"} | Stop-Process
```

---

## 🚀 CÁCH 3: CHẠY VỚI BACKGROUND JOB (PowerShell)

### Tạo background job:

```powershell
$job = Start-Job -ScriptBlock {
    cd C:\AI
    while ($true) {
        git add . 2>$null
        $commitMsg = "Auto sync: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        git commit -m $commitMsg 2>$null
        git push 2>$null
        Start-Sleep -Seconds 300
    }
}
```

### Xem trạng thái:

```powershell
Get-Job
Receive-Job $job
```

### Dừng job:

```powershell
Stop-Job $job
Remove-Job $job
```

---

## 📊 THEO DÕI LOG

Script sẽ ghi log vào file: `auto_sync_log.txt`

### Xem log:

```powershell
Get-Content auto_sync_log.txt -Tail 20
```

### Xem log real-time:

```powershell
Get-Content auto_sync_log.txt -Wait -Tail 10
```

---

## ✅ KIỂM TRA HOẠT ĐỘNG

### 1. Kiểm tra process đang chạy:

```powershell
Get-Process | Where-Object {$_.ProcessName -eq "powershell"} | Select-Object Id, ProcessName, StartTime
```

### 2. Kiểm tra log file:

```powershell
Test-Path auto_sync_log.txt
Get-Content auto_sync_log.txt -Tail 5
```

### 3. Kiểm tra lịch sử commit:

```bash
git log --oneline -5
```

---

## 🔧 TÙY CHỈNH

### Thay đổi thời gian sync:

Mở `auto_sync_github_background.ps1`, tìm:
```powershell
Start-Sleep -Seconds 300  # 300 = 5 phút
```

### Tắt log (nếu không cần):

Xóa hoặc comment các dòng `Write-Log` và `Add-Content`

---

## ⚠️ LƯU Ý

1. **Script chạy nền sẽ không hiển thị cửa sổ**
2. **Kiểm tra log file** để biết trạng thái
3. **Dừng script** trước khi tắt máy (nếu cần)
4. **Không commit file nhạy cảm** - kiểm tra `.gitignore`

---

## 🛑 DỪNG AUTO SYNC

### Cách 1: Dùng file .bat
```bash
.\stop_auto_sync.bat
```

### Cách 2: Dùng Task Manager
1. Mở Task Manager (`Ctrl + Shift + Esc`)
2. Tìm `powershell.exe` với command line chứa `auto_sync`
3. Click chuột phải → **End Task**

### Cách 3: Dùng PowerShell
```powershell
Get-Process powershell | Where-Object {$_.CommandLine -like "*auto_sync*"} | Stop-Process
```

---

## 📝 CHECKLIST

- [ ] Đã chạy `start_auto_sync.bat`
- [ ] Đã kiểm tra process trong Task Manager
- [ ] Đã kiểm tra log file
- [ ] Đã test tạo file mới và chờ 5 phút
- [ ] Đã kiểm tra file xuất hiện trên GitHub

---

**Chúc bạn thành công!** 🦐


