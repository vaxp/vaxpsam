import 'hashing_export.dart';

class CryptographyHashingPage extends ConsumerWidget {
  const CryptographyHashingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return Scaffold(
      backgroundColor: macAppStoreDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: macAppStoreDark,
            flexibleSpace: FlexibleSpaceBar(
              background: BuildHeroSection(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildInstallAllSection(context, system),
                BuildToolsGrid(context, system),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
