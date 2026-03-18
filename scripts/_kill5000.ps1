Get-NetTCPConnection -LocalPort 5000 -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty OwningProcess |
    Sort-Object -Unique |
    ForEach-Object {
        Write-Host "Matando PID $_"
        Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue
    }
Start-Sleep -Seconds 2
$test = Get-NetTCPConnection -LocalPort 5000 -ErrorAction SilentlyContinue
if ($test) { Write-Host "Porta 5000 ainda ocupada!" } else { Write-Host "Porta 5000 livre." }
