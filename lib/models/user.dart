/**
 * BOOSTLY - Modèle Utilisateur
 * 
 * Représente un utilisateur dans l'application avec son profil,
 * statistiques de gamification et préférences.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:cloud_firestore/cloud_firestore.dart';

/// Modèle de données pour un utilisateur
class BoostlyUser {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final UserStats stats;
  final UserPreferences preferences;
  final SubscriptionInfo subscription;
  final Map<String, dynamic>? metadata;

  BoostlyUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.createdAt,
    this.lastLoginAt,
    required this.stats,
    required this.preferences,
    required this.subscription,
    this.metadata,
  });

  /// Crée un utilisateur depuis un document Firestore
  factory BoostlyUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BoostlyUser(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoUrl: data['photoUrl'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp?)?.toDate(),
      stats: UserStats.fromMap(data['stats'] ?? {}),
      preferences: UserPreferences.fromMap(data['preferences'] ?? {}),
      subscription: SubscriptionInfo.fromMap(data['subscription'] ?? {}),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convertit l'utilisateur en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLoginAt': lastLoginAt != null ? Timestamp.fromDate(lastLoginAt!) : null,
      'stats': stats.toMap(),
      'preferences': preferences.toMap(),
      'subscription': subscription.toMap(),
      'metadata': metadata,
    };
  }

  /// Crée une copie de l'utilisateur avec des modifications
  BoostlyUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    UserStats? stats,
    UserPreferences? preferences,
    SubscriptionInfo? subscription,
    Map<String, dynamic>? metadata,
  }) {
    return BoostlyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      stats: stats ?? this.stats,
      preferences: preferences ?? this.preferences,
      subscription: subscription ?? this.subscription,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Vérifie si l'utilisateur a un abonnement Premium actif
  bool get isPremium => subscription.isActive;

  @override
  String toString() {
    return 'BoostlyUser(id: $id, email: $email, level: ${stats.level})';
  }
}

/// Statistiques de l'utilisateur (gamification)
class UserStats {
  final int totalXp;
  final int level;
  final int totalTasksCompleted;
  final int currentStreak;
  final int longestStreak;
  final int totalBadges;
  final DateTime? lastActivityDate;
  final Map<String, int> categoryStats;

  UserStats({
    this.totalXp = 0,
    this.level = 1,
    this.totalTasksCompleted = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalBadges = 0,
    this.lastActivityDate,
    this.categoryStats = const {},
  });

  factory UserStats.fromMap(Map<String, dynamic> map) {
    return UserStats(
      totalXp: map['totalXp'] ?? 0,
      level: map['level'] ?? 1,
      totalTasksCompleted: map['totalTasksCompleted'] ?? 0,
      currentStreak: map['currentStreak'] ?? 0,
      longestStreak: map['longestStreak'] ?? 0,
      totalBadges: map['totalBadges'] ?? 0,
      lastActivityDate: (map['lastActivityDate'] as Timestamp?)?.toDate(),
      categoryStats: Map<String, int>.from(map['categoryStats'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalXp': totalXp,
      'level': level,
      'totalTasksCompleted': totalTasksCompleted,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalBadges': totalBadges,
      'lastActivityDate': lastActivityDate != null
          ? Timestamp.fromDate(lastActivityDate!)
          : null,
      'categoryStats': categoryStats,
    };
  }

  /// Crée une copie des stats avec des modifications
  UserStats copyWith({
    int? totalXp,
    int? level,
    int? totalTasksCompleted,
    int? currentStreak,
    int? longestStreak,
    int? totalBadges,
    DateTime? lastActivityDate,
    Map<String, int>? categoryStats,
  }) {
    return UserStats(
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      totalTasksCompleted: totalTasksCompleted ?? this.totalTasksCompleted,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalBadges: totalBadges ?? this.totalBadges,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      categoryStats: categoryStats ?? this.categoryStats,
    );
  }

  /// XP nécessaire pour le prochain niveau
  int get xpForNextLevel {
    // Formule: niveau * 100 XP par niveau
    return level * 100;
  }

  /// XP restant pour le prochain niveau
  int get xpRemaining {
    return (xpForNextLevel - totalXp).clamp(0, xpForNextLevel);
  }

  /// Pourcentage de progression vers le prochain niveau
  double get levelProgress {
    if (xpForNextLevel == 0) return 0.0;
    final previousLevelXp = (level - 1) * 100;
    final currentLevelXp = totalXp - previousLevelXp;
    return (currentLevelXp / 100).clamp(0.0, 1.0);
  }
}

/// Préférences utilisateur
class UserPreferences {
  final bool darkMode;
  final String language;
  final bool notificationsEnabled;
  final bool biometricAuthEnabled;
  final List<String> favoriteCategories;
  final Map<String, dynamic>? customSettings;

  UserPreferences({
    this.darkMode = false,
    this.language = 'fr',
    this.notificationsEnabled = true,
    this.biometricAuthEnabled = false,
    this.favoriteCategories = const [],
    this.customSettings,
  });

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      darkMode: map['darkMode'] ?? false,
      language: map['language'] ?? 'fr',
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      biometricAuthEnabled: map['biometricAuthEnabled'] ?? false,
      favoriteCategories: List<String>.from(map['favoriteCategories'] ?? []),
      customSettings: map['customSettings'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'darkMode': darkMode,
      'language': language,
      'notificationsEnabled': notificationsEnabled,
      'biometricAuthEnabled': biometricAuthEnabled,
      'favoriteCategories': favoriteCategories,
      'customSettings': customSettings,
    };
  }
}

/// Informations d'abonnement
class SubscriptionInfo {
  final String tier; // 'free' ou 'premium'
  final bool isActive;
  final DateTime? trialStartDate;
  final DateTime? trialEndDate;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final String? stripeSubscriptionId;
  final String? stripeCustomerId;

  SubscriptionInfo({
    this.tier = 'free',
    this.isActive = false,
    this.trialStartDate,
    this.trialEndDate,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.stripeSubscriptionId,
    this.stripeCustomerId,
  });

  factory SubscriptionInfo.fromMap(Map<String, dynamic> map) {
    return SubscriptionInfo(
      tier: map['tier'] ?? 'free',
      isActive: map['isActive'] ?? false,
      trialStartDate: (map['trialStartDate'] as Timestamp?)?.toDate(),
      trialEndDate: (map['trialEndDate'] as Timestamp?)?.toDate(),
      subscriptionStartDate: (map['subscriptionStartDate'] as Timestamp?)?.toDate(),
      subscriptionEndDate: (map['subscriptionEndDate'] as Timestamp?)?.toDate(),
      stripeSubscriptionId: map['stripeSubscriptionId'],
      stripeCustomerId: map['stripeCustomerId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tier': tier,
      'isActive': isActive,
      'trialStartDate': trialStartDate != null
          ? Timestamp.fromDate(trialStartDate!)
          : null,
      'trialEndDate': trialEndDate != null
          ? Timestamp.fromDate(trialEndDate!)
          : null,
      'subscriptionStartDate': subscriptionStartDate != null
          ? Timestamp.fromDate(subscriptionStartDate!)
          : null,
      'subscriptionEndDate': subscriptionEndDate != null
          ? Timestamp.fromDate(subscriptionEndDate!)
          : null,
      'stripeSubscriptionId': stripeSubscriptionId,
      'stripeCustomerId': stripeCustomerId,
    };
  }

  /// Vérifie si l'utilisateur est en période d'essai
  bool get isInTrial {
    if (trialStartDate == null || trialEndDate == null) return false;
    final now = DateTime.now();
    return now.isAfter(trialStartDate!) && now.isBefore(trialEndDate!);
  }

  /// Jours restants dans l'essai
  int? get trialDaysRemaining {
    if (!isInTrial || trialEndDate == null) return null;
    return trialEndDate!.difference(DateTime.now()).inDays;
  }

  /// Crée une copie avec des modifications
  SubscriptionInfo copyWith({
    String? tier,
    bool? isActive,
    DateTime? trialStartDate,
    DateTime? trialEndDate,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    String? stripeSubscriptionId,
    String? stripeCustomerId,
  }) {
    return SubscriptionInfo(
      tier: tier ?? this.tier,
      isActive: isActive ?? this.isActive,
      trialStartDate: trialStartDate ?? this.trialStartDate,
      trialEndDate: trialEndDate ?? this.trialEndDate,
      subscriptionStartDate: subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
    );
  }
}

