import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/widgets/section_widgets.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class SystemOverviewPage extends ConsumerStatefulWidget {
  const SystemOverviewPage({super.key});

  @override
  ConsumerState<SystemOverviewPage> createState() => _SystemOverviewPageState();
}

class _SystemOverviewPageState extends ConsumerState<SystemOverviewPage> {
  Map<String, String> _systemInfo = {};
  bool _isLoading = true;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadSystemInfo();
    // Refresh every 30 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _loadSystemInfo();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadSystemInfo() async {
    try {
      final info = <String, String>{};

      // Get OS release information
      try {
        final osReleaseFile = File('/etc/os-release');
        if (await osReleaseFile.exists()) {
          final content = await osReleaseFile.readAsString();
          final lines = content.split('\n');
          for (final line in lines) {
            if (line.contains('=')) {
              final parts = line.split('=');
              if (parts.length == 2) {
                final key = parts[0].trim();
                final value = parts[1].trim().replaceAll('"', '');
                info[key] = value;
              }
            }
          }
        }
      } catch (e) {
        info['OS_ERROR'] = 'Failed to read OS information: $e';
      }

      // Get kernel version
      try {
        final result = await Process.run('uname', ['-r']);
        if (result.exitCode == 0) {
          info['KERNEL_VERSION'] = result.stdout.toString().trim();
        }
      } catch (e) {
        info['KERNEL_ERROR'] = 'Failed to get kernel version: $e';
      }

      // Get uptime
      try {
        final uptimeFile = File('/proc/uptime');
        if (await uptimeFile.exists()) {
          final content = await uptimeFile.readAsString();
          final seconds = double.parse(content.split(' ')[0]);
          final days = (seconds / 86400).floor();
          final hours = ((seconds % 86400) / 3600).floor();
          final minutes = (((seconds % 86400) % 3600) / 60).floor();
          info['UPTIME'] = '${days}d ${hours}h ${minutes}m';
        }
      } catch (e) {
        info['UPTIME_ERROR'] = 'Failed to get uptime: $e';
      }

      // Get desktop environment
      try {
        final desktop = Platform.environment['XDG_CURRENT_DESKTOP'] ?? 
                       Platform.environment['DESKTOP_SESSION'] ?? 
                       'Unknown';
        info['DESKTOP_ENVIRONMENT'] = desktop;
      } catch (e) {
        info['DESKTOP_ERROR'] = 'Failed to get desktop environment: $e';
      }

      if (mounted) {
        setState(() {
          _systemInfo = info;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _systemInfo = {'ERROR': 'Failed to load system information: $e'};
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotatingBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('System Overview'),
        backgroundColor: macAppStoreDark,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSystemInfo,
            tooltip: 'Refresh Information',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(macAppStoreBlue),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSystemInfoCard(),
                      _buildKernelInfoCard(),
                      _buildUptimeCard(),
                      _buildDesktopInfoCard(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
        ),
      
    );
  }

  Widget _buildSystemInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.computer,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Operating System Information',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Distribution', _systemInfo['PRETTY_NAME'] ?? 'Unknown'),
            _buildInfoRow('Version', _systemInfo['VERSION_ID'] ?? 'Unknown'),
            _buildInfoRow('Codename', _systemInfo['VERSION_CODENAME'] ?? 'Unknown'),
            _buildInfoRow('Architecture', _systemInfo['VERSION_ID'] ?? 'Unknown'),
            if (_systemInfo.containsKey('OS_ERROR'))
              _buildErrorRow('Error', _systemInfo['OS_ERROR']!),
          ],
        ),
      ),
    );
  }

  Widget _buildKernelInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Kernel Information',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Kernel Version', _systemInfo['KERNEL_VERSION'] ?? 'Unknown'),
            if (_systemInfo.containsKey('KERNEL_ERROR'))
              _buildErrorRow('Error', _systemInfo['KERNEL_ERROR']!),
          ],
        ),
      ),
    );
  }

  Widget _buildUptimeCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'System Uptime',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Uptime', _systemInfo['UPTIME'] ?? 'Unknown'),
            if (_systemInfo.containsKey('UPTIME_ERROR'))
              _buildErrorRow('Error', _systemInfo['UPTIME_ERROR']!),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.desktop_windows,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Desktop Environment',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Desktop', _systemInfo['DESKTOP_ENVIRONMENT'] ?? 'Unknown'),
            if (_systemInfo.containsKey('DESKTOP_ERROR'))
              _buildErrorRow('Error', _systemInfo['DESKTOP_ERROR']!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: macAppStoreGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorRow(String label, String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: macAppStoreGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFFF6B6B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
