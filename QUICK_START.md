# Guide de Démarrage Rapide - BOOSTLY

## ⚡ Installation en 5 minutes

### 1. Prérequis
```bash
# Vérifier Flutter
flutter --version

# Vérifier Dart
dart --version
```

### 2. Installation des dépendances
```bash
cd boostly
flutter pub get
```

### 3. Configuration minimale

#### Firebase
1. Créer un projet sur [Firebase Console](https://console.firebase.google.com)
2. Ajouter les fichiers de configuration :
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
3. Mettre à jour `lib/config/firebase_config.dart` avec vos clés

#### Google Gemini
1. Obtenir une clé sur [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Mettre à jour `lib/config/ai_config.dart` :
   ```dart
   static const String geminiApiKey = 'VOTRE_CLE';
   ```

#### Stripe (Optionnel pour MVP)
1. Créer un compte sur [Stripe Dashboard](https://dashboard.stripe.com)
2. Mettre à jour `lib/config/stripe_config.dart` avec la clé publique

### 4. Lancer l'application
```bash
# Android
flutter run

# iOS
flutter run -d ios
```

## 🎯 Fonctionnalités Disponibles

✅ Authentification (Email, Google, Apple)  
✅ Gestion des tâches (CRUD complet)  
✅ Système de gamification (XP, niveaux, badges)  
✅ Mascotte interactive  
✅ Bibliothèque de ressources  
✅ Dashboard analytics  
✅ Monétisation Freemium  

## 📚 Documentation Complète

- [Guide de Setup](docs/SETUP_GUIDE.md) - Configuration détaillée
- [Documentation API](docs/API_DOCUMENTATION.md) - Référence API
- [Guide de Déploiement](docs/DEPLOYMENT.md) - Déploiement production
- [Architecture](ARCHITECTURE.md) - Structure du projet

## ⚠️ Important

- Ne jamais commiter les clés API
- Utiliser le mode sandbox Stripe pour le MVP
- Respecter les limites du tier gratuit Firebase
- Tester sur appareils réels avant déploiement

## 🆘 Support

Pour toute question, consulter la documentation ou créer une issue sur le repository.

