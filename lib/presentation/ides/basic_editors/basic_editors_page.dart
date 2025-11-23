// lib/editors/basic_editors_page.dart (نظيف ومُنظم)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/venom_layout.dart';
import '../../../core/widgets/rotating_background.dart';
import 'widgets/install_all_card.dart';
import 'widgets/tools_grid.dart';

class BasicEditorsPage extends ConsumerWidget {
  const BasicEditorsPage({super.key});

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
