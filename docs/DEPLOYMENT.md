# Guide de Déploiement - BOOSTLY

## 📦 Préparation du déploiement

### 1. Vérifications pré-déploiement

- [ ] Toutes les clés API sont configurées (production)
- [ ] Les tests passent (`flutter test`)
- [ ] L'application fonctionne sur appareils réels
- [ ] Les analytics sont activés
- [ ] Les crashlytics sont configurés
- [ ] Les notifications push sont testées
- [ ] Les paiements Stripe sont testés

### 2. Configuration de production

#### Firebase
1. Créer un projet Firebase de production
2. Activer Analytics et Crashlytics
3. Configurer les règles de sécurité Firestore
4. Configurer les quotas et alertes

#### Stripe
1. Passer en mode production
2. Configurer les webhooks
3. Tester les paiements réels
4. Configurer les remboursements

#### Google Gemini
1. Vérifier les quotas
2. Configurer les alertes de dépassement
3. Implémenter le fallback si nécessaire

## 🚀 Déploiement Android

### 1. Préparer la signature

```bash
# Générer une clé de signature
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Configurer key.properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=<path-to-keystore>
```

### 2. Configurer android/app/build.gradle

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
```

### 3. Build et upload

```bash
flutter build appbundle --release
# Uploader sur Google Play Console
```

## 🍎 Déploiement iOS

### 1. Configuration Xcode

1. Ouvrir `ios/Runner.xcworkspace`
2. Configurer le Bundle Identifier
3. Configurer les certificats de signature
4. Configurer les capabilities (Push Notifications, etc.)

### 2. Build et upload

```bash
flutter build ios --release
# Uploader via Xcode ou Transporter
```

### 3. App Store Connect

1. Créer l'application sur App Store Connect
2. Remplir les métadonnées
3. Soumettre pour review

## 📊 Monitoring post-déploiement

### Firebase Analytics
- Surveiller les événements utilisateur
- Analyser les conversions
- Identifier les points de friction

### Crashlytics
- Surveiller les crashes
- Analyser les stack traces
- Prioriser les corrections

### Performance
- Surveiller les temps de chargement
- Analyser l'utilisation mémoire
- Optimiser les requêtes Firestore

## 🔄 Mises à jour

### Versioning
- Suivre le semantic versioning (MAJOR.MINOR.PATCH)
- Documenter les changements dans CHANGELOG.md
- Tester les mises à jour avant déploiement

### Rollback
- Garder les versions précédentes disponibles
- Avoir un plan de rollback en cas de problème
- Tester le processus de rollback

## 📝 Checklist de déploiement

- [ ] Code review effectué
- [ ] Tests passés
- [ ] Documentation à jour
- [ ] Changelog mis à jour
- [ ] Version incrémentée
- [ ] Build de production créé
- [ ] Tests sur appareils réels
- [ ] Monitoring configuré
- [ ] Plan de rollback préparé
- [ ] Équipe notifiée

