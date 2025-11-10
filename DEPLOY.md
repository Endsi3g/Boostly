# 🚀 Guide de Déploiement Complet - BOOSTLY

## 📋 Prérequis

### 1. Vérifications Avant Déploiement

```bash
# Vérifier Flutter
flutter --version

# Vérifier les dépendances
cd app
flutter pub get

# Analyser le code
flutter analyze

# Tester l'application
flutter test
```

### 2. Configuration de Production

#### Firebase
- [ ] Créer un projet Firebase de production
- [ ] Télécharger `google-services.json` (Android)
- [ ] Télécharger `GoogleService-Info.plist` (iOS)
- [ ] Activer Analytics et Crashlytics
- [ ] Configurer les règles de sécurité Firestore

#### Stripe
- [ ] Passer en mode production
- [ ] Configurer les clés API de production
- [ ] Configurer les webhooks
- [ ] Tester les paiements réels

#### Ollama / IA
- [ ] Configurer Ollama (optionnel)
- [ ] Vérifier les clés API Gemini
- [ ] Configurer les quotas et alertes

## 🤖 Déploiement Android

### 1. Configuration de la Signature

#### Créer la clé de signature

```bash
cd app/android

# Générer une clé de signature
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Entrer les informations demandées :
# - Mot de passe du keystore
# - Mot de passe de la clé
# - Nom, organisation, etc.
```

#### Créer le fichier key.properties

Créez `app/android/key.properties` :

```properties
storePassword=<votre-mot-de-passe-keystore>
keyPassword=<votre-mot-de-passe-cle>
keyAlias=upload
storeFile=upload-keystore.jks
```

**⚠️ IMPORTANT** : Ajoutez `key.properties` et `*.jks` au `.gitignore` !

### 2. Configurer build.gradle.kts

Modifiez `app/android/app/build.gradle.kts` :

```kotlin
// Au début du fichier
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    // ... configuration existante ...
    
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    
    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
```

### 3. Configurer le Versioning

Modifiez `app/pubspec.yaml` :

```yaml
version: 1.0.0+1  # Format: VERSION+BUILD_NUMBER
```

### 4. Build de Production

```bash
cd app

# Build App Bundle (recommandé pour Google Play)
flutter build appbundle --release

# OU Build APK (pour test direct)
flutter build apk --release

# Les fichiers seront dans :
# - appbundle: build/app/outputs/bundle/release/app-release.aab
# - apk: build/app/outputs/flutter-apk/app-release.apk
```

### 5. Upload sur Google Play Console

1. Aller sur [Google Play Console](https://play.google.com/console)
2. Créer une nouvelle application
3. Remplir les informations :
   - Nom : BOOSTLY
   - Description
   - Captures d'écran
   - Icône (512x512)
   - Politique de confidentialité
4. Uploader le fichier `.aab`
5. Remplir le formulaire de contenu
6. Soumettre pour review

## 🍎 Déploiement iOS

### 1. Prérequis

- Mac avec Xcode installé
- Compte Apple Developer (99$/an)
- Certificats de développement et distribution

### 2. Configuration Xcode

```bash
cd app/ios

# Installer les pods
pod install

# Ouvrir dans Xcode
open Runner.xcworkspace
```

Dans Xcode :

1. **Configurer le Bundle Identifier**
   - Sélectionner le projet "Runner"
   - Onglet "Signing & Capabilities"
   - Bundle Identifier : `com.votredomaine.boostly`

2. **Configurer les Certificats**
   - Team : Sélectionner votre équipe Apple Developer
   - Signing Certificate : Automatique ou manuel
   - Provisioning Profile : Automatique

3. **Configurer les Capabilities**
   - Push Notifications
   - Background Modes
   - In-App Purchase (si nécessaire)

### 3. Configurer Info.plist

Vérifiez `app/ios/Runner/Info.plist` :

```xml
<key>CFBundleDisplayName</key>
<string>BOOSTLY</string>
<key>CFBundleVersion</key>
<string>1</string>
<key>CFBundleShortVersionString</key>
<string>1.0.0</string>
```

### 4. Build de Production

```bash
cd app

# Build iOS
flutter build ios --release

# OU via Xcode
# 1. Ouvrir Runner.xcworkspace
# 2. Product > Archive
# 3. Distribute App
```

### 5. Upload sur App Store Connect

1. Aller sur [App Store Connect](https://appstoreconnect.apple.com)
2. Créer une nouvelle application
3. Remplir les informations :
   - Nom : BOOSTLY
   - Description
   - Captures d'écran (toutes les tailles)
   - Icône (1024x1024)
   - Politique de confidentialité
4. Uploader via Xcode ou Transporter
5. Soumettre pour review

## 🔧 Configuration des Fichiers de Production

### 1. Firebase

#### Android
```bash
# Copier google-services.json dans :
app/android/app/google-services.json
```

#### iOS
```bash
# Copier GoogleService-Info.plist dans :
app/ios/Runner/GoogleService-Info.plist
```

### 2. Clés API

Mettez à jour les fichiers de configuration :

- `lib/config/firebase_config.dart` - Configuration Firebase
- `lib/config/ai_config.dart` - Clés API IA
- `lib/config/stripe_config.dart` - Clés Stripe production

**⚠️ NE JAMAIS COMMITTER LES CLÉS DE PRODUCTION !**

Utilisez des variables d'environnement ou un fichier `.env` :

```dart
// Exemple avec flutter_dotenv
static const String geminiApiKey = String.fromEnvironment(
  'GEMINI_API_KEY',
  defaultValue: 'YOUR_GEMINI_API_KEY',
);
```

## 📦 Scripts de Déploiement Automatisés

### Script Android (deploy_android.sh)

```bash
#!/bin/bash

echo "🚀 Déploiement Android - BOOSTLY"

# Vérifications
flutter doctor
flutter pub get

# Build
echo "📦 Build de l'application..."
flutter build appbundle --release

# Vérification
if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
    echo "✅ Build réussi !"
    echo "📁 Fichier: build/app/outputs/bundle/release/app-release.aab"
else
    echo "❌ Erreur lors du build"
    exit 1
fi
```

### Script iOS (deploy_ios.sh)

```bash
#!/bin/bash

echo "🍎 Déploiement iOS - BOOSTLY"

# Vérifications
flutter doctor
flutter pub get
cd ios && pod install && cd ..

# Build
echo "📦 Build de l'application..."
flutter build ios --release

echo "✅ Build réussi !"
echo "📁 Ouvrir Xcode pour archiver et distribuer"
```

## 🔄 CI/CD avec GitHub Actions

Créez `.github/workflows/deploy.yml` :

```yaml
name: Deploy BOOSTLY

on:
  push:
    tags:
      - 'v*'

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: cd app && flutter pub get
      - run: cd app && flutter build appbundle --release
      - uses: actions/upload-artifact@v3
        with:
          name: app-release
          path: app/build/app/outputs/bundle/release/app-release.aab

  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: cd app && flutter pub get
      - run: cd app/ios && pod install
      - run: cd app && flutter build ios --release
```

## 📊 Checklist de Déploiement

### Avant le Déploiement
- [ ] Code review effectué
- [ ] Tests passés (`flutter test`)
- [ ] Analyse du code (`flutter analyze`)
- [ ] Version incrémentée dans `pubspec.yaml`
- [ ] Changelog mis à jour
- [ ] Documentation à jour

### Configuration
- [ ] Firebase configuré (production)
- [ ] Clés API de production configurées
- [ ] Stripe en mode production
- [ ] Certificats iOS configurés
- [ ] Signature Android configurée

### Build
- [ ] Build Android réussi
- [ ] Build iOS réussi
- [ ] Tests sur appareils réels
- [ ] Tests de toutes les fonctionnalités

### Upload
- [ ] Google Play Console configuré
- [ ] App Store Connect configuré
- [ ] Métadonnées complètes
- [ ] Captures d'écran uploadées
- [ ] Politique de confidentialité

### Post-Déploiement
- [ ] Monitoring configuré (Firebase Analytics)
- [ ] Crashlytics activé
- [ ] Notifications push testées
- [ ] Paiements testés
- [ ] Plan de rollback préparé

## 🚨 Rollback

En cas de problème critique :

### Android
1. Google Play Console > App releases
2. Désactiver la version problématique
3. Réactiver la version précédente

### iOS
1. App Store Connect > App Store
2. Retirer la version de la vente
3. Soumettre une version de correction

## 📝 Notes Importantes

1. **Sécurité** : Ne jamais committer les clés de production
2. **Versioning** : Suivre le semantic versioning (MAJOR.MINOR.PATCH)
3. **Tests** : Toujours tester sur appareils réels avant déploiement
4. **Monitoring** : Surveiller les métriques après déploiement
5. **Backup** : Garder les versions précédentes disponibles

## 🎯 Prochaines Étapes

1. Configurer les certificats et clés
2. Tester le build localement
3. Configurer les stores (Google Play / App Store)
4. Uploader la première version
5. Surveiller les métriques et feedbacks

---

**Bon déploiement ! 🚀**

