import 'dart:ui';

import 'package:window_manager/window_manager.dart';

/// 🔒 هذا الكلاس يراقب حجم النافذة ويمنع تصغيرها تحت الحد الأدنى مع دعم الاستجابة
class SizeGuard extends WindowListener {
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
