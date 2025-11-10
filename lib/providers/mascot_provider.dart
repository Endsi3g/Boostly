/**
 * BOOSTLY - Provider Mascotte
 * 
 * Gère l'état de la mascotte interactive.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/foundation.dart';
import '../models/mascot.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/ai_service.dart';

/// Provider pour gérer la mascotte
class MascotProvider extends ChangeNotifier {
  AuthService? _authService;
  FirestoreService? _firestoreService;
  AIService? _aiService;
  
  Mascot? _mascot;
  String? _currentMessage;
  bool _isLoading = false;

  Mascot? get mascot => _mascot;
  String? get currentMessage => _currentMessage;
  bool get isLoading => _isLoading;

  /// Définit le service d'authentification
  void setAuthService(AuthService authService) {
    _authService = authService;
    _firestoreService = FirestoreService();
    _aiService = AIService();
    if (_authService!.isAuthenticated) {
      _loadMascot();
    }
  }

  /// Charge la mascotte de l'utilisateur
  Future<void> _loadMascot() async {
    if (_authService?.currentFirebaseUser == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final userId = _authService!.currentFirebaseUser!.uid;
      _mascot = await _firestoreService!.getMascot(userId);

      // Créer une mascotte si elle n'existe pas
      if (_mascot == null) {
        _mascot = Mascot(
          id: userId,
          userId: userId,
          lastInteraction: DateTime.now(),
        );
        await _firestoreService!.saveMascot(_mascot!);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du chargement de la mascotte: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Met à jour la mascotte
  Future<void> updateMascot(Mascot mascot) async {
    try {
      await _firestoreService!.saveMascot(mascot);
      _mascot = mascot;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour de la mascotte: $e');
    }
  }

  /// Génère un message d'encouragement
  Future<void> generateEncouragement({
    required int tasksCompletedToday,
    required int currentStreak,
    required int level,
    String? lastAchievement,
  }) async {
    if (_aiService == null) return;

    try {
      _currentMessage = await _aiService!.generateEncouragementMessage(
        tasksCompletedToday: tasksCompletedToday,
        currentStreak: currentStreak,
        level: level,
        lastAchievement: lastAchievement,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la génération du message: $e');
      _currentMessage = 'Continue comme ça ! 💪';
      notifyListeners();
    }
  }

  /// Change l'humeur de la mascotte
  Future<void> updateMood(String mood) async {
    if (_mascot == null) return;

    final updatedMascot = _mascot!.copyWith(
      currentMood: mood,
      lastInteraction: DateTime.now(),
    );

    await updateMascot(updatedMascot);
  }

  /// Débloque un accessoire
  Future<void> unlockAccessory(String accessoryId) async {
    if (_mascot == null) return;

    if (!_mascot!.unlockedAccessories.contains(accessoryId)) {
      final updatedAccessories = [..._mascot!.unlockedAccessories, accessoryId];
      final updatedMascot = _mascot!.copyWith(
        unlockedAccessories: updatedAccessories,
      );
      await updateMascot(updatedMascot);
    }
  }

  /// Équipe un accessoire
  Future<void> equipAccessory(String? accessoryId) async {
    if (_mascot == null) return;

    final updatedMascot = _mascot!.copyWith(
      currentAccessory: accessoryId,
    );
    await updateMascot(updatedMascot);
  }

  /// Met à jour le niveau de la mascotte basé sur le niveau utilisateur
  Future<void> updateLevel(int userLevel) async {
    if (_mascot == null) return;

    final evolutionStage = _mascot!.calculateEvolutionStage(userLevel);
    final updatedMascot = _mascot!.copyWith(
      level: userLevel,
      evolutionStage: evolutionStage,
    );
    await updateMascot(updatedMascot);
  }

  /// Rafraîchit la mascotte
  Future<void> refresh() async {
    await _loadMascot();
  }
}

