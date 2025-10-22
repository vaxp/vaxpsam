import 'advanced_debugging_export.dart';

class AdvancedDebuggingPage extends ConsumerStatefulWidget {
  const AdvancedDebuggingPage({super.key});

  @override
  ConsumerState<AdvancedDebuggingPage> createState() =>
      _AdvancedDebuggingPageState();
}

class _AdvancedDebuggingPageState extends ConsumerState<AdvancedDebuggingPage> {
  bool isLoadingLogs = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: macAppStoreDark,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                const ActionGridSection(
                  title: 'Fix Broken Packages',
                  actions: AdvancedDebuggingData.kFixBrokenPackagesActions,
                ),
                const SizedBox(height: 16),

                const ActionGridSection(
                  title: 'Log Cleanup',
                  actions: AdvancedDebuggingData.kLogCleanupActions,
                ),
                const SizedBox(height: 16),

                const ActionGridSection(
                  title: 'Boot Management',
                  actions: AdvancedDebuggingData.kBootManagementActions,
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
