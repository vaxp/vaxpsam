// lib/advanced_editors/widgets/advanced_tools_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/data/advanced_editors_data.dart';
import 'package:vaxpsam/infrastructure/providers.dart';
import 'package:vaxpsam/presentation/console/console_utils.dart';
import 'package:vaxpsam/presentation/home/widgets/section_widgets.dart';

class AdvancedToolsGrid extends ConsumerWidget {
  const AdvancedToolsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    final tools =
        AdvancedEditorsData.kAdvancedEditorsTools; // استخدام البيانات المفصولة

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Advanced Editors (Flathub)',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 400) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tools.length,
              itemBuilder: (context, i) {
                final tool = tools[i]; // استخدام كائن AdvancedTool

                return AppGridCard(
                  title: tool.name,
                  description: tool.desc,
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 55, 57, 71),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      tool.iconAsset,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                  onTap:
                      () => showConsoleStream(
                        context,
                        system.runAsRoot([
                          'flatpak',
                          'install',
                          '-y',
                          'flathub',
                          tool.ref, // استخدام حقل ref مباشرة
                        ]),
                      ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
