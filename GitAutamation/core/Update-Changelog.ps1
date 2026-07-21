# ============================================
# GitAutomation - Update CHANGELOG
# ============================================

. "$PSScriptRoot\Common.ps1"

Write-Info "Atualizando CHANGELOG..."

$GitRoot = Get-GitRoot

if (!$GitRoot) {
    Write-ErrorMessage "Repositório Git não encontrado."
    exit 1
}

Set-Location $GitRoot

git cliff -o CHANGELOG.md

Write-Success "CHANGELOG.md atualizado."