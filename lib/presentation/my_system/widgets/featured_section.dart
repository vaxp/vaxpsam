import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/system_operation.dart';
import '../../../infrastructure/system_management_providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../controllers/system_management_controller.dart';

/// Featured section widget displaying main system operations in a grid
class FeaturedSection extends ConsumerWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredOperations = ref.watch(featuredOperationsProvider);
    final controller = ref.read(systemManagementControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(color: macAppStoreBlue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 400) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: featuredOperations.length,
              itemBuilder: (context, index) {
                final operation = featuredOperations[index];
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
                  onTap:
                      () => _handleOperationTap(
                        context,
                        ref,
                        operation,
                        controller,
                      ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _handleOperationTap(
    BuildContext context,
    WidgetRef ref,
    SystemOperation operation,
    SystemManagementController controller,
  ) {
    switch (operation.id) {
      case 'install_by_name':
        controller.showPackageInstallDialog(context);
        break;
      case 'install_deb':
        controller.showDebFilePickerDialog(context);
        break;
      case 'update_system':
        controller.executeOperation(context, operation);
        break;
      case 'upgrade_system':
        controller.executeOperation(context, operation);
        break;
      default:
        controller.executeOperation(context, operation);
    }
  }
}
