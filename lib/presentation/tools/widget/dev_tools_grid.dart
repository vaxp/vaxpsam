import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/data/tools_data.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart'; // GridView.count, AppGridCard
import '../../console/console_utils.dart';
import 'package:vaxpsam/domain/dev_tool.dart' show DevTool, InstallationMethod;

class DevToolsGrid extends ConsumerWidget {
  const DevToolsGrid({super.key});

  void _installTool(BuildContext context, system, DevTool tool) {
    if (tool.installMethod == InstallationMethod.debUrl) {
      // منطق التثبيت لـ VS Code عبر الرابط
      showConsoleStream(
        context,
        system.installDebFromUrl(tool.installArgument),
      );
    } else {
      // منطق التثبيت العادي عبر اسم الحزمة (APT)
      showConsoleStream(
        context,
        system.installPackageByName(tool.installArgument),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    final tools = DevToolsData.kDevelopmentTools;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'All Tools',
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
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children:
                  tools.map((tool) {
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
                      onTap: () => _installTool(context, system, tool),
                    );
                  }).toList(),
            );
          },
        ),
      ],
    );
  }
}
