import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/venom_layout.dart';

// استيراد الويدجيتات الجديدة
import 'widgets/install_all_network_card.dart';
import 'widgets/network_tools_grid.dart';

class NetworkAnalysisPage extends ConsumerWidget {
  const NetworkAnalysisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // تم إزالة قراءة system provider من هنا
    return const VenomScaffold(
      title: 'Network Analysis',
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InstallAllNetworkCard(), // الويدجيت المفصول
                NetworkToolsGrid(), // الويدجيت المفصول
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
