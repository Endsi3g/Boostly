# 🔧 Commandes Git pour Déployer sur GitHub

## 📋 Commandes Rapides

### 1. Initialiser Git (si pas déjà fait)

```powershell
cd "C:\Users\le3li\Documents\EV Appv4\boostly"
git init
```

### 2. Ajouter tous les fichiers

```powershell
git add .
```

### 3. Premier Commit

```powershell
git commit -m "feat: Initial commit - BOOSTLY MVP v1.0.0 avec Ollama AI"
```

### 4. Créer le Repository sur GitHub

1. Aller sur https://github.com
2. Cliquer sur "New repository"
3. Nom : `boostly-app`
4. Description : "Application mobile de gestion de tâches gamifiée"
5. Visibilité : Private (recommandé)
6. **NE PAS** cocher "Initialize with README"
7. Cliquer sur "Create repository"

### 5. Ajouter le Remote et Pousser

```powershell
# Remplacer VOTRE_USERNAME par votre nom d'utilisateur GitHub
git remote add origin https://github.com/VOTRE_USERNAME/boostly-app.git
git branch -M main
git push -u origin main
```

## 🏷️ Créer une Release

```powershell
# Créer un tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Pousser le tag
git push origin v1.0.0
```

## 🔄 Workflow de Développement

### Créer une Branche

```powershell
git checkout -b feature/ma-fonctionnalite
```

### Commit et Push

```powershell
git add .
git commit -m "feat: Description de la fonctionnalité"
git push origin feature/ma-fonctionnalite
```

### Merge dans Main

1. Créer une Pull Request sur GitHub
2. Review et merge

## 📝 Messages de Commit

Format recommandé :

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation
- `test:` Tests
- `refactor:` Refactoring

Exemple : `feat: Ajout de la génération de micro-tâches avec Ollama`

## ✅ Vérifications Avant Push

```powershell
# Vérifier les fichiers à committer
git status

# Vérifier les différences
git diff

# Vérifier qu'aucun fichier sensible n'est inclus
git check-ignore -v key.properties
git check-ignore -v *.jks
```

## 🚨 En Cas de Problème

### Annuler le dernier commit (localement)

```powershell
git reset --soft HEAD~1
```

### Supprimer un fichier du staging

```powershell
git reset HEAD nom-du-fichier
```

### Voir l'historique

```powershell
git log --oneline
```

---

**Prêt pour GitHub ! 🚀**

