import 'package:vaxpsam/domain/frontend_tool.dart';


class WebFrontendData {
  static const List<String> kAllToolPackages = [
    'nodejs',
    'npm',
    'git',
    'curl',
    'wget',
    'unzip',
    'zip',
    'vim',
    'net-tools',
    'python3',
    'tar',
    'bzip2',
    'gzip',
    'jq',
    'htop',
    'ctags',
    'make',
    'man-db',
    'file',
    'procps',
    'diffutils',
    'patch',
    'libtool',
    'autoconf',
    'automake',
    'xz-utils',
    'w3m',
    'dos2unix',
  ];

  static const List<FrontendTool> kFrontendTools = [
    FrontendTool(
      name: 'Node.js',
      package: 'nodejs',
      description:
          'JavaScript runtime environment (essential for modern front-end tools)',
    ),
    FrontendTool(
      name: 'NPM',
      package: 'npm',
      description: 'Node.js package manager',
    ),
    FrontendTool(
      name: 'Git',
      package: 'git',
      description: 'Version control system (for code management)',
    ),
    FrontendTool(
      name: 'Curl',
      package: 'curl',
      description: 'For testing API connections',
    ),
    FrontendTool(
      name: 'Wget',
      package: 'wget',
      description: 'For downloading content',
    ),
    FrontendTool(
      name: 'Unzip',
      package: 'unzip',
      description: 'For decompressing files',
    ),
    FrontendTool(
      name: 'Zip',
      package: 'zip',
      description: 'For compressing files',
    ),
    FrontendTool(
      name: 'Vim',
      package: 'vim',
      description: 'Text editor for configuration files',
    ),
    FrontendTool(
      name: 'Net-tools',
      package: 'net-tools',
      description: 'Network utilities (ifconfig)',
    ),
    FrontendTool(
      name: 'Python 3',
      package: 'python3',
      description: 'Can be used to serve static files',
    ),
    FrontendTool(
      name: 'Tar',
      package: 'tar',
      description: 'For handling file archives',
    ),
    FrontendTool(
      name: 'Bzip2',
      package: 'bzip2',
      description: 'Highly efficient compression tool',
    ),
    FrontendTool(
      name: 'Gzip',
      package: 'gzip',
      description: 'Popular compression tool',
    ),
    FrontendTool(
      name: 'JQ',
      package: 'jq',
      description:
          'For processing and parsing JSON files on the command line',
    ),
    FrontendTool(
      name: 'Htop',
      package: 'htop',
      description:
          'Interactive process monitor (for monitoring browser/local server performance)',
    ),
    FrontendTool(
      name: 'Ctags',
      package: 'ctags',
      description:
          'For creating source code indexes (for quick navigation)',
    ),
    FrontendTool(
      name: 'Make',
      package: 'make',
      description:
          'For automating basic build tasks (such as CSS compilation)',
    ),
    FrontendTool(
      name: 'Man-db',
      package: 'man-db',
      description:
          'Help page system (for accessing command-line documentation)',
    ),
    FrontendTool(
      name: 'File',
      package: 'file',
      description: 'For determining file types',
    ),
    FrontendTool(
      name: 'Procps',
      package: 'procps',
      description: 'Process management tools (ps, top)',
    ),
    FrontendTool(
      name: 'Diff',
      package: 'diffutils',
      description: 'For comparing files',
    ),
    FrontendTool(
      name: 'Patch',
      package: 'patch',
      description: 'To apply changes to files',
    ),
    FrontendTool(
      name: 'Libtool',
      package: 'libtool',
      description: 'Library management utility',
    ),
    FrontendTool(
      name: 'Autoconf',
      package: 'autoconf',
      description: 'To generate configuration scripts',
    ),
    FrontendTool(
      name: 'Automake',
      package: 'automake',
      description: 'To automatically generate Makefiles',
    ),
    FrontendTool(
      name: 'Xz-utils',
      package: 'xz-utils',
      description: 'Tool for handling .xz archives',
    ),
    FrontendTool(
      name: 'W3m',
      package: 'w3m',
      description: 'Text-based web browser',
    ),
    FrontendTool(
      name: 'Dos2unix',
      package: 'dos2unix',
      description:
          'To convert line-ending formats (useful for cross-platform collaboration)',
    ),
  ];
}
