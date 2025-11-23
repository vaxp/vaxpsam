import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/venom_layout.dart';
import '../../home/widgets/section_widgets.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/rotating_background.dart';

class HardwareDetailsPage extends ConsumerStatefulWidget {
  const HardwareDetailsPage({super.key});

  @override
  ConsumerState<HardwareDetailsPage> createState() =>
      _HardwareDetailsPageState();
}

class _HardwareDetailsPageState extends ConsumerState<HardwareDetailsPage> {
  Map<String, dynamic> _hardwareInfo = {};
  bool _isLoading = true;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadHardwareInfo();
    // Refresh every 60 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      _loadHardwareInfo();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadHardwareInfo() async {
    try {
      final info = <String, dynamic>{};

      // Get CPU information
      await _loadCpuInfo(info);

      // Get memory information
      await _loadMemoryInfo(info);

      // Get GPU information
      await _loadGpuInfo(info);

      // Get storage information
      await _loadStorageInfo(info);

      if (mounted) {
        setState(() {
          _hardwareInfo = info;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hardwareInfo = {'ERROR': 'Failed to load hardware information: $e'};
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadCpuInfo(Map<String, dynamic> info) async {
    try {
      final cpuInfoFile = File('/proc/cpuinfo');
      if (await cpuInfoFile.exists()) {
        final content = await cpuInfoFile.readAsString();
        final lines = content.split('\n');

        String modelName = 'Unknown';
        int cores = 0;
        int threads = 0;
        String architecture = 'Unknown';
        String cpuFlags = '';

        for (final line in lines) {
          if (line.startsWith('model name')) {
            modelName =
                line.split(':').length > 1
                    ? line.split(':')[1].trim()
                    : 'Unknown';
          } else if (line.startsWith('cpu cores')) {
            cores =
                int.tryParse(
                  line.split(':').length > 1 ? line.split(':')[1].trim() : '0',
                ) ??
                0;
          } else if (line.startsWith('siblings')) {
            threads =
                int.tryParse(
                  line.split(':').length > 1 ? line.split(':')[1].trim() : '0',
                ) ??
                0;
          } else if (line.startsWith('Architecture')) {
            architecture =
                line.split(':').length > 1
                    ? line.split(':')[1].trim()
                    : 'Unknown';
          } else if (line.startsWith('flags')) {
            cpuFlags =
                line.split(':').length > 1 ? line.split(':')[1].trim() : '';
          }
        }

        info['CPU'] = {
          'model': modelName,
          'cores': cores,
          'threads': threads,
          'architecture': architecture,
          'flags': cpuFlags,
        };
      }
    } catch (e) {
      info['CPU_ERROR'] = 'Failed to load CPU information: $e';
    }
  }

  Future<void> _loadMemoryInfo(Map<String, dynamic> info) async {
    try {
      final memInfoFile = File('/proc/meminfo');
      if (await memInfoFile.exists()) {
        final content = await memInfoFile.readAsString();
        final lines = content.split('\n');

        int totalMemKB = 0;
        int availableMemKB = 0;

        for (final line in lines) {
          if (line.startsWith('MemTotal:')) {
            totalMemKB = int.tryParse(line.split(RegExp(r'\s+'))[1]) ?? 0;
          } else if (line.startsWith('MemAvailable:')) {
            availableMemKB = int.tryParse(line.split(RegExp(r'\s+'))[1]) ?? 0;
          }
        }

        final totalMemGB = (totalMemKB / 1024 / 1024).toStringAsFixed(2);
        final availableMemGB = (availableMemKB / 1024 / 1024).toStringAsFixed(
          2,
        );
        final usedMemGB = ((totalMemKB - availableMemKB) / 1024 / 1024)
            .toStringAsFixed(2);

        info['MEMORY'] = {
          'total': totalMemGB,
          'available': availableMemGB,
          'used': usedMemGB,
          'totalKB': totalMemKB,
          'availableKB': availableMemKB,
        };
      }
    } catch (e) {
      info['MEMORY_ERROR'] = 'Failed to load memory information: $e';
    }
  }

  Future<void> _loadGpuInfo(Map<String, dynamic> info) async {
    try {
      final gpus = <Map<String, String>>[];

      // Try to get GPU info from lspci
      try {
        final result = await Process.run('lspci', ['-v']);
        if (result.exitCode == 0) {
          final output = result.stdout.toString();
          final lines = output.split('\n');

          for (int i = 0; i < lines.length; i++) {
            if (lines[i].contains('VGA') || lines[i].contains('3D')) {
              final gpuName =
                  lines[i].split(':').length > 2
                      ? lines[i].split(':')[2].trim()
                      : 'Unknown GPU';
              gpus.add({'name': gpuName, 'type': 'PCI'});
            }
          }
        }
      } catch (e) {
        // Fallback to basic detection
      }

      // Try to get GPU info from lshw
      try {
        final result = await Process.run('lshw', ['-c', 'display', '-short']);
        if (result.exitCode == 0) {
          final output = result.stdout.toString();
          final lines = output.split('\n');

          for (final line in lines) {
            if (line.contains('display') && !line.contains('*-display')) {
              final parts = line.split(RegExp(r'\s+'));
              if (parts.length > 2) {
                final gpuName = parts.sublist(2).join(' ');
                if (gpuName.isNotEmpty && gpuName != 'display') {
                  gpus.add({'name': gpuName, 'type': 'Hardware'});
                }
              }
            }
          }
        }
      } catch (e) {
        // Fallback to basic detection
      }

      if (gpus.isEmpty) {
        gpus.add({'name': 'Unknown GPU', 'type': 'Unknown'});
      }

      info['GPU'] = gpus;
    } catch (e) {
      info['GPU_ERROR'] = 'Failed to load GPU information: $e';
    }
  }

  Future<void> _loadStorageInfo(Map<String, dynamic> info) async {
    try {
      final storage = <Map<String, String>>[];

      // Get storage info from lsblk
      try {
        final result = await Process.run('lsblk', [
          '-o',
          'NAME,SIZE,TYPE,MOUNTPOINT,MODEL',
        ]);
        if (result.exitCode == 0) {
          final output = result.stdout.toString();
          final lines = output.split('\n');

          for (int i = 1; i < lines.length; i++) {
            // Skip header
            final line = lines[i].trim();
            if (line.isNotEmpty) {
              final parts = line.split(RegExp(r'\s+'));
              if (parts.length >= 3) {
                final name = parts[0];
                final size = parts[1];
                final type = parts[2];
                final mountpoint = parts.length > 3 ? parts[3] : '';
                final model =
                    parts.length > 4 ? parts.sublist(4).join(' ') : '';

                if (type == 'disk' || type == 'part') {
                  storage.add({
                    'name': name,
                    'size': size,
                    'type': type,
                    'mountpoint': mountpoint,
                    'model': model,
                  });
                }
              }
            }
          }
        }
      } catch (e) {
        // Fallback to basic detection
      }

      if (storage.isEmpty) {
        storage.add({
          'name': 'Unknown',
          'size': 'Unknown',
          'type': 'Unknown',
          'mountpoint': 'Unknown',
          'model': 'Unknown Storage',
        });
      }

      info['STORAGE'] = storage;
    } catch (e) {
      info['STORAGE_ERROR'] = 'Failed to load storage information: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StaticBackground(
      child: VenomScaffold(
        // appBar: AppBar(
        //   title: const Text('Hardware Details'),
        //   backgroundColor: macAppStoreDark,
        //   foregroundColor: Colors.white,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.refresh),
        //       onPressed: _loadHardwareInfo,
        //       tooltip: 'Refresh Information',
        //     ),
        //   ],
        // ),
        body:
            _isLoading
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
                          _buildCpuInfoCard(),
                          _buildMemoryInfoCard(),
                          _buildGpuInfoCard(),
                          _buildStorageInfoCard(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildCpuInfoCard() {
    final cpu = _hardwareInfo['CPU'] as Map<String, dynamic>?;
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.memory, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Processor (CPU)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (cpu != null) ...[
              _buildInfoRow('Model', cpu['model'] ?? 'Unknown'),
              _buildInfoRow('Cores', cpu['cores']?.toString() ?? 'Unknown'),
              _buildInfoRow('Threads', cpu['threads']?.toString() ?? 'Unknown'),
              _buildInfoRow('Architecture', cpu['architecture'] ?? 'Unknown'),
            ] else if (_hardwareInfo.containsKey('CPU_ERROR')) ...[
              _buildErrorRow('Error', _hardwareInfo['CPU_ERROR']),
            ] else ...[
              _buildInfoRow('Status', 'Loading...'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryInfoCard() {
    final memory = _hardwareInfo['MEMORY'] as Map<String, dynamic>?;
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storage, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Memory (RAM)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (memory != null) ...[
              _buildInfoRow('Total', '${memory['total']} GB'),
              _buildInfoRow('Available', '${memory['available']} GB'),
              _buildInfoRow('Used', '${memory['used']} GB'),
              const SizedBox(height: 8),
              _buildMemoryBar(memory),
            ] else if (_hardwareInfo.containsKey('MEMORY_ERROR')) ...[
              _buildErrorRow('Error', _hardwareInfo['MEMORY_ERROR']),
            ] else ...[
              _buildInfoRow('Status', 'Loading...'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGpuInfoCard() {
    final gpus = _hardwareInfo['GPU'] as List<Map<String, String>>?;
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.videocam, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Graphics (GPU)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (gpus != null && gpus.isNotEmpty) ...[
              for (int i = 0; i < gpus.length; i++) ...[
                _buildInfoRow('GPU ${i + 1}', gpus[i]['name'] ?? 'Unknown'),
                if (i < gpus.length - 1) const SizedBox(height: 8),
              ],
            ] else if (_hardwareInfo.containsKey('GPU_ERROR')) ...[
              _buildErrorRow('Error', _hardwareInfo['GPU_ERROR']),
            ] else ...[
              _buildInfoRow('Status', 'Loading...'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStorageInfoCard() {
    final storage = _hardwareInfo['STORAGE'] as List<Map<String, String>>?;
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storage, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Storage Devices',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (storage != null && storage.isNotEmpty) ...[
              for (int i = 0; i < storage.length; i++) ...[
                _buildInfoRow(
                  'Device ${i + 1}',
                  storage[i]['name'] ?? 'Unknown',
                ),
                _buildInfoRow('Size', storage[i]['size'] ?? 'Unknown'),
                _buildInfoRow('Type', storage[i]['type'] ?? 'Unknown'),
                if (storage[i]['mountpoint']?.isNotEmpty == true)
                  _buildInfoRow('Mount Point', storage[i]['mountpoint'] ?? ''),
                if (storage[i]['model']?.isNotEmpty == true)
                  _buildInfoRow('Model', storage[i]['model'] ?? ''),
                if (i < storage.length - 1) const SizedBox(height: 16),
              ],
            ] else if (_hardwareInfo.containsKey('STORAGE_ERROR')) ...[
              _buildErrorRow('Error', _hardwareInfo['STORAGE_ERROR']),
            ] else ...[
              _buildInfoRow('Status', 'Loading...'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryBar(Map<String, dynamic> memory) {
    final totalKB = memory['totalKB'] as int;
    final availableKB = memory['availableKB'] as int;
    final usedKB = totalKB - availableKB;
    final usagePercent = totalKB > 0 ? (usedKB / totalKB) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Memory Usage',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
            ),
            Text(
              '${(usagePercent * 100).toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: usagePercent,
          backgroundColor: macAppStoreLightGray,
          valueColor: AlwaysStoppedAnimation<Color>(
            usagePercent > 0.8 ? const Color(0xFFFF6B6B) : macAppStoreBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorRow(String label, String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFFFF6B6B)),
            ),
          ),
        ],
      ),
    );
  }
}
