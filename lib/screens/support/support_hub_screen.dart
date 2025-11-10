/**
 * BOOSTLY - Écran Support Hub
 * 
 * Centre d'aide et de support.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class SupportHubScreen extends StatelessWidget {
  const SupportHubScreen({super.key});

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
          'Contactez-nous',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Comment pouvons-nous vous aider ?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF5E6B7D),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _buildSupportOption(
              context,
              icon: Icons.help_outline,
              title: 'FAQ',
              description: 'Trouvez des réponses aux questions fréquentes',
              onTap: () {
                // TODO: Ouvrir FAQ
              },
            ),
            _buildSupportOption(
              context,
              icon: Icons.chat_bubble_outline,
              title: 'Chat en direct',
              description: 'Discutez avec notre équipe de support',
              onTap: () {
                // TODO: Ouvrir chat
              },
            ),
            _buildSupportOption(
              context,
              icon: Icons.email_outlined,
              title: 'Envoyer un email',
              description: 'Contactez-nous par email',
              onTap: () {
                context.push('/form-features');
              },
            ),
            _buildSupportOption(
              context,
              icon: Icons.video_call_outlined,
              title: 'Appel vidéo',
              description: 'Planifier une session avec notre équipe',
              onTap: () {
                // TODO: Planifier appel
              },
            ),
            const SizedBox(height: 32),
            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ThemeConfig.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Suivez-nous',
                    style: TextStyle(
                      fontSize: 14,
                      color: ThemeConfig.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.facebook),
                      const SizedBox(width: 20),
                      _buildSocialIcon(Icons.camera_alt),
                      const SizedBox(width: 20),
                      _buildSocialIcon(Icons.alternate_email),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: ThemeConfig.boostlyBlue, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        color: ThemeConfig.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeConfig.boostlyBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Accéder',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: ThemeConfig.boostlyBlue),
    );
  }
}

