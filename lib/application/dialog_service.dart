import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

/// Service class that handles all dialog-related logic
class DialogService {
  DialogService();

  /// Shows package installation dialog
  Future<String?> showPackageInstallDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (ctx) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Install Application'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Package name',
              hintText: 'e.g., firefox, vscode, git',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: const Text('Install'),
            ),
          ],
        );
      },
    );
  }

  /// Shows package removal dialog
  Future<String?> showPackageRemoveDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (ctx) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Remove Package'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Package name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  /// Shows .deb file picker dialog
  Future<String?> showDebFilePickerDialog(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['deb'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final fileName = result.files.single.name;

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Install .deb Package'),
          content: Text('Install "$fileName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Install'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        return filePath;
      }
    }
    return null;
  }

  /// Shows confirmation dialog for enabling repositories
  Future<bool> showRepositoryEnableDialog(
    BuildContext context,
    String title,
    String content,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Enable'),
          ),
        ],
      ),
    ) ?? false;
  }

  /// Shows package not found dialog
  void showPackageNotFoundDialog(BuildContext context, String packageName) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Not Found'),
        content: Text(
          '"$packageName" was not found in Ubuntu, Snap, or Flathub.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Shows error dialog
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Shows success dialog
  void showSuccessDialog(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Shows loading dialog
  void showLoadingDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    );
  }

  /// Hides loading dialog
  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
