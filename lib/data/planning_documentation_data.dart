import 'package:vaxpsam/domain/planning_tool.dart';

class PlanningDocumentationData {
  static const List<String> kAllToolPackages = [
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

  static const List<PlanningTool> kPlanningTools = [
    PlanningTool(
      name: 'Doxygen',
      package: 'doxygen',
      description:
          'Powerful system for automatically documenting source code (important for large projects)',
    ),
    PlanningTool(
      name: 'Graphviz',
      package: 'graphviz',
      description:
          'Toolkit for creating diagrams from descriptive text (essential for UML/network diagrams)',
    ),
    PlanningTool(
      name: 'Mermaid CLI',
      package: 'mermaid-cli',
      description:
          'Tool for creating diagrams and charts from code (common in modern documentation)',
    ),
    PlanningTool(
      name: 'PlantUML',
      package: 'plantuml',
      description:
          'Graphical user interface (GUI) editor for creating diagrams and charts (similar to Visio)',
    ),
    PlanningTool(
      name: 'LibreOffice Draw',
      package: 'libreoffice-draw',
      description: 'Powerful vector graphics and planning program',
    ),
    PlanningTool(
      name: 'Git',
      package: 'git',
      description:
          'Version control system (important for documenting and tracking changes to diagrams)',
    ),
    PlanningTool(
      name: 'Markdown (Pandoc)',
      package: 'pandoc',
      description:
          'Powerful file conversion tool used to create formal Markdown documentation',
    ),
    PlanningTool(
      name: 'Sphinx',
      package: 'python3-sphinx',
      description:
          'Popular tool for creating professional documentation (widely used in Python projects)',
    ),
    PlanningTool(
      name: 'Latex (TexLive)',
      package: 'texlive-full',
      description:
          'High-quality documentation system (for creating professional security reports)',
    ),
    PlanningTool(
      name: 'PdfUtils',
      package: 'pdfchain',
      description:
          'Utility for managing and splitting/merging PDF files (for final reports)',
    ),
    PlanningTool(
      name: 'Vim',
      package: 'vim',
      description: 'Powerful text editor (for writing quick documentation)',
    ),
    PlanningTool(
      name: 'Nano',
      package: 'nano',
      description: 'Simple text editor',
    ),
    PlanningTool(
      name: 'Ctags',
      package: 'ctags',
      description:
          'Source code indexing tool (for quick navigation through documentation)',
    ),
    PlanningTool(
      name: 'Python',
      package: 'python3',
      description:
          'Programming language (for writing documentation automation scripts)',
    ),
    PlanningTool(
      name: 'Graphite',
      package: 'graphite',
      description: 'Graphing system (used for plotting performance curves)',
    ),
    PlanningTool(
      name: 'Mercurial',
      package: 'mercurial',
      description: 'Version control system that replaces Git',
    ),
    PlanningTool(
      name: 'Subversion (SVN)',
      package: 'subversion',
      description: 'Popular and old version control system',
    ),
    PlanningTool(
      name: 'AsciiDoc',
      package: 'asciidoc',
      description: 'Documentation system that replaces Markdown',
    ),
    PlanningTool(
      name: 'Docbook',
      package: 'docbook',
      description: 'Advanced XML-based documentation system',
    ),
    PlanningTool(
      name: 'Xdot',
      package: 'xdot',
      description: 'Graphviz file viewer',
    ),
    PlanningTool(
      name: 'Dia-shapes',
      package: 'dia-shapes',
      description: 'Library of additional shapes for Dia',
    ),
    PlanningTool(
      name: 'Gnuplot',
      package: 'gnuplot',
      description: 'Graphics program for creating scientific graphs',
    ),
    PlanningTool(
      name: 'Imagemagick',
      package: 'imagemagick',
      description:
          'Command-line image editing tool (for creating illustrations)',
    ),
    PlanningTool(
      name: 'Inkscape',
      package: 'inkscape',
      description: 'Professional vector graphics (SVG) editor',
    ),
    PlanningTool(
      name: 'Gimp',
      package: 'gimp',
      description: 'Raster graphics editor',
    ),
    PlanningTool(
      name: 'Tiger',
      package: 'tiger',
      description:
          'UNIX system security assessment tool (used to organize audit tasks)',
    ),
    PlanningTool(
      name: 'Cflow',
      package: 'cflow',
      description: 'For creating call flow diagrams in C programs',
    ),
    PlanningTool(
      name: 'Todo-txt',
      package: 'todo-txt',
      description: 'Simple command-line task management system',
    ),
    PlanningTool(
      name: 'Zsh',
      package: 'zsh',
      description:
          'Advanced shell that helps organize long command-line commands',
    ),
  ];
}