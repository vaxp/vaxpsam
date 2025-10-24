import 'package:flutter/material.dart';
import '../domain/system_operation.dart';

/// Configuration class that defines all available system operations
class SystemOperationsConfig {
  static const List<SystemOperation> featuredOperations = [
    SystemOperation(
      id: 'install_by_name',
      title: 'Install by Name',
      description: 'Smart search across repositories',
      icon: Icons.search,
      color: Color(0xFF007AFF), // macAppStoreBlue
      type: SystemOperationType.installPackage,
    ),
    SystemOperation(
      id: 'install_deb',
      title: 'Install .deb',
      description: 'Local package installation',
      icon: Icons.install_desktop,
      color: Color(0xFFAF52DE), // macAppStorePurple
      type: SystemOperationType.installDeb,
    ),
    SystemOperation(
      id: 'update_system',
      title: 'Update System',
      description: 'Refresh package lists',
      icon: Icons.system_update,
      color: Color(0xFF4CAF50),
      type: SystemOperationType.update,
    ),
    SystemOperation(
      id: 'upgrade_system',
      title: 'Upgrade System',
      description: 'Update all packages',
      icon: Icons.upgrade,
      color: Color(0xFF2196F3),
      type: SystemOperationType.upgrade,
    ),
  ];

  static const List<SystemOperation> quickActions = [
    SystemOperation(
      id: 'update_system_quick',
      title: 'Update System',
      description: 'Run apt update to refresh package lists',
      icon: Icons.system_update,
      color: Color(0xFF007AFF),
      type: SystemOperationType.update,
    ),
    SystemOperation(
      id: 'upgrade_system_quick',
      title: 'Upgrade System',
      description: 'Run apt upgrade to update all packages',
      icon: Icons.upgrade,
      color: Color(0xFF2196F3),
      type: SystemOperationType.upgrade,
    ),
    SystemOperation(
      id: 'clean_system',
      title: 'Clean System',
      description: 'Remove unused packages and free up space',
      icon: Icons.cleaning_services,
      color: Color(0xFFFF9500),
      type: SystemOperationType.cleanSystem,
    ),
  ];

  static const List<SystemOperation> maintenanceOperations = [
    SystemOperation(
      id: 'remove_package',
      title: 'Remove Package',
      description: 'Uninstall a specific package from your system',
      icon: Icons.remove_circle,
      color: Color(0xFFFF3B30),
      type: SystemOperationType.removePackage,
    ),
    SystemOperation(
      id: 'search_packages',
      title: 'Search Packages',
      description: 'Find and install packages by name',
      icon: Icons.search,
      color: Color(0xFF007AFF),
      type: SystemOperationType.installPackage,
    ),
  ];

  static const List<SystemOperation> wineOperations = [
    SystemOperation(
      id: 'install_wine',
      title: 'Install Wine',
      description: 'Install Wine compatibility layer for Windows applications',
      icon: Icons.wine_bar,
      color: Color(0xFF8E44AD),
      type: SystemOperationType.installWine,
    ),
    SystemOperation(
      id: 'install_playonlinux',
      title: 'Install PlayOnLinux',
      description: 'Install PlayOnLinux frontend for Wine',
      icon: Icons.apps,
      color: Color(0xFF3498DB),
      type: SystemOperationType.installPlayOnLinux,
    ),
    SystemOperation(
      id: 'install_winetricks',
      title: 'Install Winetricks',
      description: 'Install winetricks helper for Wine configuration',
      icon: Icons.extension,
      color: Color(0xFFE67E22),
      type: SystemOperationType.installWinetricks,
    ),
  ];

  static const List<SystemSection> systemSections = [
    SystemSection(
      id: 'featured',
      title: 'Featured',
      operations: featuredOperations,
      isGridLayout: true,
    ),
    SystemSection(
      id: 'quick_actions',
      title: 'Quick Actions',
      operations: quickActions,
      isGridLayout: false,
    ),
    SystemSection(
      id: 'maintenance',
      title: 'System Maintenance',
      operations: maintenanceOperations,
      isGridLayout: false,
    ),
    SystemSection(
      id: 'wine',
      title: 'Windows Compatibility',
      operations: wineOperations,
      isGridLayout: false,
    ),
  ];

  /// Get operation by ID
  static SystemOperation? getOperationById(String id) {
    for (final section in systemSections) {
      for (final operation in section.operations) {
        if (operation.id == id) {
          return operation;
        }
      }
    }
    return null;
  }

  /// Get section by ID
  static SystemSection? getSectionById(String id) {
    for (final section in systemSections) {
      if (section.id == id) {
        return section;
      }
    }
    return null;
  }
}
