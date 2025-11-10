/**
 * BOOSTLY - Widget Carte Badge
 * 
 * Carte réutilisable pour afficher un badge/achievement.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../models/achievement.dart';

/// Carte de badge réutilisable
class BadgeCard extends StatelessWidget {
  final Achievement achievement;
  final VoidCallback? onTap;

  const BadgeCard({
    super.key,
    required this.achievement,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnlocked = achievement.isUnlocked;
    final rarityColor = _getRarityColor(achievement.rarity);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.white : Colors.white.withValues(alpha: 0.5),
          border: Border.all(
            color: isUnlocked ? rarityColor : const Color(0xFFE8EAF6),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: rarityColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône du badge
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isUnlocked
                        ? rarityColor.withValues(alpha: 0.1)
                        : ThemeConfig.textSecondary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.star,
                    size: 30,
                    color: isUnlocked ? rarityColor : ThemeConfig.textSecondary,
                  ),
                ),
                // Nom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    achievement.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isUnlocked ? ThemeConfig.textPrimary : ThemeConfig.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                // Rareté
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: rarityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    achievement.rarity.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: rarityColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            // Overlay verrouillé
            if (!isUnlocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            // Checkmark si équipé
            if (isUnlocked)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: ThemeConfig.successColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ThemeConfig.successColor,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'common':
        return ThemeConfig.boostlyBlue;
      case 'rare':
        return ThemeConfig.secondaryColor;
      case 'epic':
        return ThemeConfig.accentColor;
      case 'legendary':
        return const Color(0xFFFF6B6B);
      default:
        return ThemeConfig.boostlyBlue;
    }
  }
}

