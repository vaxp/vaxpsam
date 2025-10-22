import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';
import 'package:vaxpsam/presentation/developer_tools/web_frontend/widget/frontend_hero_section.dart';
import 'package:vaxpsam/presentation/developer_tools/web_frontend/widget/frontend_tools_grid.dart';
import 'package:vaxpsam/presentation/developer_tools/web_frontend/widget/install_all_frontend_card.dart';
import '../../../core/theme/app_theme.dart';

class WebFrontendPage extends ConsumerWidget {
  const WebFrontendPage({super.key});

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
                background: FrontendHeroSection(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllFrontendCard(),
                  FrontendToolsGrid(),
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
