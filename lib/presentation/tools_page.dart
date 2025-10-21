import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../infrastructure/providers.dart';
import 'home/widgets/section_widgets.dart';
import 'console/console_utils.dart';
import '../core/theme/app_theme.dart';

class ToolsPage extends ConsumerWidget {
  const ToolsPage({super.key});

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
                _buildToolsGrid(context, system),
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
          colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
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
                  colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
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
                  'DEVELOPMENT TOOLS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Build & Create',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Essential tools for developers and system administrators.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolsGrid(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'All Tools',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            AppGridCard(
              title: 'Git',
              description: 'Version control system',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF05032),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.account_tree, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName('git'),
                  ),
            ),
            AppGridCard(
              title: 'VS Code',
              description: 'Code editor',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF007ACC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.code, color: Colors.white),
              ),
              onTap: () {
                const debUrl =
                    'https://update.code.visualstudio.com/latest/linux-deb-x64/stable';
                showConsoleStream(context, system.installDebFromUrl(debUrl));
              },
            ),
            AppGridCard(
              title: 'FileZilla',
              description: 'FTP client',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBF0000),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.folder, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName('filezilla'),
                  ),
            ),
            AppGridCard(
              title: 'GParted',
              description: 'Partition editor',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.storage, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName('gparted'),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
