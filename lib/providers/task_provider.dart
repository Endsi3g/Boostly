/**
 * BOOSTLY - Provider Tâches
 * 
 * Gère l'état de toutes les tâches de l'utilisateur.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

/// Provider pour gérer l'état des tâches
class TaskProvider extends ChangeNotifier {
  AuthService? _authService;
  FirestoreService? _firestoreService;
  
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  String? _currentFilter;
  bool _isLoading = false;
  String? _errorMessage;

  List<Task> get tasks => _filteredTasks.isEmpty ? _tasks : _filteredTasks;
  List<Task> get completedTasks => _tasks.where((t) => t.isCompleted).toList();
  List<Task> get pendingTasks => _tasks.where((t) => !t.isCompleted).toList();
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get totalTasks => _tasks.length;
  int get completedCount => completedTasks.length;

  /// Définit le service d'authentification
  void setAuthService(AuthService authService) {
    _authService = authService;
    _firestoreService = FirestoreService();
    if (_authService!.isAuthenticated) {
      _loadTasks();
    }
  }

  /// Charge toutes les tâches de l'utilisateur
  Future<void> _loadTasks() async {
    if (_authService?.currentFirebaseUser == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final userId = _authService!.currentFirebaseUser!.uid;
      _tasks = await _firestoreService!.getUserTasks(userId);
      _applyFilter();

      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Crée une nouvelle tâche
  Future<bool> createTask(Task task) async {
    if (_authService?.currentFirebaseUser == null) return false;

    try {
      _isLoading = true;
      notifyListeners();

      final userId = _authService!.currentFirebaseUser!.uid;
      final taskWithUser = task.copyWith(userId: userId);
      final taskId = await _firestoreService!.createTask(taskWithUser);
      
      final createdTask = taskWithUser.copyWith(id: taskId);
      _tasks.insert(0, createdTask);
      _applyFilter();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Met à jour une tâche
  Future<bool> updateTask(Task task) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestoreService!.updateTask(task);
      
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        _applyFilter();
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Supprime une tâche
  Future<bool> deleteTask(String taskId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestoreService!.deleteTask(taskId);
      _tasks.removeWhere((t) => t.id == taskId);
      _applyFilter();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Marque une tâche comme complétée
  Future<bool> completeTask(String taskId) async {
    final task = _tasks.firstWhere((t) => t.id == taskId);
    final completedTask = task.copyWith(
      status: TaskStatus.completed,
      completedAt: DateTime.now(),
    );
    return await updateTask(completedTask);
  }

  /// Filtre les tâches
  void filterTasks({String? status, String? category, String? priority}) {
    _currentFilter = status ?? category ?? priority;
    _applyFilter();
  }

  /// Applique le filtre actuel
  void _applyFilter() {
    if (_currentFilter == null) {
      _filteredTasks = _tasks;
    } else {
      _filteredTasks = _tasks.where((task) {
        if (_currentFilter == task.status) return true;
        if (_currentFilter == task.category) return true;
        if (_currentFilter == task.priority) return true;
        return false;
      }).toList();
    }
    notifyListeners();
  }

  /// Réinitialise le filtre
  void clearFilter() {
    _currentFilter = null;
    _filteredTasks = [];
    notifyListeners();
  }

  /// Rafraîchit la liste des tâches
  Future<void> refresh() async {
    await _loadTasks();
  }
}

