import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers.dart';
import '../home/widgets/section_widgets.dart';
import '../theme/app_theme.dart';
import 'developer_tools/web_frontend_page.dart';
import 'developer_tools/web_backend_page.dart';
import 'developer_tools/devops_sysadmin_page.dart';
import 'developer_tools/mobile_developer_page.dart';
import 'developer_tools/desktop_developer_page.dart';
import 'developer_tools/planning_documentation_page.dart';

class DeveloperToolsPage extends ConsumerWidget {
  const DeveloperToolsPage({super.key});

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
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
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
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
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
                  'DEVELOPER TOOLS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Build & Deploy',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Professional development tools for web development, backend services, and DevOps operations.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
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
              title: 'Web Front-End',
              description: '30 front-end development tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.web, color: Colors.white),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const WebFrontendPage()),
              ),
            ),
            AppGridCard(
              title: 'Web Back-End',
              description: '30 backend development tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.storage, color: Colors.white),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const WebBackendPage()),
              ),
            ),
            AppGridCard(
              title: 'DevOps / SysAdmin',
              description: '30 DevOps and system admin tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.settings_applications, color: Colors.white),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DevOpsSysadminPage()),
              ),
            ),
            AppGridCard(
              title: 'Mobile Developer',
              description: '30 Android development tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.phone_android, color: Colors.white),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MobileDeveloperPage()),
              ),
            ),
            AppGridCard(
              title: 'Desktop Developer',
              description: '30 desktop development tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF795548),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.desktop_windows, color: Colors.white),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DesktopDeveloperPage()),
              ),
            ),
            AppGridCard(
              title: 'Planning & Documentation',
              description: '30 documentation tools',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF607D8B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.description, color: Colors.white),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PlanningDocumentationPage()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
