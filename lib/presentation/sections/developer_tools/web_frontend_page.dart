import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class WebFrontendPage extends ConsumerWidget {
  const WebFrontendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
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
                  _buildInstallAllSection(context, system),
                  _buildToolsGrid(context, system),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
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
                  'WEB FRONT-END',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Front-End Development Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '30 essential tools for modern front-end development including Node.js, Git, and build automation.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallAllSection(BuildContext context, system) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.download, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Install All Front-End Tools',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 30 front-end development tools at once',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: macAppStoreGray,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _installAllTools(context, system),
                  icon: const Icon(Icons.install_desktop),
                  label: const Text('Install All'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: macAppStoreBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsGrid(BuildContext context, system) {
    final tools = [
      {
        'name': 'Node.js',
        'package': 'nodejs',
        'description':
            'JavaScript runtime environment (essential for modern front-end tools)',
      },
      {
        'name': 'NPM',
        'package': 'npm',
        'description': 'Node.js package manager',
      },
      {
        'name': 'Git',
        'package': 'git',
        'description': 'Version control system (for code management)',
      },
      {
        'name': 'Curl',
        'package': 'curl',
        'description': 'For testing API connections',
      },
      {
        'name': 'Wget',
        'package': 'wget',
        'description': 'For downloading content',
      },
      {
        'name': 'Unzip',
        'package': 'unzip',
        'description': 'For decompressing files',
      },
      {'name': 'Zip', 'package': 'zip', 'description': 'For compressing files'},
      {
        'name': 'Vim',
        'package': 'vim',
        'description': 'Text editor for configuration files',
      },
      {
        'name': 'Net-tools',
        'package': 'net-tools',
        'description': 'Network utilities (ifconfig)',
      },
      {
        'name': 'Python 3',
        'package': 'python3',
        'description': 'Can be used to serve static files',
      },
      {
        'name': 'Tar',
        'package': 'tar',
        'description': 'For handling file archives',
      },
      {
        'name': 'Bzip2',
        'package': 'bzip2',
        'description': 'Highly efficient compression tool',
      },
      {
        'name': 'Gzip',
        'package': 'gzip',
        'description': 'Popular compression tool',
      },
      {
        'name': 'JQ',
        'package': 'jq',
        'description':
            'For processing and parsing JSON files on the command line',
      },
      {
        'name': 'Htop',
        'package': 'htop',
        'description':
            'Interactive process monitor (for monitoring browser/local server performance)',
      },
      {
        'name': 'Ctags',
        'package': 'ctags',
        'description':
            'For creating source code indexes (for quick navigation)',
      },
      {
        'name': 'Make',
        'package': 'make',
        'description':
            'For automating basic build tasks (such as CSS compilation)',
      },
      {
        'name': 'Man-db',
        'package': 'man-db',
        'description':
            'Help page system (for accessing command-line documentation)',
      },
      {
        'name': 'File',
        'package': 'file',
        'description': 'For determining file types',
      },
      {
        'name': 'Procps',
        'package': 'procps',
        'description': 'Process management tools (ps, top)',
      },
      {
        'name': 'Diff',
        'package': 'diffutils',
        'description': 'For comparing files',
      },
      {
        'name': 'Patch',
        'package': 'patch',
        'description': 'To apply changes to files',
      },
      {
        'name': 'Libtool',
        'package': 'libtool',
        'description': 'Library management utility',
      },
      {
        'name': 'Autoconf',
        'package': 'autoconf',
        'description': 'To generate configuration scripts',
      },
      {
        'name': 'Automake',
        'package': 'automake',
        'description': 'To automatically generate Makefiles',
      },
      {
        'name': 'Xz-utils',
        'package': 'xz-utils',
        'description': 'Tool for handling .xz archives',
      },
      {
        'name': 'W3m',
        'package': 'w3m',
        'description': 'Text-based web browser',
      },
      {
        'name': 'Dos2unix',
        'package': 'dos2unix',
        'description':
            'To convert line-ending formats (useful for cross-platform collaboration)',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Front-End Development Tools',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final tool = tools[index];
            return AppGridCard(
              title: tool['name']!,
              description: tool['description']!,
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.web, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName(tool['package']!),
                  ),
            );
          },
        ),
      ],
    );
  }

  void _installAllTools(BuildContext context, system) {
    final tools = [
      'nodejs',
      'npm',
      'git',
      'curl',
      'wget',
      'unzip',
      'zip',
      'vim',
      'net-tools',
      'python3',
      'tar',
      'bzip2',
      'gzip',
      'jq',
      'htop',
      'ctags',
      'make',
      'man-db',
      'file',
      'procps',
      'diffutils',
      'patch',
      'libtool',
      'autoconf',
      'automake',
      'xz-utils',
      'w3m',
      'dos2unix',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Front-End Tools'),
            content: Text(
              'This will install ${tools.length} front-end development tools. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      ...tools,
                    ]),
                  );
                },
                child: const Text('Install All'),
              ),
            ],
          ),
    );
  }
}
