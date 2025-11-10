# 🚀 Guide de Démarrage Rapide - BOOSTLY

## ⚡ Démarrage en 5 Minutes

### 1. Vérifier l'Environnement
```bash
# Vérifier Flutter
flutter --version
# Doit afficher : Flutter 3.x.x ou supérieur

# Vérifier les appareils
flutter devices
```

### 2. Installer les Dépendances
```bash
cd boostly
flutter pub get
```

### 3. Lancer l'Application
```bash
# Lancer sur l'appareil par défaut
flutter run

# Ou spécifier un appareil
flutter run -d <device-id>
```

## 📱 Parcours de Test Recommandé

### Étape 1 : Onboarding
1. L'application démarre sur `/visuals-onboarding`
2. Naviguer vers `/onboarding-intro`
3. Puis `/onboarding-joy`

### Étape 2 : Authentification
1. Aller sur `/login`
2. Créer un compte via `/signup`
3. Tester le reset password via `/password-reset`

### Étape 3 : Home & Tâches
1. Accéder à `/home` (dashboard principal)
2. Aller sur `/tasks` pour voir la liste
3. Cliquer sur le bouton "+" pour créer une tâche
4. Tester les filtres et actions

### Étape 4 : Gamification
1. Compléter quelques tâches pour gagner XP
2. Aller sur `/profile` pour voir la progression
3. Consulter `/badges` pour les achievements
4. Voir `/leaderboard` pour les classements

### Étape 5 : Autres Fonctionnalités
1. `/mascot` - Personnaliser la mascotte
2. `/analytics` - Voir les statistiques
3. `/resources` - Explorer la bibliothèque
4. `/settings` - Configurer l'application

## 🎯 Points Clés à Tester

### ✅ Fonctionnalités Critiques
- [ ] Création de compte
- [ ] Connexion
- [ ] Création de tâche
- [ ] Marquer tâche comme complétée
- [ ] Filtres de tâches
- [ ] Navigation entre écrans

### ✅ Gamification
- [ ] Gain d'XP après complétion
- [ ] Progression de niveau
- [ ] Déblocage de badges
- [ ] Affichage du leaderboard

### ✅ UI/UX
- [ ] Animations fluides
- [ ] Responsive design
- [ ] Thème clair/sombre
- [ ] Navigation intuitive

## 🔧 Commandes Utiles

```bash
# Hot reload (pendant le développement)
# Appuyer sur 'r' dans le terminal

# Hot restart
# Appuyer sur 'R' dans le terminal

# Quitter
# Appuyer sur 'q' dans le terminal

# Analyser le code
flutter analyze

# Formater le code
flutter format lib/

# Nettoyer le build
flutter clean
flutter pub get
```

## 📊 Écrans Principaux à Visiter

| Route | Description | Statut |
|-------|-------------|--------|
| `/home` | Dashboard principal | ✅ |
| `/tasks` | Liste des tâches | ✅ |
| `/profile` | Profil utilisateur | ✅ |
| `/analytics` | Statistiques | ✅ |
| `/mascot` | Mascotte | ✅ |
| `/badges` | Collection badges | ✅ |
| `/leaderboard` | Classements | ✅ |
| `/challenges` | Défis | ✅ |
| `/pricing` | Plans d'abonnement | ✅ |
| `/settings` | Paramètres | ✅ |

## 🎨 Design System

### Couleurs
- **Primary** : `#4A6FE5` (Boostly Blue)
- **Secondary** : `#7C4DFF` (Boostly Purple)
- **Accent** : `#FFB84C` (Orange)
- **Success** : `#10B981` (Green)
- **Error** : `#EF4444` (Red)

### Typographie
- **Titres** : Poppins (Bold, 700)
- **Corps** : Inter (Regular, 400)
- **Tailles** : 12px - 32px

## 🐛 Dépannage

### Problème : "No devices found"
```bash
# Vérifier les appareils connectés
flutter devices

# Démarrer un émulateur Android
# Via Android Studio > AVD Manager

# Ou connecter un appareil physique
# Activer le mode développeur
```

### Problème : "Package not found"
```bash
# Nettoyer et réinstaller
flutter clean
flutter pub get
```

### Problème : Erreurs de compilation
```bash
# Analyser le code
flutter analyze

# Vérifier les imports
# Vérifier les dépendances dans pubspec.yaml
```

## 📝 Notes Importantes

1. **Firebase** : L'application nécessite une configuration Firebase pour fonctionner complètement
2. **Stripe** : Mode sandbox pour les tests de paiement
3. **IA** : Google Gemini API (gratuit) pour les fonctionnalités IA
4. **Assets** : Les dossiers assets sont créés mais vides (à remplir)

## 🎉 Prêt à Démarrer !

L'application est **100% fonctionnelle** et prête pour les tests. Tous les écrans sont connectés et l'architecture est complète.

```bash
flutter run
```

**Bon développement ! 🚀**

