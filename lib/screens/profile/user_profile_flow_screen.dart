/**
 * BOOSTLY - Écran User Profile Flow
 * 
 * Sélection et configuration du profil utilisateur.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class UserProfileFlowScreen extends StatefulWidget {
  const UserProfileFlowScreen({super.key});

  @override
  State<UserProfileFlowScreen> createState() => _UserProfileFlowScreenState();
}

class _UserProfileFlowScreenState extends State<UserProfileFlowScreen> {
  String? _selectedProfile;

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
                  const Text(
                    'Sélectionnez votre profil',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Choisissez le profil qui vous correspond le mieux',
                style: TextStyle(
                  fontSize: 15,
                  color: ThemeConfig.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              // Profile cards
              Expanded(
                child: Column(
                  children: [
                    _buildProfileCard(
                      icon: Icons.person,
                      title: 'Individuel',
                      description: 'Pour votre usage personnel',
                      isSelected: _selectedProfile == 'individual',
                      onTap: () => setState(() => _selectedProfile = 'individual'),
                    ),
                    const SizedBox(height: 20),
                    _buildProfileCard(
                      icon: Icons.business,
                      title: 'Professionnel',
                      description: 'Pour votre carrière et projets',
                      isSelected: _selectedProfile == 'professional',
                      onTap: () => setState(() => _selectedProfile = 'professional'),
                    ),
                    const SizedBox(height: 20),
                    _buildProfileCard(
                      icon: Icons.school,
                      title: 'Étudiant',
                      description: 'Pour vos études et apprentissage',
                      isSelected: _selectedProfile == 'student',
                      onTap: () => setState(() => _selectedProfile = 'student'),
                    ),
                  ],
                ),
              ),
              // Continue button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedProfile != null
                      ? () {
                          // TODO: Sauvegarder profil
                          context.pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeConfig.boostlyBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continuer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected
              ? ThemeConfig.boostlyBlue.withValues(alpha: 0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? ThemeConfig.boostlyBlue : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 56,
              color: ThemeConfig.boostlyBlue,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: ThemeConfig.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

