import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/domain/debugging_action.dart';
import 'package:vaxpsam/presentation/advanced_debugging/widget/showbootmanagementdialog.dart';
import 'package:vaxpsam/presentation/advanced_debugging/widget/showlogcleanupdialog.dart';
import '../../../infrastructure/providers.dart';
import '../../console/console_utils.dart';
import '../../home/widgets/section_widgets.dart'; // ResponsiveGrid, AppGridCard

class ActionGridSection extends ConsumerWidget {
  final String title;
  final List<DebuggingAction> actions;

  const ActionGridSection({
    super.key,
    required this.title,
    required this.actions,
  });

  // المنطق الموحد لتنفيذ الإجراءات
  void _handleActionTap(BuildContext context, system, DebuggingAction action) {
    switch (action.commandKey) {
      case 'configure_packages':
        showConsoleStream(context, system.fixBrokenPackages());
        break;
      case 'fix_dependencies':
        showConsoleStream(context, system.fixDependencies());
        break;
      case 'clean_cache':
        showConsoleStream(context, system.cleanPackageCache());
        break;
      case 'remove_orphaned':
        showConsoleStream(context, system.removeOrphanedPackages());
        break;
      case 'clean_logs':
        showLogCleanupDialog(context, system); // حوار مخصص
        break;
      case 'check_log_usage':
        showConsoleStream(context, system.checkLogUsage());
        break;
      case 'rotate_logs':
        showConsoleStream(context, system.rotateLogs());
        break;
      case 'rebuild_grub':
        showBootManagementDialog(context, system, 'grub');
        break;
      case 'update_initramfs':
        showBootManagementDialog(context, system, 'initramfs');
        break;
      case 'check_boot_files':
        showConsoleStream(context, system.checkBootFiles());
        break;
      case 'boot_repair':
        showBootManagementDialog(context, system, 'repair');
        break;
      default:
        // التعامل مع الإجراءات غير المعروفة
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ResponsiveGrid(
          
          children:
              actions.map((action) {
                return AppGridCard(
                  title: action.title,
                  description: action.description,
                  icon: Container(
                    decoration: BoxDecoration(
                      color: action.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(action.icon, color: Colors.white),
                  ),
                  onTap: () => _handleActionTap(context, system, action),
                );
              }).toList(),
        ),
      ],
    );
  }
}
