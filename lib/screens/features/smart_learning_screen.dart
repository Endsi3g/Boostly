/**
 * BOOSTLY - Écran Apprentissage Intelligent
 * 
 * Suggestions intelligentes basées sur les habitudes.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class SmartLearningScreen extends StatelessWidget {
  const SmartLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Apprentissage Intelligent',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                    ThemeConfig.secondaryColor.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ThemeConfig.boostlyBlue.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, size: 40, color: ThemeConfig.boostlyBlue),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'IA adaptative',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'L\'IA apprend de vos habitudes pour mieux vous aider',
                          style: TextStyle(
                            fontSize: 13,
                            color: ThemeConfig.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Suggestions intelligentes',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(3, (index) => _buildSuggestionCard(context, index)),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(BuildContext context, int index) {
    final suggestions = [
      {
        'title': 'Meilleur moment pour travailler',
        'subtitle': 'Basé sur vos 30 derniers jours',
        'value': '9h - 11h',
      },
      {
        'title': 'Tâches fréquentes',
        'subtitle': 'Vous faites souvent ces tâches',
        'value': '5 tâches',
      },
      {
        'title': 'Objectif recommandé',
        'subtitle': 'Basé sur votre progression',
        'value': '10 tâches/jour',
      },
    ];

    final suggestion = suggestions[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.trending_up, color: ThemeConfig.boostlyBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestion['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  suggestion['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: ThemeConfig.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            suggestion['value'] as String,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: ThemeConfig.boostlyBlue,
            ),
          ),
        ],
      ),
    );
  }
}

