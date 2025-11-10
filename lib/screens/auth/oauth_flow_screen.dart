/**
 * BOOSTLY - Écran OAuth Flow
 * 
 * Processus de connexion OAuth avec Google/Apple.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';
import '../../services/auth_service.dart';
import 'package:provider/provider.dart';

class OAuthFlowScreen extends StatefulWidget {
  final String provider; // 'google' ou 'apple'

  const OAuthFlowScreen({
    super.key,
    required this.provider,
  });

  @override
  State<OAuthFlowScreen> createState() => _OAuthFlowScreenState();
}

class _OAuthFlowScreenState extends State<OAuthFlowScreen> {
  bool _isConnecting = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initiateOAuth();
  }

  Future<void> _initiateOAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isConnecting = false);
  }

  Future<void> _handleOAuth() async {
    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      
      if (widget.provider == 'google') {
        await authService.signInWithGoogle();
      } else if (widget.provider == 'apple') {
        await authService.signInWithApple();
      }

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isConnecting
            ? _buildConnectingView()
            : _buildOAuthView(),
      ),
    );
  }

  Widget _buildConnectingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.provider == 'google'
                    ? [const Color(0xFF4285F4), const Color(0xFF34A853)]
                    : [Colors.black, Colors.grey],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: ThemeConfig.boostlyBlue.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              widget.provider == 'google' ? Icons.g_mobiledata : Icons.apple,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          const Text(
            'Connexion en cours...',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Veuillez patienter',
            style: TextStyle(
              fontSize: 14,
              color: ThemeConfig.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOAuthView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.provider == 'google'
                    ? [const Color(0xFF4285F4), const Color(0xFF34A853)]
                    : [Colors.black, Colors.grey],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              widget.provider == 'google' ? Icons.g_mobiledata : Icons.apple,
              size: 32,
              color: Colors.white,
            ),
          ),
          Text(
            widget.provider == 'google'
                ? 'Connexion avec Google'
                : 'Connexion avec Apple',
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Autorisez Boostly à accéder à votre compte',
            style: TextStyle(
              fontSize: 14,
              color: ThemeConfig.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          // OAuth button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleOAuth,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.provider == 'google'
                    ? const Color(0xFF4285F4)
                    : Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.provider == 'google'
                              ? Icons.g_mobiledata
                              : Icons.apple,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Continuer avec ${widget.provider == 'google' ? 'Google' : 'Apple'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'Annuler',
              style: TextStyle(
                color: ThemeConfig.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

