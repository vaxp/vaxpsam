import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/rotating_background.dart';
import 'widget/devops_hero_section.dart';
import 'widget/devops_tools_grid.dart';
import 'widget/install_all_devops_card.dart';


class DevOpsSysadminPage extends ConsumerWidget {
  const DevOpsSysadminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // تم إزالة قراءة system provider من هنا
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
                background: DevOpsHeroSection(), // الويدجيت المفصول
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllDevOpsCard(), // الويدجيت المفصول
                  DevOpsToolsGrid(), // الويدجيت المفصول
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