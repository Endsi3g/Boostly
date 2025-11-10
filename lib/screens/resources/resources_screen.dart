/**
 * BOOSTLY - Écran Ressources
 * 
 * Bibliothèque de ressources avec catégorisation et favoris.
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../utils/constants.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  String _selectedCategory = 'Tous';
  final List<String> _categories = ['Tous', 'Articles', 'Vidéos', 'Podcasts', 'Conseils'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Ressources',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: ThemeConfig.textPrimary,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: ThemeConfig.boostlyBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Catégories
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: ThemeConfig.boostlyBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : ThemeConfig.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          // Liste des ressources
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildResourceCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(BuildContext context, int index) {
    final types = ['article', 'video', 'podcast', 'tip'];
    final type = types[index % types.length];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icône type
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  type == 'article' ? Icons.article
                      : type == 'video' ? Icons.play_circle
                      : type == 'podcast' ? Icons.headphones
                      : Icons.lightbulb,
                  color: ThemeConfig.boostlyBlue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Contenu
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ressource ${index + 1}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: ThemeConfig.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Description de la ressource...',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ThemeConfig.textSecondary,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            ResourceTypes.displayNames[type] ?? type,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: ThemeConfig.boostlyBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '5 min',
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
              // Favori
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: ThemeConfig.textSecondary,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ResourceTypesExtension on ResourceTypes {
  static const Map<String, String> displayNames = {
    ResourceTypes.article: 'Article',
    ResourceTypes.video: 'Vidéo',
    ResourceTypes.podcast: 'Podcast',
    ResourceTypes.tip: 'Conseil',
  };
}
