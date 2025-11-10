# Script PowerShell pour tester l'application BOOSTLY

Write-Host "🧪 Test de l'application BOOSTLY" -ForegroundColor Cyan
Write-Host ""

# Aller dans le dossier app
Set-Location -Path "app"

# 1. Vérifier Flutter
Write-Host "1️⃣ Vérification de Flutter..." -ForegroundColor Yellow
flutter --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Flutter n'est pas installé ou pas dans le PATH" -ForegroundColor Red
    exit 1
}

# 2. Installer les dépendances
Write-Host "`n2️⃣ Installation des dépendances..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur lors de l'installation des dépendances" -ForegroundColor Red
    exit 1
}

# 3. Analyser le code
Write-Host "`n3️⃣ Analyse du code..." -ForegroundColor Yellow
flutter analyze
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️ Des warnings ont été détectés (non-bloquants)" -ForegroundColor Yellow
}

# 4. Exécuter les tests
Write-Host "`n4️⃣ Exécution des tests..." -ForegroundColor Yellow
flutter test
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Certains tests ont échoué" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✅ Tous les tests passent !" -ForegroundColor Green
}

# 5. Vérifier les appareils disponibles
Write-Host "`n5️⃣ Appareils disponibles..." -ForegroundColor Yellow
flutter devices

Write-Host "`n✅ Application prête pour les tests !" -ForegroundColor Green
Write-Host "`nPour lancer l'application :" -ForegroundColor Cyan
Write-Host "  flutter run" -ForegroundColor White
Write-Host "`nPour lancer sur un appareil spécifique :" -ForegroundColor Cyan
Write-Host "  flutter run -d <device-id>" -ForegroundColor White

