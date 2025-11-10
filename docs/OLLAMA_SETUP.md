# 🤖 Configuration Ollama - BOOSTLY

## 📋 Vue d'Ensemble

**Ollama** permet d'exécuter des modèles de langage localement sur votre machine, offrant une IA **100% gratuite, illimitée et privée**.

## 🚀 Installation

### 1. Installer Ollama

#### Windows
```bash
# Télécharger depuis: https://ollama.ai/download
# Ou utiliser winget
winget install Ollama.Ollama
```

#### macOS
```bash
# Télécharger depuis: https://ollama.ai/download
# Ou utiliser Homebrew
brew install ollama
```

#### Linux
```bash
curl -fsSL https://ollama.ai/install.sh | sh
```

### 2. Démarrer le Serveur Ollama

```bash
# Démarrer le serveur (démarre automatiquement après installation)
ollama serve

# Le serveur écoute sur: http://localhost:11434
```

### 3. Installer un Modèle

```bash
# Modèles recommandés (du plus léger au plus puissant):

# Llama 2 (7B) - Léger et rapide
ollama pull llama2

# Mistral (7B) - Bon équilibre
ollama pull mistral

# CodeLlama (7B) - Spécialisé code
ollama pull codellama

# Gemma (2B) - Très léger
ollama pull gemma

# Phi-2 (2.7B) - Microsoft, très efficace
ollama pull phi
```

### 4. Vérifier l'Installation

```bash
# Lister les modèles installés
ollama list

# Tester un modèle
ollama run llama2 "Bonjour, comment ça va?"
```

## ⚙️ Configuration dans BOOSTLY

### 1. Configuration de Base

Le fichier `lib/config/ai_config.dart` contient la configuration :

```dart
// URL de base (localhost par défaut)
static const String ollamaBaseUrl = 'http://localhost:11434';

// Modèle à utiliser
static const String ollamaModel = 'llama2';

// Activer Ollama comme solution principale
static const bool useOllama = true;
```

### 2. Serveur Distant

Si vous avez Ollama sur un serveur distant :

```dart
// Dans ai_config.dart
static const String ollamaBaseUrl = 'http://votre-serveur:11434';
```

### 3. Vérification Automatique

L'application vérifie automatiquement si Ollama est disponible au démarrage :

```dart
// Vérification au démarrage
static const bool checkOllamaOnStartup = true;
```

## 🔄 Fonctionnement

### Priorité des APIs

1. **Ollama** (si disponible) - Auto-hébergé, gratuit, illimité
2. **Google Gemini** (fallback) - Gratuit, 60 req/min
3. **OpenAI** (optionnel) - Payant

### Fallback Automatique

Si Ollama n'est pas disponible ou échoue, l'application bascule automatiquement vers Gemini.

## 📊 Avantages d'Ollama

### ✅ Avantages
- **100% Gratuit** - Aucun coût
- **Illimité** - Pas de limite de requêtes
- **Privé** - Données restent locales
- **Rapide** - Pas de latence réseau
- **Personnalisable** - Choix du modèle
- **Hors ligne** - Fonctionne sans internet

### ⚠️ Considérations
- **Ressources** - Nécessite RAM/CPU (minimum 8GB RAM recommandé)
- **Modèles** - Téléchargement initial (2-7GB selon modèle)
- **Performance** - Plus lent que les APIs cloud (mais acceptable)

## 🎯 Modèles Recommandés

| Modèle | Taille | RAM | Usage |
|--------|--------|-----|-------|
| **Gemma 2B** | 2GB | 4GB | Très léger, rapide |
| **Phi-2** | 2.7GB | 4GB | Efficace, rapide |
| **Llama 2 7B** | 4GB | 8GB | Équilibré, bon |
| **Mistral 7B** | 4GB | 8GB | Très bon, rapide |
| **CodeLlama 7B** | 4GB | 8GB | Spécialisé code |

## 🔧 Dépannage

### Problème : Ollama non détecté

```bash
# Vérifier que le serveur tourne
curl http://localhost:11434/api/tags

# Redémarrer Ollama
ollama serve
```

### Problème : Modèle non trouvé

```bash
# Vérifier les modèles installés
ollama list

# Installer le modèle
ollama pull llama2
```

### Problème : Timeout

```dart
// Augmenter le timeout dans ai_config.dart
static const int ollamaTimeout = 120; // 2 minutes
```

### Problème : Serveur distant

```dart
// Vérifier la connectivité
// Dans ai_config.dart, utiliser l'IP du serveur
static const String ollamaBaseUrl = 'http://192.168.1.100:11434';
```

## 📝 Utilisation dans l'Application

L'application utilise automatiquement Ollama si disponible :

```dart
// Le service AI détecte automatiquement Ollama
final aiService = AIService();
await aiService.checkOllamaAvailability();

// Utilisation normale (Ollama ou Gemini selon disponibilité)
final suggestions = await aiService.suggestTasks(
  completedTasks: tasks,
  currentTasks: current,
);
```

## 🎉 Résultat

Avec Ollama configuré, vous avez :
- ✅ IA **100% gratuite**
- ✅ **Aucune limite** de requêtes
- ✅ **Données privées** (restent locales)
- ✅ **Fonctionne hors ligne**
- ✅ **Personnalisable** (choix du modèle)

---

**Installation Ollama** : https://ollama.ai  
**Documentation** : https://github.com/ollama/ollama  
**Modèles disponibles** : https://ollama.ai/library

