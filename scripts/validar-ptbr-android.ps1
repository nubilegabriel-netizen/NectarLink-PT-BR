param(
    [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)
$ErrorActionPreference = "Stop"
$BaseFile = Join-Path $ProjectRoot "android\app\src\main\res\values\strings.xml"
$PtFile = Join-Path $ProjectRoot "android\app\src\main\res\values-pt-rBR\strings.xml"
if (!(Test-Path $BaseFile)) { throw "Arquivo base não encontrado: $BaseFile" }
if (!(Test-Path $PtFile)) { throw "Arquivo PT-BR não encontrado: $PtFile" }
[xml]$Base = Get-Content $BaseFile -Raw -Encoding UTF8
[xml]$Pt = Get-Content $PtFile -Raw -Encoding UTF8
$BaseMap = @{}
foreach ($node in $Base.resources.string) { $BaseMap[$node.name] = $node.InnerText }
$Seen = @{}
$Errors = New-Object System.Collections.Generic.List[string]
foreach ($node in $Pt.resources.string) {
    $key = $node.name
    if ($Seen.ContainsKey($key)) { $Errors.Add("Chave duplicada: $key"); continue }
    $Seen[$key] = $true
    if (!$BaseMap.ContainsKey($key)) { $Errors.Add("Chave não existe no catálogo base: $key"); continue }
    if ([string]::IsNullOrWhiteSpace($node.InnerText)) { $Errors.Add("Tradução vazia: $key") }
    $baseMarks = [regex]::Matches($BaseMap[$key], '%\d+\$[sd]|%\d+[sd]|%%') | ForEach-Object Value | Sort-Object
    $ptMarks = [regex]::Matches($node.InnerText, '%\d+\$[sd]|%\d+[sd]|%%') | ForEach-Object Value | Sort-Object
    if (($baseMarks -join '|') -ne ($ptMarks -join '|')) { $Errors.Add("Placeholders diferentes em $key (base: $($baseMarks -join ', '); PT: $($ptMarks -join ', '))") }
}
Write-Host "Strings traduzidas: $($Seen.Count) / $($BaseMap.Count)"
Write-Host ("Progresso: {0:N1}%" -f (100 * $Seen.Count / $BaseMap.Count))
if ($Errors.Count) {
    $Errors | ForEach-Object { Write-Error $_ }
    exit 1
}
Write-Host "Validação estrutural e de placeholders: OK" -ForegroundColor Green
if ($Seen.Count -lt $BaseMap.Count) {
    Write-Warning "Tradução parcial. Não adicione pt-rBR ao locales_config.xml nem ao AppLanguage.kt até traduzir e revisar todas as strings."
}
