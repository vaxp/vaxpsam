// lib/editors/basic_editors_page.dart (نظيف ومُنظم)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/rotating_background.dart';
import 'widgets/hero_section.dart';
import 'widgets/install_all_card.dart';
import 'widgets/tools_grid.dart';

class BasicEditorsPage extends ConsumerWidget {
  const BasicEditorsPage({super.key});

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
                background: EditorsHeroSection(), 
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllEditorsCard(), 
                  BasicEditorsGrid(), 
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
