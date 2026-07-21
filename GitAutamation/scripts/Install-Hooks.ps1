# ============================================
# GitAutomation Installer
# ============================================

. "$PSScriptRoot\..\core\Common.ps1"

Clear-Host

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      GitAutomation Installer v1.0"
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$GitRoot = Get-GitRoot

if (!$GitRoot) {
    Write-ErrorMessage "Este diretório não pertence a um repositório Git."
    Read-Host "Pressione ENTER para sair"
    exit 1
}

Write-Success "Repositório encontrado"
Write-Host "  $GitRoot"
Write-Host ""

if (!(Test-GitCliff)) {
    Write-ErrorMessage "git-cliff não foi encontrado."

    Write-Host ""
    Write-Host "Instale o git-cliff antes de continuar."
    Write-Host ""

    Read-Host "Pressione ENTER para sair"
    exit 1
}

Write-Success "git-cliff encontrado"

$AutomationFolder = Join-Path $GitRoot ".gitautomation"
$HookFolder = Join-Path $GitRoot ".git\hooks"

Ensure-Folder $AutomationFolder
Ensure-Folder $HookFolder

Write-Host ""
Write-Info "Instalando arquivos..."

Install-File `
    "$PSScriptRoot\..\core\Common.ps1" `
    "$AutomationFolder\Common.ps1"

Install-File `
    "$PSScriptRoot\..\core\Update-Changelog.ps1" `
    "$AutomationFolder\Update-Changelog.ps1"

Install-File `
    "$PSScriptRoot\..\hooks\post-commit" `
    "$HookFolder\post-commit"

if (!(Test-Path "$GitRoot\cliff.toml")) {

    Install-File `
        "$PSScriptRoot\..\templates\cliff.toml" `
        "$GitRoot\cliff.toml"

}

if (!(Test-Path "$GitRoot\CHANGELOG.md")) {

    Install-File `
        "$PSScriptRoot\..\templates\CHANGELOG.md" `
        "$GitRoot\CHANGELOG.md"

}

Write-Host ""
Write-Success "Instalação concluída!"
Write-Host ""
Read-Host "Pressione ENTER para finalizar"