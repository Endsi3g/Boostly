# 🚀 Déploiement sur GitHub - BOOSTLY

## 📋 Étapes pour Déployer sur GitHub

### 1. Créer un Repository GitHub

1. Aller sur [GitHub](https://github.com)
2. Cliquer sur "New repository"
3. Nom : `boostly-app` (ou votre choix)
4. Description : "Application mobile de gestion de tâches gamifiée avec mascotte interactive et assistant IA"
5. Visibilité : Private (recommandé) ou Public
6. **NE PAS** initialiser avec README, .gitignore, ou licence (déjà présents)
7. Cliquer sur "Create repository"

### 2. Initialiser Git Localement

```bash
cd "C:\Users\le3li\Documents\EV Appv4\boostly"

# Initialiser Git
git init

# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit: BOOSTLY MVP v1.0.0"

# Ajouter le remote GitHub
git remote add origin https://github.com/VOTRE_USERNAME/boostly-app.git

# Pousser vers GitHub
git branch -M main
git push -u origin main
```

### 3. Structure du Repository

```
boostly/
├── .github/
│   └── workflows/
│       ├── test.yml          # Tests automatiques
│       └── release.yml       # Build de release
├── app/                      # Application Flutter principale
│   ├── lib/
│   ├── android/
│   ├── ios/
│   └── pubspec.yaml
├── lib/                      # Code source partagé
├── docs/                     # Documentation
├── assets/                   # Assets (images, fonts, etc.)
├── .gitignore               # Fichiers à ignorer
├── README.md                # Documentation principale
└── LICENSE                  # Licence (à ajouter)
```

### 4. Fichiers à NE JAMAIS Committer

Le `.gitignore` protège déjà ces fichiers :

- `key.properties` (clés de signature Android)
- `*.jks` / `*.keystore` (fichiers de signature)
- `google-services.json` (Firebase Android)
- `GoogleService-Info.plist` (Firebase iOS)
- Clés API de production
- Fichiers de build
- Dossiers `.dart_tool/`, `build/`, etc.

### 5. Branches Recommandées

```bash
# Branche principale
git checkout -b main

# Branche de développement
git checkout -b develop

# Branche de feature
git checkout -b feature/nom-feature

# Branche de release
git checkout -b release/v1.0.0
```

### 6. Workflow GitHub Actions

Les workflows sont déjà configurés dans `.github/workflows/` :

- **test.yml** : Tests automatiques sur chaque push
- **release.yml** : Build de release sur tags `v*`

### 7. Créer une Release

```bash
# Créer un tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# GitHub Actions va automatiquement :
# - Build l'application
# - Créer les artifacts
# - Les rendre disponibles dans la release
```

### 8. Documentation GitHub

Le README.md sera automatiquement affiché sur la page du repository.

## 🔒 Sécurité

### Secrets GitHub

Pour les clés API, utilisez GitHub Secrets :

1. Repository > Settings > Secrets and variables > Actions
2. Ajouter les secrets :
   - `GEMINI_API_KEY`
   - `STRIPE_SECRET_KEY`
   - `FIREBASE_CONFIG` (base64)

### Fichiers Sensibles

Tous les fichiers sensibles sont dans `.gitignore` :
- Clés de signature
- Fichiers Firebase
- Clés API

## 📝 Checklist Avant Push

- [ ] `.gitignore` vérifié
- [ ] Aucune clé API dans le code
- [ ] Aucun fichier de signature commité
- [ ] README.md à jour
- [ ] Documentation complète
- [ ] Tests passent localement
- [ ] Code analysé (`flutter analyze`)

## 🎯 Prochaines Étapes

1. Créer le repository GitHub
2. Initialiser Git localement
3. Faire le premier commit
4. Pousser vers GitHub
5. Configurer GitHub Actions
6. Créer la première release

---

**Bon déploiement ! 🚀**

