import '../hashing_export.dart';

class BuildToolsGrid extends StatelessWidget {
  final BuildContext context;
  // ignore: prefer_typing_uninitialized_variables
  final system;
  const BuildToolsGrid(this.context, this.system, {super.key});

  @override
  Widget build(BuildContext context) {
    // القائمة المدمجة (8 أدوات أصلية + 19 أداة جديدة = 27 أداة)
    final tools = [
      // --- أدواتك الأصلية ---
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
        'name': 'Hashsum (coreutils)',
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

      // --- الأدوات الجديدة المضافة ---
      {
        'name': 'Fcrackzip',
        'package': 'fcrackzip',
        'description': 'Brute-force password cracker for ZIP archives',
      },
      {
        'name': 'Rarcrack',
        'package': 'rarcrack',
        'description': 'Brute-force password cracker for RAR archives',
      },
      {
        'name': 'Pdfcrack',
        'package': 'pdfcrack',
        'description': 'Brute-force password cracker for PDF files',
      },
      {
        'name': 'Ophcrack',
        'package': 'ophcrack',
        'description': 'Windows password cracker based on rainbow tables',
      },
      {
        'name': 'CmosPwd',
        'package': 'cmospwd',
        'description': 'Recovers passwords stored in CMOS/BIOS',
      },
      {
        'name': 'Hashdeep',
        'package': 'hashdeep',
        'description': 'Recursively computes and audits hashes (MD5, SHA, etc.)',
      },
      {
        'name': 'GtkHash',
        'package': 'gtkhash',
        'description': 'Graphical (GUI) tool for generating file hashes',
      },
      {
        'name': 'Stunnel',
        'package': 'stunnel',
        'description': 'Creates encrypted SSL/TLS tunnels for non-SSL services',
      },
      {
        'name': 'Sslscan',
        'package': 'sslscan',
        'description': 'Scans servers for supported SSL/TLS ciphers and protocols',
      },
      {
        'name': 'Ssldump',
        'package': 'ssldump',
        'description': 'SSLv3/TLS network protocol analyzer',
      },
      {
        'name': 'Cipherscan',
        'package': 'cipherscan',
        'description': 'Analyzes and reports on SSL/TLS cipher suites',
      },
      {
        'name': 'Keyfinder',
        'package': 'keyfinder',
        'description': 'Scans files for cryptographic keys and certificates',
      },
      {
        'name': 'Steghide',
        'package': 'steghide',
        'description': 'Hides and extracts data in image/audio files',
      },
      {
        'name': 'StegSnow',
        'package': 'stegsnow',
        'description': 'Hides data in whitespace of text files',
      },
      {
        'name': 'OutGuess',
        'package': 'outguess',
        'description': 'A universal steganographic tool',
      },
      {
        'name': 'Bcrypt',
        'package': 'bcrypt',
        'description': 'Command-line utility for file encryption',
      },
      {
        'name': 'Age',
        'package': 'age-encryption.org',
        'description': 'A simple, modern, and secure file encryption tool',
      },
      {
        'name': 'Keyutils',
        'package': 'keyutils',
        'description': 'Utilities for managing Linux kernel keyrings',
      },
      {
        'name': 'Pass',
        'package': 'pass',
        'description': 'The standard Unix password manager (uses GPG)',
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
              onTap: () => showConsoleStream(
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