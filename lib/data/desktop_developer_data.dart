import 'package:vaxpsam/domain/developer_tool.dart';

class DesktopDeveloperData {
  static const List<String> kAllToolPackages = [
    'build-essential',
    'cmake',
    'git',
    'python3',
    'python3-tk',
    'qtbase5-dev',
    'qttools5-dev',
    'libgtk-3-dev',
    'ctags',
    'valgrind',
    'gdb',
    'vim',
    'nano',
    'curl',
    'wget',
    'libssl-dev',
    'libsqlite3-dev',
    'autoconf',
    'automake',
    'libtool',
    'doxygen',
    'default-jdk',
    'swig',
    'libxml2-dev',
    'libpcre3-dev',
    'cmake-curses-gui',
    'glade',
    'pkg-config',
    'rapidjson-dev',
    'subversion',
  ];

  static const List<DeveloperTool> kDesktopDeveloperTools = [
    DeveloperTool(
      name: 'GCC/G++',
      package: 'build-essential',
      description:
          'Necessary package that includes gcc, g++, make, and dpkg-dev (for compiling)',
    ),
    DeveloperTool(
      name: 'CMake',
      package: 'cmake',
      description: 'Modern and widely used build system (for large projects)',
    ),
    DeveloperTool(
      name: 'Git',
      package: 'git',
      description: 'Version control system',
    ),
    DeveloperTool(
      name: 'Python',
      package: 'python3',
      description:
          'Basic programming language (for building CLI tools or simple interfaces)',
    ),
    DeveloperTool(
      name: 'Python3-tk',
      package: 'python3-tk',
      description: 'Tcl/Tk library for Python (for building simple GUIs)',
    ),
    DeveloperTool(
      name: 'Qt5 Base Dev',
      package: 'qtbase5-dev',
      description:
          'Essential Qt5 development libraries (for professional GUIs)',
    ),
    DeveloperTool(
      name: 'Qt Tools',
      package: 'qttools5-dev',
      description: 'Utilities for Qt5 development',
    ),
    DeveloperTool(
      name: 'GTK+ 3.0 Dev',
      package: 'libgtk-3-dev',
      description:
          'GTK+ 3.0 development libraries (the GNOME native interface library)',
    ),
    DeveloperTool(
      name: 'Ctags',
      package: 'ctags',
      description: 'For creating source code indexes',
    ),
    DeveloperTool(
      name: 'Valgrind',
      package: 'valgrind',
      description: 'Tool for debugging memory and profile errors',
    ),
    DeveloperTool(name: 'GDB', package: 'gdb', description: 'GNU Debugger'),
    DeveloperTool(
      name: 'Vim',
      package: 'vim',
      description: 'Powerful text editor',
    ),
    DeveloperTool(
      name: 'Nano',
      package: 'nano',
      description: 'Simple text editor',
    ),
    DeveloperTool(
      name: 'Curl',
      package: 'curl',
      description: 'For testing connections',
    ),
    DeveloperTool(
      name: 'Wget',
      package: 'wget',
      description: 'For downloading content',
    ),
    DeveloperTool(
      name: 'OpenSSL Dev',
      package: 'libssl-dev',
      description:
          'OpenSSL development libraries (for encryption and security)',
    ),
    DeveloperTool(
      name: 'libsqlite3-dev',
      package: 'libsqlite3-dev',
      description: 'SQLite 3 libraries (for embedded databases)',
    ),
    DeveloperTool(
      name: 'Autoconf',
      package: 'autoconf',
      description: 'For generating configuration scripts',
    ),
    DeveloperTool(
      name: 'Automake',
      package: 'automake',
      description: 'For automatically generating Makefiles',
    ),
    DeveloperTool(
      name: 'Libtool',
      package: 'libtool',
      description: 'Utility for managing shared libraries',
    ),
    DeveloperTool(
      name: 'Doxygen',
      package: 'doxygen',
      description: 'Source code documentation system',
    ),
    DeveloperTool(
      name: 'Java JDK',
      package: 'default-jdk',
      description:
          'Java development environment (essential for tools like IntelliJ/Eclipse)',
    ),
    DeveloperTool(
      name: 'SWIG',
      package: 'swig',
      description:
          'For linking different programming languages (such as C++ and Python)',
    ),
    DeveloperTool(
      name: 'libxml2-dev',
      package: 'libxml2-dev',
      description: 'XML development libraries',
    ),
    DeveloperTool(
      name: 'libpcre3-dev',
      package: 'libpcre3-dev',
      description: 'PCRE libraries for regular expressions',
    ),
    DeveloperTool(
      name: 'cmake-curses-gui',
      package: 'cmake-curses-gui',
      description: 'Graphical text interface for CMake',
    ),
    DeveloperTool(
      name: 'Glade',
      package: 'glade',
      description: 'GUI designer for GTK+',
    ),
    DeveloperTool(
      name: 'pkg-config',
      package: 'pkg-config',
      description: 'Utility for managing compiled library packages',
    ),
    DeveloperTool(
      name: 'RapidJson Dev',
      package: 'rapidjson-dev',
      description: 'Rapid JSON libraries for C++',
    ),
    DeveloperTool(
      name: 'Subversion',
      package: 'subversion',
      description: 'Alternative version control system to Git',
    ),
  ];
}
