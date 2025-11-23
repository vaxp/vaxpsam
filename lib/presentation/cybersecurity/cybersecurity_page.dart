import 'cybersecurity_export.dart';

class CybersecurityPage extends ConsumerWidget {
  const CybersecurityPage({super.key});

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
            backgroundColor: macAppStoreDark,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroSection(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoriesGrid(context, system),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final subtitleSize = width > 600 ? 12.0 : 10.0;
        final titleSize = width > 600 ? 28.0 : 20.0;
        final descSize = width > 600 ? 16.0 : 14.0;

        return Container(
          height: 200,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CYBERSECURITY TOOLS',
                      style: TextStyle(
                        fontSize: subtitleSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Secure & Analyze',
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Professional cybersecurity tools for network analysis, malware detection, and penetration testing.',
                      style: TextStyle(
                        fontSize: descSize,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoriesGrid(BuildContext context, system) {
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
                  title: 'Network Analysis',
                  description: '30 network security tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.network_check, color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NetworkAnalysisPage(),
                        ),
                      ),
                ),
                AppGridCard(
                  title: 'Malware Analysis',
                  description: '25 forensic tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD32F2F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.security, color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MalwareAnalysisPage(),
                        ),
                      ),
                ),
                AppGridCard(
                  title: 'Injection & Exploitation',
                  description: '16 penetration testing tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9800),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.bug_report, color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const InjectionExploitationPage(),
                        ),
                      ),
                ),
                AppGridCard(
                  title: 'Wireless Security',
                  description: '13 Wi-Fi & Bluetooth tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF7B1FA2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.wifi, color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WirelessSecurityPage(),
                        ),
                      ),
                ),
                AppGridCard(
                  title: 'Digital Forensics',
                  description: '13 forensic investigation tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00695C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DigitalForensicsPage(),
                        ),
                      ),
                ),
                AppGridCard(
                  title: 'Cryptography & Hashing',
                  description: '8 encryption & password tools',
                  icon: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE65100),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.lock, color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CryptographyHashingPage(),
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
