import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/rotating_background.dart';

class DevOpsSysadminPage extends ConsumerWidget {
  const DevOpsSysadminPage({super.key});

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
          colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
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
                  colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
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
                  'DEVOPS / SYSADMIN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'DevOps & System Administration',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '30 professional tools for DevOps operations, containerization, and system administration.',
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
                        'Install All DevOps Tools',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 30 DevOps and system administration tools at once',
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
        'name': 'Docker',
        'package': 'docker.io',
        'description':
            'Basic container platform (for consistent deployments and environments)',
      },
      {
        'name': 'Ansible',
        'package': 'ansible',
        'description': 'Agentless automation and configuration management tool',
      },
      {
        'name': 'Kubectl',
        'package': 'kubectl',
        'description': 'Command-line client for managing Kubernetes clusters',
      },
      {
        'name': 'Vagrant',
        'package': 'vagrant',
        'description':
            'For building and managing portable virtual environments',
      },
      {
        'name': 'Git',
        'package': 'git',
        'description': 'For version control (essential for CI/CD)',
      },
      {
        'name': 'Rsync',
        'package': 'rsync',
        'description': 'For efficient file synchronization between systems',
      },
      {
        'name': 'Make',
        'package': 'make',
        'description': 'To automate routine DevOps tasks',
      },
      {
        'name': 'Python 3',
        'package': 'python3',
        'description': 'Basic language for writing automation scripts',
      },
      {
        'name': 'Bash',
        'package': 'bash',
        'description': 'Command-line shell (basic for shell scripts)',
      },
      {
        'name': 'SSH Server',
        'package': 'openssh-server',
        'description': 'To enable remote connection and management',
      },
      {
        'name': 'TMux',
        'package': 'tmux',
        'description': 'To manage multiple command-line sessions',
      },
      {
        'name': 'Screen',
        'package': 'screen',
        'description': 'Alternative to Tmux',
      },
      {
        'name': 'Nginx',
        'package': 'nginx',
        'description': 'Acts as a load balancer and reverse proxy',
      },
      {
        'name': 'Apache2',
        'package': 'apache2',
        'description': 'Web server and proxy',
      },
      {
        'name': 'Vim',
        'package': 'vim',
        'description': 'To edit configuration files',
      },
      {
        'name': 'Nano',
        'package': 'nano',
        'description': 'To edit configuration files',
      },
      {
        'name': 'Htop',
        'package': 'htop',
        'description':
            'Interactive process monitor (for analyzing server performance)',
      },
      {
        'name': 'Lsof',
        'package': 'lsof',
        'description': 'To list open files and the processes using them',
      },
      {
        'name': 'Net-tools',
        'package': 'net-tools',
        'description': 'Old but popular network tool (netstat)',
      },
      {
        'name': 'Tcpdump',
        'package': 'tcpdump',
        'description': 'For analyzing network traffic',
      },
      {
        'name': 'Curl',
        'package': 'curl',
        'description': 'For testing Endpoints',
      },
      {'name': 'Wget', 'package': 'wget', 'description': 'For downloading'},
      {
        'name': 'Bind9-utils',
        'package': 'bind9-utils',
        'description': 'For DNS inspection (dig, host)',
      },
      {
        'name': 'Logrotate',
        'package': 'logrotate',
        'description': 'For managing log file rotation',
      },
      {
        'name': 'Iftop',
        'package': 'iftop',
        'description': 'For monitoring real-time network usage',
      },
      {
        'name': 'Dmesg',
        'package': 'util-linux',
        'description': 'For viewing kernel messages',
      },
      {'name': 'Tar', 'package': 'tar', 'description': 'For backups'},
      {
        'name': 'Unzip',
        'package': 'unzip',
        'description': 'For handling archives',
      },
      {
        'name': 'Sysstat',
        'package': 'sysstat',
        'description': 'Advanced performance monitoring tools (iostat, mpstat)',
      },
      {
        'name': 'Cloud-init',
        'package': 'cloud-init',
        'description':
            'For automating the first server setup (Mission in the cloud)',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'DevOps & System Administration Tools',
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
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.settings_applications,
                  color: Colors.white,
                ),
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
      'docker.io',
      'ansible',
      'kubectl',
      'vagrant',
      'git',
      'rsync',
      'make',
      'python3',
      'bash',
      'openssh-server',
      'tmux',
      'screen',
      'nginx',
      'apache2',
      'vim',
      'nano',
      'htop',
      'lsof',
      'net-tools',
      'tcpdump',
      'curl',
      'wget',
      'bind9-utils',
      'logrotate',
      'iftop',
      'util-linux',
      'tar',
      'unzip',
      'sysstat',
      'cloud-init',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All DevOps Tools'),
            content: Text(
              'This will install ${tools.length} DevOps and system administration tools. Continue?',
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
