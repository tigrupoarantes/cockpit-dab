$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=192.168.1.10;Database=GA_DATALAKE;User Id=datalake_consulta;Password=Chok@2026;TrustServerCertificate=True"
$conn.Open()

$sql = Get-Content "$PSScriptRoot\_q_fev2026.sql" -Raw

Write-Host "=== TOP 100 - fevereiro 2026 ==="
$sw = [System.Diagnostics.Stopwatch]::StartNew()
$cmd = $conn.CreateCommand()
$cmd.CommandText = $sql
$cmd.CommandTimeout = 300
try {
    $r = $cmd.ExecuteReader()
    $rows = @()
    while ($r.Read()) {
        $rows += [PSCustomObject]@{
            data          = [string]$r['data']
            numero_pedido = [string]$r['numero_pedido']
            sku           = [string]$r['sku']
            descricao     = [string]$r['descricao_produto']
            qtde          = [string]$r['qtde_vendida']
            preco         = [string]$r['preco_unitario_prod']
            vendedor      = [string]$r['nome_vendedor']
            municipio     = [string]$r['municipio']
            estado        = [string]$r['estado']
            categoria     = [string]$r['categoria']
        }
    }
    $r.Close()
    $sw.Stop()
    Write-Host "SUCESSO - $($rows.Count) registros em $($sw.ElapsedMilliseconds)ms ($([math]::Round($sw.Elapsed.TotalSeconds,1))s)"
    $rows | Select-Object -First 5 | Format-Table -AutoSize
} catch {
    $sw.Stop()
    Write-Host "ERRO apos $($sw.ElapsedMilliseconds)ms ($([math]::Round($sw.Elapsed.TotalSeconds,1))s)"
    Write-Host $_
}

$conn.Close()
