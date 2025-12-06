# 🤖 HƯỚNG DẪN TỰ ĐỘNG THÊM CHÂM NGÔN MỚI

**Ngày tạo:** 06/12/2025

---

## 🎯 TÍNH NĂNG

**Tự động thêm 2-3 châm ngôn mới vào thư viện mỗi buổi sáng (1 lần/ngày)**

---

## ⚙️ CÁCH HOẠT ĐỘNG

### 1. **Tự động khi chạy script chào hỏi**

Khi bạn chạy `chao_ngay_moi.ps1` vào buổi sáng (5h-12h), script sẽ:
- ✅ Tự động kiểm tra đã thêm châm ngôn hôm nay chưa
- ✅ Nếu chưa → Tự động thêm 2-3 châm ngôn mới
- ✅ Ghi log để không thêm trùng

### 2. **Chạy thủ công**

```powershell
powershell -ExecutionPolicy Bypass -File .\them_cham_ngon_moi.ps1
```

---

## 📋 QUY TẮC

### ⏰ **Thời gian:**
- Chỉ chạy vào **buổi sáng** (5h - 12h)
- Chỉ chạy **1 lần mỗi ngày**

### 📝 **Số lượng:**
- Thêm **2-3 châm ngôn** mới mỗi ngày
- Tự động chọn ngẫu nhiên từ danh sách 30+ châm ngôn

### 🔍 **Kiểm tra trùng:**
- Tự động kiểm tra xem châm ngôn đã có trong file chưa
- Chỉ thêm châm ngôn mới (chưa có)

---

## 📁 FILE LIÊN QUAN

1. **`them_cham_ngon_moi.ps1`** - Script thêm châm ngôn
2. **`cham_ngon_cuoc_song.txt`** - File chứa tất cả châm ngôn
3. **`cham_ngon_log.txt`** - Log để track đã thêm hôm nay chưa
4. **`chao_ngay_moi.ps1`** - Script chào hỏi (tự động gọi script thêm châm ngôn)

---

## 🔧 CẤU HÌNH

### Thay đổi số lượng châm ngôn mỗi ngày:

Mở `them_cham_ngon_moi.ps1`, tìm dòng:
```powershell
$soLuong = $random.Next(2, 4)  # 2 hoac 3 cham ngon
```

Thay đổi thành:
- **1-2 châm ngôn:** `$random.Next(1, 3)`
- **3-4 châm ngôn:** `$random.Next(3, 5)`
- **Cố định 2 châm ngôn:** `$soLuong = 2`

### Thêm châm ngôn mới vào danh sách:

Mở `them_cham_ngon_moi.ps1`, tìm mảng `$chamNgonMoi`, thêm vào:
```powershell
$chamNgonMoi = @(
    "Châm ngôn mới của bạn...",
    ...
)
```

---

## 📊 LOG FILE

File `cham_ngon_log.txt` ghi lại:
```
2025-12-06 - Da them 2 cham ngon moi
2025-12-07 - Da them 3 cham ngon moi
```

**Format:** `YYYY-MM-DD - Da them X cham ngon moi`

---

## ✅ KIỂM TRA

### Xem log:
```powershell
Get-Content cham_ngon_log.txt -Tail 5
```

### Xem số lượng châm ngôn hiện tại:
```powershell
(Get-Content cham_ngon_cuoc_song.txt -Encoding UTF8 | Where-Object { $_ -notmatch '^\s*$' }).Count
```

### Test thêm châm ngôn (bỏ qua kiểm tra thời gian):
Sửa script tạm thời để bỏ qua kiểm tra buổi sáng.

---

## 🎯 TỰ ĐỘNG HÓA HOÀN TOÀN

### Cách 1: Chạy khi mở máy

Tạo shortcut trong **Startup folder:**
```powershell
$startup = [System.Environment]::GetFolderPath("Startup")
$shortcut = Join-Path $startup "ChaoNgayMoi.lnk"
$target = "powershell.exe"
$arguments = "-ExecutionPolicy Bypass -File `"C:\AI\chao_ngay_moi.ps1`""
$shell = New-Object -ComObject WScript.Shell
$link = $shell.CreateShortcut($shortcut)
$link.TargetPath = $target
$link.Arguments = $arguments
$link.Save()
```

### Cách 2: Task Scheduler

Tạo task chạy mỗi sáng lúc 7h:
```powershell
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File C:\AI\chao_ngay_moi.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At "07:00"
Register-ScheduledTask -TaskName "ChaoNgayMoi" -Action $action -Trigger $trigger
```

---

## 📝 LƯU Ý

1. **Chỉ chạy 1 lần/ngày:** Script tự động kiểm tra log
2. **Chỉ buổi sáng:** Script chỉ thêm châm ngôn vào buổi sáng (5h-12h)
3. **Không trùng:** Tự động kiểm tra và bỏ qua châm ngôn đã có
4. **Log file:** Tự động ghi log để track

---

## 🎉 KẾT QUẢ

Mỗi buổi sáng khi bạn chạy script chào hỏi:
- ✅ Tự động thêm 2-3 châm ngôn mới
- ✅ Thư viện châm ngôn ngày càng phong phú
- ✅ Không cần làm gì thủ công!

**Hoàn toàn tự động!** 🚀


