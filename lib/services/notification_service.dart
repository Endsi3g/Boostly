/**
 * BOOSTLY - Service de Notifications
 * 
 * Gère les notifications push locales pour:
 * - Rappels de tâches
 * - Encouragements de la mascotte
 * - Achievements débloqués
 * - Rappels de streaks
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 * 
 * Limitations Free Tier:
 * - Maximum 5 notifications par jour
 * - Pas de notifications push Firebase Cloud Messaging (nécessite upgrade)
 */

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';

/// Service de notifications locales
class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  factory NotificationService() => instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  /// Initialise le service de notifications
  Future<void> initialize() async {
    if (_isInitialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
  }

  /// Gère le tap sur une notification
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapée: ${response.payload}');
    // TODO: Naviguer vers l'écran approprié selon le payload
  }

  /// Demande les permissions de notification
  Future<bool> requestPermissions() async {
    if (!_isInitialized) await initialize();

    final android = await _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }

    return true;
  }

  /// Planifie une notification à une date/heure spécifique
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    if (!_isInitialized) await initialize();

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'boostly_channel',
          'BOOSTLY Notifications',
          channelDescription: 'Notifications pour rappels et encouragements',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  /// Planifie un rappel de tâche
  Future<void> scheduleTaskReminder({
    required int taskId,
    required String taskTitle,
    required DateTime reminderTime,
  }) async {
    await scheduleNotification(
      id: taskId,
      title: 'Rappel de tâche',
      body: 'N\'oubliez pas: $taskTitle',
      scheduledDate: reminderTime,
      payload: 'task_$taskId',
    );
  }

  /// Planifie un rappel de streak
  Future<void> scheduleStreakReminder({
    required int userId,
    required int currentStreak,
  }) async {
    await scheduleNotification(
      id: userId + 10000, // ID unique pour les rappels de streak
      title: 'Maintenez votre streak ! 🔥',
      body: 'Vous avez un streak de $currentStreak jours. Continuez !',
      scheduledDate: DateTime.now().add(const Duration(hours: 20)), // 20h le soir
      payload: 'streak_reminder',
    );
  }

  /// Affiche une notification immédiate (achievement débloqué, etc.)
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) await initialize();

    await _notifications.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'boostly_channel',
          'BOOSTLY Notifications',
          channelDescription: 'Notifications pour rappels et encouragements',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }

  /// Affiche une notification d'achievement débloqué
  Future<void> showAchievementNotification({
    required String achievementName,
    required String achievementDescription,
  }) async {
    await showInstantNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: '🏆 Achievement débloqué !',
      body: '$achievementName: $achievementDescription',
      payload: 'achievement',
    );
  }

  /// Annule une notification planifiée
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// Annule toutes les notifications
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}

