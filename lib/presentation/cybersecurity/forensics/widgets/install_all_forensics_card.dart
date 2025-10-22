// lib/forensics/widgets/install_all_forensics_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/theme/app_theme.dart';
import 'package:vaxpsam/data/forensics_data.dart';
import 'package:vaxpsam/infrastructure/providers.dart';
import 'package:vaxpsam/presentation/console/console_utils.dart';
import 'package:vaxpsam/presentation/home/widgets/section_widgets.dart';


class InstallAllForensicsCard extends ConsumerWidget {
  const InstallAllForensicsCard({super.key});

  void _installAllTools(BuildContext context, system) {
    final tools = ForensicsData.kAllToolPackages; // استخدام القائمة المفصولة

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Digital Forensics Tools'),
            content: Text(
              'This will install ${tools.length} digital forensics tools. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      ...tools,
                    ]),
                  );
                },
                child: const Text('Install All'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Row(
          children: [
            Icon(Icons.download, color: macAppStoreBlue, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Install All Digital Forensics Tools',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Install all ${ForensicsData.kForensicsTools.length} digital forensics tools at once',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: macAppStoreGray,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _installAllTools(context, system),
              icon: const Icon(Icons.install_desktop),
              label: const Text('Install All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: macAppStoreBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}