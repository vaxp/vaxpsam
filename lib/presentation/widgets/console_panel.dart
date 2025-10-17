import 'package:flutter/material.dart';
import '../../domain/command_output_line.dart';

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
    return Column(
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.copy), onPressed: onCopy),
            IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
            IconButton(
              icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
              onPressed: onPause,
            ),
            const Spacer(),
            Text('Console', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const Divider(),
        Expanded(
          child: Container(
            //Theme.of(context).colorScheme.surfaceContainerHighest,
            color: Color(
              const Color.fromARGB(204, 168, 168, 168).value + 0x11000000,
            ),
            child: ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, i) {
                final line = lines[i];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '[${line.timestamp.hour.toString().padLeft(2, '0')}:${line.timestamp.minute.toString().padLeft(2, '0')}:${line.timestamp.second.toString().padLeft(2, '0')}] ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Expanded(
                      child: Text(
                        line.text,
                        style: TextStyle(
                          color: line.isError ? Colors.red : Colors.green,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
