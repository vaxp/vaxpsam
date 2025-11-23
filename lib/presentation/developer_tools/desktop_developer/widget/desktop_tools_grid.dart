import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/data/desktop_developer_data.dart';
import 'package:vaxpsam/infrastructure/providers.dart';
import 'package:vaxpsam/presentation/console/console_utils.dart';
import 'package:vaxpsam/presentation/home/widgets/section_widgets.dart';

class DesktopToolsGrid extends ConsumerWidget {
  const DesktopToolsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    final tools =
        DesktopDeveloperData
            .kDesktopDeveloperTools; // استخدام البيانات المفصولة

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Desktop Development Tools',
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
              itemBuilder: (context, index) {
                final tool = tools[index];
                return AppGridCard(
                  title: tool.name,
                  description: tool.description,
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF795548),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.desktop_windows,
                      color: Colors.white,
                    ), // أيقونة ثابتة
                  ),
                  onTap:
                      () => showConsoleStream(
                        context,
                        system.installPackageByName(tool.package),
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
