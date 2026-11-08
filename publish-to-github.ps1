# ====================================================================
# OmniStock Enterprise WMS - Script de Vinculación a GitHub
# ====================================================================
# Este script te ayuda a vincular los 4 repositorios independientes
# a tu cuenta de GitHub de forma automática y configurar los submódulos.
# ====================================================================

param (
    [Parameter(Mandatory=$true, HelpMessage="Tu nombre de usuario u organización de GitHub")]
    [string]$GitHubUser,

    [Parameter(Mandatory=$false)]
    [string]$AuthRepoName = "omnistock-auth-service",

    [Parameter(Mandatory=$false)]
    [string]$CoreRepoName = "omnistock-core-backend",

    [Parameter(Mandatory=$false)]
    [string]$FrontendRepoName = "omnistock-frontend",

    [Parameter(Mandatory=$false)]
    [string]$RootRepoName = "omnistock"
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   CONFIGURACIÓN DE REPOSITORIOS GITHUB - OMNISTOCK" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Usuario GitHub: $GitHubUser" -ForegroundColor Yellow

# 1. Auth Service
Write-Host "`n[1/4] Subiendo auth-service..." -ForegroundColor Green
Push-Location auth-service
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$AuthRepoName.git"
git branch -M main
Write-Host "Ejecuta: git push -u origin main (en auth-service)" -ForegroundColor Gray
Pop-Location

# 2. Inventory Backend
Write-Host "`n[2/4] Subiendo inventory-backend..." -ForegroundColor Green
Push-Location inventory-backend
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$CoreRepoName.git"
git branch -M main
Write-Host "Ejecuta: git push -u origin main (en inventory-backend)" -ForegroundColor Gray
Pop-Location

# 3. Inventory Frontend
Write-Host "`n[3/4] Subiendo inventory-frontend..." -ForegroundColor Green
Push-Location inventory-frontend
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$FrontendRepoName.git"
git branch -M main
Write-Host "Ejecuta: git push -u origin main (en inventory-frontend)" -ForegroundColor Gray
Pop-Location

# 4. Root Orchestrator
Write-Host "`n[4/4] Configurando repositorio principal (orquestador)..." -ForegroundColor Green
git remote remove origin 2>$null
git remote add origin "https://github.com/$GitHubUser/$RootRepoName.git"
git branch -M main
Write-Host "Ejecuta: git push -u origin main (en la raíz)" -ForegroundColor Gray

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "PASO FINAL: Vincular los submódulos en el principal:" -ForegroundColor Yellow
Write-Host "git submodule add https://github.com/$GitHubUser/$AuthRepoName.git auth-service" -ForegroundColor White
Write-Host "git submodule add https://github.com/$GitHubUser/$CoreRepoName.git inventory-backend" -ForegroundColor White
Write-Host "git submodule add https://github.com/$GitHubUser/$FrontendRepoName.git inventory-frontend" -ForegroundColor White
Write-Host "git commit -m 'chore: link submodules'" -ForegroundColor White
Write-Host "git push origin main" -ForegroundColor White
Write-Host "==========================================================" -ForegroundColor Cyan
