import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/rotating_background.dart';

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
    // تم تحديث العدد الإجمالي هنا (5 أصلية + 28 جديدة = 33)
    const toolCount = 33;

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
              // تم تحديث النص هنا
              'Install all $toolCount media and entertainment tools at once for a complete media setup.',
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
    // تم دمج القائمة (5 أصلية + 28 جديدة = 33 أداة)
    final tools = [
      // --- أدواتك الأصلية (5) ---
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

      // --- الأدوات الجديدة المضافة (28) ---
      {
        'name': 'Celluloid',
        'pkg': 'celluloid',
        'desc': 'A simple GTK (GNOME) frontend for MPV'
      },
      {
        'name': 'SMPlayer',
        'pkg': 'smplayer',
        'desc': 'A feature-rich Qt frontend for MPV/MPlayer'
      },
      {
        'name': 'Kdenlive',
        'pkg': 'kdenlive',
        'desc': 'A powerful, multi-track non-linear video editor (KDE)'
      },
      {
        'name': 'OpenShot',
        'pkg': 'openshot-qt',
        'desc': 'An easy-to-use, non-linear video editor'
      },
      {
        'name': 'Pitivi',
        'pkg': 'pitivi',
        'desc': 'A simple, intuitive non-linear video editor (GNOME)'
      },
      {
        'name': 'OBS Studio',
        'pkg': 'obs-studio',
        'desc': 'The standard for screen recording and live streaming'
      },
      {
        'name': 'HandBrake',
        'pkg': 'handbrake',
        'desc': 'A tool for converting video from nearly any format'
      },
      {
        'name': 'MKVToolNix GUI',
        'pkg': 'mkvtoolnix-gui',
        'desc': 'Tools for creating, altering, and inspecting Matroska (MKV) files'
      },
      {
        'name': 'Clementine',
        'pkg': 'clementine',
        'desc': 'A modern music player and library organizer'
      },
      {
        'name': 'Lollypop',
        'pkg': 'lollypop',
        'desc': 'A modern, visually appealing GNOME music player'
      },
      {
        'name': 'Audacity',
        'pkg': 'audacity',
        'desc': 'The most popular multi-track audio editor and recorder'
      },
      {
        'name': 'Ardour',
        'pkg': 'ardour',
        'desc': 'A professional Digital Audio Workstation (DAW)'
      },
      {
        'name': 'LMMS',
        'pkg': 'lmms',
        'desc': 'Linux MultiMedia Studio (DAW for music production)'
      },
      {
        'name': 'Mixxx',
        'pkg': 'mixxx',
        'desc': 'Free, open-source DJ mixing software'
      },
      {
        'name': 'GIMP',
        'pkg': 'gimp',
        'desc': 'GNU Image Manipulation Program (Photoshop alternative)'
      },
      {
        'name': 'Krita',
        'pkg': 'krita',
        'desc': 'A professional-grade digital painting and sketching program'
      },
      {
        'name': 'Pinta',
        'pkg': 'pinta',
        'desc': 'A simple, lightweight drawing and editing program (Paint.NET alternative)'
      },
      {
        'name': 'MyPaint',
        'pkg': 'mypaint',
        'desc': 'A fast and easy digital painting tool for artists'
      },
      {
        'name': 'Inkscape',
        'pkg': 'inkscape',
        'desc': 'A professional vector graphics editor (Illustrator alternative)'
      },
      {
        'name': 'Blender',
        'pkg': 'blender',
        'desc': 'The complete suite for 3D modeling, animation, and rendering'
      },
      {
        'name': 'FreeCAD',
        'pkg': 'freecad',
        'desc': 'A parametric 3D modeler for CAD and engineering'
      },
      {
        'name': 'Scribus',
        'pkg': 'scribus',
        'desc': 'Professional-grade desktop publishing (InDesign alternative)'
      },
      {
        'name': 'Shotwell',
        'pkg': 'shotwell',
        'desc': 'The default GNOME photo manager and organizer'
      },
      {
        'name': 'gThumb',
        'pkg': 'gthumb',
        'desc': 'An advanced image viewer and browser for GNOME'
      },
      {
        'name': 'digiKam',
        'pkg': 'digikam',
        'desc': 'An advanced, professional photo management application (KDE)'
      },
      {
        'name': 'RawTherapee',
        'pkg': 'rawtherapee',
        'desc': 'A powerful, cross-platform raw image processing program'
      },
      {
        'name': 'darktable',
        'pkg': 'darktable',
        'desc': 'A virtual light-table and darkroom for photographers'
      },
      {
        'name': 'Eye of GNOME',
        'pkg': 'eog',
        'desc': 'The default, simple image viewer for the GNOME desktop'
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
            crossAxisCount: 5,
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
    // تم تحديث قائمة الحزم (5 أصلية + 28 جديدة = 33)
    final pkgs = <String>[
      'vlc',
      'mpv',
      'kodi',
      'audacious',
      'rhythmbox',
      // --- الحزم الجديدة ---
      'celluloid',
      'smplayer',
      'kdenlive',
      'openshot-qt',
      'pitivi',
      'obs-studio',
      'handbrake',
      'mkvtoolnix-gui',
      'clementine',
      'lollypop',
      'audacity',
      'ardour',
      'lmms',
      'mixxx',
      'gimp',
      'krita',
      'pinta',
      'mypaint',
      'inkscape',
      'blender',
      'freecad',
      'scribus',
      'shotwell',
      'gthumb',
      'digikam',
      'rawtherapee',
      'darktable',
      'eog',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Media Tools'),
            content: Text(
              // هذا النص سيعرض العدد الصحيح (33)
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