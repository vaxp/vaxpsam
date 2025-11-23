import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers.dart';
import '../home/widgets/section_widgets.dart';
import '../console/console_utils.dart';
import '../../core/theme/app_theme.dart';
import 'dart:async';
import '../../domain/command_output_line.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool? _universeEnabled;
  bool? _flatpakInstalled;
  bool? _flathubEnabled;
  bool? _snapAvailable;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _refreshStatuses();
    });
  }

  Future<void> _refreshStatuses() async {
    final system = ref.read(systemServiceProvider);
    final results = await Future.wait<bool>([
      system.isUbuntuUniverseEnabled(),
      system.isFlatpakInstalled(),
      system.isFlathubEnabled(),
      system.isSnapAvailable(),
    ]);
    if (!mounted) return;
    setState(() {
      _universeEnabled = results[0];
      _flatpakInstalled = results[1];
      _flathubEnabled = results[2];
      _snapAvailable = results[3];
    });
  }

  void _showAndRefresh(Stream<CommandOutputLine> stream) {
    final controller = StreamController<CommandOutputLine>();
    late final StreamSubscription<CommandOutputLine> sub;
    sub = stream.listen(
      controller.add,
      onError: controller.addError,
      onDone: () async {
        await _refreshStatuses();
        await controller.close();
        await sub.cancel();
      },
      cancelOnError: false,
    );
    showConsoleStream(context, controller.stream);
  }

  @override
  Widget build(BuildContext context) {
    final system = ref.read(systemServiceProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const SizedBox(height: 24),

            // Snapd Section
            _buildSettingsSection(
              context,
              title: 'Snapd',
              status:
                  _snapAvailable == null
                      ? 'Checking...'
                      : (_snapAvailable! ? 'Enabled' : 'Disabled'),
              description: 'Manage snapd service (required for snaps)',
              onAdd:
                  () => _showAndRefresh(
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      'snapd',
                      '&&',
                      'systemctl',
                      'enable',
                      '--now',
                      'snapd',
                      '&&',
                      "test",
                      "-L",
                      "/snap",
                      "||",
                      "ln",
                      "-s",
                      "/var/lib/snapd/snap",
                      "/snap",
                    ]),
                  ),
              onRemove:
                  () => _showAndRefresh(
                    system.runAsRoot([
                      'apt',
                      'remove',
                      '--purge',
                      '-y',
                      'snapd',
                      '&&',
                      'apt',
                      'autoremove',
                      '-y',
                      '&&',
                      'rm',
                      '-f',
                      '/snap',
                    ]),
                  ),
            ),

            const SizedBox(height: 16),

            // Snap Store Section
            _buildSettingsSection(
              context,
              title: 'Snap Store',
              status:
                  _snapAvailable == null
                      ? 'Checking...'
                      : (_snapAvailable! ? 'Available' : 'Snapd missing'),
              description: 'Install/remove Snap Store (requires snapd)',
              onAdd:
                  () => _showAndRefresh(
                    system.runAsRoot([
                      'systemctl',
                      'start',
                      'snapd',
                      '||',
                      'true',
                      '&&',
                      'snap',
                      'install',
                      'snap-store',
                    ]),
                  ),
              onRemove:
                  () => _showAndRefresh(
                    system.runAsRoot(['snap', 'remove', 'snap-store']),
                  ),
            ),

            const SizedBox(height: 16),

            // Flatpak Section
            _buildSettingsSection(
              context,
              title: 'Flatpak',
              status:
                  _flatpakInstalled == null
                      ? 'Checking...'
                      : (_flatpakInstalled! ? 'Installed' : 'Not installed'),
              description: 'Install/remove Flatpak runtime support',
              onAdd:
                  () => _showAndRefresh(
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      'flatpak',
                      'gnome-software-plugin-flatpak',
                    ]),
                  ),
              onRemove:
                  () => _showAndRefresh(
                    system.runAsRoot([
                      'apt',
                      'remove',
                      '-y',
                      'flatpak',
                      'gnome-software-plugin-flatpak',
                      '&&',
                      'apt',
                      'autoremove',
                      '-y',
                    ]),
                  ),
            ),

            const SizedBox(height: 16),

            // Flathub Section
            _buildSettingsSection(
              context,
              title: 'Flathub',
              status:
                  _flathubEnabled == null
                      ? 'Checking...'
                      : (_flathubEnabled! ? 'Enabled' : 'Disabled'),
              description: 'Add/remove Flathub repository for Flatpak apps',
              onAdd: () => _showAndRefresh(system.enableFlathub()),
              onRemove: () => _showAndRefresh(system.disableFlathub()),
            ),

            const SizedBox(height: 16),

            // Ubuntu Universe Section
            _buildSettingsSection(
              context,
              title: 'Ubuntu Universe',
              status:
                  _universeEnabled == null
                      ? 'Checking...'
                      : (_universeEnabled! ? 'Enabled' : 'Disabled'),
              description: 'Enable/disable the Ubuntu Universe repository',
              onAdd:
                  () => _showAndRefresh(
                    system.runAsRoot([
                      'add-apt-repository',
                      '-y',
                      'universe',
                      '&&',
                      'apt',
                      'update',
                    ]),
                  ),
              onRemove:
                  () => _showAndRefresh(
                    system.runAsRoot([
                      'add-apt-repository',
                      '-r',
                      '-y',
                      'universe',
                      '&&',
                      'apt',
                      'update',
                    ]),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context, {
    required String title,
    required String status,
    required String description,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return MacAppStoreCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            status.contains('Enabled') ||
                                    status.contains('Available') ||
                                    status.contains('Installed')
                                ? const Color(0xFF4CAF50)
                                : macAppStoreGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: onAdd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: macAppStoreBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Enable'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: onRemove,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFF6B6B),
                      side: const BorderSide(color: Color(0xFFFF6B6B)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Disable'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
