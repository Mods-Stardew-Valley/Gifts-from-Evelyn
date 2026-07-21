# ============================================
# GitAutomation - Common Functions
# ============================================

function Write-Info {
    param([string]$Message)

    Write-Host "[INFO ] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)

    Write-Host "[ OK  ] $Message" -ForegroundColor Green
}

function Write-WarningMessage {
    param([string]$Message)

    Write-Host "[WARN ] $Message" -ForegroundColor Yellow
}

function Write-ErrorMessage {
    param([string]$Message)

    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Test-GitRepository {

    $gitPath = Join-Path (Get-Location) ".git"

    return (Test-Path $gitPath)
}

function Get-GitRoot {

    try {
        git rev-parse --show-toplevel 2>$null
    }
    catch {
        return $null
    }

}

function Test-GitCliff {

    $cmd = Get-Command git-cliff -ErrorAction SilentlyContinue

    return $null -ne $cmd

}

function Test-FileExists {

    param(
        [string]$Path
    )

    return (Test-Path $Path)

}

function Copy-IfNeeded {

    param(
        [string]$Source,
        [string]$Destination
    )

    Copy-Item $Source $Destination -Force

    Write-Success "$(Split-Path $Destination -Leaf) instalado."

}
function New-FolderIfNeeded {

    param(
        [string]$Path
    )

    if (!(Test-Path $Path)) {
        New-Item -ItemType Directory -Force -Path $Path | Out-Null
        Write-Success "Pasta criada: $Path"
    }

}
function Install-File {

    param(
        [string]$Source,
        [string]$Destination
    )

    Copy-Item $Source $Destination -Force

    Write-Success ("Instalado: " + (Split-Path $Destination -Leaf))

}