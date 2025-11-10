/**
 * BOOSTLY - Configuration du Router
 * 
 * Définit toutes les routes de l'application avec navigation sécurisée.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Auth
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/password_reset_screen.dart';
import '../screens/auth/email_confirm_screen.dart';

// Onboarding
import '../screens/onboarding/onboarding_intro_screen.dart';
import '../screens/onboarding/onboarding_joy_screen.dart';

// Home & Core
import '../screens/home/home_screen.dart';
import '../screens/tasks/tasks_screen.dart';
import '../screens/tasks/task_detail_screen.dart';
import '../screens/mascot/mascot_screen.dart';
import '../screens/resources/resources_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';

// Gamification
import '../screens/gamification/badge_collection_screen.dart';
import '../screens/gamification/leaderboard_screen.dart';

// Challenges
import '../screens/challenges/challenge_hub_screen.dart';

// Payment
import '../screens/payment/pricing_plans_screen.dart';
import '../screens/payment/payment_flow_screen.dart';

// Settings
import '../screens/settings/notification_setup_screen.dart';
import '../screens/settings/calendar_settings_screen.dart';
import '../screens/settings/sync_settings_screen.dart';
import '../screens/settings/avatar_setup_screen.dart';

// Subscription
import '../screens/subscription/manage_plan_screen.dart';
import '../screens/subscription/subs_overview_screen.dart';
import '../screens/subscription/cancellation_screen.dart';
import '../screens/subscription/cancel_details_screen.dart';
import '../screens/subscription/almost_there_screen.dart';

// Features
import '../screens/features/routine_features_screen.dart';
import '../screens/features/ai_task_mastery_screen.dart';
import '../screens/features/smart_learning_screen.dart';
import '../screens/features/task_helper_screen.dart';
import '../screens/features/brainstorm_ideas_screen.dart';

// Gamification
import '../screens/gamification/achievement_flow_screen.dart';

// Challenges
import '../screens/challenges/challenge_app_screen.dart';
import '../models/achievement.dart';

// Visual & UX
import '../screens/visual/visual_delights_screen.dart';
import '../screens/upsell/upsell_ideas_screen.dart';
import '../screens/upsell/addons_brainstorm_screen.dart';
import '../screens/forms/form_features_screen.dart';
import '../screens/guidance/guidance_tools_screen.dart';
import '../screens/support/support_hub_screen.dart';
import '../screens/auth/oauth_flow_screen.dart';
import '../screens/auth/app_authorization_screen.dart';
import '../screens/updates/boostly_updates_screen.dart';
import '../screens/features/routine_enhancements_screen.dart';
import '../screens/security/enhanced_security_screen.dart';
import '../screens/profile/user_profile_flow_screen.dart';
import '../screens/wellbeing/wellbeing_app_concepts_screen.dart';
import '../screens/audio/audio_app_ideas_screen.dart';
import '../screens/onboarding/visuals_onboarding_screen.dart';
import '../screens/project/project_overview_screen.dart';

import '../services/auth_service.dart';
import 'package:provider/provider.dart';

/// Configuration du router de l'application
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/visuals-onboarding',
    redirect: (context, state) {
      final authService = Provider.of<AuthService>(context, listen: false);
      final isAuthenticated = authService.isAuthenticated;
      final isPublicRoute = _isPublicRoute(state.matchedLocation);

      // Rediriger vers login si non authentifié et pas sur une route publique
      if (!isAuthenticated && !isPublicRoute) {
        return '/login';
      }

      // Rediriger vers home si authentifié et sur une route auth/onboarding
      if (isAuthenticated &&
          (isPublicRoute && state.matchedLocation != '/home')) {
        return '/home';
      }

      return null; // Pas de redirection nécessaire
    },
    routes: [
      // Routes Onboarding (publiques)
      GoRoute(
        path: '/onboarding-intro',
        name: 'onboarding-intro',
        builder: (context, state) => const OnboardingIntroScreen(),
      ),
      GoRoute(
        path: '/onboarding-joy',
        name: 'onboarding-joy',
        builder: (context, state) => const OnboardingJoyScreen(),
      ),

      // Routes d'authentification (publiques)
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/password-reset',
        name: 'password-reset',
        builder: (context, state) => const PasswordResetScreen(),
      ),
      GoRoute(
        path: '/email-confirm',
        name: 'email-confirm',
        builder: (context, state) => const EmailConfirmScreen(),
      ),

      // Route principale avec navigation bottom bar
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Routes des tâches
      GoRoute(
        path: '/tasks',
        name: 'tasks',
        builder: (context, state) => const TasksScreen(),
      ),
      GoRoute(
        path: '/task/:id',
        name: 'task-detail',
        builder: (context, state) {
          final taskId = state.pathParameters['id']!;
          return TaskDetailScreen(taskId: taskId);
        },
      ),

      // Route mascotte
      GoRoute(
        path: '/mascot',
        name: 'mascot',
        builder: (context, state) => const MascotScreen(),
      ),

      // Route ressources
      GoRoute(
        path: '/resources',
        name: 'resources',
        builder: (context, state) => const ResourcesScreen(),
      ),

      // Route analytics
      GoRoute(
        path: '/analytics',
        name: 'analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),

      // Route profil
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Route paramètres
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Routes Gamification
      GoRoute(
        path: '/badges',
        name: 'badges',
        builder: (context, state) => const BadgeCollectionScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        name: 'leaderboard',
        builder: (context, state) => const LeaderboardScreen(),
      ),

      // Routes Challenges
      GoRoute(
        path: '/challenges',
        name: 'challenges',
        builder: (context, state) => const ChallengeHubScreen(),
      ),

      // Routes Payment
      GoRoute(
        path: '/pricing',
        name: 'pricing',
        builder: (context, state) => const PricingPlansScreen(),
      ),
      GoRoute(
        path: '/payment-flow',
        name: 'payment-flow',
        builder: (context, state) => const PaymentFlowScreen(),
      ),
      GoRoute(
        path: '/almost-there',
        name: 'almost-there',
        builder: (context, state) => const AlmostThereScreen(),
      ),

      // Routes Settings
      GoRoute(
        path: '/notification-setup',
        name: 'notification-setup',
        builder: (context, state) => const NotificationSetupScreen(),
      ),
      GoRoute(
        path: '/calendar-settings',
        name: 'calendar-settings',
        builder: (context, state) => const CalendarSettingsScreen(),
      ),
      GoRoute(
        path: '/sync-settings',
        name: 'sync-settings',
        builder: (context, state) => const SyncSettingsScreen(),
      ),
      GoRoute(
        path: '/avatar-setup',
        name: 'avatar-setup',
        builder: (context, state) => const AvatarSetupScreen(),
      ),

      // Routes Subscription
      GoRoute(
        path: '/manage-plan',
        name: 'manage-plan',
        builder: (context, state) => const ManagePlanScreen(),
      ),
      GoRoute(
        path: '/subs-overview',
        name: 'subs-overview',
        builder: (context, state) => const SubsOverviewScreen(),
      ),
      GoRoute(
        path: '/cancellation',
        name: 'cancellation',
        builder: (context, state) => const CancellationScreen(),
      ),
      GoRoute(
        path: '/cancel-details',
        name: 'cancel-details',
        builder: (context, state) => const CancelDetailsScreen(),
      ),

      // Routes Features
      GoRoute(
        path: '/routines',
        name: 'routines',
        builder: (context, state) => const RoutineFeaturesScreen(),
      ),
      GoRoute(
        path: '/ai-task-mastery',
        name: 'ai-task-mastery',
        builder: (context, state) => const AITaskMasteryScreen(),
      ),
      GoRoute(
        path: '/smart-learning',
        name: 'smart-learning',
        builder: (context, state) => const SmartLearningScreen(),
      ),
      GoRoute(
        path: '/task-helper',
        name: 'task-helper',
        builder: (context, state) => const TaskHelperScreen(),
      ),
      GoRoute(
        path: '/brainstorm',
        name: 'brainstorm',
        builder: (context, state) => const BrainstormIdeasScreen(),
      ),

      // Routes Gamification
      GoRoute(
        path: '/achievement/:id',
        name: 'achievement',
        builder: (context, state) {
          // TODO: Récupérer achievement depuis ID
          final achievement = Achievement(
            id: state.pathParameters['id']!,
            name: 'Achievement',
            description: 'Description',
            iconUrl: 'https://example.com/icon.png',
            category: 'task',
            rarity: 'common',
            xpReward: 100,
          );
          return AchievementFlowScreen(achievement: achievement);
        },
      ),

      // Routes Challenges
      GoRoute(
        path: '/challenge/:id',
        name: 'challenge',
        builder: (context, state) {
          final challengeId = state.pathParameters['id']!;
          return ChallengeAppScreen(challengeId: challengeId);
        },
      ),

      // Routes Visual & UX
      GoRoute(
        path: '/level-up',
        name: 'level-up',
        builder: (context, state) {
          final level =
              int.tryParse(state.uri.queryParameters['level'] ?? '1') ?? 1;
          final xp = int.tryParse(state.uri.queryParameters['xp'] ?? '0') ?? 0;
          return VisualDelightsScreen(newLevel: level, xpGained: xp);
        },
      ),
      GoRoute(
        path: '/upsell',
        name: 'upsell',
        builder: (context, state) {
          final contextMessage = state.uri.queryParameters['context'];
          return UpsellIdeasScreen(contextMessage: contextMessage);
        },
      ),
      GoRoute(
        path: '/addons',
        name: 'addons',
        builder: (context, state) => const AddonsBrainstormScreen(),
      ),
      GoRoute(
        path: '/form-features',
        name: 'form-features',
        builder: (context, state) => const FormFeaturesScreen(),
      ),
      GoRoute(
        path: '/guidance',
        name: 'guidance',
        builder: (context, state) => const GuidanceToolsScreen(),
      ),
      GoRoute(
        path: '/support',
        name: 'support',
        builder: (context, state) => const SupportHubScreen(),
      ),

      // Routes Auth Advanced
      GoRoute(
        path: '/oauth/:provider',
        name: 'oauth',
        builder: (context, state) {
          final provider = state.pathParameters['provider']!;
          return OAuthFlowScreen(provider: provider);
        },
      ),
      GoRoute(
        path: '/app-authorization/:app',
        name: 'app-authorization',
        builder: (context, state) {
          final appName = state.pathParameters['app']!;
          return AppAuthorizationScreen(appName: appName);
        },
      ),

      // Routes Updates & Info
      GoRoute(
        path: '/updates',
        name: 'updates',
        builder: (context, state) => const BoostlyUpdatesScreen(),
      ),
      GoRoute(
        path: '/project-overview',
        name: 'project-overview',
        builder: (context, state) => const ProjectOverviewScreen(),
      ),

      // Routes Features Advanced
      GoRoute(
        path: '/routine-enhancements',
        name: 'routine-enhancements',
        builder: (context, state) => const RoutineEnhancementsScreen(),
      ),

      // Routes Security
      GoRoute(
        path: '/enhanced-security',
        name: 'enhanced-security',
        builder: (context, state) => const EnhancedSecurityScreen(),
      ),

      // Routes Profile
      GoRoute(
        path: '/user-profile-flow',
        name: 'user-profile-flow',
        builder: (context, state) => const UserProfileFlowScreen(),
      ),

      // Routes Wellbeing
      GoRoute(
        path: '/wellbeing',
        name: 'wellbeing',
        builder: (context, state) => const WellbeingAppConceptsScreen(),
      ),

      // Routes Audio
      GoRoute(
        path: '/audio',
        name: 'audio',
        builder: (context, state) => const AudioAppIdeasScreen(),
      ),

      // Routes Onboarding
      GoRoute(
        path: '/visuals-onboarding',
        name: 'visuals-onboarding',
        builder: (context, state) => const VisualsOnboardingScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Erreur: ${state.error}'),
      ),
    ),
  );

  /// Vérifie si une route est publique (accessible sans authentification)
  static bool _isPublicRoute(String location) {
    final publicRoutes = [
      '/visuals-onboarding',
      '/onboarding-intro',
      '/onboarding-joy',
      '/login',
      '/signup',
      '/password-reset',
      '/email-confirm',
      '/oauth/google',
      '/oauth/apple',
      '/project-overview',
    ];
    return publicRoutes.contains(location);
  }
}
