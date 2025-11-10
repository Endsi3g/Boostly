/**
 * BOOSTLY - Constantes de l'Application
 * 
 * Définit toutes les constantes utilisées dans l'application.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

/// Constantes générales de l'application
class AppConstants {
  AppConstants._();
  
  static const String appName = 'BOOSTLY';
  static const String appTagline = 'Lock In Your Goals';
  static const String appVersion = '1.0.0';
  
  // URLs et endpoints
  static const String privacyPolicyUrl = 'https://boostly.app/privacy';
  static const String termsOfServiceUrl = 'https://boostly.app/terms';
  static const String supportEmail = 'support@boostly.app';
  
  // Limites Free Tier
  static const int maxTasksFreeTier = 50;
  static const int maxCategoriesFreeTier = 3;
  static const int maxResourcesFreeTier = 10;
  
  // Configuration Premium
  static const double premiumMonthlyPrice = 4.99;
  static const double premiumYearlyPrice = 39.99;
  static const int premiumTrialDays = 7;
  
  // Gamification
  static const int maxLevel = 20;
  static const int totalBadges = 45;
  static const int xpPerTask = 10;
  static const int xpPerStreak = 5;
  static const int xpPerBadge = 50;
  
  // Mascot
  static const int totalAccessories = 45;
  static const int mascotEvolutionLevels = 5;
  
  // Notifications
  static const int maxDailyNotifications = 5;
  static const int notificationDelayMinutes = 15;
  
  // Analytics
  static const int heatmapDays = 7;
  static const int heatmapHours = 24;
  
  // Cache
  static const int cacheExpirationHours = 24;
  static const int maxCacheSize = 100;
}

/// Constantes pour les catégories de tâches
class TaskCategories {
  TaskCategories._();
  
  static const String work = 'work';
  static const String personal = 'personal';
  static const String health = 'health';
  static const String learning = 'learning';
  static const String finance = 'finance';
  static const String social = 'social';
  
  static const List<String> all = [
    work,
    personal,
    health,
    learning,
    finance,
    social,
  ];
  
  static const Map<String, String> displayNames = {
    work: 'Travail',
    personal: 'Personnel',
    health: 'Santé',
    learning: 'Apprentissage',
    finance: 'Finances',
    social: 'Social',
  };
}

/// Constantes pour les priorités de tâches
class TaskPriorities {
  TaskPriorities._();
  
  static const String low = 'low';
  static const String medium = 'medium';
  static const String high = 'high';
  static const String urgent = 'urgent';
  
  static const List<String> all = [low, medium, high, urgent];
  
  static const Map<String, String> displayNames = {
    low: 'Basse',
    medium: 'Moyenne',
    high: 'Haute',
    urgent: 'Urgente',
  };
}

/// Constantes pour les statuts de tâches
class TaskStatus {
  TaskStatus._();
  
  static const String todo = 'todo';
  static const String inProgress = 'in_progress';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  
  static const List<String> all = [todo, inProgress, completed, cancelled];
}

/// Constantes pour les types de ressources
class ResourceTypes {
  ResourceTypes._();
  
  static const String article = 'article';
  static const String video = 'video';
  static const String podcast = 'podcast';
  static const String tip = 'tip';
  
  static const List<String> all = [article, video, podcast, tip];
  
  static const Map<String, String> displayNames = {
    article: 'Article',
    video: 'Vidéo',
    podcast: 'Podcast',
    tip: 'Conseil',
  };
}

/// Constantes pour le stockage local (Hive)
class HiveBoxes {
  HiveBoxes._();
  
  static const String user = 'user';
  static const String tasks = 'tasks';
  static const String achievements = 'achievements';
  static const String mascot = 'mascot';
  static const String cache = 'cache';
  static const String settings = 'settings';
}

