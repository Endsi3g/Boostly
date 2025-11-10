# Carte des Routes - BOOSTLY

## 📍 Toutes les Routes de l'Application

### 🔓 Routes Publiques (Sans Authentification)

| Route | Nom | Écran | Description |
|-------|-----|-------|-------------|
| `/onboarding-intro` | `onboarding-intro` | `OnboardingIntroScreen` | Introduction avec slides |
| `/onboarding-joy` | `onboarding-joy` | `OnboardingJoyScreen` | Dernier écran onboarding |
| `/login` | `login` | `LoginScreen` | Connexion |
| `/signup` | `signup` | `SignUpScreen` | Inscription |
| `/password-reset` | `password-reset` | `PasswordResetScreen` | Réinitialisation mot de passe |
| `/email-confirm` | `email-confirm` | `EmailConfirmScreen` | Confirmation email envoyé |

### 🏠 Routes Principales (Authentification Requise)

| Route | Nom | Écran | Description |
|-------|-----|-------|-------------|
| `/home` | `home` | `HomeScreen` | Accueil avec dashboard |
| `/tasks` | `tasks` | `TasksScreen` | Liste des tâches |
| `/task/:id` | `task-detail` | `TaskDetailScreen` | Détails d'une tâche |
| `/mascot` | `mascot` | `MascotScreen` | Mascotte personnalisée |
| `/resources` | `resources` | `ResourcesScreen` | Bibliothèque de ressources |
| `/analytics` | `analytics` | `AnalyticsScreen` | Dashboard analytics |
| `/profile` | `profile` | `ProfileScreen` | Profil utilisateur |
| `/settings` | `settings` | `SettingsScreen` | Paramètres |

### 🎮 Routes Gamification

| Route | Nom | Écran | Description |
|-------|-----|-------|-------------|
| `/badges` | `badges` | `BadgeCollectionScreen` | Collection de badges |
| `/leaderboard` | `leaderboard` | `LeaderboardScreen` | Classements |

### 🏆 Routes Challenges

| Route | Nom | Écran | Description |
|-------|-----|-------|-------------|
| `/challenges` | `challenges` | `ChallengeHubScreen` | Hub des défis |

### 💳 Routes Paiement

| Route | Nom | Écran | Description |
|-------|-----|-------|-------------|
| `/pricing` | `pricing` | `PricingPlansScreen` | Plans tarifaires |
| `/payment-flow` | `payment-flow` | `PaymentFlowScreen` | Processus de paiement |

## 🔗 Navigation

### Depuis Login Screen
- `context.go('/signup')` - Vers inscription
- `context.go('/password-reset')` - Vers réinitialisation
- `context.go('/home')` - Après connexion

### Depuis Home Screen
- `context.push('/tasks')` - Vers tâches
- `context.push('/mascot')` - Vers mascotte
- `context.push('/resources')` - Vers ressources
- `context.push('/analytics')` - Vers analytics
- `context.push('/profile')` - Vers profil
- `context.push('/settings')` - Vers paramètres
- `context.push('/badges')` - Vers badges
- `context.push('/leaderboard')` - Vers classements
- `context.push('/challenges')` - Vers défis
- `context.push('/pricing')` - Vers plans

### Depuis Profile Screen
- `context.push('/badges')` - Vers collection badges
- `context.push('/leaderboard')` - Vers classements
- `context.push('/settings')` - Vers paramètres
- `context.push('/pricing')` - Vers plans premium

## 📊 Statistiques

- **Total Routes**: 18 routes
- **Routes Publiques**: 6
- **Routes Protégées**: 12
- **Écrans Créés**: 18 écrans complets

## 🚀 Prochaines Routes à Implémenter

Les écrans suivants peuvent être ajoutés selon les besoins :

1. `/notification-setup` - Configuration notifications
2. `/calendar-settings` - Paramètres calendrier
3. `/sync-settings` - Synchronisation
4. `/avatar-setup` - Configuration avatar
5. `/manage-plan` - Gestion abonnement
6. `/subs-overview` - Vue d'ensemble abonnement
7. `/cancellation` - Annulation abonnement
8. `/achievement-flow` - Détails achievement
9. `/challenge-app` - Détails défi
10. `/routine-features` - Fonctionnalités routines
11. `/ai-task-mastery` - IA maîtrise tâches
12. `/smart-learning` - Apprentissage intelligent

## 🔐 Sécurité des Routes

- Toutes les routes (sauf publiques) nécessitent une authentification
- Redirection automatique vers `/login` si non authentifié
- Redirection vers `/home` si authentifié et sur route publique

