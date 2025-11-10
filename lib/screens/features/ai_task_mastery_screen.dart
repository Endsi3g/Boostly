/**
 * BOOSTLY - Écran IA Maîtrise Tâches
 * 
 * Génération automatique de micro-objectifs avec IA.
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
import '../../providers/task_provider.dart';

class AITaskMasteryScreen extends StatefulWidget {
  const AITaskMasteryScreen({super.key});

  @override
  State<AITaskMasteryScreen> createState() => _AITaskMasteryScreenState();
}

class _AITaskMasteryScreenState extends State<AITaskMasteryScreen> {
  String? _selectedTask;
  bool _isGenerating = false;
  final List<Map<String, dynamic>> _microTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ThemeConfig.secondaryColor, ThemeConfig.boostlyBlue],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.psychology, size: 14, color: Colors.white),
                              const SizedBox(width: 6),
                              const Text(
                                'IA',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Micro-Objectifs\nAuto-Générés',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'L\'IA décompose vos tâches en étapes simples',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task selector
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sélectionnez une tâche',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF6B7C98),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedTask,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                            ),
                            filled: true,
                            fillColor: ThemeConfig.surfaceColor,
                          ),
                          items: _getAvailableTasks(context)
                              .map((task) => DropdownMenuItem(
                                    value: task,
                                    child: Text(task),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => _selectedTask = value);
                          },
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _selectedTask != null && !_isGenerating
                                ? () async {
                                    setState(() => _isGenerating = true);
                                    
                                    final aiService = context.read<AIService>();
                                    final microTasks = await aiService.generateMicroTasks(
                                      _selectedTask!,
                                      null,
                                    );
                                    
                                    setState(() {
                                      _isGenerating = false;
                                      _microTasks.clear();
                                      _microTasks.addAll(
                                        microTasks.map((task) => {
                                          'title': task,
                                          'completed': false,
                                        }).toList(),
                                      );
                                    });
                                  }
                                : null,
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
                            label: Text(_isGenerating ? 'Génération...' : 'Générer avec IA'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeConfig.secondaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_microTasks.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Micro-objectifs générés',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._microTasks.map((task) => _buildMicroTaskCard(task)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getAvailableTasks(BuildContext context) {
    try {
      final taskProvider = context.read<TaskProvider>();
      final tasks = taskProvider.tasks
          .where((t) => t.status.toString().contains('todo'))
          .map((t) => t.title)
          .toList();
      return tasks.isNotEmpty ? tasks : ['Tâche 1', 'Tâche 2', 'Tâche 3'];
    } catch (e) {
      return ['Tâche 1', 'Tâche 2', 'Tâche 3'];
    }
  }

  Widget _buildMicroTaskCard(Map<String, dynamic> task) {
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
          Checkbox(
            value: task['completed'] as bool,
            onChanged: (value) {
              setState(() {
                task['completed'] = value ?? false;
              });
            },
            activeColor: ThemeConfig.boostlyBlue,
          ),
          Expanded(
            child: Text(
              task['title'] as String,
              style: TextStyle(
                decoration: task['completed'] as bool
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: task['completed'] as bool
                    ? ThemeConfig.textSecondary
                    : ThemeConfig.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

