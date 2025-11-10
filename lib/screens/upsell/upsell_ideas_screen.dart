/**
 * BOOSTLY - Écran Upsell Premium
 * 
 * Modal d'upsell pour passer au Premium.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class UpsellIdeasScreen extends StatelessWidget {
  final String? contextMessage;

  const UpsellIdeasScreen({
    super.key,
    this.contextMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.5),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Mascot
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ThemeConfig.boostlyBlue,
                                ThemeConfig.secondaryColor,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.rocket_launch,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Title
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [ThemeConfig.boostlyBlue, ThemeConfig.secondaryColor],
                          ).createShader(bounds),
                          child: const Text(
                            'Passez au Premium',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          contextMessage ??
                              'Débloquez toutes les fonctionnalités avancées',
                          style: TextStyle(
                            fontSize: 15,
                            color: ThemeConfig.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        // Context section
                        if (contextMessage != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ThemeConfig.boostlyBlue.withValues(alpha: 0.05),
                                  ThemeConfig.secondaryColor.withValues(alpha: 0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border(
                                left: BorderSide(
                                  color: ThemeConfig.boostlyBlue,
                                  width: 4,
                                ),
                              ),
                            ),
                            child: Text(
                              contextMessage!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: ThemeConfig.textPrimary,
                              ),
                            ),
                          ),
                        if (contextMessage != null) const SizedBox(height: 24),
                        // Features
                        ..._buildFeatureList(),
                        const SizedBox(height: 24),
                        // CTA button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pop();
                              context.push('/pricing');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeConfig.boostlyBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Voir les plans',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text(
                            'Peut-être plus tard',
                            style: TextStyle(
                              color: ThemeConfig.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFeatureList() {
    final features = [
      {'icon': Icons.all_inclusive, 'title': 'Tâches illimitées'},
      {'icon': Icons.star, 'title': 'Tous les badges'},
      {'icon': Icons.psychology, 'title': 'IA avancée'},
      {'icon': Icons.analytics, 'title': 'Analytics détaillés'},
    ];

    return features.map((feature) => Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE8EAF6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature['icon'] as IconData,
              color: ThemeConfig.boostlyBlue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              feature['title'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          const Icon(Icons.check_circle, color: ThemeConfig.successColor),
        ],
      ),
    )).toList();
  }
}

