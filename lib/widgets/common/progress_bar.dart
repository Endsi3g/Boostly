/**
 * BOOSTLY - Widget Barre de Progression
 * 
 * Barre de progression réutilisable selon le design system.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

/// Barre de progression personnalisée
class CustomProgressBar extends StatelessWidget {
  final double progress; // 0.0 à 1.0
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final String? label;
  final bool showPercentage;

  const CustomProgressBar({
    super.key,
    required this.progress,
    this.height = 12,
    this.backgroundColor,
    this.progressColor,
    this.label,
    this.showPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showPercentage)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ThemeConfig.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                if (showPercentage)
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ThemeConfig.textSecondary,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor ?? ThemeConfig.surfaceColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor ?? ThemeConfig.boostlyBlue,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

