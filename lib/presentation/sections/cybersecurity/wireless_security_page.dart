import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';

class WirelessSecurityPage extends ConsumerWidget {
  const WirelessSecurityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);
    
    return Scaffold(
      backgroundColor: macAppStoreDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: macAppStoreDark,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroSection(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInstallAllSection(context, system),
                _buildToolsGrid(context, system),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'WIRELESS SECURITY',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Wi-Fi & Bluetooth Security',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '13 professional tools for wireless network security assessment and penetration testing.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallAllSection(BuildContext context, system) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: MacAppStoreCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.download,
                  color: macAppStoreBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Install All Wireless Security Tools',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 13 wireless security tools at once',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: macAppStoreGray,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _installAllTools(context, system),
                  icon: const Icon(Icons.install_desktop),
                  label: const Text('Install All'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: macAppStoreBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsGrid(BuildContext context, system) {
    final tools = [
      {'name': 'Aircrack-ng', 'package': 'aircrack-ng', 'description': 'Toolkit for assessing 802.11 (Wi-Fi) security'},
      {'name': 'Reaver', 'package': 'reaver', 'description': 'PIN guessing tool for the WPS protocol'},
      {'name': 'Pixiewps', 'package': 'pixiewps', 'description': 'Offline PIN bruteforce attack tool for WPS'},
      {'name': 'Kismet', 'package': 'kismet', 'description': 'Intrusion detection system (IDS) and scanner for 802.11 and Bluetooth networks'},
      {'name': 'Hcxdumptool', 'package': 'hcxdumptool', 'description': 'Handshake packet capture tool for WPA/WPA2'},
      {'name': 'MDK3', 'package': 'mdk3', 'description': 'Advanced Wi-Fi penetration testing tool (DoS attacks)'},
      {'name': 'Macchanger', 'package': 'macchanger', 'description': 'Tool for changing the MAC address of network interfaces'},
      {'name': 'Bluetop', 'package': 'bluetop', 'description': 'Graphical Bluetooth monitor (helps with device discovery)'},
      {'name': 'Hcxtools', 'package': 'hcxtools', 'description': 'Utility for converting hash formats to WPA/WPA2'},
      {'name': 'Bluez', 'package': 'bluez', 'description': 'Official Bluetooth package for Linux (required for running Bluetooth tools)'},
      {'name': 'Iwevent', 'package': 'wireless-tools', 'description': 'Displays events generated by the wireless interface'},
      {'name': 'Iwconfig', 'package': 'wireless-tools', 'description': 'Configures wireless interfaces'},
      {'name': 'Iwlist', 'package': 'wireless-tools', 'description': 'Scans the list of access points'},
    ];

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
            crossAxisCount: 4,
            childAspectRatio: 1.1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final tool = tools[index];
            return AppGridCard(
              title: tool['name']!,
              description: tool['description']!,
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7B1FA2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.wifi, color: Colors.white),
              ),
              onTap: () => showConsoleStream(context, system.installPackageByName(tool['package']!)),
            );
          },
        ),
      ],
    );
  }

  void _installAllTools(BuildContext context, system) {
    final tools = [
      'aircrack-ng', 'reaver', 'pixiewps', 'kismet', 'hcxdumptool',
      'mdk3', 'macchanger', 'bluetop', 'hcxtools', 'bluez',
      'wireless-tools'
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Install All Wireless Security Tools'),
        content: Text('This will install ${tools.length} wireless security tools. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              showConsoleStream(context, system.runAsRoot(['apt', 'update', '&&', 'apt', 'install', '-y', ...tools]));
            },
            child: const Text('Install All'),
          ),
        ],
      ),
    );
  }
}
