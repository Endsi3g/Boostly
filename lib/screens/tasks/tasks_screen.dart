/**
 * BOOSTLY - Écran des Tâches
 * 
 * Liste complète des tâches avec filtres, conforme au design UX "Visual To-Do App".
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';
import '../../providers/task_provider.dart';
import '../../models/task.dart';
import '../../utils/constants.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String? _selectedFilter;
  final List<String> _filters = ['Toutes', 'En cours', 'Complétées', 'En retard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.surfaceColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Mes Tâches',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: ThemeConfig.textPrimary,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: ThemeConfig.boostlyBlue),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtres
          if (_selectedFilter != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    'Filtre: $_selectedFilter',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ThemeConfig.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilter = null;
                      });
                      context.read<TaskProvider>().clearFilter();
                    },
                    child: const Text('Effacer'),
                  ),
                ],
              ),
            ),
          // Liste des tâches
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, _) {
                if (taskProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasks = _selectedFilter == null
                    ? taskProvider.tasks
                    : _selectedFilter == 'Complétées'
                        ? taskProvider.completedTasks
                        : _selectedFilter == 'En cours'
                            ? taskProvider.pendingTasks
                            : taskProvider.tasks;

                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_outlined,
                          size: 64,
                          color: ThemeConfig.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune tâche',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: ThemeConfig.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Créez votre première tâche pour commencer',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ThemeConfig.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => _showAddTaskDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeConfig.boostlyBlue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Créer une tâche'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return _buildTaskItem(context, task, taskProvider);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        backgroundColor: ThemeConfig.boostlyBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task, TaskProvider taskProvider) {
    final isCompleted = task.isCompleted;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.go('/task/${task.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Checkbox
              GestureDetector(
                onTap: () {
                  if (isCompleted) {
                    // Marquer comme non complétée
                    final uncompletedTask = task.copyWith(
                      status: TaskStatus.todo,
                      completedAt: null,
                    );
                    taskProvider.updateTask(uncompletedTask);
                  } else {
                    taskProvider.completeTask(task.id);
                  }
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted ? ThemeConfig.boostlyBlue : Colors.transparent,
                    border: Border.all(
                      color: isCompleted ? ThemeConfig.boostlyBlue : const Color(0xFF6B7C98),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isCompleted
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 15),
              // Contenu
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isCompleted ? const Color(0xFF6B7C98) : ThemeConfig.textPrimary,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (task.description != null && task.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          task.description!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF6B7C98),
                            fontSize: 13,
                            decoration: isCompleted ? TextDecoration.lineThrough : null,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (task.dueDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: task.isOverdue && !isCompleted
                                  ? ThemeConfig.errorColor
                                  : const Color(0xFF6B7C98),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatDueDate(task.dueDate!),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: task.isOverdue && !isCompleted
                                    ? ThemeConfig.errorColor
                                    : const Color(0xFF6B7C98),
                                fontSize: 13,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (task.category.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            TaskCategories.displayNames[task.category] ?? task.category,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ThemeConfig.boostlyBlue,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Menu
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Color(0xFF6B7C98)),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 18),
                        SizedBox(width: 8),
                        Text('Modifier'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 18, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Supprimer', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'delete') {
                    _confirmDelete(context, task, taskProvider);
                  } else if (value == 'edit') {
                    context.go('/task/${task.id}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);
    
    if (taskDate == today) {
      return 'Aujourd\'hui, ${date.hour}h';
    } else if (taskDate == today.add(const Duration(days: 1))) {
      return 'Demain, ${date.hour}h';
    } else {
      final weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
      return '${weekdays[date.weekday - 1]}, ${date.day}/${date.month}';
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtrer les tâches',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            ..._filters.map((filter) => ListTile(
              title: Text(filter),
              trailing: _selectedFilter == filter
                  ? const Icon(Icons.check, color: ThemeConfig.boostlyBlue)
                  : null,
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
                Navigator.pop(context);
                // Appliquer le filtre
                if (filter == 'Complétées') {
                  context.read<TaskProvider>().filterTasks(status: TaskStatus.completed);
                } else if (filter == 'En cours') {
                  context.read<TaskProvider>().filterTasks(status: TaskStatus.todo);
                } else {
                  context.read<TaskProvider>().clearFilter();
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = TaskCategories.personal;
    String selectedPriority = TaskPriorities.medium;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Nouvelle tâche'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optionnel)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Catégorie',
                    border: OutlineInputBorder(),
                  ),
                  items: TaskCategories.all.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(TaskCategories.displayNames[cat] ?? cat),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => selectedCategory = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedPriority,
                  decoration: const InputDecoration(
                    labelText: 'Priorité',
                    border: OutlineInputBorder(),
                  ),
                  items: TaskPriorities.all.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(TaskPriorities.displayNames[priority] ?? priority),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => selectedPriority = value);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez entrer un titre')),
                  );
                  return;
                }

                final newTask = Task(
                  id: '',
                  userId: '',
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  category: selectedCategory,
                  priority: selectedPriority,
                  status: TaskStatus.todo,
                  createdAt: DateTime.now(),
                );

                context.read<TaskProvider>().createTask(newTask);
                Navigator.pop(context);
              },
              child: const Text('Créer'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Task task, TaskProvider taskProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la tâche'),
        content: Text('Êtes-vous sûr de vouloir supprimer "${task.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              taskProvider.deleteTask(task.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConfig.errorColor,
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
