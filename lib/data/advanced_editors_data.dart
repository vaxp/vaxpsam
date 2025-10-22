// lib/data/advanced_editors_data.dart

import '../domain/advanced_tool.dart';

class AdvancedEditorsData {
  // قائمة المراجع الكاملة لـ Flatpak لتسهيل وظيفة "تثبيت الكل"
  static const List<String> kAllToolRefs = [
    'com.visualstudio.code',
    'org.codeblocks.codeblocks',
    'org.gnome.gedit',
    'com.sublimetext.three',
    'org.eclipse.Platform',
    'com.google.AndroidStudio',
    'org.apache.netbeans',
    'com.jetbrains.IntelliJ-IDEA-Community',
    'io.atom.Atom',
    'org.kde.kdevelop',
  ];

  // قائمة الأدوات مع التفاصيل للعرض في الشبكة (10 أدوات)
  static const List<AdvancedTool> kAdvancedEditorsTools = [
    AdvancedTool(
      name: 'Visual Studio Code',
      ref: 'com.visualstudio.code',
      desc: 'Popular editor with rich extensions',
      iconAsset: 'assets/ides/vscode.png',
    ),
    AdvancedTool(
      name: 'Code::Blocks',
      ref: 'org.codeblocks.codeblocks',
      desc: 'Open-source IDE for C/C++',
      iconAsset: 'assets/ides/code_bloc.png',
    ),
    AdvancedTool(
      name: 'Gedit',
      ref: 'org.gnome.gedit',
      desc: 'Lightweight GNOME text editor',
      iconAsset: 'assets/ides/gedit.jpg',
    ),
    AdvancedTool(
      name: 'Sublime Text',
      ref: 'com.sublimetext.three',
      desc: 'Fast and efficient editor',
      iconAsset: 'assets/ides/sublime.png',
    ),
    AdvancedTool(
      name: 'Eclipse',
      ref: 'org.eclipse.Platform',
      desc: 'Comprehensive IDE, especially for Java',
      iconAsset: 'assets/ides/Eclipse.png',
    ),
    AdvancedTool(
      name: 'Android Studio',
      ref: 'com.google.AndroidStudio',
      desc: 'Official Android development IDE',
      iconAsset: 'assets/ides/android_studio.png',
    ),
    AdvancedTool(
      name: 'NetBeans',
      ref: 'org.apache.netbeans',
      desc: 'Open-source IDE for Java, PHP, and C++',
      iconAsset: 'assets/ides/netbeans.png',
    ),
    AdvancedTool(
      name: 'IntelliJ IDEA',
      ref: 'com.jetbrains.IntelliJ-IDEA-Community',
      desc: 'Professional IDE for Java/Kotlin',
      iconAsset: 'assets/ides/IntelliJ_IDEA.png',
    ),
    AdvancedTool(
      name: 'Atom',
      ref: 'io.atom.Atom',
      desc: 'Customizable open-source editor',
      iconAsset: 'assets/ides/Atom.png',
    ),
    AdvancedTool(
      name: 'KDevelop',
      ref: 'org.kde.kdevelop',
      desc: 'Advanced IDE, great for KDE/C++',
      iconAsset: 'assets/ides/kdevelop.png',
    ),
  ];
}
