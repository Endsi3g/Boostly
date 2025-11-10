/**
 * BOOSTLY - Service Stripe
 * 
 * Gère les paiements et abonnements Premium via Stripe.
 * Mode sandbox pour MVP, puis production.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 * 
 * Fonctionnalités:
 * - Essai gratuit de 7 jours
 * - Abonnement mensuel $4.99
 * - Abonnement annuel $39.99
 * - Gestion des webhooks
 */

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/foundation.dart';
import '../config/stripe_config.dart';
import '../utils/constants.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

/// Service Stripe pour la monétisation
class StripeService {
  static final StripeService instance = StripeService._internal();
  factory StripeService() => instance;
  StripeService._internal();

  final FirestoreService _firestoreService = FirestoreService();
  bool _isInitialized = false;

  /// Initialise Stripe
  Future<void> initialize() async {
    if (_isInitialized) return;

    Stripe.publishableKey = StripeConfig.publishableKey;
    Stripe.merchantIdentifier = StripeConfig.merchantIdentifier;
    
    await Stripe.instance.applySettings();
    _isInitialized = true;
  }

  /// Crée un client Stripe pour l'utilisateur
  Future<String?> createCustomer(String userId, String email) async {
    try {
      // TODO: Appeler votre backend pour créer un customer Stripe
      // Pour MVP, on simule la création
      return 'cus_${userId.substring(0, 10)}';
    } catch (e) {
      debugPrint('Erreur lors de la création du customer Stripe: $e');
      return null;
    }
  }

  /// Démarre l'essai gratuit Premium
  Future<bool> startFreeTrial(String userId) async {
    try {
      final user = await _firestoreService.getUser(userId);
      if (user == null) return false;

      final now = DateTime.now();
      final trialEnd = now.add(Duration(days: AppConstants.premiumTrialDays));

      final trialSubscription = SubscriptionInfo(
        tier: 'premium',
        isActive: true,
        trialStartDate: now,
        trialEndDate: trialEnd,
      );

      final updatedUser = user.copyWith(subscription: trialSubscription);
      await _firestoreService.updateUser(updatedUser);

      return true;
    } catch (e) {
      debugPrint('Erreur lors du démarrage de l\'essai gratuit: $e');
      return false;
    }
  }

  /// Crée un PaymentIntent pour l'abonnement
  Future<PaymentIntent?> createSubscriptionPayment({
    required String customerId,
    required String priceId,
  }) async {
    try {
      // TODO: Appeler votre backend pour créer le PaymentIntent
      // Pour MVP, on simule
      return null;
    } catch (e) {
      debugPrint('Erreur lors de la création du PaymentIntent: $e');
      return null;
    }
  }

  /// Confirme le paiement
  Future<bool> confirmPayment(String paymentIntentId) async {
    try {
      // TODO: Confirmer le paiement via Stripe
      return true;
    } catch (e) {
      debugPrint('Erreur lors de la confirmation du paiement: $e');
      return false;
    }
  }

  /// Annule l'abonnement
  Future<bool> cancelSubscription(String userId, String subscriptionId) async {
    try {
      final user = await _firestoreService.getUser(userId);
      if (user == null) return false;

      final cancelledSubscription = SubscriptionInfo(
        tier: 'free',
        isActive: false,
      );

      final updatedUser = user.copyWith(subscription: cancelledSubscription);
      await _firestoreService.updateUser(updatedUser);

      return true;
    } catch (e) {
      debugPrint('Erreur lors de l\'annulation: $e');
      return false;
    }
  }

  /// Vérifie le statut de l'abonnement
  Future<bool> checkSubscriptionStatus(String userId) async {
    try {
      final user = await _firestoreService.getUser(userId);
      if (user == null) return false;

      final subscription = user.subscription;
      
      // Vérifier si l'essai est expiré
      if (subscription.isInTrial && subscription.trialEndDate != null) {
        if (DateTime.now().isAfter(subscription.trialEndDate!)) {
          // Essai expiré, désactiver Premium
          final updatedSubscription = subscription.copyWith(
            tier: 'free',
            isActive: false,
          );
          final updatedUser = user.copyWith(subscription: updatedSubscription);
          await _firestoreService.updateUser(updatedUser);
          return false;
        }
      }

      // Vérifier si l'abonnement est expiré
      if (subscription.subscriptionEndDate != null) {
        if (DateTime.now().isAfter(subscription.subscriptionEndDate!)) {
          final updatedSubscription = subscription.copyWith(
            tier: 'free',
            isActive: false,
          );
          final updatedUser = user.copyWith(subscription: updatedSubscription);
          await _firestoreService.updateUser(updatedUser);
          return false;
        }
      }

      return subscription.isActive;
    } catch (e) {
      debugPrint('Erreur lors de la vérification du statut: $e');
      return false;
    }
  }
}

