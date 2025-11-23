import '../gaming_export.dart';

class Buildcategoriesgrid extends StatelessWidget {
  const Buildcategoriesgrid(SystemService system, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'All Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 400) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1;
            }

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                AppGridCard(
                  title: 'Game Runners & Frontends',
                  description: '32 gaming tools and platforms',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF171a21),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.videogame_asset,
                      color: Colors.white,
                    ),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const GameRunnersPage(),
                        ),
                      ),
                ),
                AppGridCard(
                  title: 'Media & Entertainment',
                  description: '33 media players and tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE91E63),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                    ),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MediaEntertainmentPage(),
                        ),
                      ),
                ),
                AppGridCard(
                  title: 'System & Performance',
                  description: '25 system utilities and tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.speed, color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SystemPerformancePage(),
                        ),
                      ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
