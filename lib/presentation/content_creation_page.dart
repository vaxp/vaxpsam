import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../infrastructure/providers.dart';
import 'home/widgets/section_widgets.dart';
import 'theme/app_theme.dart';
import 'content_creation/graphics_design_page.dart';
import 'content_creation/video_production_page.dart';
import 'content_creation/audio_editing_page.dart';

class ContentCreationPage extends ConsumerWidget {
  const ContentCreationPage({super.key});

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
          colors: [Color(0xFFE91E63), Color(0xFFF06292)],
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
                  colors: [Color(0xFFE91E63), Color(0xFFF06292)],
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
                  'CONTENT CREATION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Creative Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Professional tools for graphics, video production, and audio editing.',
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
              title: 'Graphics & Design',
              description: '10 graphics and design tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.palette, color: Colors.white),
              ),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const GraphicsDesignPage(),
                    ),
                  ),
            ),
            AppGridCard(
              title: 'Video Production',
              description: '10 video production tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.videocam, color: Colors.white),
              ),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const VideoProductionPage(),
                    ),
                  ),
            ),
            AppGridCard(
              title: 'Audio Editing & Podcasting',
              description: '10 audio editing tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.music_note, color: Colors.white),
              ),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AudioEditingPage()),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
