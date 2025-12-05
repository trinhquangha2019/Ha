# Script tu dong sync ngay lap tuc khi co thay doi
# Tac gia: Dasi
# Cach dung: .\auto_sync_instant.ps1

# Xac dinh thu muc lam viec
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($scriptPath)) {
    $scriptPath = $PSScriptRoot
}
if ([string]::IsNullOrWhiteSpace($scriptPath)) {
    $scriptPath = "C:\AI"
}

Set-Location $scriptPath

Write-Host "🔄 Auto Sync Instant - Dong bo ngay khi co thay doi" -ForegroundColor Cyan
Write-Host "Nhan Ctrl+C de dung`n" -ForegroundColor Yellow

$syncCount = 0

# Function de sync
function Sync-Now {
    param($reason = "Thay doi")
    
    try {
        Set-Location $scriptPath
        
        # Fetch de cap nhat thong tin remote
        git fetch origin 2>&1 | Out-Null
        
        # Kiem tra thay doi
        $status = git status --porcelain 2>&1
        $branchStatus = git status -sb 2>&1
        $hasConflict = $branchStatus -match "behind|diverged"
        
        if ([string]::IsNullOrWhiteSpace($status) -and -not $hasConflict) {
            return $false
        }
        
        Write-Host "`n[$($reason)] Dang dong bo..." -ForegroundColor Yellow
        
        # Add tat ca (bao gom file bi xoa)
        if (-not [string]::IsNullOrWhiteSpace($status)) {
            git add -A 2>&1 | Out-Null
            
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $commitMessage = "Auto sync: $timestamp"
            git commit -m $commitMessage 2>&1 | Out-Null
        }
        
        # Xu ly conflict
        if ($hasConflict) {
            Write-Host "  ⚠️  Phat hien conflict, dang xu ly..." -ForegroundColor Yellow
            $pullResult = git pull --rebase origin main 2>&1
            
            if ($LASTEXITCODE -ne 0) {
                Write-Host "  🔄 Force push de dong bo..." -ForegroundColor Yellow
                git push --force origin main 2>&1 | Out-Null
            } else {
                git push origin main 2>&1 | Out-Null
            }
        } else {
            git push origin main 2>&1 | Out-Null
        }
        
        if ($LASTEXITCODE -eq 0) {
            $script:syncCount++
            Write-Host "  ✅ Dong bo thanh cong! (Lan: $syncCount)" -ForegroundColor Green
            return $true
        } else {
            Write-Host "  ❌ Loi khi dong bo!" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "  ❌ Loi: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Sync lan dau
Sync-Now "Khoi dong"

# Su dung FileSystemWatcher de detect thay doi ngay lap tuc
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $scriptPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Loai bo cac thu muc khong can watch
$watcher.Filter = "*.*"
$watcher.NotifyFilter = [System.IO.NotifyFilters]::FileName -bor 
                       [System.IO.NotifyFilters]::DirectoryName -bor
                       [System.IO.NotifyFilters]::LastWrite

# Event handler
$action = {
    $path = $Event.SourceEventArgs.FullPath
    $changeType = $Event.SourceEventArgs.ChangeType
    
    # Bo qua file log va temp
    if ($path -match "(auto_sync_log|\.git|temp_|__pycache__)") {
        return
    }
    
    # Doi 2 giay de tranh sync nhieu lan lien tiep
    Start-Sleep -Seconds 2
    
    Sync-Now "$changeType: $(Split-Path -Leaf $path)" | Out-Null
}

# Dang ky event
Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName "Deleted" -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName "Renamed" -Action $action | Out-Null

Write-Host "`n👀 Dang theo doi thay doi... (Nhan Ctrl+C de dung)" -ForegroundColor Cyan

# Vong lap de giu script chay
try {
    while ($true) {
        # Sync dinh ky moi 30 giay (backup)
        Start-Sleep -Seconds 30
        Sync-Now "Kiem tra dinh ky" | Out-Null
    }
} finally {
    # Cleanup
    $watcher.EnableRaisingEvents = $false
    $watcher.Dispose()
    Write-Host "`n✅ Da dung theo doi" -ForegroundColor Green
}

