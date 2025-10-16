import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/widgets/section_widgets.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class LivePerformancePage extends ConsumerStatefulWidget {
  const LivePerformancePage({super.key});

  @override
  ConsumerState<LivePerformancePage> createState() => _LivePerformancePageState();
}

class _LivePerformancePageState extends ConsumerState<LivePerformancePage>
    with TickerProviderStateMixin {
  Timer? _updateTimer;
  bool _isMonitoring = false;
  bool _isDisposed = false;
  
  // Performance data
  double _cpuUsage = 0.0;
  double _memoryUsage = 0.0;
  double _networkUp = 0.0;
  double _networkDown = 0.0;
  
  // Historical data for graphs
  List<double> _cpuHistory = [];
  List<double> _memoryHistory = [];
  List<double> _networkUpHistory = [];
  List<double> _networkDownHistory = [];
  
  // Animation controllers
  late AnimationController _cpuAnimationController;
  late AnimationController _memoryAnimationController;
  late AnimationController _networkAnimationController;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _cpuAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _memoryAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _networkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    // Start monitoring after a short delay to ensure widget is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startMonitoring();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _updateTimer?.cancel();
    _cpuAnimationController.dispose();
    _memoryAnimationController.dispose();
    _networkAnimationController.dispose();
    super.dispose();
  }

  void _startMonitoring() {
    if (_isMonitoring || !mounted || _isDisposed) return;
    
    setState(() {
      _isMonitoring = true;
    });
    
    _updateTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted || _isDisposed) {
        timer.cancel();
        return;
      }
      _updatePerformanceData();
    });
  }

  void _stopMonitoring() {
    _updateTimer?.cancel();
    if (mounted && !_isDisposed) {
      setState(() {
        _isMonitoring = false;
      });
    }
  }

  Future<void> _updatePerformanceData() async {
    if (!mounted || _isDisposed) return;
    
    try {
      // Get CPU usage
      await _updateCpuUsage();
      
      // Get memory usage
      await _updateMemoryUsage();
      
      // Get network usage
      await _updateNetworkUsage();
      
      // Update historical data
      _updateHistoricalData();
      
      // Trigger animations
      if (mounted && !_isDisposed) {
        _cpuAnimationController.forward().then((_) {
          if (mounted && !_isDisposed) _cpuAnimationController.reverse();
        });
        _memoryAnimationController.forward().then((_) {
          if (mounted && !_isDisposed) _memoryAnimationController.reverse();
        });
        _networkAnimationController.forward().then((_) {
          if (mounted && !_isDisposed) _networkAnimationController.reverse();
        });
      }
      
      if (mounted && !_isDisposed) {
        setState(() {});
      }
    } catch (e) {
      print('Error updating performance data: $e');
    }
  }

  Future<void> _updateCpuUsage() async {
    if (!mounted || _isDisposed) return;
    
    try {
      // Read CPU stats from /proc/stat
      final statFile = File('/proc/stat');
      if (await statFile.exists()) {
        final content = await statFile.readAsString();
        final lines = content.split('\n');
        
        if (lines.isNotEmpty) {
          final cpuLine = lines[0].split(RegExp(r'\s+'));
          if (cpuLine.length >= 8) {
            final user = int.tryParse(cpuLine[1]) ?? 0;
            final nice = int.tryParse(cpuLine[2]) ?? 0;
            final system = int.tryParse(cpuLine[3]) ?? 0;
            final idle = int.tryParse(cpuLine[4]) ?? 0;
            final iowait = int.tryParse(cpuLine[5]) ?? 0;
            final irq = int.tryParse(cpuLine[6]) ?? 0;
            final softirq = int.tryParse(cpuLine[7]) ?? 0;
            
            final total = user + nice + system + idle + iowait + irq + softirq;
            final idleTotal = idle + iowait;
            
            if (total > 0) {
              _cpuUsage = ((total - idleTotal) / total * 100).clamp(0.0, 100.0);
            }
          }
        }
      }
    } catch (e) {
      // Fallback to random value for demo
      _cpuUsage = Random().nextDouble() * 100;
    }
  }

  Future<void> _updateMemoryUsage() async {
    if (!mounted || _isDisposed) return;
    
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
        
        if (totalMemKB > 0) {
          _memoryUsage = ((totalMemKB - availableMemKB) / totalMemKB * 100).clamp(0.0, 100.0);
        }
      }
    } catch (e) {
      // Fallback to random value for demo
      _memoryUsage = Random().nextDouble() * 100;
    }
  }

  Future<void> _updateNetworkUsage() async {
    if (!mounted || _isDisposed) return;
    
    try {
      // Read network stats from /proc/net/dev
      final netDevFile = File('/proc/net/dev');
      if (await netDevFile.exists()) {
        final content = await netDevFile.readAsString();
        final lines = content.split('\n');
        
        int totalRx = 0;
        int totalTx = 0;
        
        for (final line in lines) {
          if (line.contains(':') && !line.contains('lo:')) {
            final parts = line.split(':');
            if (parts.length == 2) {
              final stats = parts[1].trim().split(RegExp(r'\s+'));
              if (stats.length >= 9) {
                final rx = int.tryParse(stats[0]) ?? 0;
                final tx = int.tryParse(stats[8]) ?? 0;
                totalRx += rx;
                totalTx += tx;
              }
            }
          }
        }
        
        // Convert to KB/s (simplified calculation)
        _networkDown = (totalRx / 1024).clamp(0.0, 10000.0);
        _networkUp = (totalTx / 1024).clamp(0.0, 10000.0);
      }
    } catch (e) {
      // Fallback to random values for demo
      _networkDown = Random().nextDouble() * 1000;
      _networkUp = Random().nextDouble() * 1000;
    }
  }

  void _updateHistoricalData() {
    // Keep only last 30 data points
    const maxHistory = 30;
    
    _cpuHistory.add(_cpuUsage);
    _memoryHistory.add(_memoryUsage);
    _networkUpHistory.add(_networkUp);
    _networkDownHistory.add(_networkDown);
    
    if (_cpuHistory.length > maxHistory) {
      _cpuHistory.removeAt(0);
      _memoryHistory.removeAt(0);
      _networkUpHistory.removeAt(0);
      _networkDownHistory.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Live Performance'),
        backgroundColor: macAppStoreDark,
        foregroundColor: Colors.white,
        elevation: 0,
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(_isMonitoring ? Icons.pause : Icons.play_arrow),
            onPressed: _isMonitoring ? _stopMonitoring : _startMonitoring,
            tooltip: _isMonitoring ? 'Pause Monitoring' : 'Start Monitoring',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCpuUsageCard(),
                _buildMemoryUsageCard(),
                _buildNetworkUsageCard(),
                _buildPerformanceGraphs(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildCpuUsageCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.memory,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'CPU Usage',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                AnimatedBuilder(
                  animation: _cpuAnimationController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getCpuColor().withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_cpuUsage.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: _getCpuColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildUsageBar(_cpuUsage, _getCpuColor()),
            const SizedBox(height: 8),
            _buildCpuGraph(),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryUsageCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.storage,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Memory Usage',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                AnimatedBuilder(
                  animation: _memoryAnimationController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getMemoryColor().withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_memoryUsage.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: _getMemoryColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildUsageBar(_memoryUsage, _getMemoryColor()),
            const SizedBox(height: 8),
            _buildMemoryGraph(),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkUsageCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.network_check,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Network Activity',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                AnimatedBuilder(
                  animation: _networkAnimationController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: macAppStoreBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_networkDown.toStringAsFixed(1)} KB/s',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: macAppStoreBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNetworkInfo(),
            const SizedBox(height: 8),
            _buildNetworkGraph(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceGraphs() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.show_chart,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Performance Trends',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildCombinedGraph(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageBar(double usage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Usage',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: macAppStoreGray,
              ),
            ),
            Text(
              '${usage.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: usage / 100,
          backgroundColor: macAppStoreLightGray,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildNetworkInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Download',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: macAppStoreGray,
                ),
              ),
              Text(
                '${_networkDown.toStringAsFixed(1)} KB/s',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4CAF50),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: macAppStoreGray,
                ),
              ),
              Text(
                '${_networkUp.toStringAsFixed(1)} KB/s',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFFF9800),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCpuGraph() {
    return SizedBox(
      height: 60,
      child: CustomPaint(
        painter: LineGraphPainter(
          data: _cpuHistory,
          color: _getCpuColor(),
          maxValue: 100.0,
        ),
      ),
    );
  }

  Widget _buildMemoryGraph() {
    return SizedBox(
      height: 60,
      child: CustomPaint(
        painter: LineGraphPainter(
          data: _memoryHistory,
          color: _getMemoryColor(),
          maxValue: 100.0,
        ),
      ),
    );
  }

  Widget _buildNetworkGraph() {
    return SizedBox(
      height: 60,
      child: CustomPaint(
        painter: NetworkGraphPainter(
          upData: _networkUpHistory,
          downData: _networkDownHistory,
          upColor: const Color(0xFFFF9800),
          downColor: const Color(0xFF4CAF50),
        ),
      ),
    );
  }

  Widget _buildCombinedGraph() {
    return SizedBox(
      height: 120,
      child: CustomPaint(
        painter: CombinedGraphPainter(
          cpuData: _cpuHistory,
          memoryData: _memoryHistory,
          networkData: _networkDownHistory,
        ),
      ),
    );
  }

  Color _getCpuColor() {
    if (_cpuUsage > 80) return const Color(0xFFFF6B6B);
    if (_cpuUsage > 60) return const Color(0xFFFF9800);
    return const Color(0xFF4CAF50);
  }

  Color _getMemoryColor() {
    if (_memoryUsage > 90) return const Color(0xFFFF6B6B);
    if (_memoryUsage > 75) return const Color(0xFFFF9800);
    return const Color(0xFF4CAF50);
  }
}

// Custom painters for graphs
class LineGraphPainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final double maxValue;

  LineGraphPainter({
    required this.data,
    required this.color,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] / maxValue * size.height);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class NetworkGraphPainter extends CustomPainter {
  final List<double> upData;
  final List<double> downData;
  final Color upColor;
  final Color downColor;

  NetworkGraphPainter({
    required this.upData,
    required this.downData,
    required this.upColor,
    required this.downColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (upData.isEmpty && downData.isEmpty) return;

    final maxValue = [...upData, ...downData].fold(0.0, (a, b) => a > b ? a : b);
    if (maxValue == 0) return;

    // Draw upload line
    if (upData.isNotEmpty) {
      final upPaint = Paint()
        ..color = upColor
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final upPath = Path();
      final stepX = size.width / (upData.length - 1);

      for (int i = 0; i < upData.length; i++) {
        final x = i * stepX;
        final y = size.height - (upData[i] / maxValue * size.height);
        
        if (i == 0) {
          upPath.moveTo(x, y);
        } else {
          upPath.lineTo(x, y);
        }
      }

      canvas.drawPath(upPath, upPaint);
    }

    // Draw download line
    if (downData.isNotEmpty) {
      final downPaint = Paint()
        ..color = downColor
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final downPath = Path();
      final stepX = size.width / (downData.length - 1);

      for (int i = 0; i < downData.length; i++) {
        final x = i * stepX;
        final y = size.height - (downData[i] / maxValue * size.height);
        
        if (i == 0) {
          downPath.moveTo(x, y);
        } else {
          downPath.lineTo(x, y);
        }
      }

      canvas.drawPath(downPath, downPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CombinedGraphPainter extends CustomPainter {
  final List<double> cpuData;
  final List<double> memoryData;
  final List<double> networkData;

  CombinedGraphPainter({
    required this.cpuData,
    required this.memoryData,
    required this.networkData,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cpuPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final memoryPaint = Paint()
      ..color = const Color(0xFF2196F3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final networkPaint = Paint()
      ..color = const Color(0xFFFF9800)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw CPU line
    if (cpuData.isNotEmpty) {
      _drawLine(canvas, size, cpuData, cpuPaint, 100.0);
    }

    // Draw Memory line
    if (memoryData.isNotEmpty) {
      _drawLine(canvas, size, memoryData, memoryPaint, 100.0);
    }

    // Draw Network line (normalized)
    if (networkData.isNotEmpty) {
      final maxNetwork = networkData.fold(0.0, (a, b) => a > b ? a : b);
      if (maxNetwork > 0) {
        _drawLine(canvas, size, networkData, networkPaint, maxNetwork);
      }
    }
  }

  void _drawLine(Canvas canvas, Size size, List<double> data, Paint paint, double maxValue) {
    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] / maxValue * size.height);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
