# 📱 Étapes de Déploiement - BOOSTLY

## 🎯 Vue d'Ensemble

Ce guide vous accompagne étape par étape pour déployer BOOSTLY sur Google Play Store et App Store.

---

## 🤖 Android - Google Play Store

### Étape 1 : Préparer la Signature

```bash
cd app/android

# Générer la clé de signature
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**Informations à fournir :**
- Mot de passe du keystore (à conserver précieusement !)
- Mot de passe de la clé
- Nom, organisation, ville, pays

### Étape 2 : Créer key.properties

Créez `app/android/key.properties` :

```properties
storePassword=votre_mot_de_passe_keystore
keyPassword=votre_mot_de_passe_cle
keyAlias=upload
storeFile=upload-keystore.jks
```

**⚠️ IMPORTANT** : Ce fichier est déjà dans `.gitignore` - ne le committez jamais !

### Étape 3 : Configurer Firebase

1. Téléchargez `google-services.json` depuis Firebase Console
2. Placez-le dans : `app/android/app/google-services.json`

### Étape 4 : Mettre à jour la Version

Modifiez `app/pubspec.yaml` :

```yaml
version: 1.0.0+1  # Format: VERSION+BUILD_NUMBER
```

### Étape 5 : Build de Production

```bash
cd app

# Installer les dépendances
flutter pub get

# Build App Bundle (recommandé)
flutter build appbundle --release

# Le fichier sera dans :
# build/app/outputs/bundle/release/app-release.aab
```

### Étape 6 : Upload sur Google Play Console

1. **Créer l'application**
   - Aller sur [Google Play Console](https://play.google.com/console)
   - Cliquer sur "Créer une application"
   - Remplir le nom : **BOOSTLY**

2. **Remplir les informations**
   - Description courte (80 caractères max)
   - Description complète
   - Captures d'écran (minimum 2)
   - Icône haute résolution (512x512)
   - Graphique de fonctionnalité (1024x500)
   - Politique de confidentialité (URL)

3. **Uploader le fichier .aab**
   - Aller dans "Production" > "Créer une version"
   - Uploader `app-release.aab`
   - Remplir les notes de version

4. **Soumettre pour review**
   - Vérifier toutes les sections
   - Cliquer sur "Soumettre pour examen"

---

## 🍎 iOS - App Store

### Étape 1 : Prérequis

- Mac avec Xcode installé
- Compte Apple Developer (99$/an)
- Certificats configurés

### Étape 2 : Configurer Firebase

1. Téléchargez `GoogleService-Info.plist` depuis Firebase Console
2. Placez-le dans : `app/ios/Runner/GoogleService-Info.plist`
3. Ajoutez-le au projet Xcode

### Étape 3 : Installer les Pods

```bash
cd app/ios
pod install
cd ../..
```

### Étape 4 : Ouvrir dans Xcode

```bash
cd app
open ios/Runner.xcworkspace
```

### Étape 5 : Configurer le Bundle Identifier

Dans Xcode :
1. Sélectionner le projet "Runner"
2. Onglet "Signing & Capabilities"
3. Bundle Identifier : `com.votredomaine.boostly` (remplacer par votre domaine)
4. Team : Sélectionner votre équipe Apple Developer

### Étape 6 : Configurer les Capabilities

Activer :
- Push Notifications
- Background Modes
- In-App Purchase (si nécessaire)

### Étape 7 : Mettre à jour la Version

Dans Xcode :
- Version : `1.0.0`
- Build : `1`

### Étape 8 : Build et Archive

1. Dans Xcode : **Product > Scheme > Runner**
2. **Product > Destination > Any iOS Device**
3. **Product > Archive**
4. Attendre la fin de l'archive

### Étape 9 : Distribuer l'Application

1. Dans la fenêtre Organizer
2. Sélectionner l'archive
3. Cliquer sur "Distribute App"
4. Choisir "App Store Connect"
5. Suivre les étapes

### Étape 10 : Configurer App Store Connect

1. Aller sur [App Store Connect](https://appstoreconnect.apple.com)
2. Créer une nouvelle application
3. Remplir les informations :
   - Nom : **BOOSTLY**
   - Bundle ID : Celui configuré dans Xcode
   - SKU : Identifiant unique
4. Remplir les métadonnées :
   - Description
   - Captures d'écran (toutes les tailles)
   - Icône (1024x1024)
   - Politique de confidentialité
5. Soumettre pour review

---

## 🔧 Configuration des Services

### Firebase

1. **Créer un projet Firebase**
   - [Firebase Console](https://console.firebase.google.com)
   - Créer un nouveau projet
   - Activer Analytics, Crashlytics, Firestore

2. **Configurer Android**
   - Ajouter une application Android
   - Package name : `com.votredomaine.boostly`
   - Télécharger `google-services.json`

3. **Configurer iOS**
   - Ajouter une application iOS
   - Bundle ID : `com.votredomaine.boostly`
   - Télécharger `GoogleService-Info.plist`

### Stripe

1. **Passer en mode production**
   - [Stripe Dashboard](https://dashboard.stripe.com)
   - Activer le mode Live
   - Récupérer les clés de production

2. **Mettre à jour la configuration**
   - Modifier `lib/config/stripe_config.dart`
   - Utiliser les clés de production

### Ollama / IA

1. **Configurer Ollama** (optionnel)
   - Installer Ollama sur un serveur
   - Configurer l'URL dans `lib/config/ai_config.dart`

2. **Configurer Gemini** (fallback)
   - Obtenir une clé API
   - Configurer dans `lib/config/ai_config.dart`

---

## ✅ Checklist Finale

### Avant le Déploiement
- [ ] Code review effectué
- [ ] Tests passés
- [ ] Version incrémentée
- [ ] Changelog mis à jour
- [ ] Documentation à jour

### Configuration
- [ ] Firebase configuré (production)
- [ ] Clés API de production
- [ ] Stripe en mode production
- [ ] Signature Android configurée
- [ ] Certificats iOS configurés

### Build
- [ ] Build Android réussi
- [ ] Build iOS réussi
- [ ] Tests sur appareils réels
- [ ] Toutes les fonctionnalités testées

### Upload
- [ ] Google Play Console configuré
- [ ] App Store Connect configuré
- [ ] Métadonnées complètes
- [ ] Captures d'écran uploadées
- [ ] Politique de confidentialité

### Post-Déploiement
- [ ] Monitoring configuré
- [ ] Crashlytics activé
- [ ] Analytics vérifiés
- [ ] Notifications testées
- [ ] Paiements testés

---

## 🚨 En Cas de Problème

### Android
- Vérifier la signature dans `key.properties`
- Vérifier `google-services.json`
- Vérifier les permissions dans `AndroidManifest.xml`

### iOS
- Vérifier les certificats dans Xcode
- Vérifier `GoogleService-Info.plist`
- Vérifier les capabilities

### Build Errors
- `flutter clean`
- `flutter pub get`
- `cd ios && pod install && cd ..`
- Relancer le build

---

## 📞 Support

Pour toute question :
- Documentation : `docs/DEPLOYMENT.md`
- Guide complet : `DEPLOY.md`
- Guide rapide : `DEPLOY_QUICK.md`

---

**Bon déploiement ! 🚀**

