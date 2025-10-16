import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class WebBackendPage extends ConsumerWidget {
  const WebBackendPage({super.key});

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
          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
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
                  colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
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
                  'WEB BACK-END',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Backend Development Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '30 professional tools for backend development including Python, databases, and web servers.',
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

  Widget _buildInstallAllSection(BuildContext context, system) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.download,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Install All Backend Tools',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 30 backend development tools at once',
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
      {'name': 'Python 3', 'package': 'python3', 'description': 'Popular back-end programming language (Django, Flask)'},
      {'name': 'Pip', 'package': 'python3-pip', 'description': 'Python package manager'},
      {'name': 'PostgreSQL Client', 'package': 'postgresql-client', 'description': 'Command-line tools for connecting to Postgres databases'},
      {'name': 'MySQL Client', 'package': 'mysql-client', 'description': 'Command-line tools for connecting to MySQL/MariaDB databases'},
      {'name': 'PHP CLI', 'package': 'php-cli', 'description': 'PHP command-line environment (Laravel, Symfony)'},
      {'name': 'Ruby', 'package': 'ruby', 'description': 'Ruby on Rails: A back-end programming language'},
      {'name': 'Rubygems', 'package': 'rubygems', 'description': 'Ruby package manager'},
      {'name': 'GCC', 'package': 'gcc', 'description': 'C compiler'},
      {'name': 'G++', 'package': 'g++', 'description': 'C++ compiler'},
      {'name': 'OpenSSL', 'package': 'openssl', 'description': 'For managing TLS/SSL certificates'},
      {'name': 'Supervisor', 'package': 'supervisor', 'description': 'Process management system (to ensure applications remain running)'},
      {'name': 'Redis Server', 'package': 'redis-server', 'description': 'In-memory data caching server'},
      {'name': 'Apache2', 'package': 'apache2', 'description': 'Widely used web server'},
      {'name': 'Nginx', 'package': 'nginx', 'description': 'Lightweight web server and reverse proxy'},
      {'name': 'Python3-venv', 'package': 'python3-venv', 'description': 'For creating virtual Python environments'},
      {'name': 'Uwsgi', 'package': 'uwsgi', 'description': 'Application Server for Python/Perl/PHP'},
      {'name': 'Tmux', 'package': 'tmux', 'description': 'Terminal multiplexer for managing sessions on the server'},
      {'name': 'Screen', 'package': 'screen', 'description': 'Alternative to Tmux for managing sessions'},
      {'name': 'Htop', 'package': 'htop', 'description': 'Interactive process monitor (for analyzing server performance)'},
      {'name': 'Tzdata', 'package': 'tzdata', 'description': 'Timezone data package (essential for processing times)'},
      {'name': 'Curl', 'package': 'curl', 'description': 'For testing server connections'},
      {'name': 'Git', 'package': 'git', 'description': 'Version control'},
      {'name': 'Make', 'package': 'make', 'description': 'Build automation'},
      {'name': 'Valgrind', 'package': 'valgrind', 'description': 'For debugging memory errors (for C/C++ code)'},
      {'name': 'Systemd', 'package': 'systemd', 'description': 'For managing the Service Manager in Ubuntu'},
      {'name': 'Cron', 'package': 'cron', 'description': 'For scheduling tasks'},
      {'name': 'Locales', 'package': 'locales', 'description': 'Supports regional settings'},
      {'name': 'Procps', 'package': 'procps', 'description': 'Process management tools'},
      {'name': 'Netcat', 'package': 'netcat-traditional', 'description': 'For testing raw port connections'},
      {'name': 'SSH', 'package': 'openssh-client', 'description': 'For secure connection to the server'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Backend Development Tools',
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
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.storage, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.installPackageByName(tool['package']!)),
            );
          },
        ),
      ],
    );
  }

  void _installAllTools(BuildContext context, system) {
    final tools = [
      'python3', 'python3-pip', 'postgresql-client', 'mysql-client', 'php-cli',
      'ruby', 'rubygems', 'gcc', 'g++', 'openssl', 'supervisor', 'redis-server',
      'apache2', 'nginx', 'python3-venv', 'uwsgi', 'tmux', 'screen', 'htop',
      'tzdata', 'curl', 'git', 'make', 'valgrind', 'systemd', 'cron',
      'locales', 'procps', 'netcat-traditional', 'openssh-client'
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Install All Backend Tools'),
        content: Text('This will install ${tools.length} backend development tools. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              showConsoleStream(context, system.runAsRoot(['apt', 'update', '&&', 'apt', 'install', '-y', ...tools]));
            },
            child: const Text('Install All'),
          ),
        ],
      ),
    );
  }
}
