/**
 * BOOSTLY - Écran d'Accueil
 * 
 * Écran principal conforme au design UX "Visual To-Do App".
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme_config.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Accueil',
      route: '/home',
    ),
    NavigationItem(
      icon: Icons.task_outlined,
      selectedIcon: Icons.task,
      label: 'Tâches',
      route: '/tasks',
    ),
    NavigationItem(
      icon: Icons.emoji_emotions_outlined,
      selectedIcon: Icons.emoji_emotions,
      label: 'Mascotte',
      route: '/mascot',
    ),
    NavigationItem(
      icon: Icons.library_books_outlined,
      selectedIcon: Icons.library_books,
      label: 'Ressources',
      route: '/resources',
    ),
    NavigationItem(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
      label: 'Analytics',
      route: '/analytics',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    context.go(_navigationItems[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.surfaceColor,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeContent(),
          _buildPlaceholder('Tâches'),
          _buildPlaceholder('Mascotte'),
          _buildPlaceholder('Ressources'),
          _buildPlaceholder('Analytics'),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: ThemeConfig.surfaceColor, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 430),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navigationItems.length, (index) {
                final item = _navigationItems[index];
                final isSelected = _currentIndex == index;
                return Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? item.selectedIcon : item.icon,
                            color: isSelected ? ThemeConfig.boostlyBlue : const Color(0xFF6B7C98),
                            size: 22,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? ThemeConfig.boostlyBlue : const Color(0xFF6B7C98),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/tasks'),
        backgroundColor: ThemeConfig.boostlyBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec mascotte
            _buildHeader(),
            const SizedBox(height: 20),
            // Section Progression
            _buildProgressSection(),
            const SizedBox(height: 20),
            // Section Tâches
            _buildTasksSection(),
            const SizedBox(height: 20),
            // Accès rapide
            _buildQuickAccess(),
            const SizedBox(height: 100), // Espace pour le FAB
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final userName = userProvider.user?.displayName ?? 'Utilisateur';
        return Row(
          children: [
            // Mascotte avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F0FF),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '✨',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Texte de bienvenue
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prêt à avancer ✨, $userName!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      color: ThemeConfig.textPrimary,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Aujourd\'hui: Lancer la Phase 1',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6B7C98),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mon Progrès',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: ThemeConfig.textPrimary,
                ),
              ),
              const Icon(
                Icons.trending_up,
                color: Color(0xFF6B7C98),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Barre de progression
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Objectif du mois',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6B7C98),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '60%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6B7C98),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: ThemeConfig.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeConfig.boostlyBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Métriques
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: ThemeConfig.successColor,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                '25/40 Tâches Complétées',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ThemeConfig.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksSection() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        final tasks = taskProvider.pendingTasks.take(5).toList();
        
        return Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tâches du Jour',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ThemeConfig.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: ThemeConfig.boostlyBlue,
                      size: 18,
                    ),
                    onPressed: () => context.go('/tasks'),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (tasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Aucune tâche pour aujourd\'hui',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6B7C98),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.go('/tasks'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeConfig.boostlyBlue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Créer une tâche'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...tasks.map((task) => _buildTaskItem(task)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskItem(task) {
    return InkWell(
      onTap: () => context.go('/task/${task.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF6B7C98),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: task.isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 15),
            // Contenu de la tâche
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
                      color: ThemeConfig.textPrimary,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (task.dueDate != null)
                    Text(
                      _formatDueDate(task.dueDate!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF6B7C98),
                        fontSize: 13,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
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

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);
    
    if (taskDate == today) {
      return 'Aujourd\'hui, ${date.hour}h';
    } else if (taskDate == today.add(const Duration(days: 1))) {
      return 'Demain, ${date.hour}h';
    } else {
      final weekdays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
      return '${weekdays[date.weekday - 1]}, ${date.hour}h';
    }
  }

  Widget _buildQuickAccess() {
    final quickItems = [
      {'icon': Icons.book_outlined, 'label': 'Ressources'},
      {'icon': Icons.chat_bubble_outline, 'label': 'Mentorat'},
      {'icon': Icons.bar_chart, 'label': 'Statistiques'},
      {'icon': Icons.emoji_emotions_outlined, 'label': 'Mascotte'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: quickItems.length,
            itemBuilder: (context, index) {
              final item = quickItems[index];
              return Container(
                width: 100,
                margin: EdgeInsets.only(right: index < quickItems.length - 1 ? 15 : 0),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: ThemeConfig.boostlyBlue,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['label'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ThemeConfig.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
  });
}
