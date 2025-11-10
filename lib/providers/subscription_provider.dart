/**
 * BOOSTLY - Provider Abonnement
 * 
 * Gère les abonnements Premium et l'intégration Stripe.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 * 
 * Modèle Freemium:
 * - Free Tier: Fonctionnalités de base
 * - Premium: $4.99/mois avec 7 jours d'essai gratuit
 */

import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

/// Provider pour gérer les abonnements
class SubscriptionProvider extends ChangeNotifier {
  FirestoreService? _firestoreService;
  SubscriptionInfo? _subscription;
  bool _isLoading = false;

  SubscriptionInfo? get subscription => _subscription;
  bool get isLoading => _isLoading;
  bool get isPremium => _subscription?.isActive ?? false;
  bool get isInTrial => _subscription?.isInTrial ?? false;
  int? get trialDaysRemaining => _subscription?.trialDaysRemaining;

  /// Initialise le provider avec le service Firestore
  void initialize(FirestoreService firestoreService) {
    _firestoreService = firestoreService;
  }

  /// Charge les informations d'abonnement
  Future<void> loadSubscription(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = await _firestoreService?.getUser(userId);
      _subscription = user?.subscription;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du chargement de l\'abonnement: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Démarre l'essai gratuit Premium
  Future<bool> startTrial(String userId) async {
    try {
      final now = DateTime.now();
      final trialEnd = now.add(Duration(days: AppConstants.premiumTrialDays));

      final trialSubscription = SubscriptionInfo(
        tier: 'premium',
        isActive: true,
        trialStartDate: now,
        trialEndDate: trialEnd,
      );

      await _updateUserSubscription(userId, trialSubscription);
      return true;
    } catch (e) {
      debugPrint('Erreur lors du démarrage de l\'essai: $e');
      return false;
    }
  }

  /// Active l'abonnement Premium
  Future<bool> activatePremium(String userId, {
    required String stripeSubscriptionId,
    required String stripeCustomerId,
  }) async {
    try {
      final now = DateTime.now();
      final subscriptionEnd = now.add(Duration(days: 30)); // 1 mois

      final premiumSubscription = SubscriptionInfo(
        tier: 'premium',
        isActive: true,
        subscriptionStartDate: now,
        subscriptionEndDate: subscriptionEnd,
        stripeSubscriptionId: stripeSubscriptionId,
        stripeCustomerId: stripeCustomerId,
      );

      await _updateUserSubscription(userId, premiumSubscription);
      return true;
    } catch (e) {
      debugPrint('Erreur lors de l\'activation du Premium: $e');
      return false;
    }
  }

  /// Annule l'abonnement Premium
  Future<bool> cancelSubscription(String userId) async {
    try {
      final cancelledSubscription = SubscriptionInfo(
        tier: 'free',
        isActive: false,
      );

      await _updateUserSubscription(userId, cancelledSubscription);
      return true;
    } catch (e) {
      debugPrint('Erreur lors de l\'annulation: $e');
      return false;
    }
  }

  /// Met à jour l'abonnement de l'utilisateur
  Future<void> _updateUserSubscription(
    String userId,
    SubscriptionInfo subscription,
  ) async {
    final user = await _firestoreService?.getUser(userId);
    if (user == null) return;

    final updatedUser = user.copyWith(subscription: subscription);
    await _firestoreService?.updateUser(updatedUser);
    _subscription = subscription;
    notifyListeners();
  }
}

