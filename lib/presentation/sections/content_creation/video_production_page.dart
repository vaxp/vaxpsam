import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class VideoProductionPage extends ConsumerWidget {
  const VideoProductionPage({super.key});

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
              backgroundColor: Colors.transparent,
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
          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
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
                  colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
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
                  'VIDEO PRODUCTION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Video Production Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Professional video editing and production tools for content creators.',
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
                        'Install All Video Production Tools',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 10 video production tools at once',
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
        'name': 'Kdenlive',
        'package': 'kdenlive',
        'description': 'Professional non-linear video editor',
        'source': 'apt',
        'iconAsset': 'assets/creation/kdenlive.png',
      },
      {
        'name': 'OpenShot',
        'package': 'org.openshot.OpenShot',
        'description': 'Simple video editor for beginners',
        'source': 'flatpak',
        'iconAsset': 'assets/creation/openshot.png',
      },
      {
        'name': 'Pitivi',
        'package': 'org.pitivi.Pitivi',
        'description': 'GNOME-based video editor',
        'source': 'flatpak',
        'iconAsset': 'assets/creation/Pitivi.png',
      },
      {
        'name': 'Shotcut',
        'package': 'org.shotcut.Shotcut',
        'description': 'Cross-platform video editor',
        'source': 'flatpak',
        'iconAsset': 'assets/creation/Shotcut.png',
      },
      {
        'name': 'OBS Studio',
        'package': 'com.obsproject.Studio',
        'description': 'Live recording and streaming software',
        'source': 'flatpak',
        'iconAsset': 'assets/creation/OBS.png',
      },
      {
        'name': 'FFmpeg',
        'package': 'ffmpeg',
        'description': 'Command-line tool for audio and video processing',
        'source': 'apt',
        'iconAsset': 'assets/creation/FFmpeg.png',
      },
      {
        'name': 'SimpleScreenRecorder',
        'package': 'simplescreenrecorder',
        'description': 'Simple and effective screen recording tool',
        'source': 'apt',
        'iconAsset': 'assets/creation/simplescreenrecorder.png',
      },
      {
        'name': 'HandBrake',
        'package': 'fr.handbrake.ghb',
        'description': 'Powerful video format converter',
        'source': 'flatpak',
        'iconAsset': 'assets/creation/handbrake.png',
      },
      {
        'name': 'Blender',
        'package': 'blender',
        'description': '3D animation and VFX (available within Blender)',
        'source': 'apt',
        'iconAsset': 'assets/creation/blender.png',
      },
      {
        'name': 'VLC',
        'package': 'vlc',
        'description': 'Versatile media player for testing',
        'source': 'apt',
        'iconAsset': 'assets/creation/vlc.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Video Production Tools',
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
                  color: const Color.fromARGB(255, 55, 57, 71),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  tool['iconAsset'] ??
                      'assets/ides/default.png', // تمرير المسار المخزن في قائمة tools
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => _installTool(context, system, tool),
            );
          },
        ),
      ],
    );
  }

  void _installTool(BuildContext context, system, tool) {
    if (tool['source'] == 'flatpak') {
      showConsoleStream(
        context,
        system.runAsRoot(
          [
            'flatpak',
            'install',
            '-y',
            'flathub',
            tool['package']!,
          ].cast<String>(),
        ),
      );
    } else {
      showConsoleStream(context, system.installPackageByName(tool['package']!));
    }
  }

  void _installAllTools(BuildContext context, system) {
    final aptTools = [
      'kdenlive',
      'ffmpeg',
      'simplescreenrecorder',
      'blender',
      'vlc',
    ];
    final flatpakTools = [
      'org.openshot.OpenShot',
      'org.pitivi.Pitivi',
      'org.shotcut.Shotcut',
      'com.obsproject.Studio',
      'fr.handbrake.ghb',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Video Production Tools'),
            content: Text(
              'This will install ${aptTools.length + flatpakTools.length} video production tools. Continue?',
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
                    system.runAsRoot(
                      [
                        'bash',
                        '-c',
                        'apt update && apt install -y ${aptTools.join(' ')} && '
                            'for p in ${flatpakTools.join(' ')}; do flatpak install -y flathub "\$p"; done',
                      ].cast<String>(),
                    ),
                  );
                },
                child: const Text('Install All'),
              ),
            ],
          ),
    );
  }
}
