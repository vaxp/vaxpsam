import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/rotating_background.dart';

class GameRunnersPage extends ConsumerWidget {
  const GameRunnersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Game Runners & Frontends'),
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
    // تم تحديث العدد الإجمالي هنا (10 أصلية + 22 جديدة)
    const toolCount = 32;

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
                  'Install All Gaming Tools',
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
              'Install all $toolCount gaming tools at once for a complete gaming setup.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _installAllGamingTools(context, system),
                icon: const Icon(Icons.download),
                label: const Text('Install All Gaming Tools'),
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
    // تم دمج القائمة (10 أصلية + 22 جديدة = 32 أداة)
    final tools = [
      // --- أدواتك الأصلية (10) ---
      {
        'name': 'Steam',
        'pkg': 'steam',
        'desc':
            'The main gaming platform; necessary for running games via Proton',
        'iconAsset': 'assets/game/steam.png',
      },
      {
        'name': 'Lutris',
        'pkg': 'lutris',
        'desc':
            'An open-source game manager; makes it easy to run games from various sources',
        'iconAsset': 'assets/game/lutris.png',
      },
      {
        'name': 'Wine',
        'pkg': 'wine',
        'desc':
            'A basic compatibility layer for running Windows programs and games',
        'iconAsset': 'assets/game/wine.png',
      },
      {
        'name': 'PlayOnLinux',
        'pkg': 'playonlinux',
        'desc':
            'A graphical interface for Wine that helps set up custom gaming environments',
        'iconAsset': 'assets/game/PlayOnLinux.jpg',
      },
      {
        'name': 'GameMode',
        'pkg': 'gamemode',
        'desc':
            'A utility package that automatically optimizes system performance when running games',
        'iconAsset': 'assets/game/GameMode.png',
      },
      {
        'name': 'Discord',
        'ref': 'com.discordapp.Discord',
        'desc':
            'A basic communication application for gamers (voice and text chat)',
        'iconAsset': 'assets/game/discord.png',
      },
      {
        'name': 'RetroArch',
        'pkg': 'retroarch',
        'desc': 'A unified interface for retro emulators',
        'iconAsset': 'assets/game/retroarch.png',
      },
      {
        'name': 'Mesa Utilities',
        'pkg': 'mesa-utils',
        'desc':
            'Open-source graphics libraries (essential for running modern games)',
        'iconAsset': 'assets/game/MesaUtilities.png',
      },
      {
        'name': 'MangoHud',
        'pkg': 'mangohud',
        'desc':
            'A graphical overlay for displaying FPS, temperatures, and resource usage in games',
      },
      {
        'name': 'ProtonUp-Qt',
        'ref': 'net.davidotek.pupgui2',
        'desc':
            'A graphical tool for managing and updating Proton versions for Steam',
        'iconAsset': 'assets/game/ProtonUp-Qt.png',
      },

      // --- الأدوات الجديدة المضافة (22) ---
      {
        'name': 'DOSBox',
        'pkg': 'dosbox',
        'desc': 'Emulator for running classic DOS-based games'
      },
      {
        'name': 'ScummVM',
        'pkg': 'scummvm',
        'desc': 'Runner for classic point-and-click adventure games'
      },
      {
        'name': 'D-Fend Reloaded',
        'pkg': 'd-fend-reloaded',
        'desc': 'Graphical (GUI) frontend for managing DOSBox games'
      },
      {
        'name': 'Mednafen',
        'pkg': 'mednafen',
        'desc': 'A multi-system command-line emulator (NES, SNES, PSX, etc.)'
      },
      {
        'name': 'Dolphin',
        'pkg': 'dolphin-emu',
        'desc': 'High-performance emulator for GameCube and Wii'
      },
      {
        'name': 'PCSX2',
        'pkg': 'pcsx2',
        'desc': 'Emulator for PlayStation 2 games'
      },
      {
        'name': 'PPSSPP',
        'pkg': 'ppsspp',
        'desc': 'Emulator for PlayStation Portable (PSP) games'
      },
      {
        'name': 'DuckStation',
        'pkg': 'duckstation',
        'desc': 'High-performance emulator for PlayStation 1 (PSX)'
      },
      {
        'name': 'Flycast',
        'pkg': 'flycast',
        'desc': 'Emulator for Sega Dreamcast and Naomi'
      },
      {
        'name': 'Snes9x',
        'pkg': 'snes9x-gtk',
        'desc': 'A popular and accurate emulator for Super Nintendo (SNES)'
      },
      {
        'name': 'FCEUX',
        'pkg': 'fceux',
        'desc': 'Emulator for Nintendo Entertainment System (NES)'
      },
      {
        'name': 'Mupen64Plus (Qt)',
        'pkg': 'mupen64plus-qt',
        'desc': 'Graphical (GUI) frontend for the Mupen64Plus N64 emulator'
      },
      {
        'name': 'mGBA',
        'pkg': 'mgba-qt',
        'desc': 'Modern, high-accuracy emulator for Game Boy Advance'
      },
      {
        'name': 'VBA-M',
        'pkg': 'visualboyadvance-gtk',
        'desc': 'Legacy emulator for Game Boy / Color / Advance'
      },
      {
        'name': 'VICE',
        'pkg': 'vice',
        'desc': 'Emulator for the Commodore 64 home computer'
      },
      {
        'name': 'Hatari',
        'pkg': 'hatari',
        'desc': 'Emulator for the Atari ST/STE/TT/Falcon computers'
      },
      {
        'name': 'GZDoom',
        'pkg': 'gzdoom',
        'desc': 'Modern, advanced source port for the Doom engine'
      },
      {
        'name': 'PrBoom+',
        'pkg': 'prboom-plus',
        'desc': 'A classic, faithful source port for the Doom engine'
      },
      {
        'name': 'EDuke32',
        'pkg': 'eduke32',
        'desc': 'Advanced source port for the Duke Nukem 3D engine'
      },
      {
        'name': 'OpenRCT2',
        'pkg': 'openrct2',
        'desc': 'Open-source re-implementation of RollerCoaster Tycoon 2'
      },
      {
        'name': 'OpenTyrian',
        'pkg': 'opentyrian',
        'desc': 'Open-source port of the classic shooter Tyrian'
      },
      {
        'name': 'OpenMW',
        'pkg': 'openmw',
        'desc': 'Open-source engine for The Elder Scrolls III: Morrowind'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Game Runners & Frontends',
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
              onTap: () {
                if (t.containsKey('ref')) {
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'flatpak',
                      'install',
                      '-y',
                      'flathub',
                      t['ref']!,
                    ]),
                  );
                } else {
                  showConsoleStream(
                    context,
                    system.installPackageByName(t['pkg']!),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _installAllGamingTools(BuildContext context, system) {
    // تم تحديث قائمة APT (8 أصلية + 22 جديدة = 30)
    final aptPkgs = <String>[
      'steam',
      'lutris',
      'wine',
      'playonlinux',
      'gamemode',
      'retroarch',
      'mesa-utils',
      'mangohud',
      // --- الحزم الجديدة ---
      'dosbox',
      'scummvm',
      'd-fend-reloaded',
      'mednafen',
      'dolphin-emu',
      'pcsx2',
      'ppsspp',
      'duckstation',
      'flycast',
      'snes9x-gtk',
      'fceux',
      'mupen64plus-qt',
      'mgba-qt',
      'visualboyadvance-gtk',
      'vice',
      'hatari',
      'gzdoom',
      'prboom-plus',
      'eduke3to',
      'openrct2',
      'opentyrian',
      'openmw',
    ];
    // قائمة Flatpak لم تتغير
    final flatpakRefs = <String>[
      'com.discordapp.Discord',
      'net.davidotek.pupgui2',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Gaming Tools'),
            content: Text(
              // تم تحديث النص ليعكس الأعداد الجديدة
              'This will install ${aptPkgs.length} APT packages and ${flatpakRefs.length} Flatpak applications. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  // Install APT packages first
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      ...aptPkgs,
                    ]),
                  );
                  // Install Flatpak applications
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'bash',
                      '-lc',
                      'for r in "${flatpakRefs.join('" "')}"; do flatpak install -y flathub "\$r"; done',
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