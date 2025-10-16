import 'package:flutter/material.dart';
import 'dart:async';
import '../../domain/command_output_line.dart';
import '../theme/app_theme.dart';

class GPUData {
  final String vendor;
  final String name;
  final int utilization;
  final int memoryUsed;
  final int memoryTotal;
  final int temperature;
  final double powerDraw;
  final int memoryPercent;
  final String? error;

  GPUData({
    required this.vendor,
    required this.name,
    required this.utilization,
    required this.memoryUsed,
    required this.memoryTotal,
    required this.temperature,
    required this.powerDraw,
    required this.memoryPercent,
    this.error,
  });

  factory GPUData.fromMap(Map<String, dynamic> map) {
    return GPUData(
      vendor: map['vendor'] ?? 'unknown',
      name: map['name'] ?? 'Unknown GPU',
      utilization: map['utilization'] ?? 0,
      memoryUsed: map['memoryUsed'] ?? 0,
      memoryTotal: map['memoryTotal'] ?? 0,
      temperature: map['temperature'] ?? 0,
      powerDraw: map['powerDraw'] ?? 0.0,
      memoryPercent: map['memoryPercent'] ?? 0,
      error: map['error'],
    );
  }

  bool get hasError => error != null;
  bool get isNvidia => vendor == 'nvidia';
  bool get isAmd => vendor == 'amd';
  bool get isIntel => vendor == 'intel';
}

class CPUData {
  final String name;
  final double usage;
  final int temperature;
  final int cores;
  final double frequency;
  final String? error;

  CPUData({
    required this.name,
    required this.usage,
    required this.temperature,
    required this.cores,
    required this.frequency,
    this.error,
  });

  factory CPUData.fromMap(Map<String, dynamic> map) {
    return CPUData(
      name: map['name'] ?? 'Unknown CPU',
      usage: map['usage'] ?? 0.0,
      temperature: map['temperature'] ?? 0,
      cores: map['cores'] ?? 0,
      frequency: map['frequency'] ?? 0.0,
      error: map['error'],
    );
  }

  bool get hasError => error != null;
}

class IntegratedGraphicsData {
  final String name;
  final String vendor;
  final String type;
  final String? details;
  final String? error;

  IntegratedGraphicsData({
    required this.name,
    required this.vendor,
    required this.type,
    this.details,
    this.error,
  });

  factory IntegratedGraphicsData.fromMap(Map<String, dynamic> map) {
    return IntegratedGraphicsData(
      name: map['name'] ?? 'Unknown Integrated Graphics',
      vendor: map['vendor'] ?? 'unknown',
      type: map['type'] ?? 'integrated',
      details: map['details'],
      error: map['error'],
    );
  }

  bool get hasError => error != null;
}

class SystemMonitoringWidget extends StatefulWidget {
  final Future<Map<String, dynamic>> Function() getGPUData;
  final Future<Map<String, dynamic>> Function() getCPUData;
  final Future<Map<String, dynamic>> Function() getIntegratedGraphicsData;
  final Stream<CommandOutputLine> Function() installNvidiaTools;
  final Stream<CommandOutputLine> Function() installAmdTools;
  final Stream<CommandOutputLine> Function() installIntelTools;
  final Stream<CommandOutputLine> Function() installGeneralTools;
  final Future<bool> Function() isNvidiaAvailable;
  final Future<bool> Function() isAmdAvailable;
  final Future<bool> Function() isIntelAvailable;
  final Function(Stream<CommandOutputLine>) showConsoleStream;

  const SystemMonitoringWidget({
    super.key,
    required this.getGPUData,
    required this.getCPUData,
    required this.getIntegratedGraphicsData,
    required this.installNvidiaTools,
    required this.installAmdTools,
    required this.installIntelTools,
    required this.installGeneralTools,
    required this.isNvidiaAvailable,
    required this.isAmdAvailable,
    required this.isIntelAvailable,
    required this.showConsoleStream,
  });

  @override
  State<SystemMonitoringWidget> createState() => _SystemMonitoringWidgetState();
}

class _SystemMonitoringWidgetState extends State<SystemMonitoringWidget> {
  GPUData? _gpuData;
  CPUData? _cpuData;
  IntegratedGraphicsData? _integratedGraphicsData;
  bool _isLoading = false;
  bool _isMonitoring = false;
  Timer? _monitoringTimer;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  @override
  void dispose() {
    _monitoringTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadAllData() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    try {
      final gpuData = await widget.getGPUData();
      final cpuData = await widget.getCPUData();
      final integratedGraphicsData = await widget.getIntegratedGraphicsData();
      
      if (mounted) {
        setState(() {
          _gpuData = GPUData.fromMap(gpuData);
          _cpuData = CPUData.fromMap(cpuData);
          _integratedGraphicsData = IntegratedGraphicsData.fromMap(integratedGraphicsData);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateDataOnly() async {
    if (_isLoading) return;
    
    try {
      final gpuData = await widget.getGPUData();
      final cpuData = await widget.getCPUData();
      
      if (mounted) {
        setState(() {
          _gpuData = GPUData.fromMap(gpuData);
          _cpuData = CPUData.fromMap(cpuData);
          // Don't update integrated graphics during monitoring as it doesn't change frequently
        });
      }
    } catch (e) {
      // Silent fail during monitoring updates
    }
  }

  void _startMonitoring() {
    if (_isMonitoring) return;
    
    setState(() => _isMonitoring = true);
    _monitoringTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        _updateDataOnly();
      }
    });
  }

  void _stopMonitoring() {
    _monitoringTimer?.cancel();
    setState(() => _isMonitoring = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(94, 114, 114, 114),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const Divider(color: macAppStoreLightGray, height: 1),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.monitor, color: const Color.fromARGB(255, 0, 0, 0)),
          const SizedBox(width: 12),
          Text(
            'System Monitoring',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _showInstallDialog,
            icon: const Icon(Icons.download, size: 16),
            label: const Text('Install Tools'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 22, 107, 89),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              _isMonitoring ? Icons.pause : Icons.play_arrow,
              color: _isMonitoring ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50),
            ),
            onPressed: _isMonitoring ? _stopMonitoring : _startMonitoring,
            tooltip: _isMonitoring ? 'Stop Monitoring' : 'Start Monitoring',
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: macAppStoreGray),
            onPressed: _loadAllData,
            tooltip: 'Refresh',
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(macAppStoreBlue),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // GPU Section
          _buildGPUSection(context),
          const SizedBox(height: 16),
          // CPU Section
          _buildCPUSection(context),
          const SizedBox(height: 16),
          // Integrated Graphics Section
          _buildIntegratedGraphicsSection(context),
        ],
      ),
    );
  }

  Widget _buildGPUSection(BuildContext context) {
    return _buildHardwareCard(
      context,
      title: 'Dedicated GPU',
      icon: Icons.memory,
      color: _getVendorColor(_gpuData?.vendor ?? 'unknown'),
      child: _gpuData == null || _gpuData!.hasError
          ? _buildErrorState(context, _gpuData?.error ?? 'No GPU data available')
          : _buildGPUInfo(context),
    );
  }

  Widget _buildCPUSection(BuildContext context) {
    return _buildHardwareCard(
      context,
      title: 'CPU',
      icon: Icons.speed,
      color: const Color(0xFF2196F3),
      child: _cpuData == null || _cpuData!.hasError
          ? _buildErrorState(context, _cpuData?.error ?? 'No CPU data available')
          : _buildCPUInfo(context),
    );
  }

  Widget _buildIntegratedGraphicsSection(BuildContext context) {
    return _buildHardwareCard(
      context,
      title: 'Integrated Graphics',
      icon: Icons.monitor,
      color: const Color(0xFF9C27B0),
      child: _integratedGraphicsData == null || _integratedGraphicsData!.hasError
          ? _buildErrorState(context, _integratedGraphicsData?.error ?? 'No integrated graphics detected')
          : _buildIntegratedGraphicsInfo(context),
    );
  }

  Widget _buildHardwareCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: macAppStoreDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildGPUInfo(BuildContext context) {
    final gpu = _gpuData!;
    
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getVendorColor(gpu.vendor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getVendorIcon(gpu.vendor),
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gpu.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${gpu.vendor.toUpperCase()} GPU',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getVendorColor(gpu.vendor),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OptimizedMetricItem(
                label: 'Usage',
                value: '${gpu.utilization}%',
                current: gpu.utilization,
                max: 100,
                color: const Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OptimizedMetricItem(
                label: 'Memory',
                value: '${gpu.memoryUsed}MB',
                current: gpu.memoryPercent,
                max: 100,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OptimizedMetricItem(
                label: 'Temperature',
                value: '${gpu.temperature}°C',
                current: gpu.temperature,
                max: 100,
                color: _getTemperatureColor(gpu.temperature),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OptimizedMetricItem(
                label: 'Power',
                value: '${gpu.powerDraw.toStringAsFixed(1)}W',
                current: gpu.powerDraw,
                max: 300,
                color: const Color(0xFFFF9800),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCPUInfo(BuildContext context) {
    final cpu = _cpuData!;
    
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.speed,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cpu.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${cpu.cores} cores',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: macAppStoreGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OptimizedMetricItem(
                label: 'Usage',
                value: '${cpu.usage.toStringAsFixed(1)}%',
                current: cpu.usage,
                max: 100,
                color: const Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OptimizedMetricItem(
                label: 'Temperature',
                value: '${cpu.temperature}°C',
                current: cpu.temperature,
                max: 100,
                color: _getTemperatureColor(cpu.temperature),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OptimizedMetricItem(
                label: 'Frequency',
                value: '${cpu.frequency.toStringAsFixed(0)}MHz',
                current: cpu.frequency,
                max: 4000,
                color: const Color(0xFF9C27B0),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OptimizedMetricItem(
                label: 'Cores',
                value: '${cpu.cores}',
                current: cpu.cores,
                max: 32,
                color: const Color(0xFF2196F3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIntegratedGraphicsInfo(BuildContext context) {
    final igpu = _integratedGraphicsData!;
    
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.monitor,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    igpu.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${igpu.vendor.toUpperCase()} ${igpu.type.toUpperCase()}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF9C27B0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (igpu.details != null) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: macAppStoreCard,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              igpu.details!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: macAppStoreGray,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 32, color: macAppStoreGray),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color.fromARGB(186, 31, 31, 31),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _showInstallDialog() async {

    
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Install Monitoring Tools'),
        content: const Text(
          'Choose the monitoring tools to install based on your hardware:',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop('nvidia'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF76B900)),
            child: const Text('NVIDIA', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop('amd'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFED1C24)),
            child: const Text('AMD', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop('intel'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 143, 238)),
            child: const Text('Intel', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop('general'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 255, 242)),
            child: const Text('General', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      switch (result) {
        case 'nvidia':
          widget.showConsoleStream(widget.installNvidiaTools());
          break;
        case 'amd':
          widget.showConsoleStream(widget.installAmdTools());
          break;
        case 'intel':
          widget.showConsoleStream(widget.installIntelTools());
          break;
        case 'general':
          widget.showConsoleStream(widget.installGeneralTools());
          break;
      }
      
      // Refresh data after installation
      Timer(const Duration(seconds: 5), () {
        _loadAllData();
      });
    }
  }

  Color _getVendorColor(String vendor) {
    switch (vendor.toLowerCase()) {
      case 'nvidia':
        return const Color.fromARGB(255, 90, 143, 0);
      case 'amd':
        return const Color.fromARGB(255, 136, 0, 5);
      case 'intel':
        return const Color.fromARGB(255, 0, 0, 0);
      default:
        return macAppStoreGray;
    }
  }

  IconData _getVendorIcon(String vendor) {
    switch (vendor.toLowerCase()) {
      case 'nvidia':
        return Icons.memory;
      case 'amd':
        return Icons.memory;
      case 'intel':
        return Icons.memory;
      default:
        return Icons.monitor;
    }
  }

  Color _getTemperatureColor(int temp) {
    if (temp < 60) return const Color(0xFF4CAF50);
    if (temp < 80) return const Color(0xFFFF9800);
    return const Color(0xFFFF6B6B);
  }
}

class OptimizedMetricItem extends StatelessWidget {
  final String label;
  final String value;
  final num current;
  final num max;
  final Color color;

  const OptimizedMetricItem({
    super.key,
    required this.label,
    required this.value,
    required this.current,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = max > 0 ? (current / max * 100).clamp(0, 100) : 0;
    
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: macAppStoreGray,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: macAppStoreGray.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 3,
        ),
      ],
    );
  }
}
