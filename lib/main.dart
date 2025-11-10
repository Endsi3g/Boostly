/**
 * BOOSTLY - Application Mobile de Gestion de Tâches Gamifiée
 * 
 * Fichier principal de l'application
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 * 
 * Dépendances:
 * - Firebase Core
 * - Provider (State Management)
 * - GoRouter (Navigation)
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/firebase_config.dart';
import 'config/theme_config.dart';
import 'config/ai_config.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'services/ai_service.dart';
import 'services/notification_service.dart';
import 'services/stripe_service.dart';
import 'utils/security.dart';
import 'providers/user_provider.dart';
import 'providers/task_provider.dart';
import 'providers/gamification_provider.dart';
import 'providers/mascot_provider.dart';
import 'providers/subscription_provider.dart';
import 'router/app_router.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Hive pour le stockage local
  await Hive.initFlutter();

  // Initialiser la sécurité
  SecurityUtils.initializeEncryption();

  // Initialiser Firebase
  await Firebase.initializeApp(
    options: FirebaseConfig.currentPlatform,
  );

  // Initialiser Stripe
  await StripeService.instance.initialize();

  // Configurer l'orientation de l'écran (portrait uniquement pour MVP)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialiser les services
  await _initializeServices();

  runApp(const BoostlyApp());
}

/// Initialise tous les services nécessaires au démarrage
Future<void> _initializeServices() async {
  // Initialiser le service de notifications
  await NotificationService.instance.initialize();

  // Demander les permissions de notification
  await NotificationService.instance.requestPermissions();

  // Vérifier la disponibilité d'Ollama (si configuré)
  if (AIConfig.checkOllamaOnStartup && AIConfig.useOllama) {
    final aiService = AIService();
    await aiService.checkOllamaAvailability();
    debugPrint('Ollama disponible: ${aiService.ollamaAvailable}');
  }
}

class BoostlyApp extends StatelessWidget {
  const BoostlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => FirestoreService()),
        ChangeNotifierProvider(create: (_) => AIService()),

        // Providers
        ChangeNotifierProxyProvider<AuthService, UserProvider>(
          create: (_) => UserProvider(),
          update: (_, authService, previous) => previous ?? UserProvider()
            ..setAuthService(authService),
        ),
        ChangeNotifierProxyProvider<AuthService, TaskProvider>(
          create: (_) => TaskProvider(),
          update: (_, authService, previous) => previous ?? TaskProvider()
            ..setAuthService(authService),
        ),
        ChangeNotifierProxyProvider<AuthService, GamificationProvider>(
          create: (_) => GamificationProvider(),
          update: (_, authService, previous) =>
              previous ?? GamificationProvider()
                ..setAuthService(authService),
        ),
        ChangeNotifierProxyProvider<AuthService, MascotProvider>(
          create: (_) => MascotProvider(),
          update: (_, authService, previous) => previous ?? MascotProvider()
            ..setAuthService(authService),
        ),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
