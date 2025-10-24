import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
// استيراد الويدجيتات النظيفة
import 'widget/dev_tools_grid.dart';
import 'widget/tools_hero_section.dart';



class ToolsPage extends ConsumerWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // تم إزالة قراءة system provider من هنا إلى الويدجيتات الفرعية التي تحتاجها

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
              background: ToolsHeroSection(), // الويدجيت المفصول
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                DevToolsGrid(), // الويدجيت المفصول
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
