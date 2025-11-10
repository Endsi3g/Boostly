/**
 * BOOSTLY - Écran Confirmation Email
 * 
 * Confirme l'envoi du lien de réinitialisation.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class EmailConfirmScreen extends StatelessWidget {
  const EmailConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  Text(
                    'Lien Envoyé',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      color: ThemeConfig.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFFACB3C6)),
                    onPressed: () => context.go('/login'),
                  ),
                ],
              ),
              const Spacer(),
              // Success icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: ThemeConfig.successColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: ThemeConfig.successColor,
                ),
              ),
              const SizedBox(height: 30),
              // Message
              Text(
                'Nous avons envoyé un lien de réinitialisation à votre adresse email.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF6D7688),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Info box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F0FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                    left: BorderSide(
                      color: ThemeConfig.boostlyBlue,
                      width: 4,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: ThemeConfig.boostlyBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Vérifiez votre boîte de réception et vos spams.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ThemeConfig.textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.go('/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeConfig.boostlyBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Retour à la connexion',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Resend link
              TextButton(
                onPressed: () {
                  // TODO: Implémenter renvoi du lien de réinitialisation
                  // Pour l'instant, rediriger vers la page de reset
                  context.go('/password-reset');
                },
                child: const Text(
                  'Renvoyer le lien',
                  style: TextStyle(
                    color: ThemeConfig.boostlyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

