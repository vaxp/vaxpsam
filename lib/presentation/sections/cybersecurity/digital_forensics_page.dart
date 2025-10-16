import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';

class DigitalForensicsPage extends ConsumerWidget {
  const DigitalForensicsPage({super.key});

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
              background: _buildHeroSection(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInstallAllSection(context, system),
                _buildToolsGrid(context, system),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00695C), Color(0xFF4DB6AC)],
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
                  colors: [Color(0xFF00695C), Color(0xFF4DB6AC)],
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
                const Text(
                  'DIGITAL FORENSICS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Forensic Investigation Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '13 professional tools for digital forensics, file recovery, and evidence analysis.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallAllSection(BuildContext context, system) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.download,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Install All Digital Forensics Tools',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 13 digital forensics tools at once',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: macAppStoreGray,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _installAllTools(context, system),
                  icon: const Icon(Icons.install_desktop),
                  label: const Text('Install All'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: macAppStoreBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsGrid(BuildContext context, system) {
    final tools = [
      {'name': 'The Sleuth Kit (TSK)', 'package': 'sleuthkit', 'description': 'Toolkit for forensic investigation of file systems'},
      {'name': 'Foremost', 'package': 'foremost', 'description': 'File recovery tool using signature analysis (Carving)'},
      {'name': 'TestDisk', 'package': 'testdisk', 'description': 'Tool for recovering lost hard drive partitions'},
      {'name': 'PhotoRec', 'package': 'testdisk', 'description': 'File recovery tool (included with TestDisk)'},
      {'name': 'Autopsy', 'package': 'autopsy', 'description': 'Graphical interface to Sleuth Kit for comprehensive analysis'},
      {'name': 'Dd/ddrescue', 'package': 'coreutils', 'description': 'Disk imaging tools'},
      {'name': 'Chkrootkit', 'package': 'chkrootkit', 'description': 'System scanning tool for rootkits'},
      {'name': 'Rkhunter', 'package': 'rkhunter', 'description': 'Tool for detecting rootkits and malware'},
      {'name': 'Exiftool', 'package': 'libimage-exiftool-perl', 'description': 'Reads, writes, and modifies metadata for images and files'},
      {'name': 'Scalpel', 'package': 'scalpel', 'description': 'Fast file recovery tool based on Carving'},
      {'name': 'Hashdeep', 'package': 'hashdeep', 'description': 'Hash calculator for several types of hashes (useful for verifying evidence)'},
      {'name': 'Plaso', 'package': 'plaso', 'description': 'Tool for timeline analysis'},
      {'name': 'Readstat', 'package': 'readstat', 'description': 'Tool for reading statistical files (data analysis)'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Digital Forensics Tools',
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
                  color: const Color(0xFF00695C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.installPackageByName(tool['package']!)),
            );
          },
        ),
      ],
    );
  }

  void _installAllTools(BuildContext context, system) {
    final tools = [
      'sleuthkit', 'foremost', 'testdisk', 'autopsy', 'coreutils',
      'chkrootkit', 'rkhunter', 'libimage-exiftool-perl', 'scalpel',
      'hashdeep', 'plaso', 'readstat'
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Install All Digital Forensics Tools'),
        content: Text('This will install ${tools.length} digital forensics tools. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              showConsoleStream(context, system.runAsRoot(['apt', 'update', '&&', 'apt', 'install', '-y', ...tools]));
            },
            child: const Text('Install All'),
          ),
        ],
      ),
    );
  }
}
