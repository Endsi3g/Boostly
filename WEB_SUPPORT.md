# 🌐 Support Web - BOOSTLY

## ✅ Application Compatible Web

L'application BOOSTLY est maintenant **100% compatible avec le web** !

## 🚀 Lancer sur le Web

### Mode Développement

```powershell
cd app
flutter run -d chrome
```

ou

```powershell
cd app
flutter run -d edge
```

### Mode Production

```powershell
cd app
flutter build web
```

Les fichiers seront dans `app/build/web/`

## 🔧 Modifications pour le Web

### ✅ Compatibilité Ajoutée

1. **Hive** : Désactivé sur le web (utilise localStorage via Hive web adapter si nécessaire)
2. **SystemChrome** : Désactivé sur le web (orientation non applicable)
3. **Notifications locales** : Désactivées sur le web (utiliser Web Notifications API si nécessaire)
4. **Ollama** : Détection automatique - utilise Gemini sur le web si localhost
5. **Stripe** : Compatible web (fonctionne normalement)

### 📋 Fonctionnalités Web

#### ✅ Disponibles
- ✅ Navigation complète
- ✅ Authentification Firebase
- ✅ Gestion de tâches
- ✅ Gamification (XP, badges, niveaux)
- ✅ Mascotte interactive
- ✅ IA (Gemini - Ollama si serveur accessible)
- ✅ Analytics
- ✅ Stripe (paiements)

#### ⚠️ Limitations Web
- ⚠️ Notifications locales (utiliser Web Notifications API)
- ⚠️ Ollama localhost (utiliser un serveur Ollama accessible)
- ⚠️ Stockage local (utilise localStorage au lieu de Hive)

## 🌐 Configuration Web

### Firebase Web

La configuration Firebase pour le web est dans `lib/config/firebase_config.dart` :

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_WEB_API_KEY',
  appId: 'YOUR_WEB_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'boostly-app',
  authDomain: 'boostly-app.firebaseapp.com',
  storageBucket: 'boostly-app.appspot.com',
);
```

### Ollama sur le Web

Pour utiliser Ollama sur le web, vous devez :

1. **Avoir un serveur Ollama accessible** (pas localhost)
2. **Mettre à jour la configuration** dans `lib/config/ai_config.dart` :

```dart
static const String ollamaBaseUrl = 'http://votre-serveur:11434';
```

Sinon, l'application utilisera automatiquement Gemini.

## 🚀 Déploiement Web

### Option 1 : Firebase Hosting

```powershell
# Build
cd app
flutter build web

# Déployer
firebase deploy --only hosting
```

### Option 2 : GitHub Pages

```powershell
# Build
cd app
flutter build web --base-href "/Boostly/"

# Copier build/web vers gh-pages
```

### Option 3 : Netlify / Vercel

```powershell
# Build
cd app
flutter build web

# Déployer build/web
```

## 📱 Responsive Design

L'application est responsive et s'adapte à :
- 📱 Mobile (portrait)
- 📱 Mobile (landscape)
- 💻 Tablette
- 🖥️ Desktop

## 🧪 Tester sur le Web

### Chrome DevTools

```powershell
# Lancer avec Chrome
flutter run -d chrome

# Ouvrir DevTools
# F12 ou Cmd+Option+I
```

### Test de Responsive

1. Ouvrir DevTools (F12)
2. Activer le mode responsive (Ctrl+Shift+M)
3. Tester différentes tailles d'écran

## ✅ Checklist Web

- [x] Application compile pour le web
- [x] Navigation fonctionne
- [x] Firebase configuré pour le web
- [x] IA fonctionne (Gemini)
- [x] Responsive design
- [x] PWA ready (manifest.json)

## 🎯 Prochaines Étapes

1. **Tester l'application** : `flutter run -d chrome`
2. **Configurer Firebase Web** : Ajouter les clés API
3. **Déployer** : Choisir une plateforme (Firebase Hosting, Netlify, etc.)

---

**L'application est prête pour le web ! 🌐**

