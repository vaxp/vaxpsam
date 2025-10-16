import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers.dart';
import 'package:file_picker/file_picker.dart';
import '../home/widgets/section_widgets.dart';
import '../console/console_utils.dart';
import '../theme/app_theme.dart';

class MySystemPage extends ConsumerWidget {
  const MySystemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    
    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
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
                _buildFeaturedSection(context, system),
                _buildQuickActionsSection(context, system),
                _buildSystemMaintenanceSection(context, system),
                _buildWineSection(context, system),
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
          colors: [macAppStoreBlue, macAppStorePurple],
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
                  colors: [macAppStoreBlue, macAppStorePurple],
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
                  'SYSTEM MANAGEMENT',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Manage Your Linux System',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Install packages, update system, and manage applications with ease.',
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

  Widget _buildFeaturedSection(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(color: macAppStoreBlue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ResponsiveGrid(
          children: [
            AppGridCard(
              title: 'Install by Name',
              description: 'Smart search across repositories',
              icon: Container(
                decoration: BoxDecoration(
                  color: macAppStoreBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
              onTap: () => _showInstallDialog(context, system),
            ),
            AppGridCard(
              title: 'Install .deb',
              description: 'Local package installation',
              icon: Container(
                decoration: BoxDecoration(
                  color: macAppStorePurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.install_desktop, color: Colors.white),
              ),
              onTap: () => _installDebFromDevice(context, system),
            ),
            AppGridCard(
              title: 'Update System',
              description: 'Refresh package lists',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.system_update, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.update()),
            ),
            AppGridCard(
              title: 'Upgrade System',
              description: 'Update all packages',
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.upgrade, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.upgrade()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SectionActionButton(
          icon: Icons.system_update,
          title: 'Update System',
          description: 'Run apt update to refresh package lists',
          onPressed: () => showConsoleStream(context, system.update()),
        ),
        SectionActionButton(
          icon: Icons.upgrade,
          title: 'Upgrade System',
          description: 'Run apt upgrade to update all packages',
          onPressed: () => showConsoleStream(context, system.upgrade()),
        ),
        SectionActionButton(
          icon: Icons.cleaning_services,
          title: 'Clean System',
          description: 'Remove unused packages and free up space',
          onPressed: () => showConsoleStream(context, system.runAsRoot(['apt', 'autoremove', '-y'])),
        ),
      ],
    );
  }

  Widget _buildSystemMaintenanceSection(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'System Maintenance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SectionActionButton(
          icon: Icons.remove_circle,
          title: 'Remove Package',
          description: 'Uninstall a specific package from your system',
          onPressed: () => _showRemoveDialog(context, system),
        ),
        SectionActionButton(
          icon: Icons.search,
          title: 'Search Packages',
          description: 'Find and install packages by name',
          onPressed: () => _showInstallDialog(context, system),
        ),
      ],
    );
  }

  Widget _buildWineSection(BuildContext context, system) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Windows Compatibility',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SectionActionButton(
          icon: Icons.wine_bar,
          title: 'Install Wine',
          description: 'Install Wine compatibility layer for Windows applications',
          onPressed: () => showConsoleStream(context, system.installPackageByName('wine')),
        ),
        SectionActionButton(
          icon: Icons.apps,
          title: 'Install PlayOnLinux',
          description: 'Install PlayOnLinux frontend for Wine',
          onPressed: () => showConsoleStream(context, system.installPackageByName('playonlinux')),
        ),
        SectionActionButton(
          icon: Icons.extension,
          title: 'Install Winetricks',
          description: 'Install winetricks helper for Wine configuration',
          onPressed: () => showConsoleStream(context, system.installPackageByName('winetricks')),
        ),
      ],
    );
  }

  Future<void> _showInstallDialog(BuildContext context, system) async {
    final pkg = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Install Application'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Package name',
              hintText: 'e.g., firefox, vscode, git',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: const Text('Install'),
            ),
          ],
        );
      },
    );
    
    if (pkg != null && pkg.isNotEmpty) {
      // Use the smart search functionality
      final universeEnabled = await system.isUbuntuUniverseEnabled();
      final aptCandidate = await system.aptHasCandidate(pkg);
      final snapAvailable = await system.isSnapAvailable();
      final snapHas = await system.snapHasPackage(pkg);
      final flatpakInstalled = await system.isFlatpakInstalled();
      final flathubEnabled = await system.isFlathubEnabled();
      final flatpakRef = await system.findFlatpakRef(pkg);

      // Ubuntu
      if (aptCandidate) {
        if (!universeEnabled) {
          final ok = await _confirmEnable(context, 'Enable Ubuntu Universe?', 'Found "$pkg" in Ubuntu repositories. Enable Universe and continue?');
          if (ok) {
            showConsoleStream(
              context,
              Stream.fromIterable([
                ...await system.enableUbuntuUniverse().toList(),
                ...await system.runAsRoot(['apt-get', 'update', '&&', 'apt-get', 'install', '-y', pkg]).toList(),
              ]),
            );
          }
          return;
        }
        showConsoleStream(context, system.runAsRoot(['apt-get', 'update', '&&', 'apt-get', 'install', '-y', pkg]));
        return;
      }

      // Snap
      if (snapHas) {
        if (!snapAvailable) {
          final ok = await _confirmEnable(context, 'Enable Snapd?', 'Found "$pkg" in Snap. Enable snapd and continue?');
          if (ok) {
            showConsoleStream(
              context,
              Stream.fromIterable([
                ...await system.enableSnapd().toList(),
                ...await system.runAsRoot(['snap', 'install', pkg]).toList(),
              ]),
            );
          }
          return;
        }
        showConsoleStream(context, system.runAsRoot(['snap', 'install', pkg]));
        return;
      }

      // Flathub
      if (flatpakRef != null && flatpakRef.isNotEmpty) {
        if (!flatpakInstalled || !flathubEnabled) {
          final ok = await _confirmEnable(context, 'Enable Flathub?', 'Found "$pkg" on Flathub. Enable Flatpak/Flathub and continue?');
          if (ok) {
            showConsoleStream(
              context,
              Stream.fromIterable([
                if (!flatpakInstalled) ...await system.runAsRoot(['apt', 'update', '&&', 'apt', 'install', '-y', 'flatpak', 'gnome-software-plugin-flatpak']).toList(),
                if (!flathubEnabled) ...await system.enableFlathub().toList(),
                ...await system.runAsRoot(['flatpak', 'install', '-y', 'flathub', flatpakRef]).toList(),
              ]),
            );
          }
          return;
        }
        showConsoleStream(context, system.runAsRoot(['flatpak', 'install', '-y', 'flathub', flatpakRef]));
        return;
      }

      // Not found
      if (context.mounted) {
        showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Not Found'),
            content: Text('"$pkg" was not found in Ubuntu, Snap, or Flathub.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _installDebFromDevice(BuildContext context, system) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['deb'],
    );
    
    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final fileName = result.files.single.name;
      
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Install .deb Package'),
          content: Text('Install "$fileName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Install'),
            ),
          ],
        ),
      );
      
      if (confirmed == true) {
        showConsoleStream(context, system.installDebFromFile(filePath));
      }
    }
  }

  Future<void> _showRemoveDialog(BuildContext context, system) async {
    final pkg = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Remove Package'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Package name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
    
    if (pkg != null && pkg.isNotEmpty) {
      showConsoleStream(context, system.runAsRoot(['apt', 'remove', '-y', pkg]));
    }
  }

  Future<bool> _confirmEnable(BuildContext context, String title, String content) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Enable'),
          ),
        ],
      ),
    ) ?? false;
  }
}