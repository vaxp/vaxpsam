import 'package:vaxpsam/core/venom_layout.dart';

import 'hashing_export.dart';

class CryptographyHashingPage extends ConsumerWidget {
  const CryptographyHashingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return VenomScaffold(
      body: CustomScrollView(
        slivers: [
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
