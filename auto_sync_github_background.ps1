# Script tu dong sync GitHub chay nen (khong hien thi cua so)
# Tac gia: Dasi
# Chay nen: powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File .\auto_sync_github_background.ps1

# Xac dinh thu muc lam viec - su dung nhieu phuong phap de dam bao dung
$scriptPath = $null
if ($MyInvocation.MyCommand.Path) {
    $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
}
if ([string]::IsNullOrWhiteSpace($scriptPath)) {
    # Thu lay tu PSScriptRoot
    if ($PSScriptRoot) {
        $scriptPath = $PSScriptRoot
    } else {
        # Fallback ve thu muc co dinh
        $scriptPath = "C:\AI"
    }
}

# Dam bao duong dan ton tai
if (-not (Test-Path $scriptPath)) {
    $scriptPath = "C:\AI"
}

Set-Location $scriptPath

# Ghi log vao file - tao file ngay tu dau voi error handling
$logFile = Join-Path $scriptPath "auto_sync_log.txt"
$syncCount = 0
$lastSyncTime = Get-Date

# Tao log file ngay tu dau voi try-catch
try {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $initLog = @(
        "[$timestamp] Auto Sync GitHub - Bat dau chay nen",
        "[$timestamp] Thu muc: $scriptPath",
        "[$timestamp] Kiem tra moi 5 phut",
        ""
    )
    $initLog | Out-File -FilePath $logFile -Encoding UTF8 -ErrorAction Stop
} catch {
    # Neu khong ghi duoc, thu ghi vao temp
    $logFile = Join-Path $env:TEMP "auto_sync_log.txt"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "[$timestamp] Khong the ghi log vao thu muc goc, su dung temp: $logFile" | Out-File -FilePath $logFile -Encoding UTF8
}

function Write-Log {
    param($message)
    try {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logMessage = "[$timestamp] $message"
        $logMessage | Out-File -FilePath $logFile -Encoding UTF8 -Append -ErrorAction Stop
    } catch {
        # Neu khong ghi duoc log, bo qua (de script tiep tuc chay)
    }
}

# Ghi log khoi dong thanh cong
Write-Log "Script da khoi dong thanh cong"

while ($true) {
    try {
        $currentTime = Get-Date
        
        # Dam bao dung thu muc
        if (Test-Path $scriptPath) {
            Set-Location $scriptPath
        } else {
            Write-Log "LOI: Thu muc khong ton tai: $scriptPath"
            Start-Sleep -Seconds 300
            continue
        }
        
        # Kiem tra co thay doi khong
        $status = git status --porcelain 2>&1
        
        if (-not [string]::IsNullOrWhiteSpace($status)) {
            Write-Log "Phat hien thay doi! Dang sync..."
            
            # Add tat ca file
            git add . 2>&1 | Out-Null
            
            # Commit voi timestamp
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $commitMessage = "Auto sync: $timestamp"
            
            $commitResult = git commit -m $commitMessage 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Log "Commit thanh cong!"
                
                # Push len GitHub
                $pushResult = git push origin main 2>&1
                
                if ($LASTEXITCODE -eq 0) {
                    $syncCount++
                    $lastSyncTime = Get-Date
                    Write-Log "Sync thanh cong! (Lan: $syncCount)"
                } else {
                    Write-Log "LOI khi push: $pushResult"
                }
            } else {
                Write-Log "Khong co gi de commit hoac loi: $commitResult"
            }
        } else {
            # Chi log moi 30 phut de khong spam log
            $minutesSinceLastSync = ($currentTime - $lastSyncTime).TotalMinutes
            if ($minutesSinceLastSync -ge 30) {
                Write-Log "Khong co thay doi (da kiem tra $syncCount lan)"
                $lastSyncTime = $currentTime
            }
        }
        
    } catch {
        Write-Log "LOI: $($_.Exception.Message)"
    }
    
    # Doi 5 phut (300 giay)
    Start-Sleep -Seconds 300
}
