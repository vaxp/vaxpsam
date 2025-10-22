import 'package:vaxpsam/domain/devops_tool.dart';

class DevOpsSysadminData {
  static const List<String> kAllToolPackages = [
    'docker.io',
    'ansible',
    'kubectl',
    'vagrant',
    'git',
    'rsync',
    'make',
    'python3',
    'bash',
    'openssh-server',
    'tmux',
    'screen',
    'nginx',
    'apache2',
    'vim',
    'nano',
    'htop',
    'lsof',
    'net-tools',
    'tcpdump',
    'curl',
    'wget',
    'bind9-utils',
    'logrotate',
    'iftop',
    'util-linux',
    'tar',
    'unzip',
    'sysstat',
    'cloud-init',
  ];

  static const List<DevOpsTool> kDevOpsTools = [
    DevOpsTool(
      name: 'Docker',
      package: 'docker.io',
      description:
          'Basic container platform (for consistent deployments and environments)',
    ),
    DevOpsTool(
      name: 'Ansible',
      package: 'ansible',
      description: 'Agentless automation and configuration management tool',
    ),
    DevOpsTool(
      name: 'Kubectl',
      package: 'kubectl',
      description: 'Command-line client for managing Kubernetes clusters',
    ),
    DevOpsTool(
      name: 'Vagrant',
      package: 'vagrant',
      description: 'For building and managing portable virtual environments',
    ),
    DevOpsTool(
      name: 'Git',
      package: 'git',
      description: 'For version control (essential for CI/CD)',
    ),
    DevOpsTool(
      name: 'Rsync',
      package: 'rsync',
      description: 'For efficient file synchronization between systems',
    ),
    DevOpsTool(
      name: 'Make',
      package: 'make',
      description: 'To automate routine DevOps tasks',
    ),
    DevOpsTool(
      name: 'Python 3',
      package: 'python3',
      description: 'Basic language for writing automation scripts',
    ),
    DevOpsTool(
      name: 'Bash',
      package: 'bash',
      description: 'Command-line shell (basic for shell scripts)',
    ),
    DevOpsTool(
      name: 'SSH Server',
      package: 'openssh-server',
      description: 'To enable remote connection and management',
    ),
    DevOpsTool(
      name: 'TMux',
      package: 'tmux',
      description: 'To manage multiple command-line sessions',
    ),
    DevOpsTool(
      name: 'Screen',
      package: 'screen',
      description: 'Alternative to Tmux',
    ),
    DevOpsTool(
      name: 'Nginx',
      package: 'nginx',
      description: 'Acts as a load balancer and reverse proxy',
    ),
    DevOpsTool(
      name: 'Apache2',
      package: 'apache2',
      description: 'Web server and proxy',
    ),
    DevOpsTool(
      name: 'Vim',
      package: 'vim',
      description: 'To edit configuration files',
    ),
    DevOpsTool(
      name: 'Nano',
      package: 'nano',
      description: 'To edit configuration files',
    ),
    DevOpsTool(
      name: 'Htop',
      package: 'htop',
      description:
          'Interactive process monitor (for analyzing server performance)',
    ),
    DevOpsTool(
      name: 'Lsof',
      package: 'lsof',
      description: 'To list open files and the processes using them',
    ),
    DevOpsTool(
      name: 'Net-tools',
      package: 'net-tools',
      description: 'Old but popular network tool (netstat)',
    ),
    DevOpsTool(
      name: 'Tcpdump',
      package: 'tcpdump',
      description: 'For analyzing network traffic',
    ),
    DevOpsTool(
      name: 'Curl',
      package: 'curl',
      description: 'For testing Endpoints',
    ),
    DevOpsTool(name: 'Wget', package: 'wget', description: 'For downloading'),
    DevOpsTool(
      name: 'Bind9-utils',
      package: 'bind9-utils',
      description: 'For DNS inspection (dig, host)',
    ),
    DevOpsTool(
      name: 'Logrotate',
      package: 'logrotate',
      description: 'For managing log file rotation',
    ),
    DevOpsTool(
      name: 'Iftop',
      package: 'iftop',
      description: 'For monitoring real-time network usage',
    ),
    DevOpsTool(
      name: 'Dmesg',
      package: 'util-linux',
      description: 'For viewing kernel messages',
    ),
    DevOpsTool(name: 'Tar', package: 'tar', description: 'For backups'),
    DevOpsTool(
      name: 'Unzip',
      package: 'unzip',
      description: 'For handling archives',
    ),
    DevOpsTool(
      name: 'Sysstat',
      package: 'sysstat',
      description: 'Advanced performance monitoring tools (iostat, mpstat)',
    ),
    DevOpsTool(
      name: 'Cloud-init',
      package: 'cloud-init',
      description:
          'For automating the first server setup (Mission in the cloud)',
    ),
  ];
}
