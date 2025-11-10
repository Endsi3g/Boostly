/**
 * BOOSTLY - Écran Onboarding Final
 * 
 * Dernier écran d'onboarding avec CTA pour commencer.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class OnboardingJoyScreen extends StatelessWidget {
  const OnboardingJoyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Bouton retour
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF6D7688)),
                  onPressed: () => context.pop(),
                ),
              ),
              const Spacer(),
              // Illustration
              Container(
                width: 250,
                height: 250,
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ThemeConfig.boostlyBlue,
                      ThemeConfig.secondaryColor,
                      ThemeConfig.accentColor,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('🎉', style: TextStyle(fontSize: 120)),
                ),
              ),
              // Titre
              Text(
                'Prêt à Booster\nVotre Parcours ?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: ThemeConfig.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'Rejoignez des milliers d\'utilisateurs qui transforment leurs objectifs en succès avec Boostly.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: ThemeConfig.textPrimary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Bouton CTA
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.go('/signup'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeConfig.boostlyBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Commencer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

