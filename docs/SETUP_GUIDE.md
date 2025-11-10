# Guide de Configuration - BOOSTLY

## 📋 Prérequis

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / Xcode (pour les émulateurs)
- Compte Firebase
- Clé API Google Gemini
- Compte Stripe (mode sandbox pour MVP)

## 🚀 Installation

### 1. Cloner le projet

```bash
git clone <repository-url>
cd boostly
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Configuration Firebase

1. Créer un projet Firebase sur [Firebase Console](https://console.firebase.google.com)
2. Ajouter une application Android et iOS
3. Télécharger les fichiers de configuration :
   - `google-services.json` (Android) → `android/app/`
   - `GoogleService-Info.plist` (iOS) → `ios/Runner/`
4. Mettre à jour `lib/config/firebase_config.dart` avec vos clés API

### 4. Configuration Google Gemini API

1. Obtenir une clé API sur [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Mettre à jour `lib/config/ai_config.dart` :
   ```dart
   static const String geminiApiKey = 'VOTRE_CLE_API';
   ```

### 5. Configuration Stripe

1. Créer un compte Stripe sur [Stripe Dashboard](https://dashboard.stripe.com)
2. Obtenir la clé publique (mode test)
3. Mettre à jour `lib/config/stripe_config.dart` :
   ```dart
   static const String publishableKey = 'pk_test_...';
   ```

### 6. Configuration des polices

Les polices Poppins et Inter doivent être ajoutées dans `pubspec.yaml` et téléchargées depuis Google Fonts.

### 7. Lancer l'application

```bash
# Android
flutter run

# iOS
flutter run -d ios
```

## 🔧 Configuration des environnements

### Développement

Par défaut, l'application utilise les configurations de développement.

### Production

Avant le déploiement en production :
1. Mettre à jour les clés API avec les versions production
2. Configurer Stripe en mode production
3. Activer Firebase Analytics et Crashlytics
4. Configurer les webhooks Stripe

## 📱 Build pour production

### Android

```bash
flutter build apk --release
# ou
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## ⚠️ Notes importantes

- Ne jamais commiter les clés API dans le repository
- Utiliser des variables d'environnement pour les secrets
- Tester sur de vrais appareils avant le déploiement
- Respecter les limites du tier gratuit Firebase

