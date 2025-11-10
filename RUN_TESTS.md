# 🧪 Exécuter les Tests - BOOSTLY

## 🚀 Commandes Rapides

### Tous les Tests

```powershell
cd app
flutter test
```

### Tests Spécifiques

```powershell
# Tests widget
flutter test test/widget_test.dart

# Tests d'intégration
flutter test integration_test/

# Tests avec coverage
flutter test --coverage
```

### Analyser le Code

```powershell
cd app
flutter analyze
```

### Formater le Code

```powershell
cd app
flutter format lib/
```

## 📊 Résultats Attendus

### Tests Widget
- ✅ Application démarre
- ✅ Widget de base fonctionne

### Tests d'Intégration
- ✅ Application démarre correctement
- ✅ Structure de base fonctionne

### Tests de Services
- ✅ Structure de base
- ✅ Configuration Ollama

### Tests de Providers
- ✅ Structure de base
- ✅ Modèle de tâche

## 🎯 Coverage

Générer un rapport de couverture :

```powershell
cd app
flutter test --coverage
```

Le rapport sera dans `coverage/lcov.info`

## ✅ Checklist

- [ ] Tous les tests passent
- [ ] Aucune erreur d'analyse
- [ ] Code formaté
- [ ] Coverage acceptable

---

**Bon testage ! 🧪**

