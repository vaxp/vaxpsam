import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers.dart';
import '../home/widgets/section_widgets.dart';
import '../theme/app_theme.dart';
import 'gaming_utilities/game_runners_page.dart';
import 'gaming_utilities/media_entertainment_page.dart';
import 'gaming_utilities/system_performance_page.dart';

class GamingUtilitiesPage extends ConsumerWidget {
  const GamingUtilitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: macAppStoreDark,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroSection(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoriesGrid(context, system),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'GAMING & UTILITIES',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Play & Optimize',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Essential gaming tools, media players, and system utilities for the ultimate gaming experience.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'All Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            AppGridCard(
              title: 'Game Runners & Frontends',
              description: '10 gaming tools and platforms',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF171a21),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.videogame_asset, color: Colors.white),
              ),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GameRunnersPage()),
                  ),
            ),
            AppGridCard(
              title: 'Media & Entertainment',
              description: '5 media players and tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                ),
              ),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MediaEntertainmentPage(),
                    ),
                  ),
            ),
            AppGridCard(
              title: 'System & Performance',
              description: '9 system utilities and tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.speed, color: Colors.white),
              ),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SystemPerformancePage(),
                    ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
