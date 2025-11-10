# Documentation API - BOOSTLY

## 🔌 Services API

### Firebase Services

#### AuthService
- `signUpWithEmail()` - Inscription avec email/password
- `signInWithEmail()` - Connexion avec email/password
- `signInWithGoogle()` - Connexion Google
- `signInWithApple()` - Connexion Apple (iOS)
- `signOut()` - Déconnexion
- `resetPassword()` - Réinitialisation mot de passe

#### FirestoreService
- `createUser()` - Créer un utilisateur
- `getUser()` - Récupérer un utilisateur
- `updateUser()` - Mettre à jour un utilisateur
- `createTask()` - Créer une tâche
- `getUserTasks()` - Récupérer les tâches d'un utilisateur
- `updateTask()` - Mettre à jour une tâche
- `deleteTask()` - Supprimer une tâche
- `getUserAchievements()` - Récupérer les achievements
- `unlockAchievement()` - Débloquer un achievement
- `getMascot()` - Récupérer la mascotte
- `saveMascot()` - Sauvegarder la mascotte

### AI Service

#### AIService
- `suggestTasks()` - Suggestions de tâches intelligentes
- `generateEncouragementMessage()` - Message d'encouragement
- `analyzeMood()` - Analyse de l'humeur
- `generateDailyTip()` - Conseil quotidien
- `suggestRoutineImprovements()` - Améliorations de routine

**Limites:**
- 60 requêtes/minute (tier gratuit Google Gemini)
- Timeout: 30 secondes
- Retry: 3 tentatives maximum

### Stripe Service

#### StripeService
- `initialize()` - Initialiser Stripe
- `createCustomer()` - Créer un client
- `startFreeTrial()` - Démarrer l'essai gratuit
- `createSubscriptionPayment()` - Créer un paiement
- `confirmPayment()` - Confirmer le paiement
- `cancelSubscription()` - Annuler l'abonnement
- `checkSubscriptionStatus()` - Vérifier le statut

## 📊 Modèles de données

### Task
```dart
{
  id: String,
  userId: String,
  title: String,
  description: String?,
  category: String,
  priority: String,
  status: String,
  createdAt: DateTime,
  dueDate: DateTime?,
  completedAt: DateTime?,
  estimatedMinutes: int,
  tags: List<String>,
  isRecurring: bool,
  streak: int,
  xpAwarded: int
}
```

### BoostlyUser
```dart
{
  id: String,
  email: String,
  displayName: String?,
  photoUrl: String?,
  createdAt: DateTime,
  stats: UserStats,
  preferences: UserPreferences,
  subscription: SubscriptionInfo
}
```

### Achievement
```dart
{
  id: String,
  name: String,
  description: String,
  iconUrl: String,
  category: String,
  xpReward: int,
  rarity: String,
  isUnlocked: bool,
  unlockedAt: DateTime?
}
```

### Mascot
```dart
{
  id: String,
  userId: String,
  name: String,
  level: int,
  evolutionStage: int,
  currentMood: String,
  unlockedAccessories: List<String>,
  currentAccessory: String?
}
```

## 🔒 Sécurité

### Validation
- Emails: Regex validation
- Mots de passe: Minimum 8 caractères
- Sanitization: Protection XSS sur tous les inputs

### Chiffrement
- AES-256 pour données sensibles
- Stockage sécurisé via Flutter Secure Storage

### Authentification
- Firebase Auth avec sessions sécurisées
- Authentification biométrique optionnelle
- Expiration automatique des sessions

## 📈 Limites et quotas

### Firebase (Tier Gratuit)
- Authentication: 50K MAU
- Firestore: 1GB, 50K reads/writes/jour
- Storage: 5GB
- Functions: 125K invocations/mois

### Google Gemini (Tier Gratuit)
- 60 requêtes/minute
- Pas de limite quotidienne (dans la mesure du raisonnable)

### Stripe (Sandbox)
- Illimité en mode test
- Pas de frais réels

