/**
 * BOOSTLY - Écran Mascotte
 * 
 * Prévisualisation et personnalisation de la mascotte, conforme au design UX "Mascot Creator".
 * 
 * @author BOOSTLY Team
 * @date 2025-01-09
 * @version 1.0.0
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme_config.dart';
import '../../providers/mascot_provider.dart';

class MascotScreen extends StatefulWidget {
  const MascotScreen({super.key});

  @override
  State<MascotScreen> createState() => _MascotScreenState();
}

class _MascotScreenState extends State<MascotScreen> with SingleTickerProviderStateMixin {
  String _selectedCategory = 'hat';
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'hat', 'name': 'Chapeaux', 'icon': Icons.celebration},
    {'id': 'glasses', 'name': 'Lunettes', 'icon': Icons.visibility},
    {'id': 'badge', 'name': 'Badges', 'icon': Icons.star},
    {'id': 'background', 'name': 'Fonds', 'icon': Icons.palette},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header avec gradient
          _buildHeader(),
          // Contenu principal
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Prévisualisation de la mascotte
                  _buildMascotPreview(),
                  // Progression de la collection
                  _buildCollectionProgress(),
                  // Catégories
                  _buildCategoryTabs(),
                  // Grille d'accessoires
                  _buildAccessoriesGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ThemeConfig.boostlyBlue, ThemeConfig.boostlyPurple],
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeConfig.boostlyBlue.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 12),
              const Text(
                'Personnalise Ta Mascotte',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.info_outline, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMascotPreview() {
    return Consumer<MascotProvider>(
      builder: (context, mascotProvider, _) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ThemeConfig.boostlyBlue.withValues(alpha: 0.03),
                ThemeConfig.boostlyPurple.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: ThemeConfig.boostlyBlue.withValues(alpha: 0.2),
              width: 3,
            ),
          ),
          child: Column(
            children: [
              // Mascotte animée
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (_animationController.value * 0.02),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '🌱',
                          style: TextStyle(fontSize: 120),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Nom de la mascotte
              Text(
                mascotProvider.mascot?.name ?? 'Boosty',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: ThemeConfig.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              // Message d'encouragement
              Text(
                mascotProvider.currentMessage ?? 'Continue comme ça ! 💪',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeConfig.textSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollectionProgress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ThemeConfig.successColor.withValues(alpha: 0.08),
            ThemeConfig.successColor.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: ThemeConfig.successColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progression de la collection',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ThemeConfig.textPrimary,
                ),
              ),
              Text(
                '12/45',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: ThemeConfig.successColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: ThemeConfig.successColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 12 / 45,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ThemeConfig.successColor, Color(0xFF66BB6A)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, size: 14, color: Color(0xFFFFD700)),
              const SizedBox(width: 6),
              Text(
                'Débloquez plus d\'accessoires en complétant des tâches !',
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeConfig.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category['id'];
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category['name'] as String),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category['id'] as String;
                });
              },
              selectedColor: ThemeConfig.boostlyBlue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF6D7688),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : const Color(0xFFE8EAF6),
                  width: 2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccessoriesGrid() {
    // Accessoires simulés pour la démo
    final accessories = List.generate(9, (index) => {
      'id': 'accessory_$index',
      'name': 'Accessoire ${index + 1}',
      'unlocked': index < 3,
      'premium': index >= 6,
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _categories.firstWhere((c) => c['id'] == _selectedCategory)['name'] as String,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ThemeConfig.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: accessories.length,
            itemBuilder: (context, index) {
              final accessory = accessories[index];
              final isUnlocked = accessory['unlocked'] as bool;
              final isPremium = accessory['premium'] as bool;
              
              return _buildAccessoryCard(accessory, isUnlocked, isPremium);
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAccessoryCard(Map<String, dynamic> accessory, bool isUnlocked, bool isPremium) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isUnlocked ? ThemeConfig.successColor : const Color(0xFFE8EAF6),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icône de l'accessoire
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: ThemeConfig.boostlyBlue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _categories.firstWhere((c) => c['id'] == _selectedCategory)['icon'] as IconData,
                  size: 40,
                  color: isUnlocked ? ThemeConfig.boostlyBlue : ThemeConfig.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              // Nom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  accessory['name'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ThemeConfig.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Badge verrouillé
          if (!isUnlocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          // Badge premium
          if (isPremium && isUnlocked)
            Positioned(
              top: -6,
              right: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'PREMIUM',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: ThemeConfig.textPrimary,
                  ),
                ),
              ),
            ),
          // Checkmark si équipé
          if (isUnlocked)
            Positioned(
              top: -6,
              right: -6,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: ThemeConfig.successColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ThemeConfig.successColor,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
