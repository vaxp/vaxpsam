import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import '../domain/command_output_line.dart';

class SystemService {
  /// Runs a command as root using pkexec, streaming output line-by-line.
  /// If pkexec is not available, returns a clear error message.
  Stream<CommandOutputLine> runAsRoot(
    List<String> command, {
    Duration? timeout,
  }) async* {
    final now = DateTime.now();
    final helper = await _detectPrivilegeHelper();
    if (helper == _PrivilegeHelper.none) {
      // Check if polkitd daemon is present to give a more accurate message.
      final polkitPresent = await _checkPolkitd();
      final suggestion =
          polkitPresent
              ? 'polkit daemon detected but pkexec (polkit utilities) is not available on this system. Install the polkit utilities package for your distro which provides pkexec, or ensure sudo is available.'
              : 'No privilege escalation helper (pkexec or sudo) was found. Install polkit utilities (providing pkexec) or sudo.';
      yield CommandOutputLine(
        timestamp: now,
        text: suggestion,
        isError: true,
        exitCode: 127,
      );
      return;
    }

    final shellCommand = command.join(' ');
    final process = await () async {
      if (helper == _PrivilegeHelper.pkexec) {
        return await Process.start('pkexec', [
          'bash',
          '-c',
          shellCommand,
        ], runInShell: false);
      }
      // Fallback to sudo. Note: sudo will prompt in terminal where available.
      return await Process.start('sudo', [
        'bash',
        '-c',
        shellCommand,
      ], runInShell: false);
    }();
    final controller = StreamController<CommandOutputLine>();
    void handleLine(String line, bool isError) {
      controller.add(
        CommandOutputLine(
          timestamp: DateTime.now(),
          text: line,
          isError: isError,
        ),
      );
    }

    process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
          handleLine(line, false);
        });
    process.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
          handleLine(line, true);
        });
    process.exitCode.then((code) {
      controller.add(
        CommandOutputLine(
          timestamp: DateTime.now(),
          text: '[Process exited with code $code]',
          isError: code != 0,
          exitCode: code,
        ),
      );
      controller.close();
    });
    yield* controller.stream;
  }

  // Install a local .deb with automatic dependency fix and retry
  Stream<CommandOutputLine> installDebFromFile(String filePath) async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Installing $filePath ...',
      isError: false,
    );
    int? exitCode;
    await for (final line in runAsRoot(['dpkg', '-i', filePath])) {
      yield line;
      if (line.exitCode != null) exitCode = line.exitCode;
    }
    if (exitCode == 0) return;
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Attempting to fix dependencies (apt-get -f install)...',
      isError: false,
    );
    await for (final line in runAsRoot(['apt-get', 'install', '-f', '-y'])) {
      yield line;
    }
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Retrying dpkg install...',
      isError: false,
    );
    await for (final line in runAsRoot(['dpkg', '-i', filePath])) {
      yield line;
    }
  }

  Future<bool> _checkPolkitd() async {
    try {
      // Try to find polkitd executable or common systemd unit paths.
      final r = await Process.run('which', ['polkitd']);
      if (r.exitCode == 0) return true;
      // Check common locations (heuristic).
      final possible = [
        '/usr/lib/polkit-1/polkitd',
        '/usr/libexec/polkitd',
        '/usr/lib/polkitd',
      ];
      for (final p in possible) {
        if (await File(p).exists()) return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<_PrivilegeHelper> _detectPrivilegeHelper() async {
    try {
      final pk = await Process.run('which', ['pkexec']);
      if (pk.exitCode == 0) return _PrivilegeHelper.pkexec;
      final su = await Process.run('which', ['sudo']);
      if (su.exitCode == 0) return _PrivilegeHelper.sudo;
      return _PrivilegeHelper.none;
    } catch (_) {
      return _PrivilegeHelper.none;
    }
  }

  Stream<CommandOutputLine> update() => runAsRoot(['apt-get', 'update']);
  Stream<CommandOutputLine> upgrade() =>
      runAsRoot(['apt-get', 'upgrade', '-y']);
  Stream<CommandOutputLine> installPackageByName(String pkg) =>
      runAsRoot(['apt-get', 'install', '-y', pkg]);

  // APT install with automatic dependency fix and retry
  Stream<CommandOutputLine> aptInstallWithAutofix(String packageName) async* {
    int? exitCode;
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Running apt-get update...',
      isError: false,
    );
    await for (final line in runAsRoot(['apt-get', 'update'])) {
      yield line;
    }
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Installing $packageName via APT...',
      isError: false,
    );
    await for (final line in runAsRoot([
      'apt-get',
      'install',
      '-y',
      packageName,
    ])) {
      yield line;
      if (line.exitCode != null) exitCode = line.exitCode;
    }
    if (exitCode == 0) return;
    // Attempt to fix broken dependencies and retry once
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Attempting to fix dependencies (apt-get -f install)...',
      isError: false,
    );
    await for (final line in runAsRoot(['apt-get', 'install', '-f', '-y'])) {
      yield line;
    }
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Retrying installation...',
      isError: false,
    );
    exitCode = null;
    await for (final line in runAsRoot([
      'apt-get',
      'install',
      '-y',
      packageName,
    ])) {
      yield line;
      if (line.exitCode != null) exitCode = line.exitCode;
    }
    if (exitCode == 0) return;
  }

  Stream<CommandOutputLine> installDebFromUrl(
    String url, {
    String? downloadFolder,
  }) async* {
    final folder = downloadFolder ?? '/tmp';
    final fileName = p.basename(Uri.parse(url).path);
    final filePath = p.join(folder, fileName);
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Downloading $url...',
      isError: false,
    );
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text: 'Failed to download: HTTP ${response.statusCode}',
          isError: true,
        );
        return;
      }
      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
      yield CommandOutputLine(
        timestamp: DateTime.now(),
        text: 'Downloaded to $filePath',
        isError: false,
      );

      // Install using dpkg, then fix dependencies and retry if needed
      int? exitCode;
      await for (final line in runAsRoot(['dpkg', '-i', filePath])) {
        yield line;
        if (line.exitCode != null) exitCode = line.exitCode;
      }
      if (exitCode != 0) {
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text: 'Attempting to fix dependencies (apt-get -f install)...',
          isError: false,
        );
        await for (final line in runAsRoot([
          'apt-get',
          'install',
          '-f',
          '-y',
        ])) {
          yield line;
        }
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text: 'Retrying dpkg install...',
          isError: false,
        );
        await for (final line in runAsRoot(['dpkg', '-i', filePath])) {
          yield line;
        }
      }
      try {
        await file.delete();
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text: 'Deleted $filePath',
          isError: false,
        );
      } catch (_) {
        // Non-fatal if deletion fails
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text: 'Warning: could not delete $filePath',
          isError: false,
        );
      }
    } catch (e) {
      yield CommandOutputLine(
        timestamp: DateTime.now(),
        text: 'Error: $e',
        isError: true,
      );
    }
  }

  // Smart search-install: query Ubuntu (Main/Universe), Snap, and Flathub; check activation and install from the first available
  Stream<CommandOutputLine> smartInstallByName(String packageName) async* {
    int? exitCode;

    // 1) Ubuntu APT (includes Main/Universe depending on activation)
    final universeEnabled = await _isUbuntuUniverseEnabled();
    final aptCandidate = await aptHasCandidate(packageName);
    if (aptCandidate) {
      if (!universeEnabled) {
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text:
              'Found candidate in Ubuntu repositories, but Universe is disabled. Enable Universe to continue.',
          isError: true,
        );
        return;
      }
      yield CommandOutputLine(
        timestamp: DateTime.now(),
        text: 'Found in Ubuntu APT. Installing...',
        isError: false,
      );
      await for (final line in aptInstallWithAutofix(packageName)) {
        yield line;
        if (line.exitCode != null) exitCode = line.exitCode;
      }
      if (exitCode == 0) return;
    }

    // 2) Snap store
    final snapAvailable = await _isSnapAvailable();
    final snapHas = await snapHasPackage(packageName);
    if (snapHas) {
      if (!snapAvailable) {
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text:
              'Found in Snap, but snapd is not active. Enable snapd to continue.',
          isError: true,
        );
        return;
      }
      yield CommandOutputLine(
        timestamp: DateTime.now(),
        text: 'Found in Snap. Installing...',
        isError: false,
      );
      exitCode = null;
      await for (final line in runAsRoot(['snap', 'install', packageName])) {
        yield line;
        if (line.exitCode != null) exitCode = line.exitCode;
      }
      if (exitCode == 0) return;
    }

    // 3) Flathub via Flatpak
    final flatpakInstalled = await _isFlatpakInstalled();
    final flathubEnabled = await _isFlathubEnabled();
    final ref = await _findFlatpakRef(packageName);
    if (ref != null && ref.isNotEmpty) {
      if (!flatpakInstalled || !flathubEnabled) {
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text:
              'Found on Flathub, but Flatpak/Flathub not active. Enable them to continue.',
          isError: true,
        );
        return;
      }
      yield CommandOutputLine(
        timestamp: DateTime.now(),
        text: 'Found on Flathub. Installing...',
        isError: false,
      );
      exitCode = null;
      await for (final line in runAsRoot([
        'flatpak',
        'install',
        '-y',
        'flathub',
        ref,
      ])) {
        yield line;
        if (line.exitCode != null) exitCode = line.exitCode;
      }
      if (exitCode == 0) return;
    }

    // None succeeded or found
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text:
          'Could not find or install $packageName in Ubuntu, Snap, or Flathub.',
      isError: true,
    );
  }

  // Enable sources
  Stream<CommandOutputLine> enableUbuntuUniverse() => runAsRoot([
    'add-apt-repository',
    '-y',
    'universe',
    '&&',
    'apt',
    'update',
  ]);
  Stream<CommandOutputLine> enableFlathub() async* {
    // First ensure flatpak is installed
    final flatpakInstalled = await _isFlatpakInstalled();
    if (!flatpakInstalled) {
      yield CommandOutputLine(
        timestamp: DateTime.now(),
        text: 'Installing Flatpak first...',
        isError: false,
      );
      await for (final line in runAsRoot([
        'apt',
        'update',
        '&&',
        'apt',
        'install',
        '-y',
        'flatpak',
        'gnome-software-plugin-flatpak',
      ])) {
        yield line;
      }
    }

    // Then add flathub remote
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Adding Flathub remote...',
      isError: false,
    );
    await for (final line in runAsRoot([
      'flatpak',
      'remote-add',
      '--if-not-exists',
      'flathub',
      'https://flathub.org/repo/flathub.flatpakrepo',
    ])) {
      yield line;
    }
  }

  Stream<CommandOutputLine> enableSnapd() => runAsRoot([
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
  ]);

  Stream<CommandOutputLine> disableFlathub() async* {
    // Check if flathub is enabled first
    final flathubEnabled = await _isFlathubEnabled();
    if (!flathubEnabled) {
      yield CommandOutputLine(
        timestamp: DateTime.now(),
        text: 'Flathub is not enabled',
        isError: false,
      );
      return;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Removing Flathub remote...',
      isError: false,
    );
    await for (final line in runAsRoot([
      'flatpak',
      'remote-delete',
      'flathub',
    ])) {
      yield line;
    }
  }

  // Search helpers
  Future<bool> aptHasCandidate(String packageName) async {
    try {
      final r = await Process.run('bash', [
        '-lc',
        // ignore: prefer_interpolation_to_compose_strings
        'apt-cache policy ' +
            _escapeShellArg(packageName) +
            " | awk '/Candidate:/ {print \$2}'",
      ]);
      final v = (r.stdout as String).toString().trim();
      return v.isNotEmpty && v != '(none)';
    } catch (_) {
      return false;
    }
  }

  Future<String?> findFlatpakRef(String query) => _findFlatpakRef(query);

  Future<bool> snapHasPackage(String name) async {
    try {
      final r = await Process.run('bash', [
        '-lc',
        // ignore: prefer_interpolation_to_compose_strings
        'snap find ' +
            _escapeShellArg(name) +
            // ignore: prefer_interpolation_to_compose_strings
            " | awk '{print \$1}' | grep -x " +
            _escapeShellArg(name) +
            ' || true',
      ]);
      return (r.stdout as String).toString().trim().isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // Public status helpers for UI
  Future<bool> isUbuntuUniverseEnabled() => _isUbuntuUniverseEnabled();
  Future<bool> isFlatpakInstalled() => _isFlatpakInstalled();
  Future<bool> isFlathubEnabled() => _isFlathubEnabled();
  Future<bool> isSnapAvailable() => _isSnapAvailable();

  Future<bool> _isUbuntuUniverseEnabled() async {
    try {
      final result = await Process.run('bash', [
        '-lc',
        'grep -R "^deb .* universe" /etc/apt/sources.list /etc/apt/sources.list.d 2>/dev/null | grep -v "^#" | head -n 1',
      ]);
      return (result.stdout as String).toString().trim().isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _isFlatpakInstalled() async {
    try {
      final r = await Process.run('bash', [
        '-lc',
        'command -v flatpak >/dev/null 2>&1; echo \$?',
      ]);
      return (r.stdout as String).toString().trim() == '0';
    } catch (_) {
      return false;
    }
  }

  Future<bool> _isFlathubEnabled() async {
    try {
      // First check if flatpak is installed
      final flatpakInstalled = await _isFlatpakInstalled();
      if (!flatpakInstalled) return false;

      // Check if flathub remote exists
      final r = await Process.run('bash', [
        '-lc',
        'flatpak remote-list 2>/dev/null | grep -q "^flathub\\s" && echo "true" || echo "false"',
      ]);
      return (r.stdout as String).toString().trim() == 'true';
    } catch (_) {
      return false;
    }
  }

  Future<String?> _findFlatpakRef(String query) async {
    try {
      // First check if flathub is enabled
      final flathubEnabled = await _isFlathubEnabled();
      if (!flathubEnabled) return null;

      // Search for the package in flathub
      final r = await Process.run('bash', [
        '-lc',
        'flatpak search --columns=ref ${_escapeShellArg(query)} 2>/dev/null | grep -v "^Ref" | head -n 1',
      ]);
      final ref = (r.stdout as String).toString().split('\n').first.trim();
      if (ref.isEmpty || ref == 'Ref') return null; // handle header-only output
      return ref;
    } catch (_) {
      return null;
    }
  }

  Future<bool> _isSnapAvailable() async {
    try {
      final r = await Process.run('bash', [
        '-lc',
        'command -v snap >/dev/null 2>&1; echo \$?',
      ]);
      return (r.stdout as String).toString().trim() == '0';
    } catch (_) {
      return false;
    }
  }

  String _escapeShellArg(String s) {
    return "'${s.replaceAll("'", "'\\''")}'";
  }

  // Desktop Environment Management Methods

  /// Detects if a specific desktop environment is installed
  Future<bool> isDesktopEnvironmentInstalled(String deId) async {
    try {
      final packages = _getDesktopEnvironmentPackages(deId);
      if (packages.isEmpty) return false;

      // Check if the main meta-package is installed
      final mainPackage = packages.first;
      final result = await Process.run('dpkg', ['-l', mainPackage]);

      // Check if package is installed (status starts with 'ii')
      return result.stdout.toString().contains('ii  $mainPackage');
    } catch (_) {
      return false;
    }
  }

  /// Gets the currently active desktop environment
  Future<String?> getCurrentDesktopEnvironment() async {
    try {
      // Check XDG_CURRENT_DESKTOP environment variable
      final result = await Process.run('bash', [
        '-c',
        'echo \$XDG_CURRENT_DESKTOP',
      ]);
      final currentDE = result.stdout.toString().trim().toLowerCase();

      if (currentDE.isNotEmpty && currentDE != '\$XDG_CURRENT_DESKTOP') {
        return _normalizeDesktopEnvironmentName(currentDE);
      }

      // Fallback: check running processes
      final kdeResult = await Process.run('pgrep', ['-f', 'plasmashell']);
      if (kdeResult.exitCode == 0) return 'kde';

      final xfceResult = await Process.run('pgrep', ['-f', 'xfce4-session']);
      if (xfceResult.exitCode == 0) return 'xfce';

      final mateResult = await Process.run('pgrep', ['-f', 'mate-session']);
      if (mateResult.exitCode == 0) return 'mate';

      final cinnamonResult = await Process.run('pgrep', [
        '-f',
        'cinnamon-session',
      ]);
      if (cinnamonResult.exitCode == 0) return 'cinnamon';

      return 'unknown';
    } catch (_) {
      return 'unknown';
    }
  }

  /// Installs a complete desktop environment
  Stream<CommandOutputLine> installDesktopEnvironment(
    String deId,
    List<String> packages,
  ) async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text:
          'Installing ${_getDesktopEnvironmentName(deId)} desktop environment...',
      isError: false,
    );

    // Update package lists first
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Updating package lists...',
      isError: false,
    );

    await for (final line in runAsRoot(['apt-get', 'update'])) {
      yield line;
    }

    // Install the desktop environment packages
    final packageList = packages.join(' ');
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Installing packages: $packageList',
      isError: false,
    );

    await for (final line in runAsRoot([
      'apt-get',
      'install',
      '-y',
      ...packages,
    ])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Desktop environment installation completed!',
      isError: false,
    );
  }

  /// Switches to a different desktop environment and reboots
  Stream<CommandOutputLine> switchDesktopEnvironment(String deId) async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text:
          'Switching to ${_getDesktopEnvironmentName(deId)} desktop environment...',
      isError: false,
    );

    // Set the desktop environment for the current user
    final displayManager = _getDisplayManagerForDE(deId);

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Configuring display manager: $displayManager',
      isError: false,
    );

    // Enable the appropriate display manager
    await for (final line in runAsRoot([
      'systemctl',
      'enable',
      displayManager,
    ])) {
      yield line;
    }

    // Set desktop environment session
    await for (final line in runAsRoot([
      'update-alternatives',
      '--set',
      'x-session-manager',
      _getSessionManagerForDE(deId),
    ])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Desktop environment configured. Rebooting system in 10 seconds...',
      isError: false,
    );

    // Reboot the system
    await for (final line in runAsRoot([
      'shutdown',
      '-r',
      '+1',
      'Desktop environment switch',
    ])) {
      yield line;
    }
  }

  /// Removes a desktop environment completely
  Stream<CommandOutputLine> removeDesktopEnvironment(
    String deId,
    List<String> packages,
  ) async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text:
          'Removing ${_getDesktopEnvironmentName(deId)} desktop environment...',
      isError: false,
    );

    // Remove packages
    final packageList = packages.join(' ');
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Removing packages: $packageList',
      isError: false,
    );

    await for (final line in runAsRoot([
      'apt-get',
      'remove',
      '--purge',
      '-y',
      ...packages,
    ])) {
      yield line;
    }

    // Clean up dependencies
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Cleaning up unused dependencies...',
      isError: false,
    );

    await for (final line in runAsRoot(['apt-get', 'autoremove', '-y'])) {
      yield line;
    }

    await for (final line in runAsRoot(['apt-get', 'autoclean'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Desktop environment removal completed!',
      isError: false,
    );
  }

  // Helper methods for desktop environment management

  List<String> _getDesktopEnvironmentPackages(String deId) {
    switch (deId.toLowerCase()) {
      case 'kde':
        return [
          // تم استبدال 'kubuntu-desktop' بـ حزم البلازما الأساسية
          'plasma-desktop', // سطح المكتب الأساسي
          'plasma-workspace', // مساحة العمل (الـ Shell)
          'sddm', // مدير العرض (Display Manager)
          'dolphin', // مدير الملفات
          'konsole', // الطرفية
          'systemsettings', // الإعدادات
        ];
      case 'xfce':
        return [
          // تم استبدال 'xubuntu-desktop' بـ حزم Xfce الأساسية
          'xfce4',
          'xfwm4', // مدير النوافذ (Window Manager) - مهم جداً
          'xfce4-session', // مدير الجلسات (Session Manager) - مهم جداً
          'thunar',
          'xfce4-terminal',
          'lightdm',
          'xfce4-settings',
        ];
      case 'mate':
        return [
          // تم استبدال 'ubuntu-mate-desktop' بـ حزم MATE الأساسية
          'mate-core', // الحزمة الأساسية للواجهة
          'mate-session-manager', // لإدارة الجلسات
          'caja',
          'mate-terminal',
          'lightdm', // يفضل lightdm ليتوافق مع باقي البيئات الخفيفة
          'mate-control-center',
        ];
      case 'cinnamon':
        return [
          // تم استبدال 'cinnamon-desktop-environment' بـ حزم Cinnamon الأساسية
          'cinnamon',
          'cinnamon-session', // مدير الجلسات
          'nemo',
          'gnome-terminal',
          'lightdm', // استخدام LightDM بدلاً من MDM أو غيره للاتساق
          'cinnamon-control-center',
          'muffin', // مدير النوافذ لـ Cinnamon
        ];
      default:
        return [];
    }
  }

  String _getDesktopEnvironmentName(String deId) {
    switch (deId.toLowerCase()) {
      case 'kde':
        return 'KDE Plasma';
      case 'xfce':
        return 'Xfce';
      case 'mate':
        return 'MATE';
      case 'cinnamon':
        return 'Cinnamon';
      default:
        return deId.toUpperCase();
    }
  }

  String _getDisplayManagerForDE(String deId) {
    switch (deId.toLowerCase()) {
      case 'kde':
        return 'sddm';
      case 'xfce':
        return 'lightdm';
      case 'mate':
        return 'lightdm';
      case 'cinnamon':
        return 'lightdm';
      default:
        return 'lightdm';
    }
  }

  String _getSessionManagerForDE(String deId) {
    switch (deId.toLowerCase()) {
      case 'kde':
        return '/usr/bin/startplasma-x11';
      case 'xfce':
        return '/usr/bin/startxfce4';
      case 'mate':
        return '/usr/bin/mate-session';
      case 'cinnamon':
        return '/usr/bin/cinnamon-session';
      default:
        return '/usr/bin/startxfce4';
    }
  }

  String _normalizeDesktopEnvironmentName(String deName) {
    final normalized = deName.toLowerCase();
    if (normalized.contains('kde') || normalized.contains('plasma')) {
      return 'kde';
    }
    if (normalized.contains('xfce')) return 'xfce';
    if (normalized.contains('mate')) return 'mate';
    if (normalized.contains('cinnamon')) return 'cinnamon';
    return normalized;
  }


  /// Gets all system services
  Future<List<SystemServiceInfo>> getAllSystemServices() async {
    try {
      final result = await Process.run('systemctl', [
        'list-units',
        '--type=service',
        '--no-pager',
      ]);
      final lines = result.stdout.toString().split('\n');
      final services = <SystemServiceInfo>[];

      for (final line in lines) {
        if (line.trim().isEmpty ||
            line.startsWith('UNIT') ||
            line.startsWith('●')) {
          continue;
        }

        final parts = line.trim().split(RegExp(r'\s+'));
        if (parts.length >= 4) {
          final name = parts[0];
          final status = parts[2];
          final description = parts.sublist(3).join(' ');

          services.add(
            SystemServiceInfo(
              name: name,
              description: description,
              status: status,
            ),
          );
        }
      }

      return services;
    } catch (_) {
      return [];
    }
  }

  /// Checks if a service is running
  Future<bool> isServiceRunning(String serviceName) async {
    try {
      final result = await Process.run('systemctl', ['is-active', serviceName]);
      return result.exitCode == 0 &&
          result.stdout.toString().trim() == 'active';
    } catch (_) {
      return false;
    }
  }

  /// Controls a system service (start, stop, restart, enable, disable)
  Stream<CommandOutputLine> controlService(
    String serviceName,
    String action,
  ) async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: '${action.toUpperCase()} service: $serviceName',
      isError: false,
    );

    List<String> command;
    switch (action.toLowerCase()) {
      case 'start':
        command = ['systemctl', 'start', serviceName];
        break;
      case 'stop':
        command = ['systemctl', 'stop', serviceName];
        break;
      case 'restart':
        command = ['systemctl', 'restart', serviceName];
        break;
      case 'enable':
        command = ['systemctl', 'enable', serviceName];
        break;
      case 'disable':
        command = ['systemctl', 'disable', serviceName];
        break;
      default:
        yield CommandOutputLine(
          timestamp: DateTime.now(),
          text: 'Invalid action: $action',
          isError: true,
        );
        return;
    }

    await for (final line in runAsRoot(command)) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Service $serviceName $action completed',
      isError: false,
    );
  }

  /// Gets logs for a specific service
  Future<String> getServiceLogs(String serviceName) async {
    try {
      final result = await Process.run('journalctl', [
        '-u',
        serviceName,
        '--no-pager',
        '-n',
        '100',
      ]);
      return result.stdout.toString();
    } catch (_) {
      return 'Unable to retrieve logs for $serviceName';
    }
  }

  /// Fixes broken packages using dpkg --configure -a
  Stream<CommandOutputLine> fixBrokenPackages() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Fixing broken package configurations...',
      isError: false,
    );

    await for (final line in runAsRoot(['dpkg', '--configure', '-a'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Package configuration fix completed',
      isError: false,
    );
  }

  /// Fixes dependency issues using apt install -f
  Stream<CommandOutputLine> fixDependencies() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Fixing dependency issues...',
      isError: false,
    );

    await for (final line in runAsRoot(['apt', 'install', '-f', '-y'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Dependency fix completed',
      isError: false,
    );
  }

  /// Cleans package cache
  Stream<CommandOutputLine> cleanPackageCache() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Cleaning package cache...',
      isError: false,
    );

    await for (final line in runAsRoot(['apt', 'clean'])) {
      yield line;
    }

    await for (final line in runAsRoot(['apt', 'autoclean'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Package cache cleanup completed',
      isError: false,
    );
  }

  /// Removes orphaned packages
  Stream<CommandOutputLine> removeOrphanedPackages() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Removing orphaned packages...',
      isError: false,
    );

    await for (final line in runAsRoot(['apt', 'autoremove', '-y'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Orphaned packages removal completed',
      isError: false,
    );
  }

  /// Checks log storage usage
  Stream<CommandOutputLine> checkLogUsage() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Checking log storage usage...',
      isError: false,
    );

    await for (final line in runAsRoot(['journalctl', '--disk-usage'])) {
      yield line;
    }

    await for (final line in runAsRoot(['du', '-sh', '/var/log'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Log usage check completed',
      isError: false,
    );
  }

  /// Cleans system logs
  Stream<CommandOutputLine> cleanSystemLogs() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Cleaning system logs...',
      isError: false,
    );

    // Clean journal logs older than 7 days
    await for (final line in runAsRoot(['journalctl', '--vacuum-time=7d'])) {
      yield line;
    }

    // Clean old log files
    await for (final line in runAsRoot([
      'find',
      '/var/log',
      '-type',
      'f',
      '-name',
      '*.log',
      '-mtime',
      '+30',
      '-delete',
    ])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'System log cleanup completed',
      isError: false,
    );
  }

  /// Rotates system logs
  Stream<CommandOutputLine> rotateLogs() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Rotating system logs...',
      isError: false,
    );

    await for (final line in runAsRoot([
      'logrotate',
      '-f',
      '/etc/logrotate.conf',
    ])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Log rotation completed',
      isError: false,
    );
  }

  /// Checks boot files integrity
  Stream<CommandOutputLine> checkBootFiles() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Checking boot files integrity...',
      isError: false,
    );

    await for (final line in runAsRoot(['grub-install', '--verify'])) {
      yield line;
    }

    await for (final line in runAsRoot(['ls', '-la', '/boot'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Boot files check completed',
      isError: false,
    );
  }

  /// Rebuilds GRUB bootloader
  Stream<CommandOutputLine> rebuildGRUB() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Rebuilding GRUB bootloader...',
      isError: false,
    );

    await for (final line in runAsRoot(['grub-install', '/dev/sda'])) {
      yield line;
    }

    await for (final line in runAsRoot(['update-grub'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'GRUB rebuild completed',
      isError: false,
    );
  }

  /// Updates initramfs
  Stream<CommandOutputLine> updateInitramfs() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Updating initramfs...',
      isError: false,
    );

    await for (final line in runAsRoot(['update-initramfs', '-u'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Initramfs update completed',
      isError: false,
    );
  }

  /// Runs comprehensive boot repair
  Stream<CommandOutputLine> bootRepair() async* {
    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Running comprehensive boot repair...',
      isError: false,
    );

    // Update package lists
    await for (final line in runAsRoot(['apt', 'update'])) {
      yield line;
    }

    // Fix broken packages
    await for (final line in runAsRoot(['dpkg', '--configure', '-a'])) {
      yield line;
    }

    // Rebuild GRUB
    await for (final line in runAsRoot(['grub-install', '/dev/sda'])) {
      yield line;
    }

    await for (final line in runAsRoot(['update-grub'])) {
      yield line;
    }

    // Update initramfs
    await for (final line in runAsRoot(['update-initramfs', '-u'])) {
      yield line;
    }

    yield CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Boot repair completed. A reboot is recommended.',
      isError: false,
    );
  }

  Future<Map<String, dynamic>> getCPUInfo() async {
    final data = <String, dynamic>{};

    try {
      // Get CPU model
      final cpuResult = await Process.run('bash', [
        '-c',
        'cat /proc/cpuinfo | grep "model name" | head -1 | cut -d: -f2',
      ]);
      if (cpuResult.exitCode == 0) {
        data['name'] = cpuResult.stdout.toString().trim();
      }

      // Get CPU usage
      final usageResult = await Process.run('bash', [
        '-c',
        'top -bn1 | grep "Cpu(s)" | awk \'{print \$2}\' | cut -d% -f1',
      ]);
      if (usageResult.exitCode == 0) {
        data['usage'] =
            double.tryParse(usageResult.stdout.toString().trim()) ?? 0.0;
      }

      // Get CPU temperature (if available)
      final tempResult = await Process.run('bash', [
        '-c',
        'cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -1',
      ]);
      if (tempResult.exitCode == 0) {
        final temp = int.tryParse(tempResult.stdout.toString().trim());
        if (temp != null) {
          data['temperature'] =
              (temp / 1000).round(); // Convert from millidegrees
        }
      }

      // Get CPU cores
      final coresResult = await Process.run('bash', ['-c', 'nproc']);
      if (coresResult.exitCode == 0) {
        data['cores'] = int.tryParse(coresResult.stdout.toString().trim()) ?? 0;
      }

      // Get CPU frequency
      final freqResult = await Process.run('bash', [
        '-c',
        'cat /proc/cpuinfo | grep "cpu MHz" | head -1 | cut -d: -f2',
      ]);
      if (freqResult.exitCode == 0) {
        data['frequency'] =
            double.tryParse(freqResult.stdout.toString().trim()) ?? 0.0;
      }
    } catch (e) {
      data['error'] = 'Error retrieving CPU data: $e';
    }

    return data;
  }

  /// Gets integrated graphics information
  Future<Map<String, dynamic>> getIntegratedGraphicsInfo() async {
    final data = <String, dynamic>{};

    try {
      // Look for integrated graphics in lspci output
      final result = await Process.run('bash', [
        '-c',
        'lspci | grep -i "vga|display" | grep -i "intel|amd"',
      ]);
      if (result.exitCode == 0) {
        final output = result.stdout.toString().trim();
        if (output.isNotEmpty) {
          data['name'] = output;
          data['vendor'] =
              output.toLowerCase().contains('intel') ? 'intel' : 'amd';
          data['type'] = 'integrated';
        }
      }

      // Try to get more detailed info
      final detailedResult = await Process.run('bash', [
        '-c',
        'lspci -v | grep -A 10 -i "vga|display"',
      ]);
      if (detailedResult.exitCode == 0) {
        data['details'] = detailedResult.stdout.toString().trim();
      }
    } catch (e) {
      data['error'] = 'Error retrieving integrated graphics data: $e';
    }

    return data;
  }
}

class SystemServiceInfo {
  final String name;
  final String description;
  final String status;

  const SystemServiceInfo({
    required this.name,
    required this.description,
    required this.status,
  });
}

enum _PrivilegeHelper { pkexec, sudo, none }
