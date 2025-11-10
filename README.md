# BOOSTLY - Application Mobile de Gestion de Tâches Gamifiée

**Tagline:** Lock In Your Goals

## 📱 Description

BOOSTLY est une application mobile de gestion de tâches gamifiée avec mascotte interactive et assistant IA, destinée aux entrepreneurs et créateurs de contenu. L'application combine productivité, gamification et intelligence artificielle pour motiver les utilisateurs à atteindre leurs objectifs.

## 🎯 Fonctionnalités Core (MVP)

1. **Task Management** - Création, édition, suppression de tâches avec catégorisation et deadlines
2. **Gamification System** - Système de points/XP, 20 niveaux, 45+ badges, leaderboards
3. **Mascot Integration** - Mascotte interactive avec animations et feedback contextuel
4. **Resources Library** - Bibliothèque de ressources sur la productivité avec favoris
5. **Analytics Dashboard** - Graphiques de progression, statistiques, heatmap d'activité

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase (Auth, Firestore, Storage, Functions, Analytics)
- **AI:** Ollama (auto-hébergé, gratuit et illimité) + Google Gemini API (fallback - 60 req/min)
- **Paiements:** Stripe (mode sandbox pour MVP)
- **Version Control:** GitHub

## 🎨 Design System

- **Couleurs:**
  - Primaire: Violet #8B7DBC
  - Secondaire: Turquoise #4ECDC4
  - Accent: Orange #FFB84C

- **Typographie:**
  - Titres: Poppins (SemiBold/Bold)
  - Body: Inter (Regular/Medium)

- **Style:** Flat design, minimal, coins arrondis (12-16px)

## 💰 Modèle de Monétisation

- **Free Tier:** Task management basique, 3 catégories max, mascotte limitée
- **Premium ($4.99/mois):** Tâches illimitées, AI assistant complet, analytics avancés, 7 jours d'essai gratuit

## 📋 Prérequis

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Firebase project configuré
- Ollama (optionnel mais recommandé - voir `docs/OLLAMA_SETUP.md`)
- Google Gemini API key (fallback si Ollama non disponible)
- Stripe account (sandbox pour MVP)

## 🚀 Installation

1. Cloner le repository
2. Installer les dépendances: `flutter pub get`
3. Configurer Firebase (voir `docs/SETUP_GUIDE.md`)
4. Configurer les clés API (voir `docs/SETUP_GUIDE.md`)
5. Lancer l'application: `flutter run`

## 📚 Documentation

- [Guide de Setup](docs/SETUP_GUIDE.md)
- [Configuration Ollama](docs/OLLAMA_SETUP.md) - IA auto-hébergée gratuite et illimitée
- [Documentation API](docs/API_DOCUMENTATION.md)
- [Guide de Déploiement](docs/DEPLOYMENT.md)

## 🔒 Sécurité

- Authentification Firebase sécurisée
- Chiffrement AES-256 pour données sensibles
- Validation et sanitization de tous les inputs
- Conformité RGPD

## 📊 Métriques Cibles

- 1,000+ DAU au mois 1
- 40%+ retention rate sur 7 jours
- 5%+ conversion rate freemium → premium

## 🧪 Tests

```bash
cd app
flutter test              # Tests unitaires
flutter test integration_test/  # Tests d'intégration
```

Voir [TEST_GUIDE.md](TEST_GUIDE.md) pour plus de détails.

## 🚀 Déploiement

### GitHub

1. Créer un repository GitHub
2. Initialiser Git : `git init`
3. Ajouter les fichiers : `git add .`
4. Commit : `git commit -m "Initial commit"`
5. Push : `git push origin main`

Voir [GITHUB_SETUP.md](GITHUB_SETUP.md) pour le guide complet.

### Android / iOS

Voir [DEPLOY.md](DEPLOY.md) pour le guide de déploiement complet.

## 📝 Licence

MIT License - Voir [LICENSE](LICENSE) pour plus de détails.

## 👥 Auteur

Développé pour BOOSTLY MVP - 2025

## 🔗 Liens

- [Documentation](docs/)
- [Guide de Setup](docs/SETUP_GUIDE.md)
- [Guide de Tests](TEST_GUIDE.md)
- [Guide GitHub](GITHUB_SETUP.md)
- [Guide de Déploiement](DEPLOY.md)

