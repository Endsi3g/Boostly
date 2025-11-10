/**
 * BOOSTLY - Écran Brainstorm Idées
 * 
 * Génération d'idées de tâches avec IA.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme_config.dart';
import '../../services/ai_service.dart';

class BrainstormIdeasScreen extends StatefulWidget {
  const BrainstormIdeasScreen({super.key});

  @override
  State<BrainstormIdeasScreen> createState() => _BrainstormIdeasScreenState();
}

class _BrainstormIdeasScreenState extends State<BrainstormIdeasScreen> {
  final TextEditingController _topicController = TextEditingController();
  final List<String> _ideas = [];
  bool _isGenerating = false;

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  Future<void> _generateIdeas() async {
    if (_topicController.text.trim().isEmpty) return;
    
    setState(() {
      _isGenerating = true;
      _ideas.clear();
    });

    try {
      final aiService = context.read<AIService>();
      final ideas = await aiService.generateIdeas(_topicController.text.trim());
      
      setState(() {
        _isGenerating = false;
        _ideas.addAll(ideas);
      });
    } catch (e) {
      setState(() {
        _isGenerating = false;
        _ideas.addAll([
          'Idée 1 basée sur ${_topicController.text}',
          'Idée 2 basée sur ${_topicController.text}',
          'Idée 3 basée sur ${_topicController.text}',
        ]);
      });
    }
  }

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
          'Brainstorm Idées',
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                    ThemeConfig.secondaryColor.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _topicController,
                    decoration: InputDecoration(
                      labelText: 'Sujet ou domaine',
                      hintText: 'Ex: Productivité, Fitness, Apprentissage...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lightbulb_outline),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isGenerating ? null : _generateIdeas,
                      icon: _isGenerating
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.auto_awesome),
                      label: Text(_isGenerating ? 'Génération...' : 'Générer des idées'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConfig.boostlyBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_ideas.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Idées générées',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              ..._ideas.map((idea) => _buildIdeaCard(idea)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIdeaCard(String idea) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(child: Text(idea)),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // TODO: Ajouter comme tâche
            },
          ),
        ],
      ),
    );
  }
}

