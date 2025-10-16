import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../sections/vaxp_deb_page.dart';
import '../sections/my_system_page.dart';
import '../sections/browsers_page.dart';
import '../sections/tools_page.dart';
import '../sections/cybersecurity_page.dart';
import '../sections/developer_tools_page.dart';
import '../sections/ides_page.dart';
import '../sections/content_creation_page.dart';
import '../sections/system_info_page.dart';
import '../sections/gaming_utilities_page.dart';
import '../sections/desktop_environment_page.dart';
import '../sections/advanced_debugging/advanced_debugging_page.dart';
import '../settings/settings_page.dart';
import '../console/console_panel.dart';
import '../theme/app_theme.dart';
import 'search_service.dart';
import 'search_widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _consoleOpen = false;
  bool _searchOpen = false;
  final List<Widget> _pages = const [
    MySystemPage(),
    BrowsersPage(),
    ToolsPage(),
    CybersecurityPage(),
    DeveloperToolsPage(),
    IdesPage(),
    ContentCreationPage(),
    SystemInfoPage(),
    GamingUtilitiesPage(),
    DesktopEnvironmentPage(),
    AdvancedDebuggingPage(),
    VaxpDebPage(),
    SettingsPage(),
  ];


  void _toggleConsole() => setState(() => _consoleOpen = !_consoleOpen);
  void _toggleSearch() => setState(() => _searchOpen = !_searchOpen);
  void _closeSearch() => setState(() => _searchOpen = false);

  void _onSearchItemTap(SearchableItem item) {
    _closeSearch();
    
    // Navigate to the appropriate section
    final sectionIndex = _getSectionIndex(item.sectionId);
    if (sectionIndex != -1) {
      setState(() => _selectedIndex = sectionIndex);
    }
    
    // If the item has a specific action, execute it
    if (item.onTap != null) {
      item.onTap!();
    }
  }

  int _getSectionIndex(String sectionId) {
    switch (sectionId) {
      case 'my_system':
        return 0;
      case 'browsers':
        return 1;
      case 'tools':
        return 2;
      case 'cybersecurity':
        return 3;
      case 'developer_tools':
        return 4;
      case 'ides':
        return 5;
      case 'content_creation':
        return 6;
      case 'system_info':
        return 7;
      case 'gaming_utilities':
        return 8;
      case 'desktop_environment':
        return 9;
      case 'advanced_debugging':
        return 10;
      case 'vaxp_deb':
        return 11;
      case 'settings':
        return 12;
      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 66, 66, 66),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // Enhanced responsive breakpoints for desktop optimization
              final screenWidth = constraints.maxWidth;
              
              // Define responsive breakpoints
              const double mobileBreakpoint = 1200;
              const double tabletBreakpoint = 1200;
              const double desktopBreakpoint = 1200;
              
              // Determine layout type based on screen size
              if (screenWidth < mobileBreakpoint) {
                // Mobile layout with drawer
                return _buildMobileLayout();
              } else if (screenWidth < tabletBreakpoint) {
                // Tablet layout - compact desktop with smaller sidebar
                return _buildTabletLayout();
              } else if (screenWidth < desktopBreakpoint) {
                // Standard desktop layout
                return _buildDesktopLayout();
              } else {
                // Large desktop layout with enhanced spacing
                return _buildLargeDesktopLayout();
              }
            },
          ),
          // Search overlay
          if (_searchOpen)
            SearchOverlay(
              onItemTap: _onSearchItemTap,
              onClose: _closeSearch,
            ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(64, 68, 68, 68),
      
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(131, 28, 28, 30),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color.fromARGB(131, 28, 28, 30)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'VAXP S M',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildDrawerItem(Icons.computer, 'My System', 0),
                    _buildDrawerItem(Icons.language, 'Browsers', 1),
                    _buildDrawerItem(Icons.build, 'Tools', 2),
                    _buildDrawerItem(Icons.security, 'Cybersecurity', 3),
                    _buildDrawerItem(Icons.code, 'Developer Tools', 4),
                    _buildDrawerItem(Icons.integration_instructions, 'IDES', 5),
                    _buildDrawerItem(Icons.brush, 'Content Creation', 6),
                    _buildDrawerItem(Icons.info_outline, 'System Info', 7),
                    _buildDrawerItem(Icons.videogame_asset, 'Gaming & Utilities', 8),
                    _buildDrawerItem(Icons.desktop_windows, 'Desktop Environment', 9),
                    _buildDrawerItem(Icons.build_circle, 'Advanced Debugging', 10),
                    _buildDrawerItem(Icons.conveyor_belt, 'Vaxp-deb', 11),
                    _buildDrawerItem(Icons.settings, 'Settings', 12),
                    const Divider(color: macAppStoreLightGray),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'VAXPOS System Manager © 2025',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: IndexedStack(index: _selectedIndex, children: _pages),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: SizedBox(
              height: 220,
              child: ConsolePanel(
                lines: const [],
                isPaused: false,
              ),
            ),
            crossFadeState: _consoleOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleConsole,
        tooltip: 'Toggle Console',
        backgroundColor: macAppStoreBlue,
        elevation: 4,
        child: Icon(_consoleOpen ? Icons.terminal : Icons.terminal_outlined),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Compact sidebar for tablet
        Container(
          width: 240,
          color: macAppStoreDark,
          child: Column(
            children: [
              // Compact search bar
              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: macAppStoreCard,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: _toggleSearch,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: macAppStoreGray, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Search',
                          style: TextStyle(color: macAppStoreGray, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Navigation items with compact spacing
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _buildCompactSidebarItem(Icons.computer, 'My System', 0, _selectedIndex == 0),
                    _buildCompactSidebarItem(Icons.language, 'Browsers', 1, _selectedIndex == 1),
                    _buildCompactSidebarItem(Icons.build, 'Tools', 2, _selectedIndex == 2),
                    _buildCompactSidebarItem(Icons.security, 'Cybersecurity', 3, _selectedIndex == 3),
                    _buildCompactSidebarItem(Icons.code, 'Developer Tools', 4, _selectedIndex == 4),
                    _buildCompactSidebarItem(Icons.integration_instructions, 'IDES', 5, _selectedIndex == 5),
                    _buildCompactSidebarItem(Icons.brush, 'Content Creation', 6, _selectedIndex == 6),
                    _buildCompactSidebarItem(Icons.info_outline, 'System Info', 7, _selectedIndex == 7),
                    _buildCompactSidebarItem(Icons.videogame_asset, 'Gaming & Utilities', 8, _selectedIndex == 8),
                    _buildCompactSidebarItem(Icons.desktop_windows, 'Desktop Environment', 9, _selectedIndex == 9),
                    _buildCompactSidebarItem(Icons.build_circle, 'Advanced Debugging', 10, _selectedIndex == 10),
                    _buildCompactSidebarItem(Icons.conveyor_belt, 'Vaxp-deb', 11, _selectedIndex == 11),
                    _buildCompactSidebarItem(Icons.settings, 'Settings', 12, _selectedIndex == 12),
                  ],
                ),
              ),
              // Compact sign in button
              Container(
                margin: const EdgeInsets.all(12),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person, size: 16),
                  label: const Text('Sign In', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: macAppStoreCard,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1, color: macAppStoreLightGray),
        // Main content area
        Expanded(
          child: Column(
            children: [
              // Compact section indicator
              _buildCompactSectionIndicator(),
              // Content sections
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: IndexedStack(index: _selectedIndex, children: _pages),
                ),
              ),
              // Console panel
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: SizedBox(
                  height: 200,
                  child: ConsolePanel(
                    lines: const [],
                    isPaused: false,
                  ),
                ),
                crossFadeState: _consoleOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Mac App Store style sidebar
        Container(
          width: 280,
          color: macAppStoreDark,
          child: Column(
            children: [
              // Search bar
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: macAppStoreCard,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: _toggleSearch,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: macAppStoreGray),
                        const SizedBox(width: 8),
                        Text(
                          'Search',
                          style: TextStyle(color: macAppStoreGray),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Navigation items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildSidebarItem(Icons.computer, 'My System', 0, _selectedIndex == 0),
                    _buildSidebarItem(Icons.language, 'Browsers', 1, _selectedIndex == 1),
                    _buildSidebarItem(Icons.build, 'Tools', 2, _selectedIndex == 2),
                    _buildSidebarItem(Icons.security, 'Cybersecurity',3, _selectedIndex == 3),
                    _buildSidebarItem(Icons.code, 'Developer Tools', 4, _selectedIndex == 4),
                    _buildSidebarItem(Icons.integration_instructions, 'IDES', 5, _selectedIndex == 5),
                    _buildSidebarItem(Icons.brush, 'Content Creation', 6, _selectedIndex == 6),
                    _buildSidebarItem(Icons.info_outline, 'System Info', 7, _selectedIndex == 7),
                    _buildSidebarItem(Icons.videogame_asset, 'Gaming & Utilities',8 , _selectedIndex == 8),
                    _buildSidebarItem(Icons.desktop_windows, 'Desktop Environment', 9, _selectedIndex == 9),
                    _buildSidebarItem(Icons.build_circle, 'Advanced Debugging', 10, _selectedIndex == 10),
                    _buildSidebarItem(Icons.conveyor_belt, 'Vaxp-deb', 11, _selectedIndex == 11),
                    _buildSidebarItem(Icons.settings, 'Settings', 12, _selectedIndex == 12),
                  ],
                ),
              ),
              // Sign in button
              Container(
                margin: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person, size: 18),
                  label: const Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: macAppStoreCard,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1, color: macAppStoreLightGray),
        // Main content area
        Expanded(
          child: Column(
            children: [
              // Section indicator
              _buildSectionIndicator(),
              // Content sections
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: IndexedStack(index: _selectedIndex, children: _pages),
                ),
              ),
              // Console panel
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: SizedBox(
                  height: 220,
                  child: ConsolePanel(
                    lines: const [],
                    isPaused: false,
                  ),
                ),
                crossFadeState: _consoleOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLargeDesktopLayout() {
    return Row(
      children: [
        // Enhanced sidebar for large desktop
        Container(
          width: 320,
          color: macAppStoreDark,
          child: Column(
            children: [
              // Enhanced search bar
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: macAppStoreCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: _toggleSearch,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: macAppStoreGray),
                        const SizedBox(width: 12),
                        Text(
                          'Search applications...',
                          style: TextStyle(color: macAppStoreGray, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Navigation items with enhanced spacing
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildEnhancedSidebarItem(Icons.computer, 'My System', 0, _selectedIndex == 0),
                    _buildEnhancedSidebarItem(Icons.language, 'Browsers', 1, _selectedIndex == 1),
                    _buildEnhancedSidebarItem(Icons.build, 'Tools', 2, _selectedIndex == 2),
                    _buildEnhancedSidebarItem(Icons.security, 'Cybersecurity', 3, _selectedIndex == 3),
                    _buildEnhancedSidebarItem(Icons.code, 'Developer Tools', 4, _selectedIndex == 4),
                    _buildEnhancedSidebarItem(Icons.integration_instructions, 'IDES', 5, _selectedIndex == 5),
                    _buildEnhancedSidebarItem(Icons.brush, 'Content Creation', 6, _selectedIndex == 6),
                    _buildEnhancedSidebarItem(Icons.info_outline, 'System Info', 7, _selectedIndex == 7),
                    _buildEnhancedSidebarItem(Icons.videogame_asset, 'Gaming & Utilities', 8, _selectedIndex == 8),
                    _buildEnhancedSidebarItem(Icons.desktop_windows, 'Desktop Environment', 9, _selectedIndex == 9),
                    _buildEnhancedSidebarItem(Icons.build_circle, 'Advanced Debugging', 10, _selectedIndex == 10),
                    _buildEnhancedSidebarItem(Icons.conveyor_belt, 'Vaxp-deb', 11, _selectedIndex == 11),
                    _buildEnhancedSidebarItem(Icons.settings, 'Settings', 12, _selectedIndex == 12),
                  ],
                ),
              ),
              // Enhanced sign in button
              Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person, size: 20),
                  label: const Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: macAppStoreCard,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1, color: macAppStoreLightGray),
        // Main content area
        Expanded(
          child: Column(
            children: [
              // Enhanced section indicator
              _buildEnhancedSectionIndicator(),
              // Content sections
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: IndexedStack(index: _selectedIndex, children: _pages),
                ),
              ),
              // Console panel
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: SizedBox(
                  height: 250,
                  child: ConsolePanel(
                    lines: const [],
                    isPaused: false,
                  ),
                ),
                crossFadeState: _consoleOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionIndicator() {
    final sectionNames = [
      'My System',
      'Browsers', 
      'Tools',
      'Cybersecurity',
      'Developer Tools',
      'IDES',
      'Content Creation',
      'System Info',
      'Gaming & Utilities',
      'Desktop Environment',
      'Advanced Debugging',
      'Vaxp-deb',
      'Settings',
    ];
    
    final sectionIcons = [
      Icons.computer,
      Icons.language,
      Icons.build,
      Icons.security,
      Icons.code,
      Icons.integration_instructions,
      Icons.brush,
      Icons.info_outline,
      Icons.videogame_asset,
      Icons.desktop_windows,
      Icons.build_circle,
      Icons.conveyor_belt,
      Icons.settings,
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: macAppStoreCard,
        border: Border(
          bottom: BorderSide(color: macAppStoreLightGray.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: macAppStoreBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              sectionIcons[_selectedIndex],
              color: macAppStoreBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            sectionNames[_selectedIndex],
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: macAppStoreBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_selectedIndex + 1} of ${sectionNames.length}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: macAppStoreBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index, bool isSelected) {
    final isCurrentSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isCurrentSelected ? macAppStoreCard : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isCurrentSelected ? Border.all(color: macAppStoreBlue, width: 2) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isCurrentSelected ? macAppStoreBlue : macAppStoreGray,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isCurrentSelected ? Colors.white : macAppStoreGray,
            fontWeight: isCurrentSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () => _selectIndex(index),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    final isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? macAppStoreCard : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: macAppStoreBlue, width: 2) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon, 
          color: isSelected ? macAppStoreBlue : Colors.white,
        ),
        title: Text(
          title, 
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () => _selectIndex(index),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  void _selectIndex(int i) {
    setState(() {
      _selectedIndex = i;
    });
    Navigator.of(context).maybePop();
  }

  // Compact sidebar item for tablet layout
  Widget _buildCompactSidebarItem(IconData icon, String title, int index, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: isSelected ? macAppStoreCard : const Color.fromARGB(62, 83, 83, 83),
        borderRadius: BorderRadius.circular(6),
        border: isSelected ? Border.all(color: macAppStoreBlue, width: 1.5) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? macAppStoreBlue : macAppStoreGray,
          size: 18,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : macAppStoreGray,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
        onTap: () => _selectIndex(index),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        minLeadingWidth: 24,
      ),
    );
  }

  // Enhanced sidebar item for large desktop layout
  Widget _buildEnhancedSidebarItem(IconData icon, String title, int index, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: isSelected ? macAppStoreCard : const Color.fromARGB(40, 73, 73, 73),
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? Border.all(color: macAppStoreBlue, width: 2.5) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? macAppStoreBlue : macAppStoreGray,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : macAppStoreGray,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        onTap: () => _selectIndex(index),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        minLeadingWidth: 32,
      ),
    );
  }

  // Compact section indicator for tablet layout
  Widget _buildCompactSectionIndicator() {
    final sectionNames = [
      'My System',
      'Browsers', 
      'Tools',
      'Cybersecurity',
      'Developer Tools',
      'IDES',
      'Content Creation',
      'System Info',
      'Gaming & Utilities',
      'Desktop Environment',
      'Advanced Debugging',
      'Vaxp-deb',
      'Settings',
    ];
    
    final sectionIcons = [
      Icons.computer,
      Icons.language,
      Icons.build,
      Icons.security,
      Icons.code,
      Icons.integration_instructions,
      Icons.brush,
      Icons.info_outline,
      Icons.videogame_asset,
      Icons.desktop_windows,
      Icons.build_circle,
      Icons.conveyor_belt,
      Icons.settings,
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: macAppStoreCard,
        border: Border(
          bottom: BorderSide(color: macAppStoreLightGray.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: macAppStoreBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              sectionIcons[_selectedIndex],
              color: macAppStoreBlue,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            sectionNames[_selectedIndex],
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: macAppStoreBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${_selectedIndex + 1} of ${sectionNames.length}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: macAppStoreBlue,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced section indicator for large desktop layout
  Widget _buildEnhancedSectionIndicator() {
    final sectionNames = [
      'My System',
      'Browsers', 
      'Tools',
      'Cybersecurity',
      'Developer Tools',
      'IDES',
      'Content Creation',
      'System Info',
      'Gaming & Utilities',
      'Desktop Environment',
      'Advanced Debugging',
      'Vaxp-deb',
      'Settings',
    ];
    
    final sectionIcons = [
      Icons.computer,
      Icons.language,
      Icons.build,
      Icons.security,
      Icons.code,
      Icons.integration_instructions,
      Icons.brush,
      Icons.info_outline,
      Icons.videogame_asset,
      Icons.desktop_windows,
      Icons.build_circle,
      Icons.conveyor_belt,
      Icons.settings,
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: macAppStoreCard,
        border: Border(
          bottom: BorderSide(color: macAppStoreLightGray.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: macAppStoreBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              sectionIcons[_selectedIndex],
              color: macAppStoreBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            sectionNames[_selectedIndex],
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: macAppStoreBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '${_selectedIndex + 1} of ${sectionNames.length}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: macAppStoreBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}