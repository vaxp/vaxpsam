import 'package:flutter/material.dart';
import 'package:vaxpsam/domain/debugging_action.dart';

class AdvancedDebuggingData {
  static const List<DebuggingAction> kFixBrokenPackagesActions = [
    DebuggingAction(
      title: 'Configure Packages',
      description: 'Run dpkg --configure -a to fix broken package configurations',
      icon: Icons.build,
      color: Color(0xFF4CAF50),
      commandKey: 'configure_packages',
    ),
    DebuggingAction(
      title: 'Fix Dependencies',
      description: 'Run apt install -f to resolve dependency issues',
      icon: Icons.link,
      color: Color(0xFF2196F3),
      commandKey: 'fix_dependencies',
    ),
    DebuggingAction(
      title: 'Clean Package Cache',
      description: 'Remove cached package files to free up space',
      icon: Icons.cleaning_services,
      color: Color(0xFFFF9800),
      commandKey: 'clean_cache',
    ),
    DebuggingAction(
      title: 'Remove Orphaned Packages',
      description: 'Remove packages that are no longer needed',
      icon: Icons.delete_sweep,
      color: Color(0xFF9C27B0),
      commandKey: 'remove_orphaned',
    ),
  ];

  // 2. تنظيف السجلات (Log Cleanup)
  static const List<DebuggingAction> kLogCleanupActions = [
    DebuggingAction(
      title: 'Clean System Logs',
      description: 'Remove old system logs to free up storage space',
      icon: Icons.cleaning_services,
      color: Color(0xFF4CAF50),
      commandKey: 'clean_logs',
    ),
    DebuggingAction(
      title: 'View Log Usage',
      description: 'Check current log storage usage',
      icon: Icons.storage,
      color: Color(0xFF2196F3),
      commandKey: 'check_log_usage',
    ),
    DebuggingAction(
      title: 'Rotate Logs',
      description: 'Rotate system logs to prevent them from growing too large',
      icon: Icons.rotate_right,
      color: Color(0xFFFF9800),
      commandKey: 'rotate_logs',
    ),
  ];

  // 3. إدارة الإقلاع (Boot Management)
  static const List<DebuggingAction> kBootManagementActions = [
    DebuggingAction(
      title: 'Rebuild GRUB',
      description: 'Rebuild GRUB bootloader configuration',
      icon: Icons.settings,
      color: Color(0xFF4CAF50),
      commandKey: 'rebuild_grub',
    ),
    DebuggingAction(
      title: 'Update Initramfs',
      description: 'Update initial RAM filesystem',
      icon: Icons.memory,
      color: Color(0xFF2196F3),
      commandKey: 'update_initramfs',
    ),
    DebuggingAction(
      title: 'Check Boot Files',
      description: 'Verify boot files integrity',
      icon: Icons.verified,
      color: Color(0xFFFF9800),
      commandKey: 'check_boot_files',
    ),
    DebuggingAction(
      title: 'Boot Repair',
      description: 'Run comprehensive boot repair',
      icon: Icons.build_circle,
      color: Color(0xFF9C27B0),
      commandKey: 'boot_repair',
    ),
  ];
}