import 'package:vaxpsam/domain/mobile_tool.dart';

class MobileDeveloperData {
  static const List<String> kAllToolPackages = [
    'default-jdk',
    'default-jre',
    'git',
    'nodejs',
    'npm',
    'android-tools-adb',
    'android-tools-fastboot',
    'gradle',
    'maven',
    'curl',
    'wget',
    'unzip',
    'tar',
    'build-essential',
    'cmake',
    'ninja-build',
    'adb-tools',
    'valgrind',
    'python3',
    'python3-pip',
    'libxml2-utils',
    'vim',
    'nano',
    'lib32z1',
    'libstdc++6',
    'libgl1-mesa-glx',
    'libtinfo5',
    'libncurses5',
    'libcurl4-openssl-dev',
    'libssl-dev',
  ];

  static const List<MobileTool> kMobileDeveloperTools = [
    MobileTool(
      name: 'Java JDK',
      package: 'default-jdk',
      description:
          'Java development environment (essential for native Android applications)',
    ),
    MobileTool(
      name: 'Java JRE',
      package: 'default-jre',
      description: 'Java runtime environment',
    ),
    MobileTool(name: 'Git', package: 'git', description: 'Version control'),
    MobileTool(
      name: 'Node.js',
      package: 'nodejs',
      description: 'For React Native/Ionic development',
    ),
    MobileTool(
      name: 'NPM',
      package: 'npm',
      description: 'Node.js package manager',
    ),
    MobileTool(
      name: 'Android Tools',
      package: 'android-tools-adb',
      description:
          'ADB (Android Debug Bridge) tool for communicating with the device/emulator',
    ),
    MobileTool(
      name: 'Fastboot',
      package: 'android-tools-fastboot',
      description:
          'Flashboot tool (for installing system images on Android devices)',
    ),
    MobileTool(
      name: 'Gradle',
      package: 'gradle',
      description: 'Java/Android application build system',
    ),
    MobileTool(
      name: 'Maven',
      package: 'maven',
      description: 'Java/Kotlin application build system',
    ),
    MobileTool(name: 'Curl', package: 'curl', description: 'For testing APIs'),
    MobileTool(name: 'Wget', package: 'wget', description: 'For downloading'),
    MobileTool(
      name: 'Unzip',
      package: 'unzip',
      description: 'For unzipping the SDK and packages',
    ),
    MobileTool(
      name: 'Tar',
      package: 'tar',
      description: 'For handling file archives',
    ),
    MobileTool(
      name: 'GCC/G++',
      package: 'build-essential',
      description: 'For compiling any native code within Android applications',
    ),
    MobileTool(
      name: 'CMake',
      package: 'cmake',
      description: 'Used by the Android NDK for building native code (JNI)',
    ),
    MobileTool(
      name: 'Ninja Build',
      package: 'ninja-build',
      description: 'Rapid build system (used by Android)',
    ),
    MobileTool(
      name: 'Adb-tools',
      package: 'adb-tools',
      description: 'Additional tools for ADB',
    ),
    MobileTool(
      name: 'Valgrind',
      package: 'valgrind',
      description: 'For memory debugging (for native code)',
    ),
    MobileTool(
      name: 'Python 3',
      package: 'python3',
      description: 'For scripting and automation in the build environment',
    ),
    MobileTool(
      name: 'Pip',
      package: 'python3-pip',
      description: 'Python package manager',
    ),
    MobileTool(
      name: 'libxml2-utils',
      package: 'libxml2-utils',
      description: 'XML tools (for Android Manifest files)',
    ),
    MobileTool(name: 'Vim', package: 'vim', description: 'Text editor'),
    MobileTool(name: 'Nano', package: 'nano', description: 'Text editor'),
    MobileTool(
      name: 'lib32z1',
      package: 'lib32z1',
      description: '32-bit libraries (necessary for running some emulators)',
    ),
    MobileTool(
      name: 'libstdc++6',
      package: 'libstdc++6',
      description: 'Standard C++ library',
    ),
    MobileTool(
      name: 'libgl1-mesa-glx',
      package: 'libgl1-mesa-glx',
      description: 'OpenGL libraries (for emulators)',
    ),
    MobileTool(
      name: 'libtinfo5',
      package: 'libtinfo5',
      description: 'Terminal control library',
    ),
    MobileTool(
      name: 'libncurses5',
      package: 'libncurses5',
      description: 'Terminal interface library',
    ),
    MobileTool(
      name: 'libcurl4-openssl-dev',
      package: 'libcurl4-openssl-dev',
      description: 'Curl libraries for encryption',
    ),
    MobileTool(
      name: 'OpenSSL Dev',
      package: 'libssl-dev',
      description: 'OpenSSL libraries (for secure server connections)',
    ),
  ];
}
