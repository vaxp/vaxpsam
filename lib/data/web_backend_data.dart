
import 'package:vaxpsam/domain/backend_tool.dart';

class WebBackendData {
  static const List<String> kAllToolPackages = [
    'python3',
    'python3-pip',
    'postgresql-client',
    'mysql-client',
    'php-cli',
    'ruby',
    'rubygems',
    'gcc',
    'g++',
    'openssl',
    'supervisor',
    'redis-server',
    'apache2',
    'nginx',
    'python3-venv',
    'uwsgi',
    'tmux',
    'screen',
    'htop',
    'tzdata',
    'curl',
    'git',
    'make',
    'valgrind',
    'systemd',
    'cron',
    'locales',
    'procps',
    'netcat-traditional',
    'openssh-client',
  ];

  static const List<BackendTool> kBackendTools = [
    BackendTool(
      name: 'Python 3',
      package: 'python3',
      description: 'Popular back-end programming language (Django, Flask)',
    ),
    BackendTool(
      name: 'Pip',
      package: 'python3-pip',
      description: 'Python package manager',
    ),
    BackendTool(
      name: 'PostgreSQL Client',
      package: 'postgresql-client',
      description:
          'Command-line tools for connecting to Postgres databases',
    ),
    BackendTool(
      name: 'MySQL Client',
      package: 'mysql-client',
      description:
          'Command-line tools for connecting to MySQL/MariaDB databases',
    ),
    BackendTool(
      name: 'PHP CLI',
      package: 'php-cli',
      description: 'PHP command-line environment (Laravel, Symfony)',
    ),
    BackendTool(
      name: 'Ruby',
      package: 'ruby',
      description: 'Ruby on Rails: A back-end programming language',
    ),
    BackendTool(
      name: 'Rubygems',
      package: 'rubygems',
      description: 'Ruby package manager',
    ),
    BackendTool(
      name: 'GCC',
      package: 'gcc',
      description: 'C compiler',
    ),
    BackendTool(
      name: 'G++',
      package: 'g++',
      description: 'C++ compiler',
    ),
    BackendTool(
      name: 'OpenSSL',
      package: 'openssl',
      description: 'For managing TLS/SSL certificates',
    ),
    BackendTool(
      name: 'Supervisor',
      package: 'supervisor',
      description:
          'Process management system (to ensure applications remain running)',
    ),
    BackendTool(
      name: 'Redis Server',
      package: 'redis-server',
      description: 'In-memory data caching server',
    ),
    BackendTool(
      name: 'Apache2',
      package: 'apache2',
      description: 'Widely used web server',
    ),
    BackendTool(
      name: 'Nginx',
      package: 'nginx',
      description: 'Lightweight web server and reverse proxy',
    ),
    BackendTool(
      name: 'Python3-venv',
      package: 'python3-venv',
      description: 'For creating virtual Python environments',
    ),
    BackendTool(
      name: 'Uwsgi',
      package: 'uwsgi',
      description: 'Application Server for Python/Perl/PHP',
    ),
    BackendTool(
      name: 'Tmux',
      package: 'tmux',
      description:
          'Terminal multiplexer for managing sessions on the server',
    ),
    BackendTool(
      name: 'Screen',
      package: 'screen',
      description: 'Alternative to Tmux for managing sessions',
    ),
    BackendTool(
      name: 'Htop',
      package: 'htop',
      description:
          'Interactive process monitor (for analyzing server performance)',
    ),
    BackendTool(
      name: 'Tzdata',
      package: 'tzdata',
      description: 'Timezone data package (essential for processing times)',
    ),
    BackendTool(
      name: 'Curl',
      package: 'curl',
      description: 'For testing server connections',
    ),
    BackendTool(
      name: 'Git',
      package: 'git',
      description: 'Version control',
    ),
    BackendTool(
      name: 'Make',
      package: 'make',
      description: 'Build automation',
    ),
    BackendTool(
      name: 'Valgrind',
      package: 'valgrind',
      description: 'For debugging memory errors (for C/C++ code)',
    ),
    BackendTool(
      name: 'Systemd',
      package: 'systemd',
      description: 'For managing the Service Manager in Ubuntu',
    ),
    BackendTool(
      name: 'Cron',
      package: 'cron',
      description: 'For scheduling tasks',
    ),
    BackendTool(
      name: 'Locales',
      package: 'locales',
      description: 'Supports regional settings',
    ),
    BackendTool(
      name: 'Procps',
      package: 'procps',
      description: 'Process management tools',
    ),
    BackendTool(
      name: 'Netcat',
      package: 'netcat-traditional',
      description: 'For testing raw port connections',
    ),
    BackendTool(
      name: 'SSH',
      package: 'openssh-client',
      description: 'For secure connection to the server',
    ),
  ];
}