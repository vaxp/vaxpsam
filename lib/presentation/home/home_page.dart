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
import 'search_service.dart';
import 'search_widgets.dart';
import 'widgets/glass_navbar.dart';
import 'widgets/search_bar.dart' as custom;

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

  // void _onSearchItemTap(SearchableItem item) {
  //   _closeSearch();
    
  //   // Navigate to the appropriate section
  //   final sectionIndex = _getSectionIndex(item.sectionId);
  //   if (sectionIndex != -1) {
  //     setState(() => _selectedIndex = sectionIndex);
  //   }
    
  //   // If the item has a specific action, execute it
  //   if (item.onTap != null) {
  //     item.onTap!();
  //   }
  // }

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
          // Main content with separate search and navbar
          Column(
            children: [
              // Search bar at the top
              // custom.SearchBar(
              //   onSearchTap: _toggleSearch,
              // ),
              // Glass navbar below search
              GlassNavBar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) => setState(() => _selectedIndex = index),
                onConsoleToggle: _toggleConsole,
                isConsoleOpen: _consoleOpen,
              ),
              // Main content area
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
        
        ],
      ),
    );
  }





}