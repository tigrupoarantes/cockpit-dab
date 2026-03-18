$proc = Get-NetTCPConnection -LocalPort 5000 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -First 1
if ($proc) {
    Write-Host "DAB rodando (PID $proc), encerrando..."
    Stop-Process -Id $proc -Force
    Start-Sleep -Seconds 3
    Write-Host "Processo encerrado."
} else {
    Write-Host "DAB nao estava rodando na porta 5000."
}
