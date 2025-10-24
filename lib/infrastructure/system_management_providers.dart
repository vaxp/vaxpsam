import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/system_management_service.dart';
import '../application/dialog_service.dart';
import '../application/system_operations_config.dart';
import '../domain/system_operation.dart';
import 'providers.dart';

/// Provider for SystemManagementService
final systemManagementServiceProvider = Provider<SystemManagementService>((ref) {
  final systemService = ref.read(systemServiceProvider);
  return SystemManagementService(systemService);
});

/// Provider for DialogService
final dialogServiceProvider = Provider<DialogService>((ref) {
  return DialogService();
});

/// Provider for system operations configuration
final systemOperationsConfigProvider = Provider<SystemOperationsConfig>((ref) {
  return SystemOperationsConfig();
});

/// Provider for system sections
final systemSectionsProvider = Provider<List<SystemSection>>((ref) {
  return SystemOperationsConfig.systemSections;
});

/// Provider for featured operations
final featuredOperationsProvider = Provider<List<SystemOperation>>((ref) {
  return SystemOperationsConfig.featuredOperations;
});

/// Provider for quick actions
final quickActionsProvider = Provider<List<SystemOperation>>((ref) {
  return SystemOperationsConfig.quickActions;
});

/// Provider for maintenance operations
final maintenanceOperationsProvider = Provider<List<SystemOperation>>((ref) {
  return SystemOperationsConfig.maintenanceOperations;
});

/// Provider for wine operations
final wineOperationsProvider = Provider<List<SystemOperation>>((ref) {
  return SystemOperationsConfig.wineOperations;
});
