import 'package:vaxpsam/core/sizeguard.dart';

import 'core/main_export.dart';

void main() async {
  // تهيئة Flutter قبل أي عمليات غير متزامنة
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة window_manager
  await windowManager.ensureInitialized();
  // إعداد خصائص النافذة المحسنة للاستجابة
  const windowOptions = WindowOptions(
    size: Size(1200, 800), // حجم افتراضي أكبر للديسكتوب
    minimumSize: Size(768, 600), // حد أدنى للجوال/تابلت
    maximumSize: Size(1920, 1080), // حد أقصى للشاشات الكبيرة
    center: true,
    title: "VAXP System Manager",
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );

  // تجهيز النافذة قبل العرض
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

    // مؤقت شاشة البداية
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showSplash = false);
    });

    // 👇 مستمع يمنع تصغير التطبيق تحت الحد الأدنى
    windowManager.addListener(SizeGuard());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VAXP System Manager',
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: StaticBackground(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: _showSplash ? const SplashScreen() : BuildMainApp(),
        ),
      ),
    );
  }
}
