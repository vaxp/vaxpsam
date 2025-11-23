import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/core/venom_layout.dart';
import 'package:vaxpsam/core/widgets/rotating_background.dart';
import 'widget/install_all_planning_card.dart';
import 'widget/planning_tools_grid.dart';

class PlanningDocumentationPage extends ConsumerWidget {
  const PlanningDocumentationPage({super.key});

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
                  InstallAllPlanningCard(),
                  PlanningToolsGrid(),
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
