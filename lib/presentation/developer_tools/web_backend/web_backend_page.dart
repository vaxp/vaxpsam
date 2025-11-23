import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/venom_layout.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';

import 'widget/backend_tools_grid.dart';
import 'widget/install_all_backend_card.dart';

class WebBackendPage extends ConsumerWidget {
  const WebBackendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const StaticBackground(
      child: VenomScaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstallAllBackendCard(),
                  BackendToolsGrid(),
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
