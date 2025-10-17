import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class MobileDeveloperPage extends ConsumerWidget {
  const MobileDeveloperPage({super.key});

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
          colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
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
                  colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
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
                  'MOBILE DEVELOPER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Mobile Development Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '30 professional tools for Android and mobile app development including Java, ADB, and build systems.',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.download, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Install All Mobile Developer Tools',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 30 mobile development tools at once',
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
      {
        'name': 'Java JDK',
        'package': 'default-jdk',
        'description':
            'Java development environment (essential for native Android applications)',
      },
      {
        'name': 'Java JRE',
        'package': 'default-jre',
        'description': 'Java runtime environment',
      },
      {'name': 'Git', 'package': 'git', 'description': 'Version control'},
      {
        'name': 'Node.js',
        'package': 'nodejs',
        'description': 'For React Native/Ionic development',
      },
      {
        'name': 'NPM',
        'package': 'npm',
        'description': 'Node.js package manager',
      },
      {
        'name': 'Android Tools',
        'package': 'android-tools-adb',
        'description':
            'ADB (Android Debug Bridge) tool for communicating with the device/emulator',
      },
      {
        'name': 'Fastboot',
        'package': 'android-tools-fastboot',
        'description':
            'Flashboot tool (for installing system images on Android devices)',
      },
      {
        'name': 'Gradle',
        'package': 'gradle',
        'description': 'Java/Android application build system',
      },
      {
        'name': 'Maven',
        'package': 'maven',
        'description': 'Java/Kotlin application build system',
      },
      {'name': 'Curl', 'package': 'curl', 'description': 'For testing APIs'},
      {'name': 'Wget', 'package': 'wget', 'description': 'For downloading'},
      {
        'name': 'Unzip',
        'package': 'unzip',
        'description': 'For unzipping the SDK and packages',
      },
      {
        'name': 'Tar',
        'package': 'tar',
        'description': 'For handling file archives',
      },
      {
        'name': 'GCC/G++',
        'package': 'build-essential',
        'description':
            'For compiling any native code within Android applications',
      },
      {
        'name': 'CMake',
        'package': 'cmake',
        'description': 'Used by the Android NDK for building native code (JNI)',
      },
      {
        'name': 'Ninja Build',
        'package': 'ninja-build',
        'description': 'Rapid build system (used by Android)',
      },
      {
        'name': 'Adb-tools',
        'package': 'adb-tools',
        'description': 'Additional tools for ADB',
      },
      {
        'name': 'Valgrind',
        'package': 'valgrind',
        'description': 'For memory debugging (for native code)',
      },
      {
        'name': 'Python 3',
        'package': 'python3',
        'description': 'For scripting and automation in the build environment',
      },
      {
        'name': 'Pip',
        'package': 'python3-pip',
        'description': 'Python package manager',
      },
      {
        'name': 'libxml2-utils',
        'package': 'libxml2-utils',
        'description': 'XML tools (for Android Manifest files)',
      },
      {'name': 'Vim', 'package': 'vim', 'description': 'Text editor'},
      {'name': 'Nano', 'package': 'nano', 'description': 'Text editor'},
      {
        'name': 'lib32z1',
        'package': 'lib32z1',
        'description':
            '32-bit libraries (necessary for running some emulators)',
      },
      {
        'name': 'libstdc++6',
        'package': 'libstdc++6',
        'description': 'Standard C++ library',
      },
      {
        'name': 'libgl1-mesa-glx',
        'package': 'libgl1-mesa-glx',
        'description': 'OpenGL libraries (for emulators)',
      },
      {
        'name': 'libtinfo5',
        'package': 'libtinfo5',
        'description': 'Terminal control library',
      },
      {
        'name': 'libncurses5',
        'package': 'libncurses5',
        'description': 'Terminal interface library',
      },
      {
        'name': 'libcurl4-openssl-dev',
        'package': 'libcurl4-openssl-dev',
        'description': 'Curl libraries for encryption',
      },
      {
        'name': 'OpenSSL Dev',
        'package': 'libssl-dev',
        'description': 'OpenSSL libraries (for secure server connections)',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Mobile Development Tools',
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
                  color: const Color(0xFF9C27B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.phone_android, color: Colors.white),
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

  void _installAllTools(BuildContext context, system) {
    final tools = [
      'default-jdk',
      'default-jre',
      'git',
      'nodejs',
      'npm',
      'android-tools-adb',
      'android-tools-fastboot',
      'gradle',
      'maven',
      'curl',
      'wget',
      'unzip',
      'tar',
      'build-essential',
      'cmake',
      'ninja-build',
      'adb-tools',
      'valgrind',
      'python3',
      'python3-pip',
      'libxml2-utils',
      'vim',
      'nano',
      'lib32z1',
      'libstdc++6',
      'libgl1-mesa-glx',
      'libtinfo5',
      'libncurses5',
      'libcurl4-openssl-dev',
      'libssl-dev',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Mobile Developer Tools'),
            content: Text(
              'This will install ${tools.length} mobile development tools. Continue?',
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
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      ...tools,
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
