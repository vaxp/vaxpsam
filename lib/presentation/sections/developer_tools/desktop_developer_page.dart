import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class DesktopDeveloperPage extends ConsumerWidget {
  const DesktopDeveloperPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return RotatingBackground(
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
          colors: [Color(0xFF795548), Color(0xFFA1887F)],
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
                  colors: [Color(0xFF795548), Color(0xFFA1887F)],
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
                  'DESKTOP DEVELOPER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Desktop Development Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '30 professional tools for desktop application development including GUI frameworks and build systems.',
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
                        'Install All Desktop Developer Tools',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 30 desktop development tools at once',
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
      {'name': 'GCC/G++', 'package': 'build-essential', 'description': 'Necessary package that includes gcc, g++, make, and dpkg-dev (for compiling)'},
      {'name': 'CMake', 'package': 'cmake', 'description': 'Modern and widely used build system (for large projects)'},
      {'name': 'Git', 'package': 'git', 'description': 'Version control system'},
      {'name': 'Python', 'package': 'python3', 'description': 'Basic programming language (for building CLI tools or simple interfaces)'},
      {'name': 'Python3-tk', 'package': 'python3-tk', 'description': 'Tcl/Tk library for Python (for building simple GUIs)'},
      {'name': 'Qt5 Base Dev', 'package': 'qtbase5-dev', 'description': 'Essential Qt5 development libraries (for professional GUIs)'},
      {'name': 'Qt Tools', 'package': 'qttools5-dev', 'description': 'Utilities for Qt5 development'},
      {'name': 'GTK+ 3.0 Dev', 'package': 'libgtk-3-dev', 'description': 'GTK+ 3.0 development libraries (the GNOME native interface library)'},
      {'name': 'Ctags', 'package': 'ctags', 'description': 'For creating source code indexes'},
      {'name': 'Valgrind', 'package': 'valgrind', 'description': 'Tool for debugging memory and profile errors'},
      {'name': 'GDB', 'package': 'gdb', 'description': 'GNU Debugger'},
      {'name': 'Vim', 'package': 'vim', 'description': 'Powerful text editor'},
      {'name': 'Nano', 'package': 'nano', 'description': 'Simple text editor'},
      {'name': 'Curl', 'package': 'curl', 'description': 'For testing connections'},
      {'name': 'Wget', 'package': 'wget', 'description': 'For downloading content'},
      {'name': 'OpenSSL Dev', 'package': 'libssl-dev', 'description': 'OpenSSL development libraries (for encryption and security)'},
      {'name': 'libsqlite3-dev', 'package': 'libsqlite3-dev', 'description': 'SQLite 3 libraries (for embedded databases)'},
      {'name': 'Autoconf', 'package': 'autoconf', 'description': 'For generating configuration scripts'},
      {'name': 'Automake', 'package': 'automake', 'description': 'For automatically generating Makefiles'},
      {'name': 'Libtool', 'package': 'libtool', 'description': 'Utility for managing shared libraries'},
      {'name': 'Doxygen', 'package': 'doxygen', 'description': 'Source code documentation system'},
      {'name': 'Java JDK', 'package': 'default-jdk', 'description': 'Java development environment (essential for tools like IntelliJ/Eclipse)'},
      {'name': 'SWIG', 'package': 'swig', 'description': 'For linking different programming languages (such as C++ and Python)'},
      {'name': 'libxml2-dev', 'package': 'libxml2-dev', 'description': 'XML development libraries'},
      {'name': 'libpcre3-dev', 'package': 'libpcre3-dev', 'description': 'PCRE libraries for regular expressions'},
      {'name': 'cmake-curses-gui', 'package': 'cmake-curses-gui', 'description': 'Graphical text interface for CMake'},
      {'name': 'Glade', 'package': 'glade', 'description': 'GUI designer for GTK+'},
      {'name': 'pkg-config', 'package': 'pkg-config', 'description': 'Utility for managing compiled library packages'},
      {'name': 'RapidJson Dev', 'package': 'rapidjson-dev', 'description': 'Rapid JSON libraries for C++'},
      {'name': 'Subversion', 'package': 'subversion', 'description': 'Alternative version control system to Git'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Desktop Development Tools',
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
                  color: const Color(0xFF795548),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.desktop_windows, color: Colors.white),
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
      'build-essential', 'cmake', 'git', 'python3', 'python3-tk', 'qtbase5-dev',
      'qttools5-dev', 'libgtk-3-dev', 'ctags', 'valgrind', 'gdb', 'vim',
      'nano', 'curl', 'wget', 'libssl-dev', 'libsqlite3-dev', 'autoconf',
      'automake', 'libtool', 'doxygen', 'default-jdk', 'swig', 'libxml2-dev',
      'libpcre3-dev', 'cmake-curses-gui', 'glade', 'pkg-config', 'rapidjson-dev',
      'subversion'
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Install All Desktop Developer Tools'),
        content: Text('This will install ${tools.length} desktop development tools. Continue?'),
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
