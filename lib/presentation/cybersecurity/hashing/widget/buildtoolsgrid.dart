import '../hashing_export.dart';

class BuildToolsGrid extends StatelessWidget {
  final BuildContext context;
  final system;
  const BuildToolsGrid(this.context, this.system, {super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      {
        'name': 'John the Ripper (JTR)',
        'package': 'john',
        'description': 'Popular and powerful password cracking tool',
      },
      {
        'name': 'Hashcat',
        'package': 'hashcat',
        'description': 'Tool for cracking hashes (may require compilation)',
      },
      {
        'name': 'OpenSSL',
        'package': 'openssl',
        'description':
            'Comprehensive library and tool for working with encryption and SSL/TLS certificates',
      },
      {
        'name': 'Cryptsetup',
        'package': 'cryptsetup',
        'description': 'Tool for managing encryption disks (such as LUKS)',
      },
      {
        'name': 'GnuPG',
        'package': 'gnupg',
        'description':
            'Tool for managing encryption keys and digital signatures',
      },
      {
        'name': 'Hashsum',
        'package': 'coreutils',
        'description':
            'For generating and checking hashes (md5sum, sha256sum, etc.)',
      },
      {
        'name': 'Pwgen',
        'package': 'pwgen',
        'description':
            'Tool for generating strong, random passwords (important for strength testing)',
      },
      {
        'name': 'Passage',
        'package': 'passage',
        'description': 'Simple command-line password manager',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Cryptography & Hashing Tools',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final tool = tools[index];
            return AppGridCard(
              title: tool['name']!,
              description: tool['description']!,
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE65100),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.lock, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName(tool['package']!),
                  ),
            );
          },
        ),
      ],
    );
  }
}
