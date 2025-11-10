/**
 * BOOSTLY - Modèle Mascotte
 * 
 * Représente la mascotte interactive avec ses états, accessoires et animations.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:cloud_firestore/cloud_firestore.dart';

/// Modèle de données pour la mascotte
class Mascot {
  final String id;
  final String userId;
  final String name;
  final int level;
  final int evolutionStage; // 1-5
  final String currentMood; // 'happy', 'excited', 'proud', 'encouraging', 'sleepy'
  final List<String> unlockedAccessories;
  final String? currentAccessory;
  final Map<String, int> stats; // interactions, encouragements, etc.
  final DateTime lastInteraction;
  final Map<String, dynamic>? metadata;

  Mascot({
    required this.id,
    required this.userId,
    this.name = 'Boosty',
    this.level = 1,
    this.evolutionStage = 1,
    this.currentMood = 'happy',
    this.unlockedAccessories = const [],
    this.currentAccessory,
    this.stats = const {},
    required this.lastInteraction,
    this.metadata,
  });

  /// Crée une mascotte depuis un document Firestore
  factory Mascot.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Mascot(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? 'Boosty',
      level: data['level'] ?? 1,
      evolutionStage: data['evolutionStage'] ?? 1,
      currentMood: data['currentMood'] ?? 'happy',
      unlockedAccessories: List<String>.from(data['unlockedAccessories'] ?? []),
      currentAccessory: data['currentAccessory'],
      stats: Map<String, int>.from(data['stats'] ?? {}),
      lastInteraction: (data['lastInteraction'] as Timestamp?)?.toDate() ?? DateTime.now(),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convertit la mascotte en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'level': level,
      'evolutionStage': evolutionStage,
      'currentMood': currentMood,
      'unlockedAccessories': unlockedAccessories,
      'currentAccessory': currentAccessory,
      'stats': stats,
      'lastInteraction': Timestamp.fromDate(lastInteraction),
      'metadata': metadata,
    };
  }

  /// Crée une copie de la mascotte avec des modifications
  Mascot copyWith({
    String? id,
    String? userId,
    String? name,
    int? level,
    int? evolutionStage,
    String? currentMood,
    List<String>? unlockedAccessories,
    String? currentAccessory,
    Map<String, int>? stats,
    DateTime? lastInteraction,
    Map<String, dynamic>? metadata,
  }) {
    return Mascot(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      level: level ?? this.level,
      evolutionStage: evolutionStage ?? this.evolutionStage,
      currentMood: currentMood ?? this.currentMood,
      unlockedAccessories: unlockedAccessories ?? this.unlockedAccessories,
      currentAccessory: currentAccessory ?? this.currentAccessory,
      stats: stats ?? this.stats,
      lastInteraction: lastInteraction ?? this.lastInteraction,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Calcule le stage d'évolution basé sur le niveau utilisateur
  int calculateEvolutionStage(int userLevel) {
    if (userLevel >= 20) return 5;
    if (userLevel >= 15) return 4;
    if (userLevel >= 10) return 3;
    if (userLevel >= 5) return 2;
    return 1;
  }

  /// Messages d'encouragement selon le mood
  List<String> getEncouragementMessages() {
    switch (currentMood) {
      case 'happy':
        return [
          'Tu es sur la bonne voie ! 🎉',
          'Continue comme ça ! 💪',
          'Je suis fier de toi ! 🌟',
        ];
      case 'excited':
        return [
          'Wow ! Tu es incroyable ! 🚀',
          'Tu déchires ! 🔥',
          'Continue à progresser ! ⚡',
        ];
      case 'proud':
        return [
          'Félicitations pour tes accomplissements ! 🏆',
          'Tu as fait un excellent travail ! 👏',
          'Je suis impressionné ! 🌈',
        ];
      case 'encouraging':
        return [
          'Tu peux le faire ! 💫',
          'Ne lâche rien ! 🌟',
          'Chaque pas compte ! 🎯',
        ];
      case 'sleepy':
        return [
          'Prends soin de toi ! 😴',
          'N\'oublie pas de te reposer ! 🌙',
          'Repose-toi bien ! ⭐',
        ];
      default:
        return ['Continue ! 💪'];
    }
  }

  /// URL de l'animation selon le mood et le stage
  String getAnimationUrl() {
    return 'assets/animations/mascot/${evolutionStage}_$currentMood.json';
  }

  /// URL de l'image de la mascotte
  String getImageUrl() {
    return 'assets/images/mascot/stage_$evolutionStage.png';
  }

  @override
  String toString() {
    return 'Mascot(id: $id, name: $name, level: $level, stage: $evolutionStage, mood: $currentMood)';
  }
}

/// Accessoires disponibles pour la mascotte
class MascotAccessory {
  final String id;
  final String name;
  final String iconUrl;
  final String category; // 'hat', 'glasses', 'badge', 'background'
  final int unlockLevel;
  final String rarity; // 'common', 'rare', 'epic', 'legendary'
  final String? description;

  MascotAccessory({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.category,
    required this.unlockLevel,
    this.rarity = 'common',
    this.description,
  });

  /// Liste des accessoires prédéfinis
  static List<MascotAccessory> get predefined => [
    // Chapeaux
    MascotAccessory(
      id: 'hat_cap',
      name: 'Casquette',
      iconUrl: 'assets/icons/accessories/hat_cap.svg',
      category: 'hat',
      unlockLevel: 1,
      rarity: 'common',
    ),
    MascotAccessory(
      id: 'hat_crown',
      name: 'Couronne',
      iconUrl: 'assets/icons/accessories/hat_crown.svg',
      category: 'hat',
      unlockLevel: 10,
      rarity: 'epic',
    ),
    // Lunettes
    MascotAccessory(
      id: 'glasses_sun',
      name: 'Lunettes de soleil',
      iconUrl: 'assets/icons/accessories/glasses_sun.svg',
      category: 'glasses',
      unlockLevel: 3,
      rarity: 'common',
    ),
    MascotAccessory(
      id: 'glasses_smart',
      name: 'Lunettes intelligentes',
      iconUrl: 'assets/icons/accessories/glasses_smart.svg',
      category: 'glasses',
      unlockLevel: 15,
      rarity: 'rare',
    ),
    // Badges
    MascotAccessory(
      id: 'badge_star',
      name: 'Badge Étoile',
      iconUrl: 'assets/icons/accessories/badge_star.svg',
      category: 'badge',
      unlockLevel: 5,
      rarity: 'common',
    ),
    MascotAccessory(
      id: 'badge_champion',
      name: 'Badge Champion',
      iconUrl: 'assets/icons/accessories/badge_champion.svg',
      category: 'badge',
      unlockLevel: 20,
      rarity: 'legendary',
    ),
  ];
}

