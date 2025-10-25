import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/data/wireless_security_data.dart';
import 'package:vaxpsam/infrastructure/providers.dart';
import 'package:vaxpsam/presentation/console/console_utils.dart';
import 'package:vaxpsam/presentation/home/widgets/section_widgets.dart';

class WirelessToolsGrid extends ConsumerWidget {
  const WirelessToolsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    final tools = WirelessSecurityData.kWirelessTools;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Wireless Security Tools',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1.1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final tool = tools[index];
            return AppGridCard(
              title: tool.name,
              description: tool.description,
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7B1FA2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.wifi,
                  color: Colors.white,
                ), // أيقونة ثابتة
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName(tool.package),
                  ),
            );
          },
        ),
      ],
    );
  }
}
