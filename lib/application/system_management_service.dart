import 'dart:async';
import '../domain/command_output_line.dart';
import '../domain/system_operation.dart';
import '../infrastructure/system_service.dart';

/// Service class that handles all system management business logic
class SystemManagementService {
  final SystemService _systemService;

  SystemManagementService(this._systemService);

  /// Executes a system operation and returns a stream of output
  Stream<CommandOutputLine> executeOperation(SystemOperation operation) {
    switch (operation.type) {
      case SystemOperationType.update:
        return _systemService.update();
      
      case SystemOperationType.upgrade:
        return _systemService.upgrade();
      
      case SystemOperationType.installPackage:
        final packageName = operation.parameters?['packageName'] as String?;
        if (packageName == null) {
          return Stream.value(CommandOutputLine(
            timestamp: DateTime.now(),
            text: 'Error: Package name is required',
            isError: true,
          ));
        }
        return _systemService.installPackageByName(packageName);
      
      case SystemOperationType.installDeb:
        final filePath = operation.parameters?['filePath'] as String?;
        if (filePath == null) {
          return Stream.value(CommandOutputLine(
            timestamp: DateTime.now(),
            text: 'Error: File path is required',
            isError: true,
          ));
        }
        return _systemService.installDebFromFile(filePath);
      
      case SystemOperationType.removePackage:
        final packageName = operation.parameters?['packageName'] as String?;
        if (packageName == null) {
          return Stream.value(CommandOutputLine(
            timestamp: DateTime.now(),
            text: 'Error: Package name is required',
            isError: true,
          ));
        }
        return _systemService.runAsRoot(['apt', 'remove', '-y', packageName]);
      
      case SystemOperationType.cleanSystem:
        return _systemService.runAsRoot(['apt', 'autoremove', '-y']);
      
      case SystemOperationType.installWine:
        return _systemService.installPackageByName('wine');
      
      case SystemOperationType.installPlayOnLinux:
        return _systemService.installPackageByName('playonlinux');
      
      case SystemOperationType.installWinetricks:
        return _systemService.installPackageByName('winetricks');
      
      case SystemOperationType.customCommand:
        final command = operation.parameters?['command'] as List<String>?;
        if (command == null) {
          return Stream.value(CommandOutputLine(
            timestamp: DateTime.now(),
            text: 'Error: Command is required',
            isError: true,
          ));
        }
        return _systemService.runAsRoot(command);
    }
  }

  /// Smart package installation with repository detection
  Future<SystemOperationResult> smartInstallPackage(String packageName) async {
    try {
      // Check Ubuntu repositories
      final universeEnabled = await _systemService.isUbuntuUniverseEnabled();
      final aptCandidate = await _systemService.aptHasCandidate(packageName);
      
      if (aptCandidate) {
        if (!universeEnabled) {
          return SystemOperationResult.error('Universe repository needs to be enabled');
        }
        return SystemOperationResult.success('Package found in Ubuntu repositories');
      }

      // Check Snap
      final snapAvailable = await _systemService.isSnapAvailable();
      final snapHas = await _systemService.snapHasPackage(packageName);
      
      if (snapHas) {
        if (!snapAvailable) {
          return SystemOperationResult.error('Snapd needs to be enabled');
        }
        return SystemOperationResult.success('Package found in Snap store');
      }

      // Check Flathub
      final flatpakInstalled = await _systemService.isFlatpakInstalled();
      final flathubEnabled = await _systemService.isFlathubEnabled();
      final flatpakRef = await _systemService.findFlatpakRef(packageName);
      
      if (flatpakRef != null && flatpakRef.isNotEmpty) {
        if (!flatpakInstalled || !flathubEnabled) {
          return SystemOperationResult.error('Flatpak/Flathub needs to be enabled');
        }
        return SystemOperationResult.success('Package found on Flathub');
      }

      return SystemOperationResult.error('Package not found in any repository');
    } catch (e) {
      return SystemOperationResult.error('Error checking package availability: $e');
    }
  }

  /// Get installation configuration for a package
  Future<PackageInstallationConfig> getInstallationConfig(String packageName) async {
    final universeEnabled = await _systemService.isUbuntuUniverseEnabled();
    final aptCandidate = await _systemService.aptHasCandidate(packageName);
    final snapAvailable = await _systemService.isSnapAvailable();
    final snapHas = await _systemService.snapHasPackage(packageName);
    final flatpakInstalled = await _systemService.isFlatpakInstalled();
    final flathubEnabled = await _systemService.isFlathubEnabled();
    final flatpakRef = await _systemService.findFlatpakRef(packageName);

    return PackageInstallationConfig(
      packageName: packageName,
      enableUniverse: aptCandidate && !universeEnabled,
      enableSnapd: snapHas && !snapAvailable,
      enableFlathub: flatpakRef != null && (!flatpakInstalled || !flathubEnabled),
      flatpakRef: flatpakRef,
    );
  }

  /// Execute package installation with configuration
  Stream<CommandOutputLine> executePackageInstallation(PackageInstallationConfig config) async* {
    // Enable repositories if needed
    if (config.enableUniverse) {
      yield* _systemService.enableUbuntuUniverse();
      yield* _systemService.update();
    }
    
    if (config.enableSnapd) {
      yield* _systemService.enableSnapd();
    }
    
    if (config.enableFlathub) {
      if (!await _systemService.isFlatpakInstalled()) {
        yield* _systemService.runAsRoot([
          'apt', 'update', '&&', 'apt', 'install', '-y',
          'flatpak', 'gnome-software-plugin-flatpak'
        ]);
      }
      yield* _systemService.enableFlathub();
    }

    // Install the package
    if (config.flatpakRef != null && config.flatpakRef!.isNotEmpty) {
      yield* _systemService.runAsRoot([
        'flatpak', 'install', '-y', 'flathub', config.flatpakRef!
      ]);
    } else if (await _systemService.snapHasPackage(config.packageName)) {
      yield* _systemService.runAsRoot(['snap', 'install', config.packageName]);
    } else {
      yield* _systemService.runAsRoot([
        'apt-get', 'update', '&&', 'apt-get', 'install', '-y', config.packageName
      ]);
    }
  }
}
