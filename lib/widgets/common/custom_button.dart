/**
 * BOOSTLY - Widget Bouton Personnalisé
 * 
 * Bouton réutilisable selon le design system.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

/// Bouton personnalisé selon le design system
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType type;
  final IconData? icon;
  final double? width;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.type = ButtonType.primary,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidget = _buildButton(context);
    
    if (width != null) {
      return SizedBox(width: width, child: buttonWidget);
    }
    
    return buttonWidget;
  }

  Widget _buildButton(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeConfig.boostlyBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingL,
              vertical: ThemeConfig.spacingM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.borderRadiusMedium),
            ),
            elevation: 0,
          ),
          child: _buildButtonContent(),
        );
      
      case ButtonType.secondary:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: ThemeConfig.boostlyBlue,
            side: const BorderSide(color: ThemeConfig.boostlyBlue, width: 2),
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingL,
              vertical: ThemeConfig.spacingM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.borderRadiusMedium),
            ),
          ),
          child: _buildButtonContent(),
        );
      
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: ThemeConfig.boostlyBlue,
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingM,
              vertical: ThemeConfig.spacingS,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.borderRadiusSmall),
            ),
          ),
          child: _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

enum ButtonType {
  primary,
  secondary,
  text,
}

