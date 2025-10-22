// lib/editors/widgets/tools_grid.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/data/basic_editors_data.dart';
import 'package:vaxpsam/infrastructure/providers.dart';
import 'package:vaxpsam/presentation/console/console_utils.dart';
import 'package:vaxpsam/presentation/home/widgets/section_widgets.dart';

class BasicEditorsGrid extends ConsumerWidget {
  const BasicEditorsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // قراءة الـ system provider هنا، بدلاً من تمريره
    final system = ref.read(systemServiceProvider);
    final tools =
        BasicEditorsData.kBasicEditorsTools; // استخدام البيانات المفصولة

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Basic Editors (APT)',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tools.length,
          itemBuilder: (context, i) {
            final tool = tools[i]; // استخدام كائن ToolItem

            return AppGridCard(
              title: tool.name, // الوصول المباشر
              description: tool.desc, // الوصول المباشر
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 57, 71),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  tool.iconAsset, // استخدام الحقل مباشرة
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName(tool.pkg), // الوصول المباشر
                  ),
            );
          },
        ),
      ],
    );
  }
}
