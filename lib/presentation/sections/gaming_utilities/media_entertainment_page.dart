import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class MediaEntertainmentPage extends ConsumerWidget {
  const MediaEntertainmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Media & Entertainment'),
          backgroundColor: macAppStoreDark,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstallAllSection(context, system),
                  _buildToolsSection(context, system),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
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
                Icon(Icons.install_desktop, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Install All Media Tools',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Install all 5 media and entertainment tools at once for a complete media setup.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _installAllMediaTools(context, system),
                icon: const Icon(Icons.download),
                label: const Text('Install All Media Tools'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: macAppStoreBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsSection(BuildContext context, system) {
    final tools = [
      {
        'name': 'VLC Media Player',
        'pkg': 'vlc',
        'desc': 'A comprehensive media player (supports all formats)',
        'iconAsset': 'assets/game/vlc.png',
      },
      {
        'name': 'mpv',
        'pkg': 'mpv',
        'desc': 'A simple and lightweight media player (a developer favorite)',
        'iconAsset': 'assets/game/mpv.png',
      },
      {
        'name': 'Kodi',
        'pkg': 'kodi',
        'desc': 'A complete media center for entertainment',
        'iconAsset': 'assets/game/kodi.png',
      },
      {
        'name': 'Audacious',
        'pkg': 'audacious',
        'desc': 'A lightweight, customizable music player',
        'iconAsset': 'assets/game/audacious.png',
      },
      {
        'name': 'Rhythmbox',
        'pkg': 'rhythmbox',
        'desc': 'A standard music player in the GNOME environment',
        'iconAsset': 'assets/game/rhythmbox.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Media & Entertainment Tools',
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
            return AppGridCard(
              title: t['name']!,
              description: t['desc']!,
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 173, 61, 155),
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
                    system.installPackageByName(t['pkg']!),
                  ),
            );
          },
        ),
      ],
    );
  }

  void _installAllMediaTools(BuildContext context, system) {
    final pkgs = <String>['vlc', 'mpv', 'kodi', 'audacious', 'rhythmbox'];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Media Tools'),
            content: Text(
              'This will install ${pkgs.length} media and entertainment tools via APT. Continue?',
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
                      ...pkgs,
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
