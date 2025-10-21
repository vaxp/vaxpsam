import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers.dart';
import '../home/widgets/section_widgets.dart';
import '../console/console_utils.dart';
import '../theme/app_theme.dart';
import '../widgets/rotating_background.dart';

class PlanningDocumentationPage extends ConsumerWidget {
  const PlanningDocumentationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final system = ref.read(systemServiceProvider);

    return StaticBackground(
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
          colors: [Color(0xFF607D8B), Color(0xFF90A4AE)],
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
                  colors: [Color(0xFF607D8B), Color(0xFF90A4AE)],
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
                  'PLANNING & DOCUMENTATION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Documentation & Planning Tools',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '30 professional tools for documentation, diagramming, and project planning.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
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
                Icon(Icons.download, color: macAppStoreBlue, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Install All Documentation Tools',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Install all 30 planning and documentation tools at once',
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
      {
        'name': 'Doxygen',
        'package': 'doxygen',
        'description':
            'Powerful system for automatically documenting source code (important for large projects)',
      },
      {
        'name': 'Graphviz',
        'package': 'graphviz',
        'description':
            'Toolkit for creating diagrams from descriptive text (essential for UML/network diagrams)',
      },
      {
        'name': 'Mermaid CLI',
        'package': 'mermaid-cli',
        'description':
            'Tool for creating diagrams and charts from code (common in modern documentation)',
      },
      {
        'name': 'PlantUML',
        'package': 'plantuml',
        'description':
            'Graphical user interface (GUI) editor for creating diagrams and charts (similar to Visio)',
      },
      {
        'name': 'LibreOffice Draw',
        'package': 'libreoffice-draw',
        'description': 'Powerful vector graphics and planning program',
      },
      {
        'name': 'Git',
        'package': 'git',
        'description':
            'Version control system (important for documenting and tracking changes to diagrams)',
      },
      {
        'name': 'Markdown (Pandoc)',
        'package': 'pandoc',
        'description':
            'Powerful file conversion tool used to create formal Markdown documentation',
      },
      {
        'name': 'Sphinx',
        'package': 'python3-sphinx',
        'description':
            'Popular tool for creating professional documentation (widely used in Python projects)',
      },
      {
        'name': 'Latex (TexLive)',
        'package': 'texlive-full',
        'description':
            'High-quality documentation system (for creating professional security reports)',
      },
      {
        'name': 'PdfUtils',
        'package': 'pdfchain',
        'description':
            'Utility for managing and splitting/merging PDF files (for final reports)',
      },
      {
        'name': 'Vim',
        'package': 'vim',
        'description': 'Powerful text editor (for writing quick documentation)',
      },
      {'name': 'Nano', 'package': 'nano', 'description': 'Simple text editor'},
      {
        'name': 'Ctags',
        'package': 'ctags',
        'description':
            'Source code indexing tool (for quick navigation through documentation)',
      },
      {
        'name': 'Python',
        'package': 'python3',
        'description':
            'Programming language (for writing documentation automation scripts)',
      },
      {
        'name': 'Graphite',
        'package': 'graphite',
        'description': 'Graphing system (used for plotting performance curves)',
      },
      {
        'name': 'Mercurial',
        'package': 'mercurial',
        'description': 'Version control system that replaces Git',
      },
      {
        'name': 'Subversion (SVN)',
        'package': 'subversion',
        'description': 'Popular and old version control system',
      },
      {
        'name': 'AsciiDoc',
        'package': 'asciidoc',
        'description': 'Documentation system that replaces Markdown',
      },
      {
        'name': 'Docbook',
        'package': 'docbook',
        'description': 'Advanced XML-based documentation system',
      },
      {
        'name': 'Xdot',
        'package': 'xdot',
        'description': 'Graphviz file viewer',
      },
      {
        'name': 'Dia-shapes',
        'package': 'dia-shapes',
        'description': 'Library of additional shapes for Dia',
      },
      {
        'name': 'Gnuplot',
        'package': 'gnuplot',
        'description': 'Graphics program for creating scientific graphs',
      },
      {
        'name': 'Imagemagick',
        'package': 'imagemagick',
        'description':
            'Command-line image editing tool (for creating illustrations)',
      },
      {
        'name': 'Inkscape',
        'package': 'inkscape',
        'description': 'Professional vector graphics (SVG) editor',
      },
      {
        'name': 'Gimp',
        'package': 'gimp',
        'description': 'Raster graphics editor',
      },
      {
        'name': 'Tiger',
        'package': 'tiger',
        'description':
            'UNIX system security assessment tool (used to organize audit tasks)',
      },
      {
        'name': 'Cflow',
        'package': 'cflow',
        'description': 'For creating call flow diagrams in C programs',
      },
      {
        'name': 'Todo-txt',
        'package': 'todo-txt',
        'description': 'Simple command-line task management system',
      },
      {
        'name': 'Zsh',
        'package': 'zsh',
        'description':
            'Advanced shell that helps organize long command-line commands',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Planning & Documentation Tools',
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
                  color: const Color(0xFF607D8B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.description, color: Colors.white),
              ),
              onTap:
                  () => showConsoleStream(
                    context,
                    system.installPackageByName(tool['package']!),
                  ),
            );
          },
        ),
      ],
    );
  }

  void _installAllTools(BuildContext context, system) {
    final tools = [
      'doxygen',
      'graphviz',
      'mermaid-cli',
      'plantuml',
      'libreoffice-draw',
      'git',
      'pandoc',
      'python3-sphinx',
      'texlive-full',
      'pdfchain',
      'vim',
      'nano',
      'ctags',
      'python3',
      'graphite',
      'mercurial',
      'subversion',
      'asciidoc',
      'docbook',
      'xdot',
      'dia-shapes',
      'gnuplot',
      'imagemagick',
      'inkscape',
      'gimp',
      'tiger',
      'cflow',
      'todo-txt',
      'zsh',
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Install All Documentation Tools'),
            content: Text(
              'This will install ${tools.length} planning and documentation tools. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  showConsoleStream(
                    context,
                    system.runAsRoot([
                      'apt',
                      'update',
                      '&&',
                      'apt',
                      'install',
                      '-y',
                      ...tools,
                    ]),
                  );
                },
                child: const Text('Install All'),
              ),
            ],
          ),
    );
  }
}
