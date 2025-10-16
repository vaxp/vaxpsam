import 'dart:async';
import 'package:flutter/material.dart';

/// A widget that displays a rotating background image from a list of asset images
/// with a **smooth fade transition** while maintaining full cover fit.
class RotatingBackground extends StatefulWidget {
  final Widget child;
  final Duration interval;
  final Duration transitionDuration;
  final List<String>? images;

  const RotatingBackground({
    Key? key,
    required this.child,
    this.interval = const Duration(seconds: 10),
    this.transitionDuration = const Duration(milliseconds: 200),
    this.images,
  }) : super(key: key);

  @override
  State<RotatingBackground> createState() => _RotatingBackgroundState();
}

// استخدام TickerProviderStateMixin لتشغيل الـ AnimationController
class _RotatingBackgroundState extends State<RotatingBackground> with SingleTickerProviderStateMixin {
  late Timer _intervalTimer;
  late AnimationController _fadeController;
  
  // فهارس الصورتين المتراكبتين. الصورة الحالية هي التي نراها.
  int _currentImageIndex = 0;
  // الصورة القديمة (التي تتلاشى من الوجود)
  int _previousImageIndex = 0;
  
  late final List<String> _backgroundImages;

  @override
  void initState() {
    super.initState();

    _backgroundImages = widget.images ?? [
      'assets/images/background1.jpg',
      'assets/images/background2.jpg',
      'assets/images/background3.jpg',
      'assets/images/background4.jpg',
      'assets/images/background5.jpg',
      'assets/images/background6.jpg',
    ];

    // إعداد AnimationController للتحكم في التلاشي
    _fadeController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    );
    
    // عند اكتمال الرسوم المتحركة
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // بمجرد اكتمال التلاشي، نحدث الحالة لتعيين الصورة الجديدة كصورة حالية
        // ونعيد تعيين المتحكم إلى القيمة 0.0 استعدادًا للانتقال التالي
        setState(() {
          _previousImageIndex = _currentImageIndex;
          // الانتقال إلى الصورة التالية
          _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
          _fadeController.value = 0.0; // نضبط المتحكم على 0.0
        });
      }
    });

    // ضبط المؤقت لتشغيل الانتقال الدوري
    _intervalTimer = Timer.periodic(widget.interval, (timer) {
      if (mounted) {
        // تشغيل الرسوم المتحركة للتلاشي للأمام
        // ملاحظة: لقد أصبحت عملية تبديل الفهارس الآن تتم بالكامل داخل addStatusListener
        _fadeController.forward(from: 0.0);
      }
    });
    
    // تشغيل الدورة الأولى فوراً
    _fadeController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _intervalTimer.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 💡 الآن، سنستخدم قيمة المتحكم (Controller) لتلاشي الصورة القديمة للخارج
    // والصورة الجديدة للداخل في نفس الوقت.
    return Stack(
      children: [
        // 1. الصورة القديمة (تتلاشى للخارج من 1.0 إلى 0.0)
        Positioned.fill(
          child: Opacity(
            // يجب تعيين قيمة الشفافية يدوياً هنا لتكون عكس قيمة المتحكم
            opacity: 1.0 - _fadeController.value,
            child: Image.asset(
              _backgroundImages[_previousImageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 2. الصورة الجديدة (تتلاشى للداخل من 0.0 إلى 1.0)
        Positioned.fill(
          child: FadeTransition(
            // قيمة الشفافية هنا هي قيمة المتحكم مباشرة
            opacity: _fadeController, 
            child: Image.asset(
              _backgroundImages[_currentImageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // طبقة داكنة شبه شفافة لتحسين القراءة
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.35),
          ),
        ),
        
        // محتوى الواجهة الأمامي
        Positioned.fill(child: widget.child),
      ],
    );
  }
}