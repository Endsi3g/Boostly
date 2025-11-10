/**
 * BOOSTLY - Écran Détail Tâche
 * 
 * Affichage et édition des détails d'une tâche.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail de la tâche'),
      ),
      body: Center(
        child: Text('Détail de la tâche $taskId - À implémenter'),
      ),
    );
  }
}

