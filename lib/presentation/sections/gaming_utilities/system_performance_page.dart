import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class SystemPerformancePage extends ConsumerWidget {
  const SystemPerformancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('System & Performance Utilities'),
          backgroundColor: macAppStoreDark,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstallAllSection(context, system),
                  _buildToolsSection(context, system),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
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
                Icon(Icons.install_desktop, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Install All System Tools',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Install all 9 system and performance utilities at once for complete system management.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _installAllSystemTools(context, system),
                icon: const Icon(Icons.download),
                label: const Text('Install All System Tools'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: macAppStoreBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsSection(BuildContext context, system) {
    final tools = [
      {
        'name': 'Htop',
        'pkg': 'htop',
        'desc':
            'An interactive process monitor (for monitoring resource consumption during gaming)',
        'iconAsset': 'assets/game/htop.png',
      },
      {
        'name': 'Gnome Disks',
        'pkg': 'gnome-disk-utility',
        'desc': 'A graphical disk management tool (for formatting game disks)',
        'iconAsset': 'assets/game/gnome-disks.png',
      },
      {
        'name': 'CPU-X',
        'pkg': 'cpu-x',
        'desc':
            'A tool for displaying detailed information about the processor and system',
      },
      {
        'name': 'Gparted',
        'pkg': 'gparted',
        'desc':
            'A graphical partition editor (for preparing game storage spaces)',
        'iconAsset': 'assets/game/gparted.png',
      },
      {
        'name': 'Stress',
        'pkg': 'stress',
        'desc': 'A tool for stress testing before gaming',
      },
      {
        'name': 'Neofetch',
        'pkg': 'neofetch',
        'desc':
            'A command-line tool for displaying system information in an attractive way',
      },
      {
        'name': 'Corectrl',
        'pkg': 'corectrl',
        'desc':
            'A graphical user interface (GUI) for controlling performance and graphics processing units (GPUs)',
      },
      {
        'name': 'Cpufrequtils',
        'pkg': 'cpufrequtils',
        'desc': 'A command-line tool for controlling processor speed',
        'iconAsset': 'assets/game/cpufrequtils.png',
      },
      {
        'name': 'Firmware-updater',
        'pkg': 'fwupd',
        'desc':
            'fwupd for updating firmware for components (important for performance)',
        'iconAsset': 'assets/game/fwupd.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'System & Performance Tools',
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
          itemBuilder: (context, i) {
            final t = tools[i];
            return AppGridCard(
              title: t['name']!,
              description: t['desc']!,
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 61, 173, 139),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  // استخدام الأداة Image.asset
                  t['iconAsset'] ??
                      'assets/ides/default.png', // تمرير المسار المخزن في قائمة tools
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName(t['pkg']!),
                  ),
            );
          },
        ),
      ],
    );
  }

  void _installAllSystemTools(BuildContext context, system) {
    final pkgs = <String>[
      'htop',
      'gnome-disk-utility',
      'cpu-x',
      'gparted',
      'stress',
      'neofetch',
      'corectrl',
      'cpufrequtils',
      'fwupd',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All System Tools'),
            content: Text(
              'This will install ${pkgs.length} system and performance utilities via APT. Continue?',
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
                      ...pkgs,
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
