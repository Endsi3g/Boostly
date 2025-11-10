/**
 * BOOSTLY - Service Firestore
 * 
 * Gère toutes les opérations de base de données Firestore.
 * Utilise le tier gratuit de Firebase (1GB, 50K reads/writes/jour).
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 * 
 * Collections Firestore:
 * - users: Profils utilisateurs
 * - tasks: Tâches des utilisateurs
 * - achievements: Badges et achievements
 * - mascots: Données des mascottes
 * - resources: Bibliothèque de ressources
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/task.dart';
import '../models/achievement.dart';
import '../models/mascot.dart';

/// Service Firestore pour toutes les opérations de base de données
class FirestoreService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== USERS ====================

  /// Crée un nouvel utilisateur dans Firestore
  Future<void> createUser(BoostlyUser user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toFirestore());
    } catch (e) {
      debugPrint('Erreur lors de la création de l\'utilisateur: $e');
      rethrow;
    }
  }

  /// Récupère un utilisateur par son ID
  Future<BoostlyUser?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return BoostlyUser.fromFirestore(doc);
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'utilisateur: $e');
      return null;
    }
  }

  /// Met à jour un utilisateur
  Future<void> updateUser(BoostlyUser user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toFirestore());
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour de l\'utilisateur: $e');
      rethrow;
    }
  }

  /// Met à jour la date de dernière connexion
  Future<void> updateUserLastLogin(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour de la dernière connexion: $e');
    }
  }

  /// Stream des données utilisateur en temps réel
  Stream<BoostlyUser?> streamUser(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? BoostlyUser.fromFirestore(doc) : null);
  }

  // ==================== TASKS ====================

  /// Crée une nouvelle tâche
  Future<String> createTask(Task task) async {
    try {
      final docRef = await _firestore.collection('tasks').add(task.toFirestore());
      return docRef.id;
    } catch (e) {
      debugPrint('Erreur lors de la création de la tâche: $e');
      rethrow;
    }
  }

  /// Récupère une tâche par son ID
  Future<Task?> getTask(String taskId) async {
    try {
      final doc = await _firestore.collection('tasks').doc(taskId).get();
      if (!doc.exists) return null;
      return Task.fromFirestore(doc);
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la tâche: $e');
      return null;
    }
  }

  /// Met à jour une tâche
  Future<void> updateTask(Task task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).update(task.toFirestore());
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour de la tâche: $e');
      rethrow;
    }
  }

  /// Supprime une tâche
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      debugPrint('Erreur lors de la suppression de la tâche: $e');
      rethrow;
    }
  }

  /// Récupère toutes les tâches d'un utilisateur
  Future<List<Task>> getUserTasks(String userId, {String? status}) async {
    try {
      Query query = _firestore
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true);

      if (status != null) {
        query = query.where('status', isEqualTo: status);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des tâches: $e');
      return [];
    }
  }

  /// Stream des tâches d'un utilisateur en temps réel
  Stream<List<Task>> streamUserTasks(String userId, {String? status}) {
    Query query = _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true);

    if (status != null) {
      query = query.where('status', isEqualTo: status);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }

  // ==================== ACHIEVEMENTS ====================

  /// Récupère tous les achievements d'un utilisateur
  Future<List<Achievement>> getUserAchievements(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('achievements')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) => Achievement.fromFirestore(doc)).toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des achievements: $e');
      return [];
    }
  }

  /// Débloque un achievement pour un utilisateur
  Future<void> unlockAchievement(String userId, Achievement achievement) async {
    try {
      final unlockedAchievement = achievement.copyWith(
        isUnlocked: true,
        unlockedAt: DateTime.now(),
      );
      await _firestore
          .collection('achievements')
          .doc('${userId}_${achievement.id}')
          .set(unlockedAchievement.toFirestore());
    } catch (e) {
      debugPrint('Erreur lors du déblocage de l\'achievement: $e');
      rethrow;
    }
  }

  // ==================== MASCOT ====================

  /// Récupère la mascotte d'un utilisateur
  Future<Mascot?> getMascot(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('mascots')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      
      if (snapshot.docs.isEmpty) return null;
      return Mascot.fromFirestore(snapshot.docs.first);
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la mascotte: $e');
      return null;
    }
  }

  /// Crée ou met à jour la mascotte d'un utilisateur
  Future<void> saveMascot(Mascot mascot) async {
    try {
      await _firestore.collection('mascots').doc(mascot.id).set(mascot.toFirestore());
    } catch (e) {
      debugPrint('Erreur lors de la sauvegarde de la mascotte: $e');
      rethrow;
    }
  }

  /// Stream de la mascotte en temps réel
  Stream<Mascot?> streamMascot(String userId) {
    return _firestore
        .collection('mascots')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.isEmpty
            ? null
            : Mascot.fromFirestore(snapshot.docs.first));
  }
}

