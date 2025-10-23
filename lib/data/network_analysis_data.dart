import 'package:vaxpsam/domain/network_tool.dart';

class NetworkAnalysisData {
  static const List<String> kAllToolPackages = [
    // --- Your Original Packages (28) ---
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

    // --- New Packages Added (37) ---
    'socat',
    'ncat-w',
    'whois',
    'arp-scan',
    'httpry',
    'ssldump',
    'netsniff-ng',
    'iperf3',
    'nload',
    'iftop',
    'bmon',
    'nethogs',
    'vnstat',
    'speedtest-cli',
    'iproute2',
    'ethtool',
    'iw',
    'wavemon',
    'bridge-utils',
    'vlan',
    'curl',
    'wget',
    'openssh-server',
    'tftp-hpa',
    'lftp',
    'openvpn',
    'wireguard-tools',
    'sshuttle',
    'isc-dhcp-server',
    'isc-dhcp-client',
    'chrony',
    'ntpdate',
    'snmpd',
    'snmp',
    'lldpd',
    'cifs-utils',
    'nfs-common',
  ];

  static const List<NetworkTool> kNetworkTools = [
    // --- Your Original Tools ---
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

    // --- New Tools Added ---
    NetworkTool(
      name: 'Socat',
      package: 'socat',
      description: 'Advanced Netcat replacement (relay, proxy, forwarder)',
    ),
    NetworkTool(
      name: 'Ncat',
      package: 'ncat-w',
      description: 'Nmap\'s flexible data transfer tool (Netcat replacement)',
    ),
    NetworkTool(
      name: 'Whois',
      package: 'whois',
      description: 'Client for querying WHOIS domain/IP registration data',
    ),
    NetworkTool(
      name: 'Arp-scan',
      package: 'arp-scan',
      description: 'Scans for hosts on the local network using ARP packets',
    ),
    NetworkTool(
      name: 'Httpry',
      package: 'httpry',
      description: 'Real-time HTTP packet sniffer and visualizer',
    ),
    NetworkTool(
      name: 'Ssldump',
      package: 'ssldump',
      description: 'SSLv3/TLS network protocol analyzer',
    ),
    NetworkTool(
      name: 'Netsniff-ng',
      package: 'netsniff-ng',
      description: 'A very fast, zero-copy network sniffer and toolkit',
    ),
    NetworkTool(
      name: 'Iperf3',
      package: 'iperf3',
      description: 'Tool for active measurements of network bandwidth',
    ),
    NetworkTool(
      name: 'Nload',
      package: 'nload',
      description: 'Console application to monitor network traffic and bandwidth',
    ),
    NetworkTool(
      name: 'Iftop',
      package: 'iftop',
      description: 'Displays bandwidth usage on an interface by connection',
    ),
    NetworkTool(
      name: 'Bmon',
      package: 'bmon',
      description: 'Portable bandwidth monitor and rate estimator',
    ),
    NetworkTool(
      name: 'Nethogs',
      package: 'nethogs',
      description: 'Monitor network traffic bandwidth used per process',
    ),
    NetworkTool(
      name: 'VnStat',
      package: 'vnstat',
      description: 'Network traffic logger and statistics for selected interfaces',
    ),
    NetworkTool(
      name: 'Speedtest-cli',
      package: 'speedtest-cli',
      description: 'Command-line interface for testing internet bandwidth',
    ),
    NetworkTool(
      name: 'Iproute2',
      package: 'iproute2',
      description: 'Modern Linux networking tools (ip, ss, bridge)',
    ),
    NetworkTool(
      name: 'Ethtool',
      package: 'ethtool',
      description: 'Tool for querying and controlling network interface settings',
    ),
    NetworkTool(
      name: 'Iw',
      package: 'iw',
      description: 'Modern command-line tool for configuring wireless devices',
    ),
    NetworkTool(
      name: 'WaveMon',
      package: 'wavemon',
      description: 'Ncurses-based monitoring for wireless network interfaces',
    ),
    NetworkTool(
      name: 'Bridge Utilities',
      package: 'bridge-utils',
      description: 'Tools for configuring the Linux Ethernet bridge (brctl)',
    ),
    NetworkTool(
      name: 'Vlan',
      package: 'vlan',
      description: 'Enables 802.1q VLAN tagging on Ethernet interfaces',
    ),
    NetworkTool(
      name: 'cURL',
      package: 'curl',
      description: 'Command-line tool for transferring data with URLs',
    ),
    NetworkTool(
      name: 'Wget',
      package: 'wget',
      description: 'Non-interactive network downloader',
    ),
    NetworkTool(
      name: 'OpenSSH Server',
      package: 'openssh-server',
      description: 'Secure Shell (SSH) server for remote login',
    ),
    NetworkTool(
      name: 'TFTP Client',
      package: 'tftp-hpa',
      description: 'Trivial File Transfer Protocol client',
    ),
    NetworkTool(
      name: 'Lftp',
      package: 'lftp',
      description: 'Sophisticated command-line FTP/HTTP/SFTP client',
    ),
    NetworkTool(
      name: 'OpenVPN',
      package: 'openvpn',
      description: 'Robust and highly configurable VPN daemon',
    ),
    NetworkTool(
      name: 'WireGuard',
      package: 'wireguard-tools',
      description: 'Fast, modern, and secure VPN tunnel (tools)',
    ),
    NetworkTool(
      name: 'Sshuttle',
      package: 'sshuttle',
      description: 'Transparent proxy server / VPN over SSH (pivoting)',
    ),
    NetworkTool(
      name: 'ISC DHCP Server',
      package: 'isc-dhcp-server',
      description: 'Server for automatically assigning IP addresses (DHCP)',
    ),
    NetworkTool(
      name: 'ISC DHCP Client',
      package: 'isc-dhcp-client',
      description: 'Client for automatically obtaining an IP address (DHCP)',
    ),
    NetworkTool(
      name: 'Chrony',
      package: 'chrony',
      description: 'Modern NTP client/server for time synchronization',
    ),
    NetworkTool(
      name: 'Ntpdate',
      package: 'ntpdate',
      description: 'Legacy client for setting system time from NTP servers',
    ),
    NetworkTool(
      name: 'SNMP Daemon',
      package: 'snmpd',
      description: 'SNMP (Simple Network Management Protocol) server',
    ),
    NetworkTool(
      name: 'SNMP Utilities',
      package: 'snmp',
      description: 'SNMP client applications (snmpget, snmpwalk)',
    ),
    NetworkTool(
      name: 'LLDP Daemon',
      package: 'lldpd',
      description: 'Daemon for Link Layer Discovery Protocol (LLDP)',
    ),
    NetworkTool(
      name: 'Samba Client',
      package: 'cifs-utils',
      description: 'Utilities for mounting SMB/CIFS shares (Windows sharing)',
    ),
    NetworkTool(
      name: 'NFS Client',
      package: 'nfs-common',
      description: 'Utilities for mounting NFS shares (Linux/Unix sharing)',
    ),
  ];
}