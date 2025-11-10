/**
 * BOOSTLY - Données de Test
 * 
 * Fixtures pour les tests.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

// Note: Les fixtures nécessitent que les modèles soient dans app/lib/
// Pour l'instant, données de test basiques

/// Tâche de test (structure basique)
Map<String, dynamic> get testTask => {
  'id': 'test-task-1',
  'title': 'Tâche de test',
  'description': 'Description de la tâche de test',
  'status': 'todo',
  'priority': 'medium',
};

/// Utilisateur de test (structure basique)
Map<String, dynamic> get testUser => {
  'id': 'test-user-1',
  'email': 'test@boostly.app',
  'displayName': 'Test User',
};

/// Liste de tâches de test
List<Map<String, dynamic>> get testTasks => [
  testTask,
  {
    'id': 'test-task-2',
    'title': 'Tâche complétée',
    'status': 'completed',
  },
];
