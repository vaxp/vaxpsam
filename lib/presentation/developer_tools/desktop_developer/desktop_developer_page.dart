import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';

import '../../../core/theme/app_theme.dart';
import 'widget/desktop_hero_section.dart';
import 'widget/desktop_tools_grid.dart';
import 'widget/install_all_desktop_card.dart';

class DesktopDeveloperPage extends ConsumerWidget {
  const DesktopDeveloperPage({super.key});

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
              flexibleSpace: FlexibleSpaceBar(background: DesktopHeroSection()),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllDesktopCard(),
                  DesktopToolsGrid(),
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
