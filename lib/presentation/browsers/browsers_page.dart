import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'widget/browsers_grid.dart';
import 'widget/browsers_hero_section.dart';



class BrowsersPage extends ConsumerWidget {
  const BrowsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: macAppStoreDark,
            flexibleSpace: const FlexibleSpaceBar(
              background: BrowsersHeroSection(), 
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                BrowsersGrid(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
