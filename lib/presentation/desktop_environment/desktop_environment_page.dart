import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers.dart';
import '../home/widgets/section_widgets.dart';
import '../console/console_utils.dart';
import '../../core/theme/app_theme.dart';
import 'dart:async';

class DesktopEnvironmentPage extends ConsumerStatefulWidget {
  const DesktopEnvironmentPage({super.key});

  @override
  ConsumerState<DesktopEnvironmentPage> createState() =>
      _DesktopEnvironmentPageState();
}

class _DesktopEnvironmentPageState
    extends ConsumerState<DesktopEnvironmentPage> {
  Map<String, bool> _installedDEs = {};
  String? _currentDE;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _refreshDesktopEnvironmentStatus();
    });
  }

  Future<void> _refreshDesktopEnvironmentStatus() async {
    final system = ref.read(systemServiceProvider);

    setState(() => _isLoading = true);

    try {
      // Check which desktop environments are installed
      final kdeInstalled = await system.isDesktopEnvironmentInstalled('kde');
      final xfceInstalled = await system.isDesktopEnvironmentInstalled('xfce');
      final mateInstalled = await system.isDesktopEnvironmentInstalled('mate');
      final cinnamonInstalled = await system.isDesktopEnvironmentInstalled(
        'cinnamon',
      );

      // Get current desktop environment
      final currentDE = await system.getCurrentDesktopEnvironment();

      if (mounted) {
        setState(() {
          _installedDEs = {
            'kde': kdeInstalled,
            'xfce': xfceInstalled,
            'mate': mateInstalled,
            'cinnamon': cinnamonInstalled,
          };
          _currentDE = currentDE;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking desktop environments: $e'),
            backgroundColor: const Color(0xFFFF6B6B),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(color: macAppStoreBlue),
                    ),
                  )
                else
                  Column(
                    children: [
                      _buildCurrentEnvironmentSection(context),
                      const SizedBox(height: 16),
                      _buildDesktopEnvironmentGrid(context, system),
                      const SizedBox(height: 20),
                    ],
                  ),
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
          colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
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
                  colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
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
                  'DESKTOP ENVIRONMENTS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Manage Desktop Environments',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Install, switch, and manage different desktop environments on your system.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentEnvironmentSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.desktop_windows, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Current Desktop Environment',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh, color: macAppStoreGray),
                  onPressed: _refreshDesktopEnvironmentStatus,
                  tooltip: 'Refresh Status',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: macAppStoreBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                // ignore: deprecated_member_use
                border: Border.all(color: macAppStoreBlue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getDEIcon(_currentDE),
                    color: macAppStoreBlue,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _currentDE?.toUpperCase() ?? 'UNKNOWN',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: macAppStoreBlue,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: macAppStoreBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopEnvironmentGrid(BuildContext context, system) {
final desktopEnvironments = [
      {
        'id': 'kde',
        'name': 'KDE Plasma',
        'description': 'Modern, feature-rich desktop environment',
        'icon': Icons.diamond,
        'color': const Color(0xFF2196F3),
        'packages': [
          // 'kubuntu-desktop', // <-- This was the problem
          'plasma-desktop',     // The desktop data
          'plasma-workspace',   // The core shell (session)
          'sddm',               // The display manager
          'dolphin',            // File manager
          'konsole',            // Terminal
          'systemsettings',     // Settings panel
        ],
      },
      {
        'id': 'xfce',
        'name': 'Xfce',
        'description': 'Lightweight and fast desktop environment',
        'icon': Icons.speed,
        'color': const Color(0xFF4CAF50),
        'packages': [
          // This list was already perfect and minimal. No changes needed.
          'xfwm4',
          'xfce4-session',
          'xfce4-panel',
          'xfce4-settings',
          'lightdm',
          'xfdesktop4',
          'libxfce4ui-utils',
          'thunar',
          'xfce4-screenshooter',
        ],
      },
      {
        'id': 'mate',
        'name': 'MATE',
        'description': 'Traditional desktop environment',
        'icon': Icons.coffee,
        'color': const Color(0xFF8BC34A),
        'packages': [
          // 'ubuntu-mate-desktop', // <-- This was the problem
          'mate-session-manager', // The core session
          'mate-panel',           // The panel
          'mate-control-center',  // Settings panel
          'caja',                 // File manager
          'mate-terminal',        // Terminal
          'marco',                // Window manager
          'lightdm',              // Display manager
        ],
      },
      {
        'id': 'cinnamon',
        'name': 'Cinnamon',
        'description': 'Modern desktop with traditional workflow',
        'icon': Icons.home,
        'color': const Color(0xFFFF9800),
        'packages': [
          // 'cinnamon-desktop-environment', // <-- This was the problem
          'cinnamon-session',         // The core session
          'cinnamon-control-center',  // Settings panel
          'nemo',                     // File manager
          'gnome-terminal',           // Terminal (as requested in original)
          'muffin',                   // Window manager
          'lightdm',                  // Display manager
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Available Desktop Environments',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ResponsiveGrid(
          crossAxisCount: 3,
            childAspectRatio: 1.2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          children:
              desktopEnvironments.map((de) {
                final isInstalled = _installedDEs[de['id']] ?? false;
                final isCurrent = _currentDE == de['id'];

                return DesktopEnvironmentCard(

                  name: de['name'] as String,
                  description: de['description'] as String,
                  icon: de['icon'] as IconData,
                  color: de['color'] as Color,
                  isInstalled: isInstalled,
                  isCurrent: isCurrent,
                  onInstall:
                      () => _installDesktopEnvironment(
                        context,
                        system,
                        de['id'] as String,
                        de['packages'] as List<String>,
                      ),
                  onSwitch:
                      () => _switchDesktopEnvironment(
                        context,
                        system,
                        de['id'] as String,
                      ),
                  onRemove:
                      () => _removeDesktopEnvironment(
                        context,
                        system,
                        de['id'] as String,
                        de['packages'] as List<String>,
                      ),
                );
              }).toList(),
        ),
      ],
    );
  }

  IconData _getDEIcon(String? de) {
    switch (de?.toLowerCase()) {
      case 'kde':
        return Icons.diamond;
      case 'xfce':
        return Icons.speed;
      case 'mate':
        return Icons.coffee;
      case 'cinnamon':
        return Icons.home;
      default:
        return Icons.desktop_windows;
    }
  }

  Future<void> _installDesktopEnvironment(
    BuildContext context,
    system,
    String deId,
    List<String> packages,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Install ${_getDEName(deId)}'),
            content: Text(
              'This will install the complete ${_getDEName(deId)} desktop environment. This may take several minutes. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Install'),
              ),
            ],
          ),
    );

    if (confirmed == true && context.mounted) {
      showConsoleStream(
        context,
        system.installDesktopEnvironment(deId, packages),
      );
      // Refresh status after installation
      Timer(const Duration(seconds: 5), () {
        if (mounted) _refreshDesktopEnvironmentStatus();
      });
    }
  }

  Future<void> _switchDesktopEnvironment(
    BuildContext context,
    system,
    String deId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Switch to ${_getDEName(deId)}'),
            content: const Text(
              'This will switch to the selected desktop environment and reboot the system. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Switch & Reboot'),
              ),
            ],
          ),
    );

    if (confirmed == true && context.mounted) {
      showConsoleStream(context, system.switchDesktopEnvironment(deId));
    }
  }

  Future<void> _removeDesktopEnvironment(
    BuildContext context,
    system,
    String deId,
    List<String> packages,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Remove ${_getDEName(deId)}'),
            content: Text(
              'This will completely remove the ${_getDEName(deId)} desktop environment and all its components. This action cannot be undone. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B6B),
                ),
                child: const Text('Remove'),
              ),
            ],
          ),
    );

    if (confirmed == true && context.mounted) {
      showConsoleStream(
        context,
        system.removeDesktopEnvironment(deId, packages),
      );
      // Refresh status after removal
      Timer(const Duration(seconds: 5), () {
        if (mounted) _refreshDesktopEnvironmentStatus();
      });
    }
  }

  String _getDEName(String deId) {
    switch (deId) {
      case 'kde':
        return 'KDE Plasma';
      case 'xfce':
        return 'Xfce';
      case 'mate':
        return 'MATE';
      case 'cinnamon':
        return 'Cinnamon';
      default:
        return deId.toUpperCase();
    }
  }
}

class DesktopEnvironmentCard extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isInstalled;
  final bool isCurrent;
  final VoidCallback onInstall;
  final VoidCallback onSwitch;
  final VoidCallback onRemove;

  const DesktopEnvironmentCard({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.isInstalled,
    required this.isCurrent,
    required this.onInstall,
    required this.onSwitch,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return MacAppStoreCard(
      padding: EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: macAppStoreGray),
                    ),
                  ],
                ),
              ),
              if (isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: macAppStoreBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'CURRENT',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: onInstall,
                  icon: Icon(
                    isInstalled ? Icons.check : Icons.download,
                    size: 16,
                  ),
                  label: Text(isInstalled ? 'Installed' : 'Install'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isInstalled ? const Color(0xFF4CAF50) : macAppStoreBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  onPressed: isInstalled ? onSwitch : null,
                  icon: const Icon(Icons.swap_horiz, size: 16),
                  label: const Text('Switch'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: macAppStoreBlue,
                    side: BorderSide(color: macAppStoreBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  onPressed: isInstalled ? onRemove : null,
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Remove'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFF6B6B),
                    side: const BorderSide(color: Color(0xFFFF6B6B)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
