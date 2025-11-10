# 📖 Guide Complet de Test - BOOSTLY

## 🎯 Vue d'Ensemble

Ce guide vous accompagne pour tester complètement l'application BOOSTLY.

## 📋 Prérequis

### Obligatoires
- ✅ Flutter SDK >= 3.0.0
- ✅ Dart SDK >= 3.0.0
- ✅ Un appareil/émulateur pour tester

### Optionnels (pour fonctionnalités complètes)
- Firebase (authentification, données)
- Ollama (IA locale)
- Google Gemini API (fallback IA)
- Stripe (paiements)

## 🚀 Démarrage Rapide

### 1. Installation

```powershell
cd app
flutter pub get
```

### 2. Vérification

```powershell
# Vérifier que tout est OK
flutter doctor
flutter analyze
flutter test
```

### 3. Lancement

```powershell
# Lancer l'application
flutter run
```

## 🧪 Tests Automatisés

### Tests Unitaires

```powershell
cd app
flutter test
```

**Résultat attendu** : Tous les tests passent ✅

### Tests d'Intégration

```powershell
cd app
flutter test integration_test/
```

### Coverage

```powershell
cd app
flutter test --coverage
```

Le rapport sera dans `coverage/lcov.info`

## 📱 Tests Manuels

### Scénario 1 : Parcours Utilisateur Complet

1. **Démarrer l'application**
   - ✅ L'application démarre sans erreur
   - ✅ Écran d'onboarding ou login s'affiche

2. **Créer un compte**
   - ✅ Formulaire d'inscription fonctionne
   - ✅ Validation des champs
   - ✅ Création du compte réussie

3. **Se connecter**
   - ✅ Login fonctionne
   - ✅ Redirection vers l'écran d'accueil

4. **Navigation**
   - ✅ Tous les écrans sont accessibles
   - ✅ Navigation fluide
   - ✅ Pas de crash

5. **Créer une tâche**
   - ✅ Formulaire d'ajout fonctionne
   - ✅ Tâche créée et affichée
   - ✅ Filtres fonctionnent

6. **Compléter une tâche**
   - ✅ Marquer comme complétée
   - ✅ XP gagné
   - ✅ Mascotte réagit

7. **Gamification**
   - ✅ XP affiché
   - ✅ Niveau calculé
   - ✅ Badges débloqués

8. **IA**
   - ✅ Génération de micro-tâches
   - ✅ Brainstorm d'idées
   - ✅ Chat avec l'IA

9. **Analytics**
   - ✅ Dashboard affiché
   - ✅ Graphiques visibles
   - ✅ Statistiques correctes

10. **Profil**
    - ✅ Informations utilisateur
    - ✅ Badges collection
    - ✅ Statistiques

### Scénario 2 : Tests de Fonctionnalités

#### Tâches
- [ ] Créer une tâche
- [ ] Modifier une tâche
- [ ] Compléter une tâche
- [ ] Décompléter une tâche
- [ ] Supprimer une tâche
- [ ] Filtrer par statut
- [ ] Filtrer par priorité
- [ ] Filtrer par catégorie
- [ ] Rechercher une tâche

#### Gamification
- [ ] Gagner XP en complétant une tâche
- [ ] Monter de niveau
- [ ] Débloquer un badge
- [ ] Voir le leaderboard
- [ ] Voir les achievements

#### Mascotte
- [ ] Mascotte affichée
- [ ] Animations fonctionnent
- [ ] Messages d'encouragement
- [ ] Personnalisation

#### IA
- [ ] Générer des micro-tâches
- [ ] Brainstorm d'idées
- [ ] Chat conversationnel
- [ ] Messages d'encouragement IA

#### Analytics
- [ ] Dashboard affiché
- [ ] Graphiques circulaires
- [ ] Heatmap de productivité
- [ ] Statistiques détaillées

### Scénario 3 : Tests d'Intégration

#### Firebase
- [ ] Authentification fonctionne
- [ ] Données sauvegardées
- [ ] Synchronisation
- [ ] Gestion des erreurs

#### Ollama/Gemini
- [ ] Ollama détecté (si installé)
- [ ] Fallback vers Gemini
- [ ] Génération de contenu
- [ ] Gestion des erreurs

#### Stripe
- [ ] Affichage des plans
- [ ] Processus de paiement (sandbox)
- [ ] Gestion d'abonnement

#### Notifications
- [ ] Permissions demandées
- [ ] Notifications affichées
- [ ] Rappels de tâches

## 🐛 Tests de Robustesse

### Gestion des Erreurs

- [ ] **Pas de connexion** : Message d'erreur approprié
- [ ] **Données invalides** : Validation et messages
- [ ] **Timeout réseau** : Gestion gracieuse
- [ ] **Firebase indisponible** : Fallback local

### Performance

- [ ] **Démarrage** : < 3 secondes
- [ ] **Navigation** : Fluide, pas de lag
- [ ] **Animations** : 60 FPS
- [ ] **Mémoire** : Pas de fuites

### Compatibilité

- [ ] **Android** : Testé sur différentes versions
- [ ] **iOS** : Testé (si disponible)
- [ ] **Tailles d'écran** : Responsive
- [ ] **Orientations** : Portrait/Landscape

## 📊 Rapports de Test

### Template de Rapport

```markdown
# Rapport de Test - BOOSTLY v1.0.0

**Date** : [Date]
**Testeur** : [Nom]
**Appareil** : [Modèle/Version]

## Résultats

### Tests Automatisés
- ✅ Tests unitaires : PASSENT
- ✅ Tests d'intégration : PASSENT

### Tests Manuels
- ✅ Parcours utilisateur : PASSENT
- ✅ Fonctionnalités : PASSENT
- ⚠️ [Problèmes détectés]

## Problèmes Détectés

1. [Description du problème]
   - **Sévérité** : [Haute/Moyenne/Basse]
   - **Reproduction** : [Étapes]
   - **Screenshot** : [Si applicable]

## Recommandations

- [Recommandations]
```

## ✅ Checklist Finale

### Avant de Commencer
- [ ] Flutter installé et configuré
- [ ] Dépendances installées
- [ ] Appareil/Émulateur disponible
- [ ] Firebase configuré (si nécessaire)

### Tests Automatisés
- [ ] Tests unitaires passent
- [ ] Tests d'intégration passent
- [ ] Coverage acceptable (> 60%)

### Tests Manuels
- [ ] Parcours utilisateur complet
- [ ] Toutes les fonctionnalités testées
- [ ] Aucun crash détecté
- [ ] Performance acceptable

### Documentation
- [ ] Rapport de test créé
- [ ] Problèmes documentés
- [ ] Recommandations notées

## 🎯 Critères de Succès

L'application est considérée comme **prête** si :

- ✅ Tous les tests automatisés passent
- ✅ Parcours utilisateur complet fonctionne
- ✅ Aucun crash critique
- ✅ Performance acceptable
- ✅ UX fluide et intuitive

## 📝 Notes

- Les tests peuvent être exécutés sans Firebase (mode local)
- Ollama est optionnel (fallback vers Gemini)
- Stripe en mode sandbox pour les tests

---

**Bon testage ! 🧪🚀**

