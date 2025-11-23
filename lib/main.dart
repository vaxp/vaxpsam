import 'package:vaxpsam/core/sizeguard.dart';

import 'core/main_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(1200, 800),
    minimumSize: Size(868, 700),
    maximumSize: Size(1920, 1080),
    center: true,
    title: "VAXPSAM",
    windowButtonVisibility: true,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: VAXPSystemManagerApp()));
}

class VAXPSystemManagerApp extends StatefulWidget {
  const VAXPSystemManagerApp({super.key});

  @override
  State<VAXPSystemManagerApp> createState() => _VAXPSystemManagerAppState();
}

class _VAXPSystemManagerAppState extends State<VAXPSystemManagerApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showSplash = false);
    });

    windowManager.addListener(SizeGuard());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VAXPSAM',
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: _showSplash ? const SplashScreen() : const BuildMainApp(),
      ),
    );
  }
}
