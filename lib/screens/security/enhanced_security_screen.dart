/**
 * BOOSTLY - Écran Sécurité Avancée
 * 
 * Configuration de la sécurité et confidentialité.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class EnhancedSecurityScreen extends StatefulWidget {
  const EnhancedSecurityScreen({super.key});

  @override
  State<EnhancedSecurityScreen> createState() => _EnhancedSecurityScreenState();
}

class _EnhancedSecurityScreenState extends State<EnhancedSecurityScreen> {
  bool _twoFactorEnabled = false;
  bool _biometricEnabled = true;
  bool _dataEncryption = true;
  bool _sessionTimeout = true;

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
          'Sécurité & Confidentialité',
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
            // Status badge
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ThemeConfig.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ThemeConfig.successColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified,
                    color: ThemeConfig.successColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sécurité activée',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Toutes vos données sont protégées',
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
            // Security options
            _buildSectionTitle('Authentification'),
            const SizedBox(height: 16),
            _buildSecurityCard(
              icon: Icons.fingerprint,
              title: 'Authentification biométrique',
              description: 'Utilisez votre empreinte ou Face ID',
              enabled: _biometricEnabled,
              onChanged: (value) => setState(() => _biometricEnabled = value),
            ),
            _buildSecurityCard(
              icon: Icons.security,
              title: 'Authentification à deux facteurs',
              description: 'Sécurité renforcée avec 2FA',
              enabled: _twoFactorEnabled,
              onChanged: (value) => setState(() => _twoFactorEnabled = value),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Protection des données'),
            const SizedBox(height: 16),
            _buildSecurityCard(
              icon: Icons.lock,
              title: 'Chiffrement des données',
              description: 'AES-256 pour toutes vos données',
              enabled: _dataEncryption,
              onChanged: (value) => setState(() => _dataEncryption = value),
            ),
            _buildSecurityCard(
              icon: Icons.timer_off,
              title: 'Déconnexion automatique',
              description: 'Déconnexion après inactivité',
              enabled: _sessionTimeout,
              onChanged: (value) => setState(() => _sessionTimeout = value),
            ),
            const SizedBox(height: 24),
            // Advanced options
            _buildSectionTitle('Avancé'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.red),
              title: const Text('Effacer l\'historique'),
              subtitle: const Text('Supprimer toutes les données locales'),
              onTap: () {
                // TODO: Confirmer suppression
              },
            ),
            ListTile(
              leading: const Icon(Icons.download, color: ThemeConfig.boostlyBlue),
              title: const Text('Exporter mes données'),
              subtitle: const Text('Télécharger une copie de vos données'),
              onTap: () {
                // TODO: Exporter données
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

  Widget _buildSecurityCard({
    required IconData icon,
    required String title,
    required String description,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: enabled ? ThemeConfig.boostlyBlue : const Color(0xFFE0E0E0),
          width: enabled ? 2 : 1,
        ),
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
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.grey],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: enabled
                        ? ThemeConfig.successColor.withValues(alpha: 0.15)
                        : Colors.red.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    enabled ? 'ACTIF' : 'INACTIF',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: enabled ? ThemeConfig.successColor : Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: ThemeConfig.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: onChanged,
            activeThumbColor: ThemeConfig.boostlyBlue,
          ),
        ],
      ),
    );
  }
}

