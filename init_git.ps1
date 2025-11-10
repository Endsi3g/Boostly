# Script PowerShell pour initialiser Git et préparer le déploiement GitHub

Write-Host "🚀 Initialisation Git pour BOOSTLY" -ForegroundColor Green

# Vérifier si Git est déjà initialisé
if (Test-Path ".git") {
    Write-Host "✅ Git est déjà initialisé" -ForegroundColor Yellow
} else {
    Write-Host "📦 Initialisation de Git..." -ForegroundColor Cyan
    git init
    Write-Host "✅ Git initialisé" -ForegroundColor Green
}

# Vérifier les fichiers à ajouter
Write-Host "`n📋 Vérification des fichiers..." -ForegroundColor Cyan
$status = git status --short
if ($status) {
    Write-Host "Fichiers à committer:" -ForegroundColor Yellow
    Write-Host $status
} else {
    Write-Host "✅ Tous les fichiers sont déjà commités" -ForegroundColor Green
}

Write-Host "`n📝 Commandes suivantes:" -ForegroundColor Cyan
Write-Host "1. git add ." -ForegroundColor White
Write-Host "2. git commit -m 'feat: Initial commit - BOOSTLY MVP v1.0.0'" -ForegroundColor White
Write-Host "3. git remote add origin https://github.com/VOTRE_USERNAME/boostly-app.git" -ForegroundColor White
Write-Host "4. git branch -M main" -ForegroundColor White
Write-Host "5. git push -u origin main" -ForegroundColor White

Write-Host "`n✅ Prêt pour GitHub !" -ForegroundColor Green

