/**
 * BOOSTLY - Écran Routine Enhancements
 * 
 * Routines intelligentes avec détection d'habitudes par IA.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class RoutineEnhancementsScreen extends StatelessWidget {
  const RoutineEnhancementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ThemeConfig.secondaryColor, ThemeConfig.boostlyBlue],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'NOUVEAU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Routines Intelligentes',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'L\'IA détecte vos habitudes et suggère des routines',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Habit detection cards
                  ...List.generate(3, (index) => _buildHabitCard(context, index)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(BuildContext context, int index) {
    final habits = [
      {
        'icon': '🌅',
        'title': 'Routine Matinale',
        'pattern': 'Détecté: Vous faites souvent ces tâches le matin',
        'tasks': ['Méditation', 'Exercice', 'Petit-déjeuner'],
      },
      {
        'icon': '🎯',
        'title': 'Focus Time',
        'pattern': 'Détecté: Période de productivité maximale',
        'tasks': ['Travail important', 'Réunions', 'Projets'],
      },
      {
        'icon': '🌙',
        'title': 'Routine Soirée',
        'pattern': 'Détecté: Habitudes de fin de journée',
        'tasks': ['Lecture', 'Planification', 'Détente'],
      },
    ];

    final habit = habits[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeConfig.boostlyBlue.withValues(alpha: 0.05),
            ThemeConfig.secondaryColor.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(color: ThemeConfig.boostlyBlue, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                habit['icon'] as String,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  habit['title'] as String,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ThemeConfig.boostlyBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border(
                left: BorderSide(color: ThemeConfig.boostlyBlue, width: 3),
              ),
            ),
            child: Text(
              habit['pattern'] as String,
              style: const TextStyle(
                fontSize: 14,
                color: ThemeConfig.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...(habit['tasks'] as List<String>).map((task) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: ThemeConfig.boostlyBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        task,
                        style: TextStyle(
                          fontSize: 14,
                          color: ThemeConfig.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Créer routine depuis habitude
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeConfig.boostlyBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Créer cette routine'),
            ),
          ),
        ],
      ),
    );
  }
}

