import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart'; // ResponsiveGrid, AppGridCard
import '../../console/console_utils.dart';
import '../../../data/browsers_data.dart'; // البيانات المفصولة

class BrowsersGrid extends ConsumerWidget {
  const BrowsersGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    final tools = BrowsersData.kBrowserTools;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'All Browsers',
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
                childAspectRatio: 1.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tools.length,
              itemBuilder: (context, index) {
                final tool = tools[index];
                return AppGridCard(
                  title: tool.title,
                  description: tool.description,
                  icon: Container(
                    decoration: BoxDecoration(
                      color: tool.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(tool.icon, color: Colors.white),
                  ),
                  onTap:
                      () => showConsoleStream(
                        context,
                        system.installPackageByName(tool.packageName),
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
