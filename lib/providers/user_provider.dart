/**
 * BOOSTLY - Provider Utilisateur
 * 
 * Gère l'état de l'utilisateur actuel et ses données.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

/// Provider pour gérer l'état de l'utilisateur
class UserProvider extends ChangeNotifier {
  AuthService? _authService;
  FirestoreService? _firestoreService;
  BoostlyUser? _user;
  bool _isLoading = false;

  BoostlyUser? get user => _user;
  bool get isLoading => _isLoading;
  bool get isPremium => _user?.isPremium ?? false;

  /// Définit le service d'authentification
  void setAuthService(AuthService authService) {
    _authService = authService;
    _authService!.addListener(_onAuthChanged);
    _loadUser();
  }

  /// Écoute les changements d'authentification
  void _onAuthChanged() {
    if (_authService!.isAuthenticated) {
      _loadUser();
    } else {
      _user = null;
      notifyListeners();
    }
  }

  /// Charge les données utilisateur
  Future<void> _loadUser() async {
    if (_authService?.currentFirebaseUser == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      _firestoreService ??= FirestoreService();
      _user = await _firestoreService!.getUser(_authService!.currentFirebaseUser!.uid);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du chargement de l\'utilisateur: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Met à jour les préférences utilisateur
  Future<void> updatePreferences(UserPreferences preferences) async {
    if (_user == null) return;

    try {
      final updatedUser = _user!.copyWith(preferences: preferences);
      await _firestoreService!.updateUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour des préférences: $e');
    }
  }

  /// Met à jour les statistiques utilisateur
  Future<void> updateStats(UserStats stats) async {
    if (_user == null) return;

    try {
      final updatedUser = _user!.copyWith(stats: stats);
      await _firestoreService!.updateUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour des stats: $e');
    }
  }

  /// Rafraîchit les données utilisateur
  Future<void> refresh() async {
    await _loadUser();
  }
}

