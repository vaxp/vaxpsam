import 'package:flutter/material.dart';

/// A widget that displays a single, static background image from a list of asset images,
/// maintaining a full cover fit.
class StaticBackground extends StatelessWidget {
  final Widget child;
  // تم الاحتفاظ بقائمة الصور لأغراض التوافق، ولكن سيتم استخدام الصورة الأولى فقط.
  final List<String>? images;

  const StaticBackground({
    Key? key,
    required this.child,
    this.images,
  }) : super(key: key);

  // تعريف قائمة الصور الافتراضية هنا أو استخدام القائمة المقدمة
  List<String> get _backgroundImages {
    return images ?? [
      'assets/images/background4.jpg', // هذه هي الصورة الثابتة التي سيتم استخدامها
    ];
  }

  // تم إزالة Interval و transitionDuration لأننا لا نحتاج للتبديل أو الرسوم المتحركة

  @override
  Widget build(BuildContext context) {
    // نستخدم الصورة الأولى فقط من القائمة
    final String staticImagePath = _backgroundImages.first;

    return Stack(
      children: [
        // 1. الخلفية الثابتة (Image.asset)
        Positioned.fill(
          child: Image.asset(
            staticImagePath,
            fit: BoxFit.cover, // لتغطية الشاشة بالكامل
          ),
        ),

        // 2. طبقة داكنة شبه شفافة لتحسين القراءة (تم الاحتفاظ بها لأنها مفيدة)
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.35),
          ),
        ),

        // 3. محتوى الواجهة الأمامي
        Positioned.fill(child: child),
      ],
    );
  }
}