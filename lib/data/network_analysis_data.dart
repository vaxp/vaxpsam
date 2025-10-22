import 'package:vaxpsam/domain/network_tool.dart';

class NetworkAnalysisData {
  static const List<String> kAllToolPackages = [
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

  static const List<NetworkTool> kNetworkTools = [
    NetworkTool(
      name: 'Nmap',
      package: 'nmap',
      description: 'Scans ports and networks and discovers services',
    ),
    NetworkTool(
      name: 'Wireshark',
      package: 'wireshark',
      description: 'Graphical packet analyzer',
    ),
    NetworkTool(
      name: 'tcpdump',
      package: 'tcpdump',
      description: 'Captures command-line packets',
    ),
    NetworkTool(
      name: 'Masscan',
      package: 'masscan',
      description: 'Ultra-fast port scanning',
    ),
    NetworkTool(
      name: 'Netcat',
      package: 'netcat-traditional',
      description: 'Swiss Army knife for networks',
    ),
    NetworkTool(
      name: 'Hping3',
      package: 'hping3',
      description: 'Advanced packet crafter',
    ),
    NetworkTool(
      name: 'Iptraf-ng',
      package: 'iptraf-ng',
      description: 'Network traffic monitor',
    ),
    NetworkTool(
      name: 'Tcpflow',
      package: 'tcpflow',
      description: 'Reconstructs TCP flows',
    ),
    NetworkTool(
      name: 'Dnsutils',
      package: 'dnsutils',
      description: 'DNS query tools (dig, host)',
    ),
    NetworkTool(
      name: 'Dnsmap',
      package: 'dnsmap',
      description: 'Subdomain brute-forcing discovery',
    ),
    NetworkTool(
      name: 'Fierce',
      package: 'fierce',
      description: 'Comprehensive DNS scanning tool',
    ),
    NetworkTool(
      name: 'Mtr',
      package: 'mtr',
      description: 'Combination of Ping and Traceroute',
    ),
    NetworkTool(
      name: 'Traceroute',
      package: 'traceroute',
      description: 'Trace the path of IP packets',
    ),
    NetworkTool(
      name: 'Arpwatch',
      package: 'arpwatch',
      description: 'Monitor ARP activity on the network',
    ),
    NetworkTool(
      name: 'Etherape',
      package: 'etherape',
      description: 'Graphical display of network activity',
    ),
    NetworkTool(
      name: 'Netdiscover',
      package: 'netdiscover',
      description: 'Discover active devices on networks',
    ),
    NetworkTool(
      name: 'OpenSSH Client',
      package: 'openssh-client',
      description: 'Secure SSH client',
    ),
    NetworkTool(
      name: 'Telnet',
      package: 'telnet',
      description: 'Simple port telnet connection',
    ),
    NetworkTool(
      name: 'Nslookup',
      package: 'dnsutils', // نفس حزمة Dnsutils
      description: 'Query DNS records',
    ),
    NetworkTool(
      name: 'Ping',
      package: 'iputils-ping',
      description: 'Basic connectivity testing',
    ),
    NetworkTool(
      name: 'Route',
      package: 'net-tools', // نفس حزمة Net-tools
      description: 'View and modify routing tables',
    ),
    NetworkTool(
      name: 'Ifconfig',
      package: 'net-tools', // نفس حزمة Net-tools
      description: 'Displays and configures network interfaces',
    ),
    NetworkTool(
      name: 'Proxychains',
      package: 'proxychains4',
      description: 'Force programs to run through a proxy',
    ),
    NetworkTool(
      name: 'Aircrack-ng',
      package: 'aircrack-ng',
      description: 'Suite of tools for pentesting wireless networks',
    ),
    NetworkTool(
      name: 'Tshark',
      package: 'tshark',
      description: 'Command-line version of Wireshark',
    ),
    NetworkTool(
      name: 'Tcpreplay',
      package: 'tcpreplay',
      description: 'Replays pcap files',
    ),
    NetworkTool(
      name: 'Dsniff',
      package: 'dsniff',
      description: 'Intercepts and analyzes network passwords',
    ),
    NetworkTool(
      name: 'Ngrep',
      package: 'ngrep',
      description: 'Searches for patterns in network packets',
    ),
    NetworkTool(
      name: 'Tcpxtract',
      package: 'tcpxtract',
      description: 'Extracts files from network traffic',
    ),
    NetworkTool(
      name: 'Ettercap',
      package: 'ettercap-text-only',
      description: 'Intercepts man-in-the-middle attacks',
    ),
  ];
}
