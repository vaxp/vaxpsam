import 'package:flutter/material.dart';

/// Represents a system operation that can be performed
class SystemOperation {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final SystemOperationType type;
  final Map<String, dynamic>? parameters;

  const SystemOperation({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.type,
    this.parameters,
  });
}

/// Types of system operations
enum SystemOperationType {
  update,
  upgrade,
  installPackage,
  installDeb,
  removePackage,
  cleanSystem,
  installWine,
  installPlayOnLinux,
  installWinetricks,
  customCommand,
}

/// Represents a system section with its operations
class SystemSection {
  final String id;
  final String title;
  final List<SystemOperation> operations;
  final bool isGridLayout;

  const SystemSection({
    required this.id,
    required this.title,
    required this.operations,
    this.isGridLayout = false,
  });
}

/// Represents the result of a system operation
class SystemOperationResult {
  final bool success;
  final String? message;
  final String? error;
  final Map<String, dynamic>? data;

  const SystemOperationResult({
    required this.success,
    this.message,
    this.error,
    this.data,
  });

  factory SystemOperationResult.success([String? message, Map<String, dynamic>? data]) {
    return SystemOperationResult(
      success: true,
      message: message,
      data: data,
    );
  }

  factory SystemOperationResult.error(String error) {
    return SystemOperationResult(
      success: false,
      error: error,
    );
  }
}

/// Configuration for package installation
class PackageInstallationConfig {
  final String packageName;
  final bool enableUniverse;
  final bool enableSnapd;
  final bool enableFlathub;
  final String? flatpakRef;

  const PackageInstallationConfig({
    required this.packageName,
    this.enableUniverse = false,
    this.enableSnapd = false,
    this.enableFlathub = false,
    this.flatpakRef,
  });
}
