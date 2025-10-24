import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/system_operation.dart';
import '../../home/widgets/section_widgets.dart';
import '../controllers/system_management_controller.dart';

/// Generic operations section widget that can display operations in list or grid format
class OperationsSection extends ConsumerWidget {
  final String title;
  final List<SystemOperation> operations;
  final bool isGridLayout;

  const OperationsSection({
    super.key,
    required this.title,
    required this.operations,
    this.isGridLayout = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(systemManagementControllerProvider);

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
        if (isGridLayout)
          ResponsiveGrid(
            children: operations.map((operation) {
              return AppGridCard(
                title: operation.title,
                description: operation.description,
                icon: Container(
                  decoration: BoxDecoration(
                    color: operation.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(operation.icon, color: Colors.white),
                ),
                onTap: () => _handleOperationTap(context, ref, operation, controller),
              );
            }).toList(),
          )
        else
          ...operations.map((operation) {
            return SectionActionButton(
              icon: operation.icon,
              title: operation.title,
              description: operation.description,
              onPressed: () => _handleOperationTap(context, ref, operation, controller),
            );
          }),
      ],
    );
  }

  void _handleOperationTap(
    BuildContext context,
    WidgetRef ref,
    SystemOperation operation,
    SystemManagementController controller,
  ) {
    // Handle special cases that need dialogs
    if (operation.type == SystemOperationType.installPackage) {
      if (operation.id == 'search_packages') {
        controller.showPackageInstallDialog(context);
      } else {
        controller.executeOperation(context, operation);
      }
    } else if (operation.type == SystemOperationType.removePackage) {
      controller.showPackageRemoveDialog(context);
    } else if (operation.type == SystemOperationType.installDeb) {
      controller.showDebFilePickerDialog(context);
    } else {
      controller.executeOperation(context, operation);
    }
  }
}
