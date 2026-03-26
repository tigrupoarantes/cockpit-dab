[CmdletBinding()]
param(
    [string]$ColumnsCsv = "docs/schema_columns.csv",
    [string]$FksCsv = "docs/schema_fks.csv",
    [string]$OverridesJson = "lakehouse/catalog/classification-overrides.json",
    [string]$OutputRoot = "lakehouse"
)

$ErrorActionPreference = "Stop"

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

function Ensure-IndexFile {
    param(
        [string]$Path,
        [string]$Schema,
        [string]$Industry,
        [object[]]$Objects
    )

    $lines = @(
        "# $Schema/$Industry",
        "",
        "| objeto | tipo | colunas | PKs | relacionamentos | origem |",
        "|---|---|---:|---:|---:|---|"
    )

    if (-not $Objects -or $Objects.Count -eq 0) {
        $lines += "| _sem objetos_ | - | 0 | 0 | 0 | inventario atual |"
    }
    else {
        foreach ($item in ($Objects | Sort-Object object_name)) {
            $lines += "| $($item.object_name) | $($item.object_type) | $($item.column_count) | $($item.pk_count) | $($item.relationship_count) | $($item.metadata_source) |"
        }
    }

    Set-Content -Path $Path -Value ($lines -join "`r`n") -Encoding UTF8
}

$columns = Import-Csv $ColumnsCsv
$fks = Import-Csv $FksCsv
$config = Get-Content $OverridesJson -Raw | ConvertFrom-Json

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
    if ($row.schema_name -notin $targetSchemas) {
        continue
    }

    $key = "$($row.schema_name).$($row.object_name)"
    if (-not $objects.ContainsKey($key)) {
        $industry = Get-Industry -QualifiedName $key -ObjectName $row.object_name -Overrides $overrides -SupportedIndustries $supportedIndustries -IndustryAliases $industryAliases
        $objects[$key] = [pscustomobject][ordered]@{
            schema = $row.schema_name
            object_name = $row.object_name
            object_type = $row.object_type
            industry = $industry
            metadata_source = "docs/schema_columns.csv"
            columns = New-Object System.Collections.Generic.List[object]
            pk_columns = New-Object System.Collections.Generic.List[string]
            relationships = New-Object System.Collections.Generic.List[object]
        }
    }

    $entry = $objects[$key]
    $entry.columns.Add([pscustomobject][ordered]@{
        ordinal_position = [int]$row.column_ordinal
        column_name = $row.column_name
        data_type = $row.data_type
        is_nullable = $row.is_nullable
        is_identity = $row.is_identity
        is_pk = $false
    }) | Out-Null
}

foreach ($fk in $fks) {
    if ($fk.parent_schema -notin $targetSchemas -and $fk.referenced_schema -notin $targetSchemas) {
        continue
    }

    $parentKey = "$($fk.parent_schema).$($fk.parent_table)"
    if ($objects.ContainsKey($parentKey)) {
        $objects[$parentKey].relationships.Add([pscustomobject][ordered]@{
            fk_name = $fk.fk_name
            parent_column = $fk.parent_column
            referenced_schema = $fk.referenced_schema
            referenced_table = $fk.referenced_table
            referenced_column = $fk.referenced_column
        }) | Out-Null
    }
}

$objectList = foreach ($entry in $objects.Values) {
    [pscustomobject][ordered]@{
        schema = $entry.schema
        industry = $entry.industry
        object_name = $entry.object_name
        object_type = $entry.object_type
        metadata_source = $entry.metadata_source
        column_count = $entry.columns.Count
        pk_count = $entry.pk_columns.Count
        relationship_count = $entry.relationships.Count
        pk_columns = @($entry.pk_columns.ToArray())
        columns = @($entry.columns.ToArray() | Sort-Object ordinal_position)
        relationships = @($entry.relationships.ToArray())
    }
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
        columns_csv = $ColumnsCsv
        fks_csv = $FksCsv
        classification_overrides = $OverridesJson
    }
    supported_industries = @($supportedIndustries)
    summary = @($summary)
    objects = @($objectList | Sort-Object schema, industry, object_name)
}

$manifestJsonPath = Join-Path $OutputRoot "catalog/manifest.json"
$manifestMdPath = Join-Path $OutputRoot "catalog/manifest.md"
$manifest | ConvertTo-Json -Depth 8 | Set-Content -Path $manifestJsonPath -Encoding UTF8

$md = @(
    "# Manifesto Lakehouse",
    "",
    "Gerado a partir de `docs/schema_columns.csv` e `docs/schema_fks.csv`.",
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
$md += "- `shared` e o fallback para objetos sem sufixo de industria ou com override explicito."
$md += "- `g4_distribuidora` e `g4distribuidora` sao tratados como a mesma industria canonica: `g4distribuidora`."

Set-Content -Path $manifestMdPath -Value ($md -join "`r`n") -Encoding UTF8

foreach ($schema in $targetSchemas) {
    foreach ($industry in @("shared", "chokdistribuidora", "g4distribuidora")) {
        $dir = Join-Path $OutputRoot "$schema/$industry"
        $path = Join-Path $dir "index.md"
        $items = @($objectList | Where-Object { $_.schema -eq $schema -and $_.industry -eq $industry })
        Ensure-IndexFile -Path $path -Schema $schema -Industry $industry -Objects $items
    }
}

Write-Output "Inventario gerado em $OutputRoot."
