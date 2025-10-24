import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/system_operation.dart';
import '../../../application/system_management_service.dart';
import '../../../application/dialog_service.dart';
import '../../../infrastructure/system_management_providers.dart';
import '../../console/console_utils.dart';

/// Controller that manages system management operations and UI interactions
class SystemManagementController {
  final SystemManagementService _systemManagementService;
  final DialogService _dialogService;

  SystemManagementController(this._systemManagementService, this._dialogService);

  /// Executes a system operation and shows the console output
  void executeOperation(BuildContext context, SystemOperation operation) {
    final stream = _systemManagementService.executeOperation(operation);
    showConsoleStream(context, stream);
  }

  /// Shows package installation dialog and handles the installation
  Future<void> showPackageInstallDialog(BuildContext context) async {
    final packageName = await _dialogService.showPackageInstallDialog(context);
    
    if (packageName != null && packageName.isNotEmpty) {
      // ignore: use_build_context_synchronously
      await _handlePackageInstallation(context, packageName);
    }
  }

  /// Shows package removal dialog and handles the removal
  Future<void> showPackageRemoveDialog(BuildContext context) async {
    final packageName = await _dialogService.showPackageRemoveDialog(context);
    
    if (packageName != null && packageName.isNotEmpty) {
      final operation = SystemOperation(
        id: 'remove_package',
        title: 'Remove Package',
        description: 'Remove $packageName',
        icon: Icons.remove_circle,
        color: const Color(0xFFFF3B30),
        type: SystemOperationType.removePackage,
        parameters: {'packageName': packageName},
      );
      // ignore: use_build_context_synchronously
      executeOperation(context, operation);
    }
  }

  /// Shows .deb file picker dialog and handles the installation
  Future<void> showDebFilePickerDialog(BuildContext context) async {
    final filePath = await _dialogService.showDebFilePickerDialog(context);
    
    if (filePath != null) {
      final operation = SystemOperation(
        id: 'install_deb',
        title: 'Install .deb',
        description: 'Install from file',
        icon: Icons.install_desktop,
        color: const Color(0xFFAF52DE),
        type: SystemOperationType.installDeb,
        parameters: {'filePath': filePath},
      );
      // ignore: use_build_context_synchronously
      executeOperation(context, operation);
    }
  }

  /// Handles smart package installation with repository detection
  Future<void> _handlePackageInstallation(BuildContext context, String packageName) async {
    try {
      // Show loading dialog
      _dialogService.showLoadingDialog(context, 'Checking package availability...');
      
      // Check package availability
      final result = await _systemManagementService.smartInstallPackage(packageName);
      
      // Hide loading dialog
      // ignore: use_build_context_synchronously
      _dialogService.hideLoadingDialog(context);
      
      if (!result.success) {
        // Show error dialog
        // ignore: use_build_context_synchronously
        _dialogService.showErrorDialog(context, 'Package Not Found', result.error ?? 'Unknown error');
        return;
      }
      
      // Get installation configuration
      final config = await _systemManagementService.getInstallationConfig(packageName);
      
      // Check if we need to enable repositories
      if (config.enableUniverse || config.enableSnapd || config.enableFlathub) {
        // ignore: use_build_context_synchronously
        final shouldEnable = await _showRepositoryEnableDialog(context, config);
        if (!shouldEnable) return;
      }
      
      // Execute installation
      final stream = _systemManagementService.executePackageInstallation(config);
      // ignore: use_build_context_synchronously
      showConsoleStream(context, stream);
      
    } catch (e) {
        // ignore: use_build_context_synchronously
      _dialogService.hideLoadingDialog(context);
        // ignore: use_build_context_synchronously
      _dialogService.showErrorDialog(context, 'Error', 'Failed to install package: $e');
    }
  }

  /// Shows repository enable confirmation dialog
  Future<bool> _showRepositoryEnableDialog(BuildContext context, PackageInstallationConfig config) async {
    String title = 'Enable Repository';
    String content = '';
    
    if (config.enableUniverse) {
      title = 'Enable Ubuntu Universe?';
      content = 'Found "${config.packageName}" in Ubuntu repositories. Enable Universe and continue?';
    } else if (config.enableSnapd) {
      title = 'Enable Snapd?';
      content = 'Found "${config.packageName}" in Snap. Enable snapd and continue?';
    } else if (config.enableFlathub) {
      title = 'Enable Flathub?';
      content = 'Found "${config.packageName}" on Flathub. Enable Flatpak/Flathub and continue?';
    }
    
    return await _dialogService.showRepositoryEnableDialog(context, title, content);
  }
}

/// Provider for SystemManagementController
final systemManagementControllerProvider = Provider<SystemManagementController>((ref) {
  final systemManagementService = ref.read(systemManagementServiceProvider);
  final dialogService = ref.read(dialogServiceProvider);
  return SystemManagementController(systemManagementService, dialogService);
});
