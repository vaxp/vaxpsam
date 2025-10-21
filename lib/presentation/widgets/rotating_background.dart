import 'package:flutter/material.dart';

class StaticBackground extends StatelessWidget {
  final Widget child;
  final List<String>? images;

  const StaticBackground({super.key, required this.child, this.images});

  List<String> get _backgroundImages {
    return images ?? ['assets/images/background1.jpg'];
  }

  @override
  Widget build(BuildContext context) {
    final String staticImagePath = _backgroundImages.first;

    return Stack(
      children: [
        // 1. الصورة (الخلفية) في الأسفل
        Positioned.fill(child: Image.asset(staticImagePath, fit: BoxFit.cover)),

        // 2. طبقة التعتيم الشفافة (Overlay)
        // **التعديل:** استخدام Colors.black.withOpacity(0.5) أو استخدام اللون مع رمز الشفافية (0xAA000000)
        Positioned.fill(
            child: Container(
                color: Colors.black.withOpacity(0.5))), // 0.5 تعني 50% شفافية

        // 3. المحتوى الفعلي للتطبيق في الأعلى
        Positioned.fill(child: child),
      ],
    );
  }
}