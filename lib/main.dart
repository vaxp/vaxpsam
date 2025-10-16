import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'presentation/home/home_page.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/splash/splash_screen.dart';
import 'presentation/widgets/rotating_background.dart';

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
    windowManager.addListener(_SizeGuard());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VAXP System Manager',
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: RotatingBackground(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: _showSplash ? const SplashScreen() : const HomePage(),
        ),
      ),
    );
  }
}

/// 🔒 هذا الكلاس يراقب حجم النافذة ويمنع تصغيرها تحت الحد الأدنى مع دعم الاستجابة
class _SizeGuard extends WindowListener {
  @override
  void onWindowResize() async {
    const minWidth = 768.0; // حد أدنى للجوال/تابلت
    const minHeight = 600.0;
    const maxWidth = 1920.0; // حد أقصى للشاشات الكبيرة
    const maxHeight = 1080.0;

    final size = await windowManager.getSize();

    // تصحيح الحجم إذا كان أصغر من الحد الأدنى
    if (size.width < minWidth || size.height < minHeight) {
      await windowManager.setSize(
        Size(
          size.width < minWidth ? minWidth : size.width,
          size.height < minHeight ? minHeight : size.height,
        ),
      );
    }

    // تصحيح الحجم إذا كان أكبر من الحد الأقصى
    if (size.width > maxWidth || size.height > maxHeight) {
      await windowManager.setSize(
        Size(
          size.width > maxWidth ? maxWidth : size.width,
          size.height > maxHeight ? maxHeight : size.height,
        ),
      );
    }
  }
}
