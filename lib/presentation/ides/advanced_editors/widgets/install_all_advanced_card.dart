// lib/advanced_editors/widgets/install_all_advanced_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/data/advanced_editors_data.dart';
import 'package:vaxpsam/infrastructure/providers.dart';
import 'package:vaxpsam/presentation/console/console_utils.dart';
import 'package:vaxpsam/presentation/home/widgets/section_widgets.dart';
import 'package:vaxpsam/presentation/theme/app_theme.dart';

class InstallAllAdvancedEditorsCard extends ConsumerWidget {
  const InstallAllAdvancedEditorsCard({super.key});

  void _installAll(BuildContext context, system) {
    final refs = AdvancedEditorsData.kAllToolRefs; // استخدام القائمة المفصولة

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Advanced Editors'),
            content: Text(
              'This will install ${refs.length} editors via Flatpak. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  // المنطق المعقد لتثبيت جميع حزم Flatpak
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'bash',
                      '-lc',
                      'for r in "${refs.join('" "')}"; do flatpak install -y flathub "\$r"; done',
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
                    'Install All Advanced Editors',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Installs all listed IDEs via Flatpak from Flathub',
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