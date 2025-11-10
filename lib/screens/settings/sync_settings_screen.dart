/**
 * BOOSTLY - Écran Paramètres Synchronisation
 * 
 * Configuration de la synchronisation des données.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class SyncSettingsScreen extends StatelessWidget {
  const SyncSettingsScreen({super.key});

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
          'Synchronisation',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ThemeConfig.successColor.withValues(alpha: 0.1),
                    ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ThemeConfig.successColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: ThemeConfig.successColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cloud_done,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Synchronisation active',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dernière sync: Il y a 5 min',
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeConfig.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      // TODO: Forcer synchronisation
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Sync options
            _buildSectionTitle('Options de synchronisation'),
            const SizedBox(height: 16),
            _buildSyncOption(
              'Synchronisation automatique',
              'Synchronise automatiquement vos données',
              Icons.sync,
              true,
            ),
            _buildSyncOption(
              'Synchronisation Wi‑Fi uniquement',
              'Économise les données mobiles',
              Icons.wifi,
              false,
            ),
            _buildSyncOption(
              'Sauvegarde cloud',
              'Sauvegarde automatique sur le cloud',
              Icons.cloud_upload,
              true,
            ),
            const SizedBox(height: 32),
            // Advanced
            _buildSectionTitle('Avancé'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text(
                'Effacer les données locales',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // TODO: Confirmer suppression
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Restaurer depuis le cloud'),
              onTap: () {
                // TODO: Restaurer
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: ThemeConfig.textPrimary,
      ),
    );
  }

  Widget _buildSyncOption(String title, String subtitle, IconData icon, bool enabled) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: enabled ? ThemeConfig.boostlyBlue : const Color(0xFFE0E0E0),
          width: enabled ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: ThemeConfig.boostlyBlue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: ThemeConfig.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: (value) {
              // TODO: Mettre à jour
            },
            activeThumbColor: ThemeConfig.boostlyBlue,
          ),
        ],
      ),
    );
  }
}

