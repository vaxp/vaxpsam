

import 'dart:async';
import 'advanced_debugging_export.dart';

class AdvancedDebuggingPage extends ConsumerStatefulWidget {
  const AdvancedDebuggingPage({super.key});

  @override
  ConsumerState<AdvancedDebuggingPage> createState() => _AdvancedDebuggingPageState();
}

class _AdvancedDebuggingPageState extends ConsumerState<AdvancedDebuggingPage> {
  List<SystemServiceInfo> _services = [];
  bool _isLoadingServices = false;
  Map<String, bool> _serviceStates = {};
  final Map<String, String> _serviceLogs = {};
  bool isLoadingLogs = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadServices();
    });
  }

  Future<void> _loadServices() async {
    setState(() => _isLoadingServices = true);
    try {
      final system = ref.read(systemServiceProvider);
      final services = await system.getAllSystemServices();
      final states = <String, bool>{};
      
      for (final service in services) {
        states[service.name] = await system.isServiceRunning(service.name);
      }
      
      if (mounted) {
        setState(() {
          _services = services;
          _serviceStates = states;
          _isLoadingServices = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingServices = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading services: $e'),
            backgroundColor: const Color(0xFFFF6B6B),
          ),
        );
      }
    }
  }

  Future<void> _loadServiceLogs(String serviceName) async {
    setState(() => isLoadingLogs = true);
    try {
      final system = ref.read(systemServiceProvider);
      final logs = await system.getServiceLogs(serviceName);
      
      if (mounted) {
        setState(() {
          _serviceLogs[serviceName] = logs;
          isLoadingLogs = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoadingLogs = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading logs: $e'),
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
                _buildSystemServiceManagement(context, system),
                const SizedBox(height: 16),
                _buildFixBrokenPackages(context, system),
                const SizedBox(height: 16),
                _buildLogCleanup(context, system),
                const SizedBox(height: 16),
                _buildBootManagement(context, system),
                const SizedBox(height: 16),
                _buildGraphicsCardMonitoring(context, system),
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
          colors: [Color(0xFFFF6B6B), Color(0xFFE91E63)],
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
                  colors: [Color(0xFFFF6B6B), Color(0xFFE91E63)],
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
                  'ADVANCED DEBUGGING',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'System Troubleshooting',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Advanced tools for diagnosing and fixing system issues.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemServiceManagement(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'System Service Management',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        
        // Service List
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: macAppStoreCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.settings_applications, color: macAppStoreBlue),
                    const SizedBox(width: 12),
                    Text(
                      'System Services',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    if (_isLoadingServices)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(macAppStoreBlue),
                        ),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.refresh, color: macAppStoreGray),
                        onPressed: _loadServices,
                        tooltip: 'Refresh Services',
                      ),
                  ],
                ),
              ),
              const Divider(color: macAppStoreLightGray, height: 1),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: _services.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(Icons.settings_applications, size: 48, color: macAppStoreGray),
                            const SizedBox(height: 16),
                            Text(
                              'No services loaded',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Click refresh to load system services',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: macAppStoreGray,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _services.length,
                        itemBuilder: (context, index) {
                          final service = _services[index];
                          final isRunning = _serviceStates[service.name] ?? false;
                          return ServiceManagementCard(
                            service: service,
                            isRunning: isRunning,
                            onStart: () => _controlService(system, service.name, 'start'),
                            onStop: () => _controlService(system, service.name, 'stop'),
                            onRestart: () => _controlService(system, service.name, 'restart'),
                            onEnable: () => _controlService(system, service.name, 'enable'),
                            onDisable: () => _controlService(system, service.name, 'disable'),
                            onViewLogs: () => _showServiceLogs(context, service.name),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
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
              description: 'Run dpkg --configure -a to fix broken package configurations',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.build, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.fixBrokenPackages()),
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
              onTap: () => showConsoleStream(context, system.cleanPackageCache()),
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
              onTap: () => showConsoleStream(context, system.removeOrphanedPackages()),
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
              description: 'Rotate system logs to prevent them from growing too large',
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
              onTap: () => showBootManagementDialog(context, system, 'initramfs'),
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
              onTap: () => showBootManagementDialog(context,system, 'repair'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGraphicsCardMonitoring(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'System Hardware Monitoring',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SystemMonitoringWidget(
          getGPUData: system.getParsedGPUUsage,
          getCPUData: system.getCPUInfo,
          getIntegratedGraphicsData: system.getIntegratedGraphicsInfo,
          installNvidiaTools: system.installNvidiaTools,
          installAmdTools: system.installAmdTools,
          installIntelTools: system.installIntelTools,
          installGeneralTools: system.installGeneralGpuTools,
          isNvidiaAvailable: system.isNvidiaToolsAvailable,
          isAmdAvailable: system.isAmdToolsAvailable,
          isIntelAvailable: system.isIntelToolsAvailable,
          showConsoleStream: (stream) => showConsoleStream(context, stream),
        ),
      ],
    );
  }

  Future<void> _controlService(system, String serviceName, String action) async {
    showConsoleStream(context, system.controlService(serviceName, action));
    // Refresh service states after control
    Timer(const Duration(seconds: 2), () => _loadServices());
  }

  Future<void> _showServiceLogs(BuildContext context, String serviceName) async {
    await _loadServiceLogs(serviceName);
    
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('$serviceName Logs'),
          content: SizedBox(
            width: 600,
            height: 400,
            child: SingleChildScrollView(
              child: Text(
                _serviceLogs[serviceName] ?? 'No logs available',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }
}

