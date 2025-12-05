# HƯỚNG DẪN SỬ DỤNG SCRIPT EXTRACT PPTX

## Cách 1: Sử dụng PowerShell (Đã hoàn thành)
```powershell
powershell -ExecutionPolicy Bypass -File extract_pptx_text.ps1
```
Nội dung đã được extract vào file: `pptx_content.txt`

## Cách 2: Sử dụng Bash Script (Khi có Git Bash hoặc WSL)

### Cài Git Bash (Khuyến nghị - Nhẹ, nhanh)
1. Tải Git for Windows: https://git-scm.com/download/win
2. Cài đặt và chọn "Git Bash Here"
3. Chạy script:
```bash
chmod +x extract_pptx.sh
./extract_pptx.sh "ran bien.pptx"
```

### Hoặc sử dụng với WSL (Nếu đã cài):
```bash
wsl bash extract_pptx.sh "ran bien.pptx"
```

## Cấu trúc script bash

Script `extract_pptx.sh` sẽ:
1. Đổi tên file .pptx thành .zip
2. Giải nén vào thư mục tạm
3. Trích xuất text từ các file slide XML
4. Lưu vào file `pptx_content.txt`
5. Dọn dẹp file tạm

## Sử dụng
```bash
# Extract từ file mặc định (ran bien.pptx)
./extract_pptx.sh

# Extract từ file khác
./extract_pptx.sh "ten_file.pptx"
```

