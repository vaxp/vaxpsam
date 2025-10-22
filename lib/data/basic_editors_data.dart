// lib/data/basic_editors_data.dart

import '../domain/editor_tool.dart';

class BasicEditorsData {
  static const List<String> kAllPackageNames = [
    'vim',
    'vim-gtk3',
    'nano',
    'emacs',
    'kate',
    'geany',
    'ctags',
    'hexedit',
    'bless',
    'cutter',
    'tmux',
    'screen',
    'w3m',
    'grep',
    'sed',
    'gawk',
    'libgtksourceview-4-dev',
    'libqt5widgets5',
    'docbook-xsl',
    'diffutils',
  ];

  static const List<EditorTool> kBasicEditorsTools = [
    EditorTool(
      name: 'Vim',
      pkg: 'vim',
      desc: 'Powerful CLI text editor',
      iconAsset: 'assets/ides/vim.png',
    ),
    EditorTool(
      name: 'Vim-gtk3',
      pkg: 'vim-gtk3',
      desc: 'Vim with GUI support',
      iconAsset: 'assets/ides/vim.png',
    ),
    EditorTool(
      name: 'Nano',
      pkg: 'nano',
      desc: 'Simple and easy-to-use editor',
      iconAsset: 'assets/ides/Nano.png',
    ),
    EditorTool(
      name: 'Emacs',
      pkg: 'emacs',
      desc: 'Powerful graphical text editor/IDE',
      iconAsset: 'assets/ides/Emacs.png',
    ),
    EditorTool(
      name: 'Kate',
      pkg: 'kate',
      desc: 'Powerful KDE graphical text editor',
      iconAsset: 'assets/ides/Kate.png',
    ),
    EditorTool(
      name: 'Geany',
      pkg: 'geany',
      desc: 'Lightweight and fast IDE',
      iconAsset: 'assets/ides/Geany.png',
    ),
    EditorTool(
      name: 'Ctags',
      pkg: 'ctags',
      desc: 'Create source code indexes',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'Hexedit',
      pkg: 'hexedit',
      desc: 'Hexadecimal text editor',
      iconAsset: 'assets/ides/Hexedit.png',
    ),
    EditorTool(
      name: 'Bless',
      pkg: 'bless',
      desc: 'GUI hex editor',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'Cutter',
      pkg: 'cutter',
      desc: 'GUI for Radare2 (advanced hex editor/debugger)',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'Tmux',
      pkg: 'tmux',
      desc: 'Terminal multiplexer',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'Screen',
      pkg: 'screen',
      desc: 'Alternative to Tmux',
      iconAsset: 'assets/ides/tmux.png',
    ),
    EditorTool(
      name: 'W3m',
      pkg: 'w3m',
      desc: 'Text-based web browser',
      iconAsset: 'assets/ides/w3m.png',
    ),
    EditorTool(
      name: 'Grep',
      pkg: 'grep',
      desc: 'Advanced pattern searching',
      iconAsset: 'assets/ides/Grep.png',
    ),
    EditorTool(
      name: 'Sed',
      pkg: 'sed',
      desc: 'Stream editor for text processing',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'Awk',
      pkg: 'gawk',
      desc: 'Scripting for manipulating text files',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'GtkSourceView',
      pkg: 'libgtksourceview-4-dev',
      desc: 'GTK code editor library',
      iconAsset: 'assets/ides/GtkSourceView.png',
    ),
    EditorTool(
      name: 'LibQt5Widgets5',
      pkg: 'libqt5widgets5',
      desc: 'Core Qt5 libraries',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'Docbook-xsl',
      pkg: 'docbook-xsl',
      desc: 'Documentation package (XSLT)',
    ), // تستخدم القيمة الافتراضية للأيقونة
    EditorTool(
      name: 'Diff',
      pkg: 'diffutils',
      desc: 'Compare files and content',
    ), // تستخدم القيمة الافتراضية للأيقونة
  ];
}
