import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../infrastructure/providers.dart';
import 'home/widgets/section_widgets.dart';
import 'console/console_utils.dart';
import 'theme/app_theme.dart';

class BrowsersPage extends ConsumerWidget {
  const BrowsersPage({super.key});

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
                _buildBrowserGrid(context, system),
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
          colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
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
                  colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
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
                  'WEB BROWSERS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Browse the Web',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Install popular web browsers for the best browsing experience.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrowserGrid(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'All Browsers',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ResponsiveGrid(
          children: [
            AppGridCard(
              title: 'Firefox',
              description: 'Mozilla Firefox',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.language, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName('firefox'),
                  ),
            ),
            AppGridCard(
              title: 'Brave',
              description: 'Privacy-focused browser',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.security, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName('brave-browser'),
                  ),
            ),
            AppGridCard(
              title: 'Chromium',
              description: 'Open-source Chrome',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.web, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName('chromium'),
                  ),
            ),
            AppGridCard(
              title: 'Opera',
              description: 'Fast and secure browser',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0000),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.public, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName('opera'),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
