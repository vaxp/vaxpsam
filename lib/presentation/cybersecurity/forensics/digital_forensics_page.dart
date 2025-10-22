// lib/forensics/digital_forensics_page.dart (نظيف ومُنظم)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';
import '../../../core/theme/app_theme.dart';

import 'widgets/forensics_hero_section.dart';
import 'widgets/install_all_forensics_card.dart';
import 'widgets/forensics_tools_grid.dart';

class DigitalForensicsPage extends ConsumerWidget {
  const DigitalForensicsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // لم نعد نحتاج لقراءة system provider هنا
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
                background: ForensicsHeroSection(), // الويدجيت المفصول
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllForensicsCard(), // الويدجيت المفصول
                  ForensicsToolsGrid(), // الويدجيت المفصول
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