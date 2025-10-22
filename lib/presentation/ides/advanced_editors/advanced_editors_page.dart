// lib/advanced_editors/advanced_editors_page.dart (نظيف ومُنظم)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/theme/app_theme.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';
// استيراد الويدجيتات الجديدة
import 'widgets/advanced_hero_section.dart';
import 'widgets/install_all_advanced_card.dart';
import 'widgets/advanced_tools_grid.dart';

class AdvancedEditorsPage extends ConsumerWidget {
  const AdvancedEditorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: macAppStoreDark,
              flexibleSpace: FlexibleSpaceBar(
                background: AdvancedEditorsHeroSection(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllAdvancedEditorsCard(),
                  AdvancedToolsGrid(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
