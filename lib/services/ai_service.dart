/**
 * BOOSTLY - Service Intelligence Artificielle
 * 
 * Intègre Ollama (auto-hébergé) et Google Gemini API pour:
 * - Suggestions de tâches intelligentes
 * - Feedback contextuel de la mascotte
 * - Analyse de l'humeur
 * - Génération de conseils quotidiens
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.1.0
 * 
 * Priorité: Ollama (auto-hébergé) > Google Gemini (fallback)
 * 
 * Installation Ollama:
 * - Télécharger: https://ollama.ai
 * - Installer un modèle: ollama pull llama2
 * - Démarrer le serveur: ollama serve
 */

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../config/ai_config.dart';
import '../models/task.dart';

/// Service d'intelligence artificielle utilisant Ollama (prioritaire) et Gemini (fallback)
class AIService extends ChangeNotifier {
  // Configuration Ollama
  final String _ollamaBaseUrl = AIConfig.ollamaBaseUrl;
  final String _ollamaModel = AIConfig.ollamaModel;
  
  // Configuration Gemini (fallback)
  final String _geminiApiKey = AIConfig.geminiApiKey;
  final String _geminiBaseUrl = AIConfig.geminiBaseUrl;
  final String _geminiModel = AIConfig.geminiModel;
  
  bool _isLoading = false;
  String? _errorMessage;
  int _requestCount = 0;
  DateTime? _lastRequestTime;
  bool? _ollamaAvailable;
  String _currentProvider = 'ollama'; // 'ollama' ou 'gemini'

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool? get ollamaAvailable => _ollamaAvailable;
  String get currentProvider => _currentProvider;

  /// Vérifie si Ollama est disponible
  Future<bool> checkOllamaAvailability() async {
    if (_ollamaAvailable != null) return _ollamaAvailable!;
    
    // Sur le web, localhost ne fonctionne pas, utiliser Gemini directement
    if (kIsWeb && _ollamaBaseUrl.contains('localhost')) {
      _ollamaAvailable = false;
      _currentProvider = 'gemini';
      debugPrint('Ollama: localhost non disponible sur le web, utilisation de Gemini');
      return false;
    }
    
    try {
      final url = Uri.parse('$_ollamaBaseUrl/api/tags');
      final response = await http.get(url).timeout(
        const Duration(seconds: 3),
      );
      
      _ollamaAvailable = response.statusCode == 200;
      if (_ollamaAvailable == true) {
        _currentProvider = 'ollama';
      }
      return _ollamaAvailable ?? false;
    } catch (e) {
      _ollamaAvailable = false;
      _currentProvider = 'gemini';
      debugPrint('Ollama non disponible: $e');
      return false;
    }
  }

  /// Vérifie le rate limiting (uniquement pour Gemini - 60 req/min)
  bool _checkRateLimit() {
    // Ollama n'a pas de limite de rate
    if (_currentProvider == 'ollama') return true;
    
    final now = DateTime.now();
    if (_lastRequestTime == null) {
      _lastRequestTime = now;
      _requestCount = 1;
      return true;
    }

    final difference = now.difference(_lastRequestTime!);
    if (difference.inMinutes >= 1) {
      // Réinitialiser le compteur après 1 minute
      _requestCount = 1;
      _lastRequestTime = now;
      return true;
    }

    if (_requestCount >= AIConfig.geminiRateLimit) {
      return false; // Limite atteinte
    }

    _requestCount++;
    return true;
  }

  /// Fait une requête à Ollama
  Future<Map<String, dynamic>?> _makeOllamaRequest(String prompt) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final url = Uri.parse('$_ollamaBaseUrl/api/generate');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': _ollamaModel,
          'prompt': prompt,
          'stream': false,
        }),
      ).timeout(Duration(seconds: AIConfig.ollamaTimeout));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _isLoading = false;
        notifyListeners();
        return data;
      } else {
        throw Exception('Erreur Ollama API: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Erreur Ollama: $e';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Fait une requête à l'API Gemini
  Future<Map<String, dynamic>?> _makeGeminiRequest(String prompt) async {
    if (!_checkRateLimit()) {
      _errorMessage = 'Limite de requêtes atteinte. Réessayez dans une minute.';
      return null;
    }

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final url = Uri.parse('$_geminiBaseUrl/models/$_geminiModel:generateContent?key=$_geminiApiKey');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
        }),
      ).timeout(Duration(seconds: AIConfig.requestTimeout));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _isLoading = false;
        notifyListeners();
        return data;
      } else {
        throw Exception('Erreur Gemini API: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  /// Fait une requête avec fallback automatique (Ollama > Gemini)
  Future<Map<String, dynamic>?> _makeRequest(String prompt) async {
    // Vérifier Ollama si pas encore vérifié
    if (_ollamaAvailable == null && AIConfig.useOllama) {
      await checkOllamaAvailability();
    }

    // Essayer Ollama en premier si disponible
    if (AIConfig.useOllama && _ollamaAvailable == true) {
      final ollamaResponse = await _makeOllamaRequest(prompt);
      if (ollamaResponse != null) {
        return ollamaResponse;
      }
      // Si Ollama échoue, essayer Gemini
      debugPrint('Ollama a échoué, basculement vers Gemini');
    }

    // Fallback vers Gemini
    return await _makeGeminiRequest(prompt);
  }

  /// Extrait le texte de la réponse (Ollama ou Gemini)
  String? _extractText(Map<String, dynamic>? response) {
    if (response == null) return null;
    
    try {
      // Format Ollama
      if (response.containsKey('response')) {
        return response['response'] as String?;
      }
      
      // Format Gemini
      if (response.containsKey('candidates')) {
        final candidates = response['candidates'] as List?;
        if (candidates == null || candidates.isEmpty) return null;
        
        final content = candidates[0]['content'] as Map<String, dynamic>?;
        if (content == null) return null;
        
        final parts = content['parts'] as List?;
        if (parts == null || parts.isEmpty) return null;
        
        return parts[0]['text'] as String?;
      }
      
      return null;
    } catch (e) {
      debugPrint('Erreur lors de l\'extraction du texte: $e');
      return null;
    }
  }

  /// Génère des suggestions de tâches intelligentes basées sur l'historique
  Future<List<String>> suggestTasks({
    required List<Task> completedTasks,
    required List<Task> currentTasks,
    String? userGoal,
  }) async {
    final prompt = '''
Tu es un assistant de productivité pour l'application BOOSTLY.
Génère 5 suggestions de tâches pertinentes basées sur:
- Tâches complétées récemment: ${completedTasks.take(5).map((t) => t.title).join(', ')}
- Tâches en cours: ${currentTasks.take(3).map((t) => t.title).join(', ')}
- Objectif utilisateur: ${userGoal ?? 'Améliorer la productivité'}

Réponds UNIQUEMENT avec une liste de 5 tâches, une par ligne, sans numérotation ni puces.
Format: Titre de la tâche
''';

    final response = await _makeRequest(prompt);
    final text = _extractText(response);
    
    if (text == null) return [];

    // Parser les suggestions
    final suggestions = text
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .take(5)
        .map((line) => line.trim())
        .toList();

    return suggestions;
  }

  /// Génère un message d'encouragement contextuel pour la mascotte
  Future<String?> generateEncouragementMessage({
    required int tasksCompletedToday,
    required int currentStreak,
    required int level,
    String? lastAchievement,
  }) async {
    final prompt = '''
Tu es la mascotte Boosty, un compagnon motivant et encourageant.
Génère un message court et positif (maximum 2 phrases) pour encourager l'utilisateur.

Contexte:
- Tâches complétées aujourd'hui: $tasksCompletedToday
- Streak actuel: $currentStreak jours
- Niveau: $level
- Dernier achievement: ${lastAchievement ?? 'Aucun'}

Le message doit être:
- Positif et motivant
- Court (maximum 2 phrases)
- En français
- Adapté au contexte de l'utilisateur

Réponds UNIQUEMENT avec le message, sans guillemets ni formatage.
''';

    final response = await _makeRequest(prompt);
    return _extractText(response);
  }

  /// Analyse l'humeur de l'utilisateur basée sur son activité
  Future<String?> analyzeMood({
    required int tasksCompleted,
    required int tasksPending,
    required int streak,
    required DateTime lastActivity,
  }) async {
    final prompt = '''
Analyse l'humeur et l'état d'esprit de l'utilisateur basé sur son activité.

Données:
- Tâches complétées: $tasksCompleted
- Tâches en attente: $tasksPending
- Streak: $streak jours
- Dernière activité: ${lastActivity.toString()}

Réponds avec UN SEUL mot parmi: happy, excited, proud, encouraging, sleepy

Le mot doit refléter l'état émotionnel probable de l'utilisateur.
''';

    final response = await _makeRequest(prompt);
    final text = _extractText(response);
    return text?.trim().toLowerCase();
  }

  /// Génère un conseil quotidien personnalisé
  Future<String?> generateDailyTip({
    required int level,
    required List<String> categories,
    String? userGoal,
  }) async {
    final prompt = '''
Génère un conseil de productivité quotidien personnalisé (2-3 phrases maximum).

Contexte:
- Niveau utilisateur: $level
- Catégories préférées: ${categories.join(', ')}
- Objectif: ${userGoal ?? 'Améliorer la productivité'}

Le conseil doit être:
- Pratique et actionnable
- Court (2-3 phrases)
- En français
- Adapté au niveau et aux préférences de l'utilisateur

Réponds UNIQUEMENT avec le conseil, sans formatage.
''';

    final response = await _makeRequest(prompt);
    return _extractText(response);
  }

  /// Suggère des améliorations pour une routine
  Future<String?> suggestRoutineImprovements({
    required List<Task> routineTasks,
    required Map<String, int> completionStats,
  }) async {
    final prompt = '''
Analyse cette routine et suggère 3 améliorations concrètes.

Routine actuelle:
${routineTasks.map((t) => '- ${t.title}').join('\n')}

Statistiques de complétion:
${completionStats.entries.map((e) => '- ${e.key}: ${e.value}%').join('\n')}

Réponds avec 3 suggestions courtes, une par ligne, sans numérotation.
Format: Suggestion
''';

    final response = await _makeRequest(prompt);
    return _extractText(response);
  }

  /// Génère des micro-objectifs pour une tâche (utilisé par AI Task Mastery)
  Future<List<String>> generateMicroTasks(String taskTitle, String? taskDescription) async {
    final prompt = '''
Tu es un assistant de productivité pour l'application BOOSTLY.
Décompose cette tâche en 3-5 micro-objectifs simples et actionnables.

Tâche: $taskTitle
${taskDescription != null ? 'Description: $taskDescription' : ''}

Réponds UNIQUEMENT avec une liste de micro-objectifs, un par ligne, sans numérotation ni puces.
Format: Micro-objectif
''';

    final response = await _makeRequest(prompt);
    final text = _extractText(response);
    
    if (text == null) return [];

    // Parser les micro-objectifs
    final microTasks = text
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .take(5)
        .map((line) => line.trim())
        .toList();

    return microTasks;
  }

  /// Génère des idées de brainstorming (utilisé par Brainstorm Ideas)
  Future<List<String>> generateIdeas(String topic) async {
    final prompt = '''
Tu es un assistant créatif pour l'application BOOSTLY.
Génère 5 idées créatives et actionnables sur le sujet suivant.

Sujet: $topic

Réponds UNIQUEMENT avec une liste de 5 idées, une par ligne, sans numérotation ni puces.
Format: Idée
''';

    final response = await _makeRequest(prompt);
    final text = _extractText(response);
    
    if (text == null) return [];

    // Parser les idées
    final ideas = text
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .take(5)
        .map((line) => line.trim())
        .toList();

    return ideas;
  }

  /// Chat conversationnel avec l'IA (utilisé par Task Helper)
  Future<String?> chatWithAI(String userMessage, {String? context}) async {
    final prompt = '''
Tu es Boosty, l'assistant IA de l'application BOOSTLY, une app de gestion de tâches gamifiée.
Tu es amical, motivant et utile. Réponds en français de manière concise (2-3 phrases maximum).

${context != null ? 'Contexte: $context\n' : ''}
Message de l'utilisateur: $userMessage

Réponds comme un assistant de productivité bienveillant.
''';

    final response = await _makeRequest(prompt);
    return _extractText(response);
  }
}

// Extension pour exposer les méthodes privées si nécessaire
extension AIServiceExtension on AIService {
  Future<Map<String, dynamic>?> makeRequest(String prompt) async {
    return await _makeRequest(prompt);
  }
  
  String? extractText(Map<String, dynamic>? response) {
    return _extractText(response);
  }
}

