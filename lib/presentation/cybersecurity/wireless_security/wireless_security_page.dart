import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/venom_layout.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';
import 'widgets/install_all_wireless_card.dart';
import 'widgets/wireless_tools_grid.dart';

class WirelessSecurityPage extends ConsumerWidget {
  const WirelessSecurityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // تم إزالة قراءة system provider من هنا
    return const StaticBackground(
      child: VenomScaffold(
        title: "Wireless Security",
        body: CustomScrollView(
          slivers: [
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
