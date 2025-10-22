import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';
import '../../../core/theme/app_theme.dart';

// استيراد الويدجيتات الجديدة
import 'widgets/wireless_hero_section.dart';
import 'widgets/install_all_wireless_card.dart';
import 'widgets/wireless_tools_grid.dart';

class WirelessSecurityPage extends ConsumerWidget {
  const WirelessSecurityPage({super.key});

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
                background: WirelessHeroSection(), // الويدجيت المفصول
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllWirelessCard(), // الويدجيت المفصول
                  WirelessToolsGrid(), // الويدجيت المفصول
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
