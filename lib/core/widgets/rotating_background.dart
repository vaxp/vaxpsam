import 'package:flutter/material.dart';

class StaticBackground extends StatelessWidget {
  final Widget child;
  final List<String>? images;

  const StaticBackground({super.key, required this.child, this.images});

  List<String> get _backgroundImages {
    return images ?? ['assets/images/background5.jpg'];
  }

  @override
  Widget build(BuildContext context) {
    final String staticImagePath = _backgroundImages.first;

    return Stack(
      children: [
        Positioned.fill(child: Image.asset(staticImagePath, fit: BoxFit.cover)),

        Positioned.fill(
            child: Container(
                color: Colors.black.withOpacity(0.5))), 

        Positioned.fill(child: child),
      ],
    );
  }
}