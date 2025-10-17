import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class AdvancedEditorsPage extends ConsumerWidget {
  const AdvancedEditorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    return StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
          colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
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
                  colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
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
                  'ADVANCED EDITORS (FLATPAK)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Install Editors from Flathub',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Popular IDEs and editors installed via Flatpak. Ensure Flathub is enabled.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
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
        child: Row(
          children: [
            Icon(Icons.download, color: macAppStoreBlue, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Install All Advanced Editors',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Installs all listed IDEs via Flatpak from Flathub',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _installAll(context, system),
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
      ),
    );
  }

  Widget _buildToolsGrid(BuildContext context, system) {
    final tools = [
      {
        'name': 'Visual Studio Code',
        'ref': 'com.visualstudio.code',
        'desc': 'Popular editor with rich extensions',
        'iconAsset': 'assets/ides/vscode.png',
      },
      {
        'name': 'Code::Blocks',
        'ref': 'org.codeblocks.codeblocks',
        'desc': 'Open-source IDE for C/C++',
        'iconAsset': 'assets/ides/code_bloc.png',
      },
      {
        'name': 'Gedit',
        'ref': 'org.gnome.gedit',
        'desc': 'Lightweight GNOME text editor',
        'iconAsset': 'assets/ides/gedit.jpg',
      },
      {
        'name': 'Sublime Text',
        'ref': 'com.sublimetext.three',
        'desc': 'Fast and efficient editor',
        'iconAsset': 'assets/ides/sublime.png',
      },
      {
        'name': 'Eclipse',
        'ref': 'org.eclipse.Platform',
        'desc': 'Comprehensive IDE, especially for Java',
        'iconAsset': 'assets/ides/Eclipse.png',
      },
      {
        'name': 'Android Studio',
        'ref': 'com.google.AndroidStudio',
        'desc': 'Official Android development IDE',
        'iconAsset': 'assets/ides/android_studio.png',
      },
      {
        'name': 'NetBeans',
        'ref': 'org.apache.netbeans',
        'desc': 'Open-source IDE for Java, PHP, and C++',
        'iconAsset': 'assets/ides/netbeans.png',
      },
      {
        'name': 'IntelliJ IDEA',
        'ref': 'com.jetbrains.IntelliJ-IDEA-Community',
        'desc': 'Professional IDE for Java/Kotlin',
        'iconAsset': 'assets/ides/IntelliJ_IDEA.png',
      },
      {
        'name': 'Atom',
        'ref': 'io.atom.Atom',
        'desc': 'Customizable open-source editor',
        'iconAsset': 'assets/ides/Atom.png',
      },
      {
        'name': 'KDevelop',
        'ref': 'org.kde.kdevelop',
        'desc': 'Advanced IDE, great for KDE/C++',
        'iconAsset': 'assets/ides/kdevelop.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Advanced Editors (Flathub)',
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
          itemBuilder: (context, i) {
            final t = tools[i];
            final assetPath = t['iconAsset'] ?? 'assets/ides/default.png';

            return AppGridCard(
              title: t['name']!,
              description: t['desc']!,
              image: Image.asset(
                assetPath,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 57, 71),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  // استخدام الأداة Image.asset
                  t['iconAsset'] ??
                      'assets/ides/default.png', // تمرير المسار المخزن في قائمة tools
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.runAsRoot([
                      'flatpak',
                      'install',
                      '-y',
                      'flathub',
                      t['ref']!,
                    ]),
                  ),
            );
          },
        ),
      ],
    );
  }

  void _installAll(BuildContext context, system) {
    final refs = [
      'com.visualstudio.code',
      'org.codeblocks.codeblocks',
      'org.gnome.gedit',
      'com.sublimetext.three',
      'org.eclipse.Platform',
      'com.google.AndroidStudio',
      'org.apache.netbeans',
      'com.jetbrains.IntelliJ-IDEA-Community',
      'io.atom.Atom',
      'org.kde.kdevelop',
    ];
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Advanced Editors'),
            content: Text(
              'This will install ${refs.length} editors via Flatpak. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'bash',
                      '-lc',
                      'for r in "${refs.join('" "')}"; do flatpak install -y flathub "\$r"; done',
                    ]),
                  );
                },
                child: const Text('Install All'),
              ),
            ],
          ),
    );
  }
}
