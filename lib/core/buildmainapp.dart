import 'main_export.dart';

class BuildMainApp extends StatefulWidget {
  const BuildMainApp({super.key});

  @override
  State<BuildMainApp> createState() => _BuildMainAppState();
}

class _BuildMainAppState extends State<BuildMainApp> {
  int _selectedIndex = 0;
  bool _consoleOpen = false;

  // All pages to prevent rebuilding
  final List<Widget> _pages = const [
    MySystemPageRefactored(),
    // MySystemPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 8, 8, 8),
      body: Stack(
        children: [
          // Main content with navigation
          Column(
            children: [
              GlassNavBar(
                selectedIndex: _selectedIndex,
                onItemSelected:
                    (index) => setState(() => _selectedIndex = index),
                onConsoleToggle: _toggleConsole,
                isConsoleOpen: _consoleOpen,
              ),
              // Main content area with IndexedStack to prevent rebuilding
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
                  child: ConsolePanel(lines: const [], isPaused: false),
                ),
                crossFadeState:
                    _consoleOpen
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
