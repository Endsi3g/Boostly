/**
 * BOOSTLY - Modèle Achievement/Badge
 * 
 * Représente un badge/achievement dans le système de gamification.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:cloud_firestore/cloud_firestore.dart';

/// Modèle de données pour un achievement/badge
class Achievement {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final String category; // 'task', 'streak', 'level', 'special'
  final int xpReward;
  final Map<String, dynamic> requirements;
  final String rarity; // 'common', 'rare', 'epic', 'legendary'
  final DateTime? unlockedAt;
  final bool isUnlocked;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.category,
    this.xpReward = 50,
    this.requirements = const {},
    this.rarity = 'common',
    this.unlockedAt,
    this.isUnlocked = false,
  });

  /// Crée un achievement depuis un document Firestore
  factory Achievement.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Achievement(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      iconUrl: data['iconUrl'] ?? '',
      category: data['category'] ?? 'task',
      xpReward: data['xpReward'] ?? 50,
      requirements: Map<String, dynamic>.from(data['requirements'] ?? {}),
      rarity: data['rarity'] ?? 'common',
      unlockedAt: (data['unlockedAt'] as Timestamp?)?.toDate(),
      isUnlocked: data['isUnlocked'] ?? false,
    );
  }

  /// Convertit l'achievement en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'category': category,
      'xpReward': xpReward,
      'requirements': requirements,
      'rarity': rarity,
      'unlockedAt': unlockedAt != null ? Timestamp.fromDate(unlockedAt!) : null,
      'isUnlocked': isUnlocked,
    };
  }

  /// Crée une copie de l'achievement avec des modifications
  Achievement copyWith({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    String? category,
    int? xpReward,
    Map<String, dynamic>? requirements,
    String? rarity,
    DateTime? unlockedAt,
    bool? isUnlocked,
  }) {
    return Achievement(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      category: category ?? this.category,
      xpReward: xpReward ?? this.xpReward,
      requirements: requirements ?? this.requirements,
      rarity: rarity ?? this.rarity,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  /// Couleur selon la rareté
  String get rarityColor {
    switch (rarity) {
      case 'common':
        return '#8B7DBC'; // Violet
      case 'rare':
        return '#4ECDC4'; // Turquoise
      case 'epic':
        return '#FFB84C'; // Orange
      case 'legendary':
        return '#FF6B6B'; // Rouge
      default:
        return '#8B7DBC';
    }
  }

  @override
  String toString() {
    return 'Achievement(id: $id, name: $name, rarity: $rarity, unlocked: $isUnlocked)';
  }
}

/// Liste des achievements prédéfinis pour le MVP
class PredefinedAchievements {
  static List<Achievement> get all => [
    // Achievements de tâches
    Achievement(
      id: 'first_task',
      name: 'Premier Pas',
      description: 'Complétez votre première tâche',
      iconUrl: 'assets/icons/achievements/first_task.svg',
      category: 'task',
      xpReward: 50,
      requirements: {'tasksCompleted': 1},
      rarity: 'common',
    ),
    Achievement(
      id: 'task_master_10',
      name: 'Maître des Tâches',
      description: 'Complétez 10 tâches',
      iconUrl: 'assets/icons/achievements/task_master_10.svg',
      category: 'task',
      xpReward: 100,
      requirements: {'tasksCompleted': 10},
      rarity: 'common',
    ),
    Achievement(
      id: 'task_master_50',
      name: 'Expert des Tâches',
      description: 'Complétez 50 tâches',
      iconUrl: 'assets/icons/achievements/task_master_50.svg',
      category: 'task',
      xpReward: 200,
      requirements: {'tasksCompleted': 50},
      rarity: 'rare',
    ),
    Achievement(
      id: 'task_master_100',
      name: 'Légende des Tâches',
      description: 'Complétez 100 tâches',
      iconUrl: 'assets/icons/achievements/task_master_100.svg',
      category: 'task',
      xpReward: 500,
      requirements: {'tasksCompleted': 100},
      rarity: 'epic',
    ),
    
    // Achievements de streak
    Achievement(
      id: 'streak_3',
      name: 'En Forme',
      description: 'Maintenez un streak de 3 jours',
      iconUrl: 'assets/icons/achievements/streak_3.svg',
      category: 'streak',
      xpReward: 75,
      requirements: {'streak': 3},
      rarity: 'common',
    ),
    Achievement(
      id: 'streak_7',
      name: 'Semaine Parfaite',
      description: 'Maintenez un streak de 7 jours',
      iconUrl: 'assets/icons/achievements/streak_7.svg',
      category: 'streak',
      xpReward: 150,
      requirements: {'streak': 7},
      rarity: 'rare',
    ),
    Achievement(
      id: 'streak_30',
      name: 'Mois de Fer',
      description: 'Maintenez un streak de 30 jours',
      iconUrl: 'assets/icons/achievements/streak_30.svg',
      category: 'streak',
      xpReward: 500,
      requirements: {'streak': 30},
      rarity: 'epic',
    ),
    Achievement(
      id: 'streak_100',
      name: 'Légende du Streak',
      description: 'Maintenez un streak de 100 jours',
      iconUrl: 'assets/icons/achievements/streak_100.svg',
      category: 'streak',
      xpReward: 1000,
      requirements: {'streak': 100},
      rarity: 'legendary',
    ),
    
    // Achievements de niveau
    Achievement(
      id: 'level_5',
      name: 'Niveau 5',
      description: 'Atteignez le niveau 5',
      iconUrl: 'assets/icons/achievements/level_5.svg',
      category: 'level',
      xpReward: 100,
      requirements: {'level': 5},
      rarity: 'common',
    ),
    Achievement(
      id: 'level_10',
      name: 'Niveau 10',
      description: 'Atteignez le niveau 10',
      iconUrl: 'assets/icons/achievements/level_10.svg',
      category: 'level',
      xpReward: 250,
      requirements: {'level': 10},
      rarity: 'rare',
    ),
    Achievement(
      id: 'level_20',
      name: 'Niveau Maximum',
      description: 'Atteignez le niveau 20',
      iconUrl: 'assets/icons/achievements/level_20.svg',
      category: 'level',
      xpReward: 1000,
      requirements: {'level': 20},
      rarity: 'legendary',
    ),
  ];
}

