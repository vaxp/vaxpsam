// lib/editors/widgets/install_all_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/data/basic_editors_data.dart';
import 'package:vaxpsam/infrastructure/providers.dart';
import 'package:vaxpsam/presentation/console/console_utils.dart';
import 'package:vaxpsam/presentation/home/widgets/section_widgets.dart';
import 'package:vaxpsam/presentation/theme/app_theme.dart';


class InstallAllEditorsCard extends ConsumerWidget {
  const InstallAllEditorsCard({super.key});

  // نقل منطق التثبيت ليكون خاص بهذا الويدجيت
  void _installAll(BuildContext context, system) {
    final pkgs = BasicEditorsData.kAllPackageNames; // استخدام القائمة المفصولة

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Basic Editors'),
            content: Text(
              'This will install ${pkgs.length} editors and utilities via APT. Continue?',
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
                      ...pkgs,
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
                    'Install All Basic Editors',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Installs CLI/GUI editors and related developer utilities',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _installAll(context, system),
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