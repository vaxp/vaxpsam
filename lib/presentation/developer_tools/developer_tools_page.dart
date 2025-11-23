import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers.dart';
import '../home/widgets/section_widgets.dart';
import '../../core/theme/app_theme.dart';
import 'web_frontend/web_frontend_page.dart';
import 'web_backend/web_backend_page.dart';
import 'devops_sysadmin/devops_sysadmin_page.dart';
import 'mobile_developer/mobile_developer_page.dart';
import 'desktop_developer/desktop_developer_page.dart';
import 'planning_documentation/planning_documentation_page.dart';

class DeveloperToolsPage extends ConsumerWidget {
  const DeveloperToolsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
        slivers: [
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
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 400) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1;
            }

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
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
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WebFrontendPage(),
                        ),
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
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WebBackendPage(),
                        ),
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
                    child: const Icon(
                      Icons.settings_applications,
                      color: Colors.white,
                    ),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DevOpsSysadminPage(),
                        ),
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
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MobileDeveloperPage(),
                        ),
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
                    child: const Icon(
                      Icons.desktop_windows,
                      color: Colors.white,
                    ),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DesktopDeveloperPage(),
                        ),
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
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PlanningDocumentationPage(),
                        ),
                      ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
