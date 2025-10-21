import '../advanced_debugging_export.dart';

Future<void> showLogCleanupDialog(BuildContext context, system) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: const Text('Clean System Logs'),
          content: const Text(
            'This will remove old system logs to free up storage space. '
            'This action cannot be undone. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text('Clean Logs'),
            ),
          ],
        ),
  );

  if (confirmed == true && context.mounted) {
    showConsoleStream(context, system.cleanSystemLogs());
  }
}
