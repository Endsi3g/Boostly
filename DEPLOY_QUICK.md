# 🚀 Déploiement Rapide - BOOSTLY

## ⚡ Commandes Rapides

### Android

```bash
cd app

# 1. Préparer la signature (une seule fois)
cd android
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
# Créer key.properties avec les informations

# 2. Build
cd ..
flutter build appbundle --release

# 3. Fichier généré :
# build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
cd app

# 1. Installer les pods
cd ios && pod install && cd ..

# 2. Build
flutter build ios --release

# 3. Ouvrir Xcode pour archiver
open ios/Runner.xcworkspace
# Product > Archive > Distribute App
```

## 📋 Checklist Minimale

- [ ] Version incrémentée dans `pubspec.yaml`
- [ ] Firebase configuré (google-services.json / GoogleService-Info.plist)
- [ ] Clés API de production configurées
- [ ] Signature Android configurée (key.properties)
- [ ] Certificats iOS configurés
- [ ] Build réussi
- [ ] Tests sur appareil réel

## 🔗 Liens Utiles

- [Google Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com)
- [Firebase Console](https://console.firebase.google.com)
- [Stripe Dashboard](https://dashboard.stripe.com)

---

Voir `DEPLOY.md` pour le guide complet.

