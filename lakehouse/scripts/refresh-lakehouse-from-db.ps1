[CmdletBinding()]
param(
    [string]$ServerInstance,
    [string]$Database,
    [ValidateSet('Windows','Sql')][string]$Auth,
    [string]$Username,
    [string]$OverridesJson = "lakehouse/catalog/classification-overrides.json",
    [string]$OutputRoot = "lakehouse",
    [switch]$SkipSchemaSnapshotRefresh
)

$ErrorActionPreference = "Stop"

function Import-DotEnvFile {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) { return }

    foreach ($line in Get-Content -LiteralPath $Path -ErrorAction Stop) {
        $trimmed = $line.Trim()
        if (-not $trimmed -or $trimmed.StartsWith('#')) { continue }

        $eqIndex = $trimmed.IndexOf('=')
        if ($eqIndex -lt 1) { continue }

        $name = $trimmed.Substring(0, $eqIndex).Trim()
        $value = $trimmed.Substring($eqIndex + 1).Trim()

        if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
            $value = $value.Substring(1, $value.Length - 2)
        }

        if ($name) {
            $existing = $null
            try { $existing = (Get-Item -Path ("Env:$name") -ErrorAction SilentlyContinue).Value } catch { }
            if ([string]::IsNullOrEmpty($value) -and -not [string]::IsNullOrEmpty($existing)) {
                continue
            }
            Set-Item -Path ("Env:$name") -Value $value
        }
    }
}

function Invoke-DbQuery {
    param(
        [Parameter(Mandatory = $true)][string]$ConnectionString,
        [Parameter(Mandatory = $true)][string]$Sql
    )

    $conn = $null
    try {
        $conn = [System.Data.SqlClient.SqlConnection]::new($ConnectionString)
        $conn.Open()

        $cmd = $conn.CreateCommand()
        $cmd.CommandTimeout = 120
        $cmd.CommandText = $Sql

        $reader = $cmd.ExecuteReader()
        try {
            $results = New-Object System.Collections.Generic.List[object]
            while ($reader.Read()) {
                $row = [ordered]@{}
                for ($i = 0; $i -lt $reader.FieldCount; $i++) {
                    $name = $reader.GetName($i)
                    $row[$name] = if ($reader.IsDBNull($i)) { $null } else { $reader.GetValue($i) }
                }
                $results.Add([pscustomobject]$row) | Out-Null
            }
            return @($results.ToArray())
        }
        finally {
            $reader.Dispose()
        }
    }
    finally {
        if ($conn) { $conn.Dispose() }
    }
}

function Get-Industry {
    param(
        [string]$QualifiedName,
        [string]$ObjectName,
        [hashtable]$Overrides,
        [string[]]$SupportedIndustries,
        [hashtable]$IndustryAliases
    )

    if ($Overrides.ContainsKey($QualifiedName)) {
        return $Overrides[$QualifiedName]
    }

    $normalizedName = $ObjectName.ToLowerInvariant()
    foreach ($industry in $SupportedIndustries) {
        if ($normalizedName.EndsWith("_$industry")) {
            return $industry
        }
    }

    foreach ($alias in $IndustryAliases.Keys) {
        if ($normalizedName.EndsWith("_$alias")) {
            return $IndustryAliases[$alias]
        }
    }

    return "shared"
}

function Format-SqlType {
    param([pscustomobject]$Column)

    $type = [string]$Column.data_type
    $maxLength = if ($null -ne $Column.max_length) { [int]$Column.max_length } else { 0 }
    $precision = if ($null -ne $Column.precision) { [int]$Column.precision } else { 0 }
    $scale = if ($null -ne $Column.scale) { [int]$Column.scale } else { 0 }

    switch ($type) {
        { $_ -in @('varchar', 'char', 'varbinary', 'binary') } {
            if ($maxLength -eq -1) { return "$type(max)" }
            return "$type($maxLength)"
        }
        { $_ -in @('nvarchar', 'nchar') } {
            if ($maxLength -eq -1) { return "$type(max)" }
            return "$type($($maxLength / 2))"
        }
        { $_ -in @('decimal', 'numeric') } { return "$type($precision,$scale)" }
        { $_ -in @('datetime2', 'datetimeoffset', 'time') } { return "$type($scale)" }
        default { return $type }
    }
}

function Build-TableDefinition {
    param(
        [pscustomobject]$Object,
        [object[]]$Columns,
        [object[]]$PrimaryKeys
    )

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("CREATE TABLE [$($Object.schema)].[$($Object.object_name)] (") | Out-Null

    $columnLines = New-Object System.Collections.Generic.List[string]
    foreach ($column in $Columns) {
        if ([bool]$column.is_computed -and $column.computed_definition) {
            $columnLines.Add("    [$($column.column_name)] AS $($column.computed_definition)") | Out-Null
            continue
        }

        $line = "    [$($column.column_name)] $(Format-SqlType -Column $column)"

        if ([bool]$column.is_identity) {
            $seed = if ($null -ne $column.identity_seed) { $column.identity_seed } else { 1 }
            $increment = if ($null -ne $column.identity_increment) { $column.identity_increment } else { 1 }
            $line += " IDENTITY($seed,$increment)"
        }

        if ($column.default_definition) {
            $line += " DEFAULT $($column.default_definition)"
        }

        $line += $(if ([bool]$column.is_nullable) { " NULL" } else { " NOT NULL" })
        $columnLines.Add($line) | Out-Null
    }

    if ($PrimaryKeys.Count -gt 0) {
        $pkName = $PrimaryKeys[0].pk_name
        $pkColumns = ($PrimaryKeys | Sort-Object key_ordinal | ForEach-Object { "[$($_.column_name)]" }) -join ", "
        $columnLines.Add("    CONSTRAINT [$pkName] PRIMARY KEY ($pkColumns)") | Out-Null
    }

    $lines.Add(($columnLines -join ",`r`n")) | Out-Null
    $lines.Add(");") | Out-Null
    return ($lines -join "`r`n")
}

function Ensure-IndexFile {
    param(
        [string]$Path,
        [string]$Schema,
        [string]$Industry,
        [object[]]$Objects
    )

    $lines = @(
        "<!-- generated: lakehouse-index -->",
        "# $Schema/$Industry",
        "",
        "| objeto | tipo | colunas | PKs | relacionamentos | artefato |",
        "|---|---|---:|---:|---:|---|"
    )

    if (-not $Objects -or $Objects.Count -eq 0) {
        $lines += "| _sem objetos_ | - | 0 | 0 | 0 | - |"
    }
    else {
        foreach ($item in ($Objects | Sort-Object object_name)) {
            $artifactFile = Split-Path -Leaf $item.artifact_path
            $lines += "| $($item.object_name) | $($item.object_type) | $($item.column_count) | $($item.pk_count) | $($item.relationship_count) | [$artifactFile](./$artifactFile) |"
        }
    }

    Set-Content -Path $Path -Value ($lines -join "`r`n") -Encoding UTF8
}

function Write-ObjectDocument {
    param([pscustomobject]$Object)

    $path = $Object.artifact_path
    $columnsLines = @(
        "| ordem | coluna | tipo | nullable | identity | computed | default |",
        "|---:|---|---|---|---|---|---|"
    )

    foreach ($column in ($Object.columns | Sort-Object ordinal_position)) {
        $defaultText = if ($column.default_definition) { [string]$column.default_definition } else { "-" }
        $columnsLines += "| $($column.ordinal_position) | $($column.column_name) | $($column.sql_type) | $($column.is_nullable) | $($column.is_identity) | $($column.is_computed) | $defaultText |"
    }

    $fkLines = @(
        "| fk | coluna | referencia |",
        "|---|---|---|"
    )

    if ($Object.relationships.Count -eq 0) {
        $fkLines += "| - | - | - |"
    }
    else {
        foreach ($fk in $Object.relationships) {
            $fkLines += "| $($fk.fk_name) | $($fk.parent_column) | $($fk.referenced_schema).$($fk.referenced_table).$($fk.referenced_column) |"
        }
    }

    $pkLine = if ($Object.pk_columns.Count -gt 0) { ($Object.pk_columns -join ", ") } else { "Nao identificado no banco" }
    $definitionHeading = if ($Object.definition_source -eq "sys.sql_modules") { "## DDL" } else { "## DDL Reconstruida" }

    $lines = @(
        "<!-- generated: lakehouse-object -->",
        "# $($Object.schema).$($Object.object_name)",
        "",
        ('- Tipo: `{0}`' -f $Object.object_type),
        ('- Industria: `{0}`' -f $Object.industry),
        ('- Origem: `{0}`' -f $Object.metadata_source),
        "- PKs: $pkLine",
        "- Relacionamentos: $($Object.relationship_count)",
        "",
        "## Colunas",
        ""
    ) + $columnsLines + @(
        "",
        "## Relacionamentos",
        ""
    ) + $fkLines + @(
        "",
        $definitionHeading,
        "",
        '```sql',
        $Object.definition_sql.TrimEnd(),
        '```'
    )

    if ($Object.object_type -eq "TABLE" -and $Object.definition_source -ne "sys.sql_modules") {
        $lines += ""
        $lines += "_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._"
    }

    Set-Content -Path $path -Value ($lines -join "`r`n") -Encoding UTF8
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')

if (-not $ServerInstance) { $ServerInstance = $env:MSSQL_SERVER }
if (-not $Database) { $Database = $env:MSSQL_DATABASE }
if (-not $Auth) { $Auth = $(if ($env:MSSQL_AUTH) { $env:MSSQL_AUTH } else { 'Windows' }) }
if (-not $Username) { $Username = $env:MSSQL_USERNAME }

if (-not $ServerInstance) { throw 'Defina MSSQL_SERVER no .env/.env.local ou passe -ServerInstance.' }
if (-not $Database) { throw 'Defina MSSQL_DATABASE no .env/.env.local ou passe -Database.' }

$ServerInstance = $ServerInstance.Trim()
if ($ServerInstance -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
    $ServerInstance = ($ServerInstance -split '\\', 2)[0]
}

$trust = $true
if ($env:MSSQL_TRUST_SERVER_CERTIFICATE) {
    $trust = @('1', 'true', 'yes', 'y', 'sim') -contains $env:MSSQL_TRUST_SERVER_CERTIFICATE.ToLowerInvariant()
}

$trustText = if ($trust) { 'True' } else { 'False' }
if ($Auth -eq 'Sql') {
    if (-not $Username) { throw 'Para Auth=Sql, defina MSSQL_USERNAME ou passe -Username.' }
    if (-not $env:MSSQL_PASSWORD) { throw 'Para Auth=Sql, defina MSSQL_PASSWORD no .env/.env.local.' }
    $connectionString = "Server=$ServerInstance;Database=$Database;User ID=$Username;Password=$($env:MSSQL_PASSWORD);Encrypt=True;TrustServerCertificate=$trustText;"
}
else {
    $connectionString = "Server=$ServerInstance;Database=$Database;Integrated Security=True;Encrypt=True;TrustServerCertificate=$trustText;"
}

if (-not $SkipSchemaSnapshotRefresh) {
    & powershell -ExecutionPolicy Bypass -File (Join-Path $repoRoot 'scripts/export-schema.ps1') -ServerInstance $ServerInstance -Database $Database -Auth $Auth -Username $Username
}

$columnsSql = @"
SELECT
  DB_NAME() AS database_name,
  s.name AS schema_name,
  o.name AS object_name,
  CASE o.type WHEN 'U' THEN 'TABLE' WHEN 'V' THEN 'VIEW' ELSE o.type_desc END AS object_type,
  c.column_id AS column_ordinal,
  c.name AS column_name,
  t.name AS data_type,
  c.max_length AS max_length,
  c.precision AS [precision],
  c.scale AS [scale],
  c.is_nullable AS is_nullable,
  c.is_identity AS is_identity,
  c.is_computed AS is_computed,
  cc.definition AS computed_definition,
  dc.definition AS default_definition,
  ic.seed_value AS identity_seed,
  ic.increment_value AS identity_increment
FROM sys.objects o
JOIN sys.schemas s ON s.schema_id = o.schema_id
JOIN sys.columns c ON c.object_id = o.object_id
JOIN sys.types t ON t.user_type_id = c.user_type_id
LEFT JOIN sys.default_constraints dc
  ON dc.parent_object_id = c.object_id
 AND dc.parent_column_id = c.column_id
LEFT JOIN sys.computed_columns cc
  ON cc.object_id = c.object_id
 AND cc.column_id = c.column_id
LEFT JOIN sys.identity_columns ic
  ON ic.object_id = c.object_id
 AND ic.column_id = c.column_id
WHERE o.type IN ('U','V')
  AND o.is_ms_shipped = 0
  AND s.name IN ('bronze','silver','gold')
ORDER BY s.name, o.name, c.column_id;
"@

$fksSql = @"
SELECT
  DB_NAME() AS database_name,
  fk.name AS fk_name,
  s_parent.name AS parent_schema,
  t_parent.name AS parent_table,
  c_parent.name AS parent_column,
  s_ref.name AS referenced_schema,
  t_ref.name AS referenced_table,
  c_ref.name AS referenced_column,
  fkc.constraint_column_id AS column_ordinal
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
JOIN sys.tables t_parent ON t_parent.object_id = fk.parent_object_id
JOIN sys.schemas s_parent ON s_parent.schema_id = t_parent.schema_id
JOIN sys.columns c_parent ON c_parent.object_id = t_parent.object_id AND c_parent.column_id = fkc.parent_column_id
JOIN sys.tables t_ref ON t_ref.object_id = fk.referenced_object_id
JOIN sys.schemas s_ref ON s_ref.schema_id = t_ref.schema_id
JOIN sys.columns c_ref ON c_ref.object_id = t_ref.object_id AND c_ref.column_id = fkc.referenced_column_id
WHERE fk.is_ms_shipped = 0
  AND (s_parent.name IN ('bronze','silver','gold') OR s_ref.name IN ('bronze','silver','gold'))
ORDER BY s_parent.name, t_parent.name, fk.name, fkc.constraint_column_id;
"@

$pkSql = @"
SELECT
  DB_NAME() AS database_name,
  s.name AS schema_name,
  t.name AS table_name,
  kc.name AS pk_name,
  ic.key_ordinal AS key_ordinal,
  c.name AS column_name
FROM sys.key_constraints kc
JOIN sys.tables t ON t.object_id = kc.parent_object_id
JOIN sys.schemas s ON s.schema_id = t.schema_id
JOIN sys.index_columns ic ON ic.object_id = kc.parent_object_id AND ic.index_id = kc.unique_index_id
JOIN sys.columns c ON c.object_id = kc.parent_object_id AND c.column_id = ic.column_id
WHERE kc.type = 'PK'
  AND s.name IN ('bronze','silver','gold')
ORDER BY s.name, t.name, kc.name, ic.key_ordinal;
"@

$definitionsSql = @"
SELECT
  DB_NAME() AS database_name,
  s.name AS schema_name,
  o.name AS object_name,
  CASE o.type WHEN 'U' THEN 'TABLE' WHEN 'V' THEN 'VIEW' ELSE o.type_desc END AS object_type,
  m.definition AS sql_definition
FROM sys.objects o
JOIN sys.schemas s ON s.schema_id = o.schema_id
LEFT JOIN sys.sql_modules m ON m.object_id = o.object_id
WHERE o.type IN ('U','V')
  AND o.is_ms_shipped = 0
  AND s.name IN ('bronze','silver','gold')
ORDER BY s.name, o.name;
"@

Write-Output "Consultando objetos medalhao em $Database..."
$columns = Invoke-DbQuery -ConnectionString $connectionString -Sql $columnsSql
$fks = Invoke-DbQuery -ConnectionString $connectionString -Sql $fksSql
$pks = Invoke-DbQuery -ConnectionString $connectionString -Sql $pkSql
$definitions = Invoke-DbQuery -ConnectionString $connectionString -Sql $definitionsSql

$config = Get-Content (Join-Path $repoRoot $OverridesJson) -Raw | ConvertFrom-Json
$supportedIndustries = @($config.supported_industries)
$industryAliases = @{}
if ($config.industry_aliases) {
    foreach ($property in $config.industry_aliases.PSObject.Properties) {
        $industryAliases[$property.Name.ToLowerInvariant()] = [string]$property.Value
    }
}
$overrides = @{}
foreach ($property in $config.overrides.PSObject.Properties) {
    $overrides[$property.Name] = [string]$property.Value
}

$targetSchemas = @("bronze", "silver", "gold")
$objects = @{}

foreach ($row in $columns) {
    $key = "$($row.schema_name).$($row.object_name)"
    if (-not $objects.ContainsKey($key)) {
        $industry = Get-Industry -QualifiedName $key -ObjectName $row.object_name -Overrides $overrides -SupportedIndustries $supportedIndustries -IndustryAliases $industryAliases
        $artifactPath = Join-Path $repoRoot (Join-Path $OutputRoot "$($row.schema_name)\$industry\$($row.object_name).md")
        $objects[$key] = [pscustomobject][ordered]@{
            schema = $row.schema_name
            object_name = $row.object_name
            object_type = $row.object_type
            industry = $industry
            metadata_source = "database:$Database"
            artifact_path = $artifactPath
            artifact_relative_path = (Resolve-Path -LiteralPath (Split-Path $artifactPath -Parent)).Path.Replace((Resolve-Path -LiteralPath $repoRoot).Path + "\", "") + "\" + (Split-Path $artifactPath -Leaf)
            columns = New-Object System.Collections.Generic.List[object]
            relationships = New-Object System.Collections.Generic.List[object]
            primary_keys = New-Object System.Collections.Generic.List[object]
        }
    }

    $sqlType = Format-SqlType -Column $row
    $objects[$key].columns.Add([pscustomobject][ordered]@{
        ordinal_position = [int]$row.column_ordinal
        column_name = $row.column_name
        data_type = $row.data_type
        sql_type = $sqlType
        is_nullable = [bool]$row.is_nullable
        is_identity = [bool]$row.is_identity
        is_computed = [bool]$row.is_computed
        computed_definition = $row.computed_definition
        default_definition = $row.default_definition
        max_length = $row.max_length
        precision = $row.precision
        scale = $row.scale
        identity_seed = $row.identity_seed
        identity_increment = $row.identity_increment
    }) | Out-Null
}

foreach ($row in $pks) {
    $key = "$($row.schema_name).$($row.table_name)"
    if ($objects.ContainsKey($key)) {
        $objects[$key].primary_keys.Add([pscustomobject][ordered]@{
            pk_name = $row.pk_name
            key_ordinal = [int]$row.key_ordinal
            column_name = $row.column_name
        }) | Out-Null
    }
}

foreach ($row in $fks) {
    $key = "$($row.parent_schema).$($row.parent_table)"
    if ($objects.ContainsKey($key)) {
        $objects[$key].relationships.Add([pscustomobject][ordered]@{
            fk_name = $row.fk_name
            parent_column = $row.parent_column
            referenced_schema = $row.referenced_schema
            referenced_table = $row.referenced_table
            referenced_column = $row.referenced_column
            column_ordinal = [int]$row.column_ordinal
        }) | Out-Null
    }
}

$definitionMap = @{}
foreach ($row in $definitions) {
    $definitionMap["$($row.schema_name).$($row.object_name)"] = $row
}

$objectList = foreach ($entry in ($objects.Values | Sort-Object schema, industry, object_name)) {
    $qualifiedName = "$($entry.schema).$($entry.object_name)"
    $definitionRow = $definitionMap[$qualifiedName]
    $sortedColumns = @($entry.columns.ToArray() | Sort-Object ordinal_position)
    $sortedPks = @($entry.primary_keys.ToArray() | Sort-Object key_ordinal)
    $sortedRelationships = @($entry.relationships.ToArray() | Sort-Object fk_name, column_ordinal)
    $definitionSql = $null
    $definitionSource = $null

    if ($definitionRow -and $definitionRow.sql_definition) {
        $definitionSql = [string]$definitionRow.sql_definition
        $definitionSource = "sys.sql_modules"
    }
    else {
        $definitionSql = Build-TableDefinition -Object $entry -Columns $sortedColumns -PrimaryKeys $sortedPks
        $definitionSource = "reconstructed"
    }

    [pscustomobject][ordered]@{
        schema = $entry.schema
        industry = $entry.industry
        object_name = $entry.object_name
        object_type = $entry.object_type
        metadata_source = $entry.metadata_source
        artifact_path = $entry.artifact_path
        artifact_relative_path = $entry.artifact_relative_path.Replace('\', '/')
        column_count = $sortedColumns.Count
        pk_count = $sortedPks.Count
        relationship_count = $sortedRelationships.Count
        has_definition = [bool]$definitionSql
        definition_source = $definitionSource
        pk_columns = @($sortedPks | ForEach-Object { $_.column_name })
        columns = $sortedColumns
        relationships = $sortedRelationships
        definition_sql = $definitionSql
    }
}

foreach ($item in $objectList) {
    Write-ObjectDocument -Object $item
}

$summary = foreach ($schema in $targetSchemas) {
    $schemaObjects = @($objectList | Where-Object { $_.schema -eq $schema })
    [pscustomobject][ordered]@{
        schema = $schema
        total_objects = $schemaObjects.Count
        industries = [pscustomobject][ordered]@{
            shared = (@($schemaObjects | Where-Object { $_.industry -eq "shared" })).Count
            chokdistribuidora = (@($schemaObjects | Where-Object { $_.industry -eq "chokdistribuidora" })).Count
            g4distribuidora = (@($schemaObjects | Where-Object { $_.industry -eq "g4distribuidora" })).Count
        }
    }
}

$manifest = [pscustomobject][ordered]@{
    generated_at = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssK")
    source = [pscustomobject][ordered]@{
        database = $Database
        server = $ServerInstance
        columns_csv = "docs/schema_columns.csv"
        fks_csv = "docs/schema_fks.csv"
        classification_overrides = $OverridesJson
    }
    supported_industries = @($supportedIndustries)
    summary = @($summary)
    objects = @($objectList | ForEach-Object {
        [pscustomobject][ordered]@{
            schema = $_.schema
            industry = $_.industry
            object_name = $_.object_name
            object_type = $_.object_type
            metadata_source = $_.metadata_source
            artifact_relative_path = $_.artifact_relative_path
            column_count = $_.column_count
            pk_count = $_.pk_count
            relationship_count = $_.relationship_count
            has_definition = $_.has_definition
            definition_source = $_.definition_source
            pk_columns = $_.pk_columns
            columns = $_.columns
            relationships = $_.relationships
        }
    })
}

$manifestJsonPath = Join-Path $repoRoot (Join-Path $OutputRoot "catalog\manifest.json")
$manifestMdPath = Join-Path $repoRoot (Join-Path $OutputRoot "catalog\manifest.md")
$manifest | ConvertTo-Json -Depth 8 | Set-Content -Path $manifestJsonPath -Encoding UTF8

$md = @(
    "# Manifesto Lakehouse",
    "",
    'Gerado a partir do banco real via `.env`, com snapshots auxiliares em `docs/schema_columns.csv` e `docs/schema_fks.csv`.',
    "",
    "## Resumo por schema",
    "",
    "| schema | objetos | shared | chokdistribuidora | g4distribuidora |",
    "|---|---:|---:|---:|---:|"
)

foreach ($item in $summary) {
    $md += "| $($item.schema) | $($item.total_objects) | $($item.industries.shared) | $($item.industries.chokdistribuidora) | $($item.industries.g4distribuidora) |"
}

$md += ""
$md += "## Observacoes"
$md += ""
$md += '- `shared` e o fallback para objetos sem sufixo de industria ou com override explicito.'
$md += '- `g4_distribuidora` e `g4distribuidora` sao tratados como a mesma industria canonica: `g4distribuidora`.'
$md += '- Cada objeto do medalhao recebeu um artefato `.md` em `lakehouse/<schema>/<industria>/`.'

Set-Content -Path $manifestMdPath -Value ($md -join "`r`n") -Encoding UTF8

foreach ($schema in $targetSchemas) {
    foreach ($industry in @("shared", "chokdistribuidora", "g4distribuidora")) {
        $path = Join-Path $repoRoot (Join-Path $OutputRoot "$schema\$industry\index.md")
        $items = @($objectList | Where-Object { $_.schema -eq $schema -and $_.industry -eq $industry })
        Ensure-IndexFile -Path $path -Schema $schema -Industry $industry -Objects $items
    }
}

Write-Output "Lakehouse materializado em $OutputRoot a partir do banco $Database."
