# 🧪 Guide de Tests - BOOSTLY

## 📋 Vue d'Ensemble

Ce guide explique comment exécuter les tests complets de l'application BOOSTLY.

## 🎯 Types de Tests

### 1. Tests Unitaires

Tests des services, providers et modèles individuels.

```bash
cd app
flutter test test/
```

### 2. Tests Widget

Tests des widgets et écrans individuels.

```bash
cd app
flutter test test/widget_test.dart
```

### 3. Tests d'Intégration

Tests complets de l'application.

```bash
cd app
flutter test integration_test/
```

## 📁 Structure des Tests

```
app/test/
├── widget_test.dart              # Tests widget de base
├── services/
│   └── ai_service_test.dart      # Tests AIService
├── providers/
│   └── task_provider_test.dart   # Tests TaskProvider
└── integration_test/
    └── integration_test.dart     # Tests d'intégration
```

## 🚀 Exécution des Tests

### Tous les Tests

```bash
cd app
flutter test
```

### Tests Spécifiques

```bash
# Tests d'un fichier spécifique
flutter test test/services/ai_service_test.dart

# Tests avec coverage
flutter test --coverage

# Tests en mode verbose
flutter test --verbose
```

### Tests d'Intégration

```bash
cd app
flutter test integration_test/
```

## 📊 Coverage

Générer un rapport de couverture :

```bash
cd app
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## ✅ Checklist de Tests

### Services
- [ ] AIService - Vérification Ollama
- [ ] AIService - Génération micro-tâches
- [ ] AIService - Génération d'idées
- [ ] AIService - Chat IA
- [ ] AuthService - Connexion
- [ ] AuthService - Inscription
- [ ] FirestoreService - CRUD

### Providers
- [ ] TaskProvider - Ajout tâche
- [ ] TaskProvider - Complétion tâche
- [ ] UserProvider - Mise à jour profil
- [ ] GamificationProvider - Calcul XP
- [ ] MascotProvider - Messages

### Widgets
- [ ] Écran de connexion
- [ ] Écran d'accueil
- [ ] Écran des tâches
- [ ] Écran de la mascotte

### Intégration
- [ ] Parcours utilisateur complet
- [ ] Création de compte
- [ ] Création de tâche
- [ ] Gamification
- [ ] IA fonctionnelle

## 🔧 Configuration

### Mock Services

Pour tester sans dépendances externes :

```dart
// Exemple avec mockito
class MockAIService extends Mock implements AIService {}
```

### Test Data

Créer des données de test dans `test/fixtures/` :

```dart
final testTask = Task(
  id: 'test-1',
  title: 'Test Task',
  // ...
);
```

## 📝 Exemples de Tests

### Test de Service

```dart
test('Génération de micro-tâches', () async {
  final aiService = AIService();
  final tasks = await aiService.generateMicroTasks('Tâche test');
  expect(tasks, isA<List<String>>());
});
```

### Test de Provider

```dart
test('Ajout d\'une tâche', () {
  final provider = TaskProvider();
  final task = Task(/* ... */);
  provider.addTask(task);
  expect(provider.totalTasks, 1);
});
```

## 🎯 Objectifs de Coverage

- **Services** : 80%+
- **Providers** : 80%+
- **Widgets** : 70%+
- **Intégration** : Scénarios principaux

## 🚨 Tests en CI/CD

Les tests sont exécutés automatiquement sur GitHub Actions :

- Sur chaque push
- Sur chaque pull request
- Avant chaque release

Voir `.github/workflows/test.yml`

---

**Bon testage ! 🧪**

