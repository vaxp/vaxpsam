import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import '../../domain/command_output_line.dart';
import '../theme/app_theme.dart';

class ConsoleModal extends StatefulWidget {
  final Stream<CommandOutputLine> stream;
  const ConsoleModal({super.key, required this.stream});

  @override
  State<ConsoleModal> createState() => _ConsoleModalState();
}

class _ConsoleModalState extends State<ConsoleModal> {
  final List<CommandOutputLine> _lines = [];
  StreamSubscription<CommandOutputLine>? _sub;
  bool _paused = false;
  bool _running = true;
  bool _showProgress = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _sub = widget.stream.listen(_onLine, onDone: _onDone, onError: _onError);
  }

  void _onLine(CommandOutputLine line) {
    // detect simple progress hints
    final text = line.text.toLowerCase();
    if (text.contains('downloading') || text.contains('download')) {
      _showProgress = true;
    }
    // try parse percent like " 12%" in the line
    final percentMatch = RegExp(r'([0-9]{1,3})%').firstMatch(line.text);
    if (percentMatch != null) {
      final p = int.tryParse(percentMatch.group(1)!) ?? 0;
      _progress = (p.clamp(0, 100)) / 100.0;
      _showProgress = true;
    }

    if (text.contains('[process exited with code')) {
      _running = false;
      _showProgress = false;
    }

    if (!_paused) {
      setState(() => _lines.add(line));
    }
  }

  void _onDone() {
    setState(() {
      _running = false;
      _showProgress = false;
    });
  }

  void _onError(Object err, StackTrace st) {
    setState(() {
      _running = false;
      _showProgress = false;
      _lines.add(CommandOutputLine(timestamp: DateTime.now(), text: 'Error: $err', isError: true));
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _copyAll() async {
    final all = _lines.map((l) => '[${l.timestamp.toIso8601String()}] ${l.text}').join('\n');
    await Clipboard.setData(ClipboardData(text: all));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Console copied to clipboard'),
          backgroundColor: macAppStoreCard,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _clear() => setState(() => _lines.clear());

  void _togglePause() => setState(() => _paused = !_paused);

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
                bottom: BorderSide(color: macAppStoreLightGray.withOpacity(0.2)),
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
                  onPressed: _copyAll,
                  tooltip: 'Copy Output',
                ),
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: macAppStoreGray,
                    size: 18,
                  ),
                  onPressed: _clear,
                  tooltip: 'Clear Console',
                ),
                IconButton(
                  icon: Icon(
                    _paused ? Icons.play_arrow : Icons.pause,
                    color: macAppStoreGray,
                    size: 18,
                  ),
                  onPressed: _togglePause,
                  tooltip: _paused ? 'Resume' : 'Pause',
                ),
              ],
            ),
          ),
          // Progress indicator
          if (_showProgress || (_running && _lines.isEmpty))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  if (_showProgress)
                    LinearProgressIndicator(
                      value: _progress > 0 ? _progress : null,
                      backgroundColor: macAppStoreLightGray,
                      valueColor: AlwaysStoppedAnimation<Color>(macAppStoreBlue),
                    ),
                  if (_running && _lines.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(macAppStoreBlue),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          // Console content
          Expanded(
            child: Container(
              color: const Color(0xFF1A1A1A),
              child: _lines.isEmpty && !_running
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
                      itemCount: _lines.length,
                      itemBuilder: (context, i) {
                        final line = _lines[i];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
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
          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: macAppStoreCard,
              border: Border(
                top: BorderSide(color: macAppStoreLightGray.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _running ? 'Running...' : 'Finished',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: macAppStoreGray,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: macAppStoreBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}