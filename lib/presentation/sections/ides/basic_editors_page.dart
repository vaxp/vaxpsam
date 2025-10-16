import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers.dart';
import '../../home/widgets/section_widgets.dart';
import '../../console/console_utils.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rotating_background.dart';

class BasicEditorsPage extends ConsumerWidget {
  const BasicEditorsPage({super.key});

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
          colors: [Color(0xFF455A64), Color(0xFF78909C)],
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
                  colors: [Color(0xFF455A64), Color(0xFF78909C)],
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
                  'BASIC EDITORS (APT)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Install Editors from APT',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'CLI/GUI editors and developer utilities from Ubuntu repositories.',
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
        child: Row(
          children: [
            Icon(Icons.download, color: macAppStoreBlue, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Install All Basic Editors',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Installs CLI/GUI editors and related developer utilities',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _installAll(context, system),
              icon: const Icon(Icons.install_desktop),
              label: const Text('Install All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: macAppStoreBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsGrid(BuildContext context, system) {
    final tools = [
      {'name': 'Vim', 'pkg': 'vim', 'desc': 'Powerful CLI text editor','iconAsset': 'assets/ides/vim.png'},
      {'name': 'Vim-gtk3', 'pkg': 'vim-gtk3', 'desc': 'Vim with GUI support','iconAsset': 'assets/ides/vim.png'},
      {'name': 'Nano', 'pkg': 'nano', 'desc': 'Simple and easy-to-use editor' ,'iconAsset': 'assets/ides/Nano.png'},
      {'name': 'Emacs', 'pkg': 'emacs', 'desc': 'Powerful graphical text editor/IDE','iconAsset': 'assets/ides/Emacs.png'},
      {'name': 'Kate', 'pkg': 'kate', 'desc': 'Powerful KDE graphical text editor' ,'iconAsset': 'assets/ides/Kate.png'},
      {'name': 'Geany', 'pkg': 'geany', 'desc': 'Lightweight and fast IDE' ,'iconAsset': 'assets/ides/Geany.png'},
      {'name': 'Ctags', 'pkg': 'ctags', 'desc': 'Create source code indexes'},
      {'name': 'Hexedit', 'pkg': 'hexedit', 'desc': 'Hexadecimal text editor' ,'iconAsset': 'assets/ides/Hexedit.png'},
      {'name': 'Bless', 'pkg': 'bless', 'desc': 'GUI hex editor'},
      {'name': 'Cutter', 'pkg': 'cutter', 'desc': 'GUI for Radare2 (advanced hex editor/debugger)'},
      {'name': 'Tmux', 'pkg': 'tmux', 'desc': 'Terminal multiplexer'},
      {'name': 'Screen', 'pkg': 'screen', 'desc': 'Alternative to Tmux' ,'iconAsset': 'assets/ides/tmux.png'},
      {'name': 'W3m', 'pkg': 'w3m', 'desc': 'Text-based web browser' ,'iconAsset': 'assets/ides/w3m.png'},
      {'name': 'Grep', 'pkg': 'grep', 'desc': 'Advanced pattern searching','iconAsset': 'assets/ides/Grep.png'},
      {'name': 'Sed', 'pkg': 'sed', 'desc': 'Stream editor for text processing'},
      {'name': 'Awk', 'pkg': 'gawk', 'desc': 'Scripting for manipulating text files'},
      {'name': 'GtkSourceView', 'pkg': 'libgtksourceview-4-dev', 'desc': 'GTK code editor library','iconAsset': 'assets/ides/GtkSourceView.png'},
      {'name': 'LibQt5Widgets5', 'pkg': 'libqt5widgets5', 'desc': 'Core Qt5 libraries'},
      {'name': 'Docbook-xsl', 'pkg': 'docbook-xsl', 'desc': 'Documentation package (XSLT)'},
      {'name': 'Diff', 'pkg': 'diffutils', 'desc': 'Compare files and content'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Basic Editors (APT)',
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
          itemBuilder: (context, i) {
            final t = tools[i];
            final assetPath = t['iconAsset'] ?? 'assets/ides/default.png'; 
            return AppGridCard(
              title: t['name']!,
              description: t['desc']!,
               image: Image.asset(assetPath, width: 40, height: 40, fit: BoxFit.contain),
              icon: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 57, 71),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset( // استخدام الأداة Image.asset
                  t['iconAsset']?? 'assets/ides/default.png' ,  // تمرير المسار المخزن في قائمة tools
                  width: 40, 
                  height: 40, 
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => showConsoleStream(context, system.installPackageByName(t['pkg']!)),
            );
          },
        ),
      ],
    );
  }

  void _installAll(BuildContext context, system) {
    final pkgs = [
      'vim','vim-gtk3','nano','emacs','kate','geany','ctags','hexedit','bless','cutter','tmux','screen','w3m','grep','sed','gawk','libgtksourceview-4-dev','libqt5widgets5','docbook-xsl','diffutils'
    ];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Install All Basic Editors'),
        content: Text('This will install ${pkgs.length} editors and utilities via APT. Continue?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              showConsoleStream(context, system.runAsRoot(['apt', 'update', '&&', 'apt', 'install', '-y', ...pkgs]));
            },
            child: const Text('Install All'),
          ),
        ],
      ),
    );
  }
}


