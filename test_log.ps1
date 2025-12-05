$logFile = "C:\AI\auto_sync_log.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"[$timestamp] Test log - Script đang chạy!" | Out-File -FilePath $logFile -Encoding UTF8
"[$timestamp] Thư mục: C:\AI" | Out-File -FilePath $logFile -Encoding UTF8 -Append

