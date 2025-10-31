import 'gaming_export.dart';

class GamingUtilitiesPage extends ConsumerWidget {
  const GamingUtilitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            flexibleSpace: FlexibleSpaceBar(background: Buildherosection()),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Buildcategoriesgrid(system),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
