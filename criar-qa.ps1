# Pega conteúdo da área de transferência
$content = Get-Clipboard

# Tenta extrair número do ticket (ex: #370697)
if ($content -match "#(\d+)") {
    $id = $matches[1]
} else {
    $id = Get-Date -Format "yyyyMMddHHmmss"
}

# Nome do arquivo
$fileName = "$id.md"

# Cria arquivo
New-Item $fileName -ItemType File -Force

# Conteúdo inicial
$initialContent = @"
QA

$content
"@

# Escreve no arquivo
Set-Content $fileName $initialContent

# Abre no VSCode
code $fileName