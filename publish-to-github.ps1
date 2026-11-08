param (
    [Parameter(Mandatory=$true)]
    [string]$GitHubUser,

    [string]$AuthRepoName = "omnistock-auth-service",
    [string]$CoreRepoName = "omnistock-core-backend",
    [string]$FrontendRepoName = "omnistock-frontend",
    [string]$RootRepoName = "omnistock"
)

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   CONFIGURACION DE REPOSITORIOS GITHUB - OMNISTOCK" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Usuario de GitHub: $GitHubUser" -ForegroundColor Yellow
Write-Host ""

# 1. Auth Service
Write-Host "[1/4] Configurando remoto para auth-service..." -ForegroundColor Green
Push-Location -Path "auth-service"
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$AuthRepoName.git"
git branch -M main
Write-Host "Subiendo auth-service a GitHub..." -ForegroundColor Cyan
git push -u origin main
Pop-Location
Write-Host ""

# 2. Inventory Backend
Write-Host "[2/4] Configurando remoto para inventory-backend..." -ForegroundColor Green
Push-Location -Path "inventory-backend"
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$CoreRepoName.git"
git branch -M main
Write-Host "Subiendo inventory-backend a GitHub..." -ForegroundColor Cyan
git push -u origin main
Pop-Location
Write-Host ""

# 3. Inventory Frontend
Write-Host "[3/4] Configurando remoto para inventory-frontend..." -ForegroundColor Green
Push-Location -Path "inventory-frontend"
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$FrontendRepoName.git"
git branch -M main
Write-Host "Subiendo inventory-frontend a GitHub..." -ForegroundColor Cyan
git push -u origin main
Pop-Location
Write-Host ""

# 4. Root Orchestrator
Write-Host "[4/4] Configurando repositorio principal (orquestador)..." -ForegroundColor Green
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$RootRepoName.git"
git branch -M main
Write-Host "Subiendo orquestador a GitHub..." -ForegroundColor Cyan
git push -u origin main
Write-Host ""

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "REPOSITORIOS SUBIDOS EXITOSAMENTE" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
