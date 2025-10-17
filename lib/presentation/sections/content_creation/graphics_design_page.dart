import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class GraphicsDesignPage extends ConsumerWidget {
  const GraphicsDesignPage({super.key});

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
          colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
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
                  colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
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
                  'GRAPHICS & DESIGN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Graphics & Design Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Professional graphics and design tools for image editing, vector graphics, and 3D modeling.',
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
                        'Install All Graphics & Design Tools',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 10 graphics and design tools at once',
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
        'name': 'GIMP',
        'package': 'gimp',
        'description':
            'Professional raster image editor (alternative to Photoshop)',
        'source': 'apt',
        'iconAsset': 'assets/creation/gimp.png',
      },
      {
        'name': 'Inkscape',
        'package': 'inkscape',
        'description':
            'Professional vector graphics editor (alternative to Illustrator)',
        'source': 'apt',
        'iconAsset': 'assets/creation/inkscape.png',
      },
      {
        'name': 'Krita',
        'package': 'org.kde.krita',
        'description': 'Digital painting and raster graphics program',
        'source': 'flatpak',
        'iconAsset': 'assets/creation/krita.png',
      },
      {
        'name': 'Blender',
        'package': 'blender',
        'description': '3D design, animation, and modeling program',
        'source': 'apt',
        'iconAsset': 'assets/creation/blender.png',
      },
      {
        'name': 'Scribus',
        'package': 'scribus',
        'description':
            'Desktop publishing program (for brochures and magazines)',
        'source': 'apt',
        'iconAsset': 'assets/creation/scribus.png',
      },
      {
        'name': 'Shotwell',
        'package': 'shotwell',
        'description': 'Simple image manager and basic editor',
        'source': 'apt',
        'iconAsset': 'assets/creation/shotwell.png',
      },
      {
        'name': 'Geeqie',
        'package': 'geeqie',
        'description': 'Fast and advanced image viewer',
        'source': 'apt',
      },
      {
        'name': 'ImageMagick',
        'package': 'imagemagick',
        'description': 'Powerful command-line image processing toolkit',
        'source': 'apt',
        'iconAsset': 'assets/creation/Imagemagick.png',
      },
      {
        'name': 'Darktable',
        'package': 'org.darktable.Darktable',
        'description': 'RAW image processing software (Lightroom alternative)',
        'source': 'flatpak',
        'iconAsset': 'assets/creation/darktable.png',
      },
      {
        'name': 'Hugin',
        'package': 'hugin',
        'description': 'Panoramic image creation tool',
        'source': 'apt',
        'iconAsset': 'assets/creation/hugin.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Graphics & Design Tools',
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
                  color: const Color.fromARGB(54, 55, 57, 71),
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
      'gimp',
      'inkscape',
      'blender',
      'scribus',
      'shotwell',
      'geeqie',
      'imagemagick',
      'hugin',
    ];
    final flatpakTools = ['org.kde.krita', 'org.darktable.Darktable'];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Graphics & Design Tools'),
            content: Text(
              'This will install ${aptTools.length + flatpakTools.length} graphics and design tools. Continue?',
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
