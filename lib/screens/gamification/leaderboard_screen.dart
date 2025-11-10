/**
 * BOOSTLY - Écran Leaderboard
 * 
 * Affiche les classements des utilisateurs.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme_config.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _selectedTab = 'global';
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ThemeConfig.boostlyBlue,
                  ThemeConfig.secondaryColor,
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Classements',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 16),
                // Tab switcher
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTabButton('global', 'Global'),
                      ),
                      Expanded(
                        child: _buildTabButton('friends', 'Amis'),
                      ),
                      Expanded(
                        child: _buildTabButton('weekly', 'Semaine'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Filters
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedFilter,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFFE8EAF6), width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('Tous')),
                      DropdownMenuItem(value: 'xp', child: Text('XP')),
                      DropdownMenuItem(value: 'level', child: Text('Niveau')),
                      DropdownMenuItem(value: 'streak', child: Text('Série')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedFilter = value ?? 'all';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Leaderboard list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 20, // TODO: Remplacer par données réelles
              itemBuilder: (context, index) {
                final rank = index + 1;
                final isTopThree = rank <= 3;
                return _buildLeaderboardItem(rank, isTopThree);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String value, String label) {
    final isSelected = _selectedTab == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? ThemeConfig.boostlyBlue : Colors.white.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(int rank, bool isTopThree) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isTopThree ? ThemeConfig.boostlyBlue : const Color(0xFFE8EAF6),
          width: isTopThree ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isTopThree
                  ? ThemeConfig.boostlyBlue
                  : const Color(0xFFE8EAF6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: isTopThree ? Colors.white : ThemeConfig.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
            child: const Icon(Icons.person, color: ThemeConfig.boostlyBlue),
          ),
          const SizedBox(width: 16),
          // Name and stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Utilisateur $rank',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ThemeConfig.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${1000 - rank * 50} XP',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ThemeConfig.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Trophy icon for top 3
          if (isTopThree)
            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 24,
            ),
        ],
      ),
    );
  }
}

