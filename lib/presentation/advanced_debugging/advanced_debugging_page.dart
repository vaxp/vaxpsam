import 'advanced_debugging_export.dart';

class AdvancedDebuggingPage extends ConsumerStatefulWidget {
  const AdvancedDebuggingPage({super.key});

  @override
  ConsumerState<AdvancedDebuggingPage> createState() =>
      _AdvancedDebuggingPageState();
}

class _AdvancedDebuggingPageState extends ConsumerState<AdvancedDebuggingPage> {
  bool isLoadingLogs = false;

  @override
  Widget build(BuildContext context) {
    final system = ref.read(systemServiceProvider);

    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildFixBrokenPackages(context, system),
                const SizedBox(height: 16),
                _buildLogCleanup(context, system),
                const SizedBox(height: 16),
                _buildBootManagement(context, system),
                const SizedBox(height: 16),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixBrokenPackages(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Fix Broken Packages',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ResponsiveGrid(
          children: [
            AppGridCard(
              title: 'Configure Packages',
              description:
                  'Run dpkg --configure -a to fix broken package configurations',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.build, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(context, system.fixBrokenPackages()),
            ),
            AppGridCard(
              title: 'Fix Dependencies',
              description: 'Run apt install -f to resolve dependency issues',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.link, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.fixDependencies()),
            ),
            AppGridCard(
              title: 'Clean Package Cache',
              description: 'Remove cached package files to free up space',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.cleaning_services, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(context, system.cleanPackageCache()),
            ),
            AppGridCard(
              title: 'Remove Orphaned Packages',
              description: 'Remove packages that are no longer needed',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.delete_sweep, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.removeOrphanedPackages(),
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogCleanup(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Log Cleanup',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ResponsiveGrid(
          children: [
            AppGridCard(
              title: 'Clean System Logs',
              description: 'Remove old system logs to free up storage space',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.cleaning_services, color: Colors.white),
              ),
              onTap: () => showLogCleanupDialog(context, system),
            ),
            AppGridCard(
              title: 'View Log Usage',
              description: 'Check current log storage usage',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.storage, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.checkLogUsage()),
            ),
            AppGridCard(
              title: 'Rotate Logs',
              description:
                  'Rotate system logs to prevent them from growing too large',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.rotate_right, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.rotateLogs()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBootManagement(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Boot Management',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ResponsiveGrid(
          children: [
            AppGridCard(
              title: 'Rebuild GRUB',
              description: 'Rebuild GRUB bootloader configuration',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.settings, color: Colors.white),
              ),
              onTap: () => showBootManagementDialog(context, system, 'grub'),
            ),
            AppGridCard(
              title: 'Update Initramfs',
              description: 'Update initial RAM filesystem',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.memory, color: Colors.white),
              ),
              onTap:
                  () => showBootManagementDialog(context, system, 'initramfs'),
            ),
            AppGridCard(
              title: 'Check Boot Files',
              description: 'Verify boot files integrity',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.verified, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.checkBootFiles()),
            ),
            AppGridCard(
              title: 'Boot Repair',
              description: 'Run comprehensive boot repair',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.build_circle, color: Colors.white),
              ),
              onTap: () => showBootManagementDialog(context, system, 'repair'),
            ),
          ],
        ),
      ],
    );
  }
}
