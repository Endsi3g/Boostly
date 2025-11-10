# 🔄 GitHub Actions - BOOSTLY

## 📋 Workflows Configurés

### 1. Tests Automatiques (`test.yml`)

**Déclenchement** :
- Sur chaque push vers `main` ou `develop`
- Sur chaque pull request vers `main` ou `develop`

**Actions** :
1. Setup Flutter
2. Installation des dépendances
3. Analyse du code (`flutter analyze`)
4. Exécution des tests (`flutter test`)
5. Vérification du formatage

**Artifacts** :
- APK Debug (si build réussi)

### 2. Build de Release (`release.yml`)

**Déclenchement** :
- Sur chaque tag `v*` (ex: `v1.0.0`)

**Actions** :
1. Build Android App Bundle
2. Build iOS (sans signature)
3. Upload des artifacts

**Artifacts** :
- `app-release.aab` (Android)
- `Runner.app` (iOS)

## 🚀 Utilisation

### Créer une Release

```bash
# Créer un tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# GitHub Actions va automatiquement :
# - Build l'application
# - Créer les artifacts
# - Les rendre disponibles dans la release
```

### Voir les Workflows

1. Aller sur GitHub
2. Repository > Actions
3. Voir les workflows en cours/complétés

## 🔧 Configuration

### Secrets GitHub

Pour utiliser des secrets dans les workflows :

1. Repository > Settings > Secrets and variables > Actions
2. Ajouter un secret :
   - Name : `GEMINI_API_KEY`
   - Value : Votre clé API

3. Utiliser dans le workflow :
```yaml
env:
  GEMINI_API_KEY: ${{ secrets.GEMINI_API_KEY }}
```

## 📊 Badges

Ajouter des badges dans le README :

```markdown
![Tests](https://github.com/USERNAME/boostly-app/workflows/Tests/badge.svg)
![Build](https://github.com/USERNAME/boostly-app/workflows/Build/badge.svg)
```

## 🎯 Prochaines Améliorations

- [ ] Tests sur plusieurs versions Flutter
- [ ] Build pour plusieurs plateformes
- [ ] Upload automatique sur Firebase App Distribution
- [ ] Notifications Slack/Discord

---

**Workflows configurés et prêts ! 🚀**

