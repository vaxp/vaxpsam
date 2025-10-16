import '../advanced_debugging_export.dart';

Future<void> showBootManagementDialog(
  BuildContext context,
  system,
  String action,
) async {
  String title;
  String content;

  switch (action) {
    case 'grub':
      title = 'Rebuild GRUB';
      content =
          'This will rebuild the GRUB bootloader configuration. '
          'This may take several minutes. Continue?';
      break;
    case 'initramfs':
      title = 'Update Initramfs';
      content =
          'This will update the initial RAM filesystem. '
          'This may take several minutes. Continue?';
      break;
    case 'repair':
      title = 'Boot Repair';
      content =
          'This will run comprehensive boot repair operations. '
          'This may take several minutes and requires a reboot. Continue?';
      break;
    default:
      title = 'Boot Management';
      content = 'Continue with boot management operation?';
  }

  final confirmed = await showDialog<bool>(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: macAppStoreBlue),
              child: const Text('Continue'),
            ),
          ],
        ),
  );

  if (confirmed == true && context.mounted) {
    switch (action) {
      case 'grub':
        showConsoleStream(context, system.rebuildGRUB());
        break;
      case 'initramfs':
        showConsoleStream(context, system.updateInitramfs());
        break;
      case 'repair':
        showConsoleStream(context, system.bootRepair());
        break;
    }
  }
}
