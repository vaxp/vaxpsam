import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaxpsam/presentation/widgets/rotating_background.dart';
import '../../infrastructure/providers.dart';
import '../home/widgets/section_widgets.dart';
import '../console/console_utils.dart';
import '../theme/app_theme.dart';

class NetworkAnalysisPage extends ConsumerWidget {
  const NetworkAnalysisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return StaticBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
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
                  colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
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
                  'NETWORK ANALYSIS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Network Security Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '30 professional tools for network scanning, monitoring, and analysis.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
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
                Icon(Icons.download, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Install All Network Tools',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 30 network analysis tools at once',
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
      {
        'name': 'Nmap',
        'package': 'nmap',
        'description': 'Scans ports and networks and discovers services',
      },
      {
        'name': 'Wireshark',
        'package': 'wireshark',
        'description': 'Graphical packet analyzer',
      },
      {
        'name': 'tcpdump',
        'package': 'tcpdump',
        'description': 'Captures command-line packets',
      },
      {
        'name': 'Masscan',
        'package': 'masscan',
        'description': 'Ultra-fast port scanning',
      },
      {
        'name': 'Netcat',
        'package': 'netcat-traditional',
        'description': 'Swiss Army knife for networks',
      },
      {
        'name': 'Hping3',
        'package': 'hping3',
        'description': 'Advanced packet crafter',
      },
      {
        'name': 'Iptraf-ng',
        'package': 'iptraf-ng',
        'description': 'Network traffic monitor',
      },
      {
        'name': 'Tcpflow',
        'package': 'tcpflow',
        'description': 'Reconstructs TCP flows',
      },
      {
        'name': 'Dnsutils',
        'package': 'dnsutils',
        'description': 'DNS query tools (dig, host)',
      },
      {
        'name': 'Dnsmap',
        'package': 'dnsmap',
        'description': 'Subdomain brute-forcing discovery',
      },
      {
        'name': 'Fierce',
        'package': 'fierce',
        'description': 'Comprehensive DNS scanning tool',
      },
      {
        'name': 'Mtr',
        'package': 'mtr',
        'description': 'Combination of Ping and Traceroute',
      },
      {
        'name': 'Traceroute',
        'package': 'traceroute',
        'description': 'Trace the path of IP packets',
      },
      {
        'name': 'Arpwatch',
        'package': 'arpwatch',
        'description': 'Monitor ARP activity on the network',
      },
      {
        'name': 'Etherape',
        'package': 'etherape',
        'description': 'Graphical display of network activity',
      },
      {
        'name': 'Netdiscover',
        'package': 'netdiscover',
        'description': 'Discover active devices on networks',
      },
      {
        'name': 'OpenSSH Client',
        'package': 'openssh-client',
        'description': 'Secure SSH client',
      },
      {
        'name': 'Telnet',
        'package': 'telnet',
        'description': 'Simple port telnet connection',
      },
      {
        'name': 'Nslookup',
        'package': 'dnsutils',
        'description': 'Query DNS records',
      },
      {
        'name': 'Ping',
        'package': 'iputils-ping',
        'description': 'Basic connectivity testing',
      },
      {
        'name': 'Route',
        'package': 'net-tools',
        'description': 'View and modify routing tables',
      },
      {
        'name': 'Ifconfig',
        'package': 'net-tools',
        'description': 'Displays and configures network interfaces',
      },
      {
        'name': 'Proxychains',
        'package': 'proxychains4',
        'description': 'Force programs to run through a proxy',
      },
      {
        'name': 'Aircrack-ng',
        'package': 'aircrack-ng',
        'description': 'Suite of tools for pentesting wireless networks',
      },
      {
        'name': 'Tshark',
        'package': 'tshark',
        'description': 'Command-line version of Wireshark',
      },
      {
        'name': 'Tcpreplay',
        'package': 'tcpreplay',
        'description': 'Replays pcap files',
      },
      {
        'name': 'Dsniff',
        'package': 'dsniff',
        'description': 'Intercepts and analyzes network passwords',
      },
      {
        'name': 'Ngrep',
        'package': 'ngrep',
        'description': 'Searches for patterns in network packets',
      },
      {
        'name': 'Tcpxtract',
        'package': 'tcpxtract',
        'description': 'Extracts files from network traffic',
      },
      {
        'name': 'Ettercap',
        'package': 'ettercap-text-only',
        'description': 'Intercepts man-in-the-middle attacks',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Network Analysis Tools',
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
                  color: const Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.network_check, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName(tool['package']!),
                  ),
            );
          },
        ),
      ],
    );
  }

  void _installAllTools(BuildContext context, system) {
    final tools = [
      'nmap',
      'wireshark',
      'tcpdump',
      'masscan',
      'netcat-traditional',
      'hping3',
      'iptraf-ng',
      'tcpflow',
      'dnsutils',
      'dnsmap',
      'fierce',
      'mtr',
      'traceroute',
      'arpwatch',
      'etherape',
      'netdiscover',
      'openssh-client',
      'telnet',
      'iputils-ping',
      'net-tools',
      'proxychains4',
      'aircrack-ng',
      'tshark',
      'tcpreplay',
      'dsniff',
      'ngrep',
      'tcpxtract',
      'ettercap-text-only',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Network Tools'),
            content: Text(
              'This will install ${tools.length} network analysis tools. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      ...tools,
                    ]),
                  );
                },
                child: const Text('Install All'),
              ),
            ],
          ),
    );
  }
}
