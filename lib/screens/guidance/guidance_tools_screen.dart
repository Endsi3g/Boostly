/**
 * BOOSTLY - Écran Guidance Tools
 * 
 * Outils de guidance et tutoriels interactifs.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class GuidanceToolsScreen extends StatefulWidget {
  const GuidanceToolsScreen({super.key});

  @override
  State<GuidanceToolsScreen> createState() => _GuidanceToolsScreenState();
}

class _GuidanceToolsScreenState extends State<GuidanceToolsScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  final List<GuidanceStep> _steps = [
    GuidanceStep(
      title: 'Bienvenue sur Boostly',
      description: 'Découvrez comment transformer vos objectifs en succès.',
      emoji: '🚀',
    ),
    GuidanceStep(
      title: 'Créez vos premières tâches',
      description: 'Organisez votre quotidien avec des tâches simples et efficaces.',
      emoji: '✅',
    ),
    GuidanceStep(
      title: 'Gagnez des XP',
      description: 'Chaque tâche complétée vous rapporte des points d\'expérience.',
      emoji: '⭐',
    ),
    GuidanceStep(
      title: 'Débloquez des badges',
      description: 'Atteignez des objectifs et collectionnez des badges exclusifs.',
      emoji: '🏆',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _steps.length,
                  (index) => Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentStep == index
                          ? ThemeConfig.boostlyBlue
                          : const Color(0xFFE0E0E0),
                    ),
                  ),
                ),
              ),
            ),
            // Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentStep = index);
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Illustration
                        Container(
                          width: 200,
                          height: 200,
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ThemeConfig.boostlyBlue,
                                ThemeConfig.secondaryColor,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              step.emoji,
                              style: const TextStyle(fontSize: 100),
                            ),
                          ),
                        ),
                        // Title
                        Text(
                          step.title,
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
                          step.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: ThemeConfig.textPrimary,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text(
                      'Passer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6D7688),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentStep < _steps.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        context.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConfig.boostlyBlue,
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Icon(
                      _currentStep < _steps.length - 1
                          ? Icons.arrow_forward
                          : Icons.check,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuidanceStep {
  final String title;
  final String description;
  final String emoji;

  GuidanceStep({
    required this.title,
    required this.description,
    required this.emoji,
  });
}

