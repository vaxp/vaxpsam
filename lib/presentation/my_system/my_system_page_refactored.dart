import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../infrastructure/system_management_providers.dart';
import 'widgets/featured_section.dart';
import 'widgets/operations_section.dart';

/// Refactored system management page with clean architecture
class MySystemPageRefactored extends ConsumerWidget {
  const MySystemPageRefactored({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemSections = ref.watch(systemSectionsProvider);

    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured section (grid layout)
                const FeaturedSection(),
                
                // Other sections (list layout)
                ...systemSections
                    .where((section) => section.id != 'featured')
                    .map((section) => OperationsSection(
                          title: section.title,
                          operations: section.operations,
                          isGridLayout: section.isGridLayout,
                        )),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
