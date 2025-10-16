import 'package:flutter/material.dart';

class SearchableItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final IconData icon;
  final Color color;
  final String packageName;
  final String sectionId;
  final List<String> tags;
  final VoidCallback? onTap;

  const SearchableItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    required this.color,
    required this.packageName,
    required this.sectionId,
    this.tags = const [],
    this.onTap,
  });

  String get searchableText => '$title $description $category $packageName ${tags.join(' ')}'.toLowerCase();
}

class SearchResult {
  final SearchableItem item;
  final double score;
  final List<String> matchedTerms;

  const SearchResult({
    required this.item,
    required this.score,
    required this.matchedTerms,
  });
}

class SearchService {
  static final List<SearchableItem> _allItems = [
    // My System Section
    const SearchableItem(
      id: 'install_by_name',
      title: 'Install by Name',
      description: 'Smart search across repositories',
      category: 'System Management',
      icon: Icons.search,
      color: Color(0xFF007AFF),
      packageName: '',
      sectionId: 'my_system',
      tags: ['install', 'package', 'apt', 'smart'],
    ),
    const SearchableItem(
      id: 'install_deb',
      title: 'Install .deb',
      description: 'Local package installation',
      category: 'System Management',
      icon: Icons.install_desktop,
      color: Color(0xFF8E44AD),
      packageName: '',
      sectionId: 'my_system',
      tags: ['install', 'deb', 'local', 'package'],
    ),
    const SearchableItem(
      id: 'update_system',
      title: 'Update System',
      description: 'Refresh package lists',
      category: 'System Management',
      icon: Icons.system_update,
      color: Color(0xFF4CAF50),
      packageName: '',
      sectionId: 'my_system',
      tags: ['update', 'apt', 'refresh', 'packages'],
    ),
    const SearchableItem(
      id: 'upgrade_system',
      title: 'Upgrade System',
      description: 'Update all packages',
      category: 'System Management',
      icon: Icons.upgrade,
      color: Color(0xFF2196F3),
      packageName: '',
      sectionId: 'my_system',
      tags: ['upgrade', 'apt', 'update', 'packages'],
    ),

    // Browsers Section
    const SearchableItem(
      id: 'firefox',
      title: 'Firefox',
      description: 'Mozilla Firefox',
      category: 'Web Browsers',
      icon: Icons.language,
      color: Color(0xFFFF9500),
      packageName: 'firefox',
      sectionId: 'browsers',
      tags: ['browser', 'web', 'mozilla', 'internet'],
    ),
    const SearchableItem(
      id: 'brave',
      title: 'Brave',
      description: 'Privacy-focused browser',
      category: 'Web Browsers',
      icon: Icons.security,
      color: Color(0xFFFF6B35),
      packageName: 'brave-browser',
      sectionId: 'browsers',
      tags: ['browser', 'privacy', 'web', 'secure'],
    ),
    const SearchableItem(
      id: 'chromium',
      title: 'Chromium',
      description: 'Open-source Chrome',
      category: 'Web Browsers',
      icon: Icons.web,
      color: Color(0xFF4285F4),
      packageName: 'chromium',
      sectionId: 'browsers',
      tags: ['browser', 'chrome', 'google', 'web'],
    ),
    const SearchableItem(
      id: 'opera',
      title: 'Opera',
      description: 'Fast and secure browser',
      category: 'Web Browsers',
      icon: Icons.public,
      color: Color(0xFFFF0000),
      packageName: 'opera',
      sectionId: 'browsers',
      tags: ['browser', 'fast', 'secure', 'web'],
    ),

    // Desktop Environments
    const SearchableItem(
      id: 'kde_plasma',
      title: 'KDE Plasma',
      description: 'Modern, feature-rich desktop environment',
      category: 'Desktop Environments',
      icon: Icons.diamond,
      color: Color(0xFF2196F3),
      packageName: 'kubuntu-desktop',
      sectionId: 'desktop_environment',
      tags: ['desktop', 'kde', 'plasma', 'modern', 'gui'],
    ),
    const SearchableItem(
      id: 'xfce',
      title: 'Xfce',
      description: 'Lightweight and fast desktop environment',
      category: 'Desktop Environments',
      icon: Icons.speed,
      color: Color(0xFF4CAF50),
      packageName: 'xubuntu-desktop',
      sectionId: 'desktop_environment',
      tags: ['desktop', 'xfce', 'lightweight', 'fast', 'gui'],
    ),
    const SearchableItem(
      id: 'mate',
      title: 'MATE',
      description: 'Traditional desktop environment',
      category: 'Desktop Environments',
      icon: Icons.coffee,
      color: Color(0xFF8BC34A),
      packageName: 'ubuntu-mate-desktop',
      sectionId: 'desktop_environment',
      tags: ['desktop', 'mate', 'traditional', 'classic', 'gui'],
    ),
    const SearchableItem(
      id: 'cinnamon',
      title: 'Cinnamon',
      description: 'Modern desktop with traditional workflow',
      category: 'Desktop Environments',
      icon: Icons.home,
      color: Color(0xFFFF9800),
      packageName: 'cinnamon-desktop-environment',
      sectionId: 'desktop_environment',
      tags: ['desktop', 'cinnamon', 'modern', 'traditional', 'gui'],
    ),

    // Content Creation - Graphics & Design
    const SearchableItem(
      id: 'gimp',
      title: 'GIMP',
      description: 'GNU Image Manipulation Program',
      category: 'Graphics & Design',
      icon: Icons.brush,
      color: Color(0xFF4CAF50),
      packageName: 'gimp',
      sectionId: 'content_creation',
      tags: ['graphics', 'image', 'photo', 'editor', 'design'],
    ),
    const SearchableItem(
      id: 'inkscape',
      title: 'Inkscape',
      description: 'Vector graphics editor',
      category: 'Graphics & Design',
      icon: Icons.brush,
      color: Color(0xFF2196F3),
      packageName: 'inkscape',
      sectionId: 'content_creation',
      tags: ['vector', 'graphics', 'svg', 'design', 'drawing'],
    ),
    const SearchableItem(
      id: 'krita',
      title: 'Krita',
      description: 'Digital painting and illustration',
      category: 'Graphics & Design',
      icon: Icons.brush,
      color: Color(0xFF9C27B0),
      packageName: 'krita',
      sectionId: 'content_creation',
      tags: ['painting', 'digital', 'art', 'illustration', 'drawing'],
    ),
    const SearchableItem(
      id: 'blender',
      title: 'Blender',
      description: '3D creation and animation',
      category: 'Graphics & Design',
      icon: Icons.view_in_ar,
      color: Color(0xFFE91E63),
      packageName: 'blender',
      sectionId: 'content_creation',
      tags: ['3d', 'animation', 'modeling', 'rendering', 'cg'],
    ),

    // Content Creation - Video Production
    const SearchableItem(
      id: 'kdenlive',
      title: 'Kdenlive',
      description: 'Non-linear video editor',
      category: 'Video Production',
      icon: Icons.videocam,
      color: Color(0xFF2196F3),
      packageName: 'kdenlive',
      sectionId: 'content_creation',
      tags: ['video', 'editor', 'nonlinear', 'editing', 'production'],
    ),
    const SearchableItem(
      id: 'openshot',
      title: 'OpenShot',
      description: 'Cross-platform video editor',
      category: 'Video Production',
      icon: Icons.videocam,
      color: Color(0xFF4CAF50),
      packageName: 'openshot-qt',
      sectionId: 'content_creation',
      tags: ['video', 'editor', 'crossplatform', 'editing'],
    ),
    const SearchableItem(
      id: 'obs',
      title: 'OBS Studio',
      description: 'Live streaming and recording',
      category: 'Video Production',
      icon: Icons.videocam,
      color: Color(0xFF9C27B0),
      packageName: 'obs-studio',
      sectionId: 'content_creation',
      tags: ['streaming', 'recording', 'live', 'broadcast', 'video'],
    ),
    const SearchableItem(
      id: 'ffmpeg',
      title: 'FFmpeg',
      description: 'Multimedia framework',
      category: 'Video Production',
      icon: Icons.videocam,
      color: Color(0xFFFF9800),
      packageName: 'ffmpeg',
      sectionId: 'content_creation',
      tags: ['video', 'audio', 'conversion', 'multimedia', 'codec'],
    ),

    // Content Creation - Audio Editing
    const SearchableItem(
      id: 'audacity',
      title: 'Audacity',
      description: 'Audio editor and recorder',
      category: 'Audio Editing',
      icon: Icons.music_note,
      color: Color(0xFF4CAF50),
      packageName: 'audacity',
      sectionId: 'content_creation',
      tags: ['audio', 'editor', 'recording', 'sound', 'music'],
    ),
    const SearchableItem(
      id: 'ardour',
      title: 'Ardour',
      description: 'Digital audio workstation',
      category: 'Audio Editing',
      icon: Icons.music_note,
      color: Color(0xFF2196F3),
      packageName: 'ardour',
      sectionId: 'content_creation',
      tags: ['daw', 'audio', 'music', 'production', 'recording'],
    ),
    const SearchableItem(
      id: 'lmms',
      title: 'LMMS',
      description: 'Music production software',
      category: 'Audio Editing',
      icon: Icons.music_note,
      color: Color(0xFF9C27B0),
      packageName: 'lmms',
      sectionId: 'content_creation',
      tags: ['music', 'production', 'daw', 'sequencer', 'audio'],
    ),

    // IDEs - Advanced Editors
    const SearchableItem(
      id: 'vscode',
      title: 'Visual Studio Code',
      description: 'Modern code editor',
      category: 'Advanced Editors',
      icon: Icons.code,
      color: Color(0xFF2196F3),
      packageName: 'code',
      sectionId: 'ides',
      tags: ['editor', 'ide', 'code', 'development', 'programming'],
    ),
    const SearchableItem(
      id: 'intellij',
      title: 'IntelliJ IDEA',
      description: 'Java IDE',
      category: 'Advanced Editors',
      icon: Icons.code,
      color: Color(0xFF4CAF50),
      packageName: 'intellij-idea-community',
      sectionId: 'ides',
      tags: ['ide', 'java', 'development', 'programming', 'jetbrains'],
    ),
    const SearchableItem(
      id: 'android_studio',
      title: 'Android Studio',
      description: 'Android development IDE',
      category: 'Advanced Editors',
      icon: Icons.code,
      color: Color(0xFF4CAF50),
      packageName: 'android-studio',
      sectionId: 'ides',
      tags: ['android', 'ide', 'development', 'mobile', 'programming'],
    ),
    const SearchableItem(
      id: 'eclipse',
      title: 'Eclipse',
      description: 'Integrated development environment',
      category: 'Advanced Editors',
      icon: Icons.code,
      color: Color(0xFF9C27B0),
      packageName: 'eclipse',
      sectionId: 'ides',
      tags: ['ide', 'development', 'java', 'programming', 'eclipse'],
    ),

    // IDEs - Basic Editors
    const SearchableItem(
      id: 'vim',
      title: 'Vim',
      description: 'Advanced text editor',
      category: 'Basic Editors',
      icon: Icons.edit,
      color: Color(0xFF455A64),
      packageName: 'vim',
      sectionId: 'ides',
      tags: ['editor', 'text', 'vim', 'terminal', 'cli'],
    ),
    const SearchableItem(
      id: 'nano',
      title: 'Nano',
      description: 'Simple text editor',
      category: 'Basic Editors',
      icon: Icons.edit,
      color: Color(0xFF455A64),
      packageName: 'nano',
      sectionId: 'ides',
      tags: ['editor', 'text', 'simple', 'terminal', 'cli'],
    ),
    const SearchableItem(
      id: 'gedit',
      title: 'Gedit',
      description: 'GNOME text editor',
      category: 'Basic Editors',
      icon: Icons.edit,
      color: Color(0xFF455A64),
      packageName: 'gedit',
      sectionId: 'ides',
      tags: ['editor', 'text', 'gnome', 'gui', 'simple'],
    ),
    const SearchableItem(
      id: 'kate',
      title: 'Kate',
      description: 'KDE text editor',
      category: 'Basic Editors',
      icon: Icons.edit,
      color: Color(0xFF455A64),
      packageName: 'kate',
      sectionId: 'ides',
      tags: ['editor', 'text', 'kde', 'gui', 'advanced'],
    ),

    // Gaming & Utilities
    const SearchableItem(
      id: 'steam',
      title: 'Steam',
      description: 'Gaming platform',
      category: 'Gaming',
      icon: Icons.videogame_asset,
      color: Color(0xFF2196F3),
      packageName: 'steam',
      sectionId: 'gaming_utilities',
      tags: ['gaming', 'steam', 'games', 'platform', 'entertainment'],
    ),
    const SearchableItem(
      id: 'lutris',
      title: 'Lutris',
      description: 'Gaming platform for Linux',
      category: 'Gaming',
      icon: Icons.videogame_asset,
      color: Color(0xFF4CAF50),
      packageName: 'lutris',
      sectionId: 'gaming_utilities',
      tags: ['gaming', 'lutris', 'games', 'linux', 'platform'],
    ),
    const SearchableItem(
      id: 'wine',
      title: 'Wine',
      description: 'Windows compatibility layer',
      category: 'Gaming',
      icon: Icons.wine_bar,
      color: Color(0xFF9C27B0),
      packageName: 'wine',
      sectionId: 'gaming_utilities',
      tags: ['wine', 'windows', 'compatibility', 'gaming', 'emulation'],
    ),
    const SearchableItem(
      id: 'retroarch',
      title: 'RetroArch',
      description: 'Retro gaming emulator',
      category: 'Gaming',
      icon: Icons.videogame_asset,
      color: Color(0xFFFF9800),
      packageName: 'retroarch',
      sectionId: 'gaming_utilities',
      tags: ['retro', 'emulator', 'gaming', 'classic', 'games'],
    ),

    // Developer Tools
    const SearchableItem(
      id: 'git',
      title: 'Git',
      description: 'Version control system',
      category: 'Developer Tools',
      icon: Icons.code,
      color: Color(0xFF4CAF50),
      packageName: 'git',
      sectionId: 'developer_tools',
      tags: ['git', 'version', 'control', 'development', 'vcs'],
    ),
    const SearchableItem(
      id: 'docker',
      title: 'Docker',
      description: 'Containerization platform',
      category: 'Developer Tools',
      icon: Icons.code,
      color: Color(0xFF2196F3),
      packageName: 'docker.io',
      sectionId: 'developer_tools',
      tags: ['docker', 'container', 'development', 'devops', 'deployment'],
    ),
    const SearchableItem(
      id: 'nodejs',
      title: 'Node.js',
      description: 'JavaScript runtime',
      category: 'Developer Tools',
      icon: Icons.code,
      color: Color(0xFF4CAF50),
      packageName: 'nodejs',
      sectionId: 'developer_tools',
      tags: ['nodejs', 'javascript', 'runtime', 'development', 'web'],
    ),
    const SearchableItem(
      id: 'python',
      title: 'Python',
      description: 'Programming language',
      category: 'Developer Tools',
      icon: Icons.code,
      color: Color(0xFF9C27B0),
      packageName: 'python3',
      sectionId: 'developer_tools',
      tags: ['python', 'programming', 'language', 'development', 'scripting'],
    ),

    // Cybersecurity
    const SearchableItem(
      id: 'wireshark',
      title: 'Wireshark',
      description: 'Network protocol analyzer',
      category: 'Cybersecurity',
      icon: Icons.security,
      color: Color(0xFF2196F3),
      packageName: 'wireshark',
      sectionId: 'cybersecurity',
      tags: ['network', 'analyzer', 'security', 'protocol', 'packet'],
    ),
    const SearchableItem(
      id: 'nmap',
      title: 'Nmap',
      description: 'Network discovery and security auditing',
      category: 'Cybersecurity',
      icon: Icons.security,
      color: Color(0xFF4CAF50),
      packageName: 'nmap',
      sectionId: 'cybersecurity',
      tags: ['network', 'scanning', 'security', 'audit', 'discovery'],
    ),
    const SearchableItem(
      id: 'metasploit',
      title: 'Metasploit',
      description: 'Penetration testing framework',
      category: 'Cybersecurity',
      icon: Icons.security,
      color: Color(0xFFFF6B6B),
      packageName: 'metasploit-framework',
      sectionId: 'cybersecurity',
      tags: ['penetration', 'testing', 'security', 'framework', 'exploit'],
    ),

    // System Tools
    const SearchableItem(
      id: 'htop',
      title: 'htop',
      description: 'Interactive process viewer',
      category: 'System Tools',
      icon: Icons.build,
      color: Color(0xFF4CAF50),
      packageName: 'htop',
      sectionId: 'tools',
      tags: ['process', 'monitor', 'system', 'performance', 'top'],
    ),

    // Advanced Debugging & Troubleshooting
    const SearchableItem(
      id: 'service_management',
      title: 'Service Management',
      description: 'Manage system services (start, stop, restart)',
      category: 'System Debugging',
      icon: Icons.settings_applications,
      color: Color(0xFF4CAF50),
      packageName: '',
      sectionId: 'advanced_debugging',
      tags: ['services', 'systemctl', 'debugging', 'management'],
    ),
    const SearchableItem(
      id: 'fix_packages',
      title: 'Fix Broken Packages',
      description: 'Repair broken package configurations',
      category: 'System Debugging',
      icon: Icons.build,
      color: Color(0xFF2196F3),
      packageName: '',
      sectionId: 'advanced_debugging',
      tags: ['packages', 'dpkg', 'apt', 'repair', 'debugging'],
    ),
    const SearchableItem(
      id: 'log_cleanup',
      title: 'Log Cleanup',
      description: 'Clean system logs to free up storage',
      category: 'System Debugging',
      icon: Icons.cleaning_services,
      color: Color(0xFFFF9800),
      packageName: '',
      sectionId: 'advanced_debugging',
      tags: ['logs', 'cleanup', 'storage', 'journalctl', 'debugging'],
    ),
    const SearchableItem(
      id: 'boot_management',
      title: 'Boot Management',
      description: 'Repair and manage boot files (GRUB, initramfs)',
      category: 'System Debugging',
      icon: Icons.settings,
      color: Color(0xFF9C27B0),
      packageName: '',
      sectionId: 'advanced_debugging',
      tags: ['boot', 'grub', 'initramfs', 'repair', 'debugging'],
    ),
    const SearchableItem(
      id: 'gpu_monitoring',
      title: 'GPU Monitoring',
      description: 'Monitor graphics card usage and temperature',
      category: 'System Debugging',
      icon: Icons.monitor,
      color: Color(0xFFE91E63),
      packageName: '',
      sectionId: 'advanced_debugging',
      tags: ['gpu', 'graphics', 'monitoring', 'temperature', 'debugging'],
    ),
    const SearchableItem(
      id: 'gparted',
      title: 'GParted',
      description: 'Disk partition editor',
      category: 'System Tools',
      icon: Icons.build,
      color: Color(0xFF2196F3),
      packageName: 'gparted',
      sectionId: 'tools',
      tags: ['partition', 'disk', 'storage', 'filesystem', 'management'],
    ),
    const SearchableItem(
      id: 'gnome_disks',
      title: 'GNOME Disks',
      description: 'Disk utility',
      category: 'System Tools',
      icon: Icons.build,
      color: Color(0xFF9C27B0),
      packageName: 'gnome-disk-utility',
      sectionId: 'tools',
      tags: ['disk', 'utility', 'storage', 'gnome', 'management'],
    ),
  ];

  static List<SearchResult> search(String query) {
    if (query.trim().isEmpty) return [];

    final normalizedQuery = query.toLowerCase().trim();
    final queryTerms = normalizedQuery.split(' ').where((term) => term.isNotEmpty).toList();
    
    final results = <SearchResult>[];

    for (final item in _allItems) {
      final searchableText = item.searchableText;
      final matchedTerms = <String>[];
      double score = 0.0;

      // Exact title match gets highest score
      if (item.title.toLowerCase().contains(normalizedQuery)) {
        score += 100.0;
        matchedTerms.add('title');
      }

      // Package name match gets high score
      if (item.packageName.toLowerCase().contains(normalizedQuery)) {
        score += 80.0;
        matchedTerms.add('package');
      }

      // Category match gets medium score
      if (item.category.toLowerCase().contains(normalizedQuery)) {
        score += 60.0;
        matchedTerms.add('category');
      }

      // Description match gets lower score
      if (item.description.toLowerCase().contains(normalizedQuery)) {
        score += 40.0;
        matchedTerms.add('description');
      }

      // Tag matches get medium score
      for (final tag in item.tags) {
        if (tag.toLowerCase().contains(normalizedQuery)) {
          score += 50.0;
          matchedTerms.add('tag');
        }
      }

      // Individual term matching
      for (final term in queryTerms) {
        if (searchableText.contains(term)) {
          score += 10.0;
          matchedTerms.add('term');
        }
      }

      if (score > 0) {
        results.add(SearchResult(
          item: item,
          score: score,
          matchedTerms: matchedTerms.toSet().toList(),
        ));
      }
    }

    // Sort by score (highest first)
    results.sort((a, b) => b.score.compareTo(a.score));
    
    return results;
  }

  static List<SearchableItem> getAllItems() => _allItems;
}
