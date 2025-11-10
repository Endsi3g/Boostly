# 🚀 Déploiement Web - BOOSTLY

## ✅ Build Web Créé

L'application a été compilée pour le web dans `app/build/web/`

## 🌐 Options de Déploiement

### Option 1 : Firebase Hosting (Recommandé)

#### Prérequis
```powershell
# Installer Firebase CLI
npm install -g firebase-tools

# Se connecter
firebase login

# Initialiser (si pas déjà fait)
firebase init hosting
```

#### Déployer
```powershell
cd "C:\Users\le3li\Documents\EV Appv4\boostly"
firebase deploy --only hosting
```

**URL** : `https://boostly-app.web.app` ou `https://boostly-app.firebaseapp.com`

### Option 2 : Netlify

#### Via Netlify CLI
```powershell
# Installer Netlify CLI
npm install -g netlify-cli

# Déployer
cd app
netlify deploy --prod --dir=build/web
```

#### Via Netlify Drag & Drop
1. Aller sur https://app.netlify.com/drop
2. Glisser le dossier `app/build/web`
3. L'application sera déployée automatiquement

### Option 3 : Vercel

#### Via Vercel CLI
```powershell
# Installer Vercel CLI
npm install -g vercel

# Déployer
cd app
vercel --prod build/web
```

#### Via Vercel Dashboard
1. Aller sur https://vercel.com
2. Importer le projet
3. Configurer : `Build Command: flutter build web`, `Output Directory: build/web`

### Option 4 : GitHub Pages

```powershell
cd app
flutter build web --base-href "/Boostly/"

# Copier build/web vers gh-pages branch
# Voir: https://github.com/Endsi3g/Boostly/settings/pages
```

## 📋 Configuration Actuelle

- **Build** : `app/build/web/`
- **Firebase config** : `firebase.json` créé
- **Firebase project** : `boostly-app` (à configurer)

## 🔧 Configuration Firebase

### 1. Créer un Projet Firebase

1. Aller sur https://console.firebase.google.com
2. Créer un nouveau projet : `boostly-app`
3. Activer Firebase Hosting

### 2. Initialiser Firebase Hosting

```powershell
cd "C:\Users\le3li\Documents\EV Appv4\boostly"
firebase init hosting
```

Sélectionner :
- Public directory : `app/build/web`
- Single-page app : `Yes`
- GitHub deploys : `No` (ou `Yes` si vous voulez)

### 3. Déployer

```powershell
firebase deploy --only hosting
```

## 🌐 URLs de Déploiement

Après déploiement, l'application sera accessible sur :
- Firebase : `https://boostly-app.web.app`
- Netlify : `https://votre-app.netlify.app`
- Vercel : `https://votre-app.vercel.app`

## ✅ Checklist

- [x] Build web créé
- [x] `firebase.json` configuré
- [x] `.firebaserc` créé
- [ ] Firebase CLI installé
- [ ] Firebase projet créé
- [ ] Déploiement effectué

## 🎯 Prochaines Étapes

1. **Installer Firebase CLI** (si pas déjà fait)
2. **Se connecter** : `firebase login`
3. **Initialiser** : `firebase init hosting`
4. **Déployer** : `firebase deploy --only hosting`

---

**L'application est prête pour le déploiement ! 🚀**

