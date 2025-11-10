# ⚡ Déploiement Rapide - BOOSTLY

## 🚀 Commandes pour Déployer sur GitHub

### Étape 1 : Initialiser Git

```powershell
cd "C:\Users\le3li\Documents\EV Appv4\boostly"
git init
```

### Étape 2 : Créer le Repository GitHub

1. Aller sur https://github.com/new
2. Nom : `boostly-app`
3. Description : "Application mobile de gestion de tâches gamifiée avec IA"
4. Visibilité : Private
5. **NE PAS** initialiser avec README
6. Créer le repository

### Étape 3 : Ajouter et Committer

```powershell
git add .
git commit -m "feat: Initial commit - BOOSTLY MVP v1.0.0"
```

### Étape 4 : Pousser vers GitHub

```powershell
# Remplacer VOTRE_USERNAME
git remote add origin https://github.com/VOTRE_USERNAME/boostly-app.git
git branch -M main
git push -u origin main
```

## ✅ C'est Tout !

Votre application est maintenant sur GitHub !

## 🎯 Prochaines Étapes

1. Vérifier que tout est bien uploadé
2. Configurer GitHub Actions (automatique)
3. Créer une release : `git tag v1.0.0 && git push origin v1.0.0`

---

Voir [GITHUB_SETUP.md](GITHUB_SETUP.md) pour le guide complet.

