import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/rotating_background.dart';

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
    // تم تحديث العدد الإجمالي هنا
    const toolCount = 25;

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
              // تم تحديث النص هنا
              'Install all $toolCount system and performance utilities at once for complete system management.',
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
    // تم دمج القائمتين (9 أصلية + 16 جديدة = 25 أداة)
    final tools = [
      // --- أدواتك الأصلية ---
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

      // --- الأدوات الجديدة المضافة (16) ---
      {
        'name': 'GameMode',
        'pkg': 'gamemode',
        'desc': 'System optimization daemon for gaming (by Feral Interactive)'
      },
      {
        'name': 'MangoHud',
        'pkg': 'mangohud',
        'desc': 'Vulkan/OpenGL overlay for monitoring FPS, temps, and loads'
      },
      {
        'name': 'GOverlay',
        'pkg': 'goverlay',
        'desc': 'Graphical (GUI) tool for managing MangoHud settings'
      },
      {
        'name': 'NVtop',
        'pkg': 'nvtop',
        'desc': 'Terminal (TUI) monitor for NVIDIA, AMD, and Intel GPUs'
      },
      {
        'name': 'RadeonTop',
        'pkg': 'radeontop',
        'desc': 'Terminal (TUI) monitor for older AMD GPUs'
      },
      {
        'name': 'Intel GPU Tools',
        'pkg': 'intel-gpu-tools',
        'desc': 'Debugging and monitoring tools for Intel GPUs'
      },
      {
        'name': 'Btop',
        'pkg': 'btop',
        'desc': 'Modern resource monitor (CPU, Mem, Disk, Net) (TUI)'
      },
      {
        'name': 'LM-Sensors',
        'pkg': 'lm-sensors',
        'desc': 'Provides the `sensors` command to read hardware temperatures'
      },
      {
        'name': 'CPUFreq Indicator',
        'pkg': 'indicator-cpufreq',
        'desc': 'GUI applet for changing the CPU governor (performance/ondemand)'
      },
      {
        'name': 'Phoronix Test Suite',
        'pkg': 'phoronix-test-suite',
        'desc': 'The most comprehensive benchmarking platform for Linux'
      },
      {
        'name': 'GLMark2',
        'pkg': 'glmark2',
        'desc': 'A standard benchmark for OpenGL 2.0 performance'
      },
      {
        'name': 'S-TUI',
        'pkg': 's-tui',
        'desc': 'Terminal UI for monitoring and stressing the CPU'
      },
      {
        'name': 'Stress-NG',
        'pkg': 'stress-ng',
        'desc': 'Advanced stress testing tool for CPU, Memory, and I/O'
      },
      {
        'name': 'System Monitor',
        'pkg': 'gnome-system-monitor',
        'desc': 'The default GNOME graphical process and resource monitor'
      },
      {
        'name': 'PowerTOP',
        'pkg': 'powertop',
        'desc': 'Diagnoses power consumption and helps optimize battery life'
      },
      {
        'name': 'CPU Power',
        'pkg': 'cpupower',
        'desc': 'Modern tool for CPU frequency and power management'
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
            crossAxisCount: 5,
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
    // تم تحديث قائمة الحزم (أصبحت 25)
    final pkgs = <String>[
      // --- الحزم الأصلية ---
      'htop',
      'gnome-disk-utility',
      'cpu-x',
      'gparted',
      'stress',
      'neofetch',
      'corectrl',
      'cpufrequtils',
      'fwupd',
      // --- الحزم الجديدة ---
      'gamemode',
      'mangohud',
      'goverlay',
      'nvtop',
      'radeontop',
      'intel-gpu-tools',
      'btop',
      'lm-sensors',
      'indicator-cpufreq',
      'phoronix-test-suite',
      'glmark2',
      's-tui',
      'stress-ng',
      'gnome-system-monitor',
      'powertop',
      'cpupower',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All System Tools'),
            content: Text(
              // هذا النص سيعرض العدد الصحيح (25)
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
