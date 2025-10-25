import 'package:flutter/material.dart';

class StaticBackground extends StatelessWidget {
  final Widget child;

  // تم حذف 'images' لأننا لم نعد بحاجة إليها
  const StaticBackground({super.key, required this.child});

  // تم حذف Getter الخاص بالصور

  @override
  Widget build(BuildContext context) {
    // تم استبدال الـ Stack بالكامل بهذا الـ Container
    // هذا أكثر كفاءة بكثير
    return Container(
      // هذا هو لون "الزجاج الأسود" الذي حددته
      color: const Color.fromARGB(176, 0, 0, 0),
      child: child,
    );
  }
}