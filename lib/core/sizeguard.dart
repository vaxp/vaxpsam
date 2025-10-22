import 'dart:ui';

import 'package:window_manager/window_manager.dart';

class SizeGuard extends WindowListener {
  @override
  void onWindowResize() async {
    const minWidth = 768.0;
    const minHeight = 600.0;
    const maxWidth = 1920.0; 
    const maxHeight = 1080.0;

    final size = await windowManager.getSize();

    if (size.width < minWidth || size.height < minHeight) {
      await windowManager.setSize(
        Size(
          size.width < minWidth ? minWidth : size.width,
          size.height < minHeight ? minHeight : size.height,
        ),
      );
    }

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
