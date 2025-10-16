import 'package:flutter/material.dart';
import '../../domain/command_output_line.dart';
import '../theme/app_theme.dart';

class ConsolePanel extends StatelessWidget {
  final List<CommandOutputLine> lines;
  final VoidCallback? onCopy;
  final VoidCallback? onClear;
  final VoidCallback? onPause;
  final bool isPaused;

  const ConsolePanel({
    super.key,
    required this.lines,
    this.onCopy,
    this.onClear,
    this.onPause,
    this.isPaused = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: macAppStoreCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          // Header with Mac App Store style
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: macAppStoreCard,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(
                bottom: BorderSide(color: macAppStoreLightGray),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.terminal,
                  color: macAppStoreBlue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Console',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: macAppStoreGray,
                    size: 18,
                  ),
                  onPressed: onCopy,
                  tooltip: 'Copy Output',
                ),
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: macAppStoreGray,
                    size: 18,
                  ),
                  onPressed: onClear,
                  tooltip: 'Clear Console',
                ),
                IconButton(
                  icon: Icon(
                    isPaused ? Icons.play_arrow : Icons.pause,
                    color: macAppStoreGray,
                    size: 18,
                  ),
                  onPressed: onPause,
                  tooltip: isPaused ? 'Resume' : 'Pause',
                ),
              ],
            ),
          ),
          // Console content
          Expanded(
            child: Container(
              color: const Color(0xFF1A1A1A),
              child: lines.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.terminal,
                            size: 48,
                            color: macAppStoreGray,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No output yet',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: macAppStoreGray,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Run a command to see output here',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: macAppStoreGray,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: lines.length,
                      itemBuilder: (context, i) {
                        final line = lines[i];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  '[${line.timestamp.hour.toString().padLeft(2, '0')}:${line.timestamp.minute.toString().padLeft(2, '0')}:${line.timestamp.second.toString().padLeft(2, '0')}]',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: macAppStoreGray,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  line.text,
                                  style: TextStyle(
                                    color: line.isError ? const Color(0xFFFF6B6B) : const Color(0xFF4ECDC4),
                                    fontFamily: 'monospace',
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}