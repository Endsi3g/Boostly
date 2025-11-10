# Architecture de l'Application BOOSTLY

## 📁 Structure du Projet

```
boostly/
├── lib/
│   ├── main.dart                    # Point d'entrée de l'application
│   ├── config/                      # Configurations
│   │   ├── firebase_config.dart     # Configuration Firebase
│   │   ├── ai_config.dart           # Configuration Google Gemini
│   │   ├── theme_config.dart        # Design system et thèmes
│   │   └── stripe_config.dart       # Configuration Stripe
│   ├── models/                       # Modèles de données
│   │   ├── task.dart                # Modèle Task
│   │   ├── user.dart                # Modèle User avec Stats
│   │   ├── achievement.dart          # Modèle Achievement/Badge
│   │   └── mascot.dart              # Modèle Mascotte
│   ├── services/                    # Services métier
│   │   ├── auth_service.dart        # Authentification Firebase
│   │   ├── firestore_service.dart   # Base de données Firestore
│   │   ├── ai_service.dart          # Service Google Gemini
│   │   ├── notification_service.dart # Notifications locales
│   │   └── stripe_service.dart      # Paiements Stripe
│   ├── providers/                   # State Management (Provider)
│   │   ├── user_provider.dart       # État utilisateur
│   │   ├── task_provider.dart       # État des tâches
│   │   ├── gamification_provider.dart # État gamification
│   │   ├── mascot_provider.dart     # État mascotte
│   │   └── subscription_provider.dart # État abonnements
│   ├── screens/                     # Écrans de l'application
│   │   ├── auth/                    # Authentification
│   │   │   ├── login_screen.dart
│   │   │   └── signup_screen.dart
│   │   ├── home/                    # Accueil
│   │   │   └── home_screen.dart
│   │   ├── tasks/                   # Gestion des tâches
│   │   │   ├── tasks_screen.dart
│   │   │   └── task_detail_screen.dart
│   │   ├── mascot/                 # Mascotte
│   │   │   └── mascot_screen.dart
│   │   ├── resources/              # Bibliothèque de ressources
│   │   │   └── resources_screen.dart
│   │   ├── analytics/              # Analytics
│   │   │   └── analytics_screen.dart
│   │   ├── profile/                # Profil utilisateur
│   │   │   └── profile_screen.dart
│   │   └── settings/               # Paramètres
│   │       └── settings_screen.dart
│   ├── widgets/                    # Widgets réutilisables
│   │   └── common/
│   │       ├── custom_button.dart
│   │       ├── task_card.dart
│   │       ├── progress_bar.dart
│   │       ├── mascot_widget.dart
│   │       ├── badge_card.dart
│   │       └── stat_card.dart
│   ├── router/                     # Navigation
│   │   └── app_router.dart
│   └── utils/                      # Utilitaires
│       ├── constants.dart
│       └── security.dart
├── assets/                         # Ressources
│   ├── images/
│   ├── animations/
│   ├── icons/
│   └── fonts/
├── docs/                           # Documentation
│   ├── SETUP_GUIDE.md
│   ├── API_DOCUMENTATION.md
│   └── DEPLOYMENT.md
├── pubspec.yaml                    # Dépendances Flutter
├── README.md                       # Documentation principale
├── CHANGELOG.md                    # Historique des versions
└── .gitignore                      # Fichiers ignorés par Git
```

## 🏗️ Architecture

### Pattern: Provider (State Management)
- Utilisation de Provider pour la gestion d'état
- Séparation claire entre UI et logique métier
- Services injectés via Provider

### Services Layer
- **AuthService**: Gère l'authentification Firebase
- **FirestoreService**: Toutes les opérations de base de données
- **AIService**: Intégration Google Gemini API
- **NotificationService**: Notifications push locales
- **StripeService**: Gestion des paiements

### Models Layer
- Modèles de données immutables
- Conversion Firestore ↔ Dart automatique
- Méthodes `copyWith` pour les mises à jour

### UI Layer
- Écrans conformes aux designs UX
- Widgets réutilisables selon le design system
- Navigation via GoRouter

## 🔐 Sécurité

### Chiffrement
- AES-256 pour données sensibles
- Stockage sécurisé via Flutter Secure Storage
- Clés générées de manière sécurisée

### Validation
- Validation des emails (regex)
- Validation des mots de passe (force)
- Sanitization XSS sur tous les inputs

### Authentification
- Firebase Auth avec sessions sécurisées
- Support Google et Apple Sign-In
- Expiration automatique des sessions

## 📊 Base de Données Firestore

### Collections
- `users`: Profils utilisateurs
- `tasks`: Tâches des utilisateurs
- `achievements`: Badges débloqués
- `mascots`: Données des mascottes
- `resources`: Bibliothèque de ressources

### Structure des Documents
- Tous les documents ont un `userId` pour la sécurité
- Indexes Firestore pour les requêtes fréquentes
- Règles de sécurité Firestore à configurer

## 🎨 Design System

### Couleurs
- Primaire: `#4A6FE5` (Bleu Boostly)
- Secondaire: `#7C4DFF` (Violet)
- Accent: `#FFB84C` (Orange)
- Texte: `#333A4D` (Charcoal), `#6B7C98` (Gray)

### Typographie
- Titres: Poppins (SemiBold/Bold)
- Body: Inter (Regular/Medium)

### Composants
- Border radius: 8px (small), 12px (medium), 16px (large)
- Ombres subtiles pour élévation
- Animations fluides (0.2s ease-in-out)

## 🚀 Déploiement

### Prérequis
1. Flutter SDK >= 3.0.0
2. Compte Firebase configuré
3. Clé API Google Gemini
4. Compte Stripe (sandbox pour MVP)

### Étapes
1. `flutter pub get`
2. Configurer les clés API
3. `flutter run` pour tester
4. `flutter build` pour production

## 📈 Métriques et Analytics

### Firebase Analytics
- Événements utilisateur trackés
- Conversion freemium → premium
- Taux de rétention
- Temps de session

### KPIs
- DAU/MAU
- Taux de rétention 7 jours
- Taux de conversion Premium
- LTV par utilisateur

## 🔄 Workflow de Développement

1. **Développement**: Utiliser les services gratuits
2. **Test**: Firebase Emulator + TestFlight/Internal Testing
3. **Staging**: Environnement de test avec données réelles
4. **Production**: Déploiement sur App Store et Google Play

## 📝 Notes Importantes

- **Budget MVP**: $0 - Utilisation exclusive des tiers gratuits
- **Scalabilité**: Architecture prête pour 1,000+ utilisateurs
- **Sécurité**: Conformité RGPD intégrée
- **Performance**: Lazy loading, caching, pagination

