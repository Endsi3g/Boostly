/**
 * BOOSTLY - Provider Gamification
 * 
 * Gère le système de gamification: XP, niveaux, badges, streaks.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/achievement.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

/// Provider pour gérer la gamification
class GamificationProvider extends ChangeNotifier {
  AuthService? _authService;
  FirestoreService? _firestoreService;
  
  List<Achievement> _achievements = [];
  bool _isLoading = false;

  List<Achievement> get achievements => _achievements;
  List<Achievement> get unlockedAchievements => 
      _achievements.where((a) => a.isUnlocked).toList();
  bool get isLoading => _isLoading;

  /// Définit le service d'authentification
  void setAuthService(AuthService authService) {
    _authService = authService;
    _firestoreService = FirestoreService();
    if (_authService!.isAuthenticated) {
      _loadAchievements();
    }
  }

  /// Charge tous les achievements de l'utilisateur
  Future<void> _loadAchievements() async {
    if (_authService?.currentFirebaseUser == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final userId = _authService!.currentFirebaseUser!.uid;
      _achievements = await _firestoreService!.getUserAchievements(userId);

      // Ajouter les achievements prédéfinis non débloqués
      final predefined = PredefinedAchievements.all;
      for (final achievement in predefined) {
        if (!_achievements.any((a) => a.id == achievement.id)) {
          _achievements.add(achievement);
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du chargement des achievements: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Ajoute de l'XP à l'utilisateur
  Future<void> addXp(int xp, {String? source}) async {
    if (_authService?.currentFirebaseUser == null) return;

    try {
      final userId = _authService!.currentFirebaseUser!.uid;
      final user = await _firestoreService!.getUser(userId);
      if (user == null) return;

      final newXp = user.stats.totalXp + xp;
      final newLevel = _calculateLevel(newXp);
      
      final updatedStats = user.stats.copyWith(
        totalXp: newXp,
        level: newLevel,
      );

      await _firestoreService!.updateUser(user.copyWith(stats: updatedStats));

      // Vérifier les achievements
      await _checkAchievements(updatedStats);

      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de l\'ajout d\'XP: $e');
    }
  }

  /// Calcule le niveau basé sur l'XP total
  int _calculateLevel(int totalXp) {
    // Formule: niveau = sqrt(XP / 100) + 1
    final level = sqrt(totalXp / 100).floor() + 1;
    return level.clamp(1, AppConstants.maxLevel);
  }

  /// Vérifie et débloque les achievements
  Future<void> _checkAchievements(UserStats stats) async {
    if (_authService?.currentFirebaseUser == null) return;

    final userId = _authService!.currentFirebaseUser!.uid;

    for (final achievement in PredefinedAchievements.all) {
      if (_achievements.any((a) => a.id == achievement.id && a.isUnlocked)) {
        continue; // Déjà débloqué
      }

      bool shouldUnlock = false;

      switch (achievement.category) {
        case 'task':
          final requiredTasks = achievement.requirements['tasksCompleted'] as int?;
          if (requiredTasks != null && stats.totalTasksCompleted >= requiredTasks) {
            shouldUnlock = true;
          }
          break;
        case 'streak':
          final requiredStreak = achievement.requirements['streak'] as int?;
          if (requiredStreak != null && stats.currentStreak >= requiredStreak) {
            shouldUnlock = true;
          }
          break;
        case 'level':
          final requiredLevel = achievement.requirements['level'] as int?;
          if (requiredLevel != null && stats.level >= requiredLevel) {
            shouldUnlock = true;
          }
          break;
      }

      if (shouldUnlock) {
        await unlockAchievement(userId, achievement);
      }
    }
  }

  /// Débloque un achievement
  Future<void> unlockAchievement(String userId, Achievement achievement) async {
    try {
      final unlockedAchievement = achievement.copyWith(
        isUnlocked: true,
        unlockedAt: DateTime.now(),
      );

      await _firestoreService!.unlockAchievement(userId, unlockedAchievement);

      final index = _achievements.indexWhere((a) => a.id == achievement.id);
      if (index != -1) {
        _achievements[index] = unlockedAchievement;
      } else {
        _achievements.add(unlockedAchievement);
      }

      // Ajouter l'XP de récompense
      await addXp(achievement.xpReward, source: 'achievement');

      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du déblocage de l\'achievement: $e');
    }
  }

  /// Met à jour le streak
  Future<void> updateStreak(int newStreak) async {
    if (_authService?.currentFirebaseUser == null) return;

    try {
      final userId = _authService!.currentFirebaseUser!.uid;
      final user = await _firestoreService!.getUser(userId);
      if (user == null) return;

      final updatedStats = user.stats.copyWith(
        currentStreak: newStreak,
        longestStreak: newStreak > user.stats.longestStreak 
            ? newStreak 
            : user.stats.longestStreak,
      );

      await _firestoreService!.updateUser(user.copyWith(stats: updatedStats));

      // Vérifier les achievements de streak
      await _checkAchievements(updatedStats);

      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour du streak: $e');
    }
  }

  /// Rafraîchit les achievements
  Future<void> refresh() async {
    await _loadAchievements();
  }
}

