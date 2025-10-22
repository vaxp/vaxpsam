import 'package:flutter/material.dart';
import '../../console/console_utils.dart'; // showConsoleStream

void showLogCleanupDialog(BuildContext context, system) {
  showDialog(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: const Text('Clean System Logs'),
          content: const Text(
            'This action will permanently delete old system logs to free up space. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                showConsoleStream(context, system.cleanSystemLogs());
              },
              child: const Text('Clean Logs'),
            ),
          ],
        ),
  );
}

void showBootManagementDialog(BuildContext context, system, String action) {
  String title = '';
  String content = '';
  Function() onConfirm = () {};

  switch (action) {
    case 'grub':
      title = 'Rebuild GRUB Bootloader';
      content =
          'This will attempt to rebuild the GRUB boot configuration. This is a critical action. Continue?';
      onConfirm = () => showConsoleStream(context, system.rebuildGrub());
      break;
    case 'initramfs':
      title = 'Update Initramfs';
      content = 'This will update the initial RAM filesystem. Continue?';
      onConfirm = () => showConsoleStream(context, system.updateInitramfs());
      break;
    case 'repair':
      title = 'Run Boot Repair';
      content =
          'This will run a comprehensive boot repair tool. This is a critical action. Continue?';
      onConfirm = () => showConsoleStream(context, system.runBootRepair());
      break;
  }

  showDialog(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onConfirm();
              },
              child: Text(title.startsWith('Run') ? 'Repair' : 'Continue'),
            ),
          ],
        ),
  );
}
