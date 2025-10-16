
import '../advanced_debugging_export.dart';

class ServiceManagementCard extends StatelessWidget {
  final SystemServiceInfo service;
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onRestart;
  final VoidCallback onEnable;
  final VoidCallback onDisable;
  final VoidCallback onViewLogs;

  const ServiceManagementCard({
    super.key,
    required this.service,
    required this.isRunning,
    required this.onStart,
    required this.onStop,
    required this.onRestart,
    required this.onEnable,
    required this.onDisable,
    required this.onViewLogs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isRunning 
                  ? const Color(0xFF4CAF50).withOpacity(0.1)
                  : const Color(0xFFFF6B6B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isRunning ? Icons.play_circle : Icons.stop_circle,
              color: isRunning ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  service.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: macAppStoreGray,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  isRunning ? 'Running' : 'Stopped',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isRunning ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isRunning ? Icons.stop : Icons.play_arrow,
                  color: isRunning ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50),
                  size: 16,
                ),
                onPressed: isRunning ? onStop : onStart,
                tooltip: isRunning ? 'Stop' : 'Start',
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: macAppStoreBlue, size: 16),
                onPressed: onRestart,
                tooltip: 'Restart',
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: macAppStoreGray, size: 16),
                onPressed: onEnable,
                tooltip: 'Enable',
              ),
              IconButton(
                icon: const Icon(Icons.visibility, color: macAppStoreGray, size: 16),
                onPressed: onViewLogs,
                tooltip: 'View Logs',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
