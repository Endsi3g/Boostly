/**
 * BOOSTLY - Écran Configuration Notifications
 * 
 * Configuration des notifications push et locales.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class NotificationSetupScreen extends StatefulWidget {
  const NotificationSetupScreen({super.key});

  @override
  State<NotificationSetupScreen> createState() => _NotificationSetupScreenState();
}

class _NotificationSetupScreenState extends State<NotificationSetupScreen> {
  bool _pushEnabled = true;
  bool _taskReminders = true;
  bool _dailyMotivation = true;
  bool _achievementAlerts = true;
  bool _streakReminders = true;
  bool _weeklyReports = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Gérez vos préférences de notifications pour rester informé de vos progrès.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF5E6B7D),
                ),
              ),
            ),
            _buildSection('GÉNÉRAL', [
              _buildSwitchTile(
                'Notifications push',
                'Recevez des notifications sur votre appareil',
                _pushEnabled,
                (value) => setState(() => _pushEnabled = value),
              ),
            ]),
            _buildSection('RAPPELS', [
              _buildSwitchTile(
                'Rappels de tâches',
                'Notifications pour vos tâches à venir',
                _taskReminders,
                (value) => setState(() => _taskReminders = value),
              ),
              _buildSwitchTile(
                'Rappels de série',
                'Rappels pour maintenir votre série quotidienne',
                _streakReminders,
                (value) => setState(() => _streakReminders = value),
              ),
            ]),
            _buildSection('MOTIVATION', [
              _buildSwitchTile(
                'Motivation quotidienne',
                'Messages d\'encouragement quotidiens',
                _dailyMotivation,
                (value) => setState(() => _dailyMotivation = value),
              ),
              _buildSwitchTile(
                'Alertes de succès',
                'Notifications lors de nouveaux badges',
                _achievementAlerts,
                (value) => setState(() => _achievementAlerts = value),
              ),
            ]),
            _buildSection('RAPPORTS', [
              _buildSwitchTile(
                'Rapports hebdomadaires',
                'Résumé de votre semaine chaque dimanche',
                _weeklyReports,
                (value) => setState(() => _weeklyReports = value),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: ThemeConfig.surfaceColor,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ThemeConfig.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: ThemeConfig.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF5E6B7D),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: ThemeConfig.boostlyBlue,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}

