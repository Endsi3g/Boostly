/**
 * BOOSTLY - Écran Wellbeing Concepts
 * 
 * Suivi de l'humeur et de l'énergie pour le bien-être.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class WellbeingAppConceptsScreen extends StatefulWidget {
  const WellbeingAppConceptsScreen({super.key});

  @override
  State<WellbeingAppConceptsScreen> createState() => _WellbeingAppConceptsScreenState();
}

class _WellbeingAppConceptsScreenState extends State<WellbeingAppConceptsScreen> {
  double _energyValue = 5.0;
  String _selectedMood = '😊';

  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😢', 'label': 'Triste'},
    {'emoji': '😕', 'label': 'Déçu'},
    {'emoji': '😐', 'label': 'Neutre'},
    {'emoji': '😊', 'label': 'Content'},
    {'emoji': '🤩', 'label': 'Excellent'},
  ];

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
          'Humeur & Énergie',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Hero mood card
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ThemeConfig.secondaryColor, const Color(0xFFE91E63)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ThemeConfig.secondaryColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _selectedMood,
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Comment vous sentez-vous ?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Mood emojis
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _moods.map((mood) {
                      final isSelected = _selectedMood == mood['emoji'];
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedMood = mood['emoji'] as String);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.3)
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  mood['emoji'] as String,
                                  style: TextStyle(
                                    fontSize: isSelected ? 36 : 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mood['label'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Energy section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Niveau d\'énergie',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _energyValue,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _energyValue.round().toString(),
                    activeColor: ThemeConfig.boostlyBlue,
                    onChanged: (value) {
                      setState(() => _energyValue = value);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Faible',
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeConfig.textSecondary,
                        ),
                      ),
                      Text(
                        'Élevé',
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeConfig.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Save button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Sauvegarder humeur
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeConfig.boostlyBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Enregistrer',
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
    );
  }
}

