// lib/advanced_editors/widgets/advanced_hero_section.dart

import 'package:flutter/material.dart';

class AdvancedEditorsHeroSection extends StatelessWidget {
  const AdvancedEditorsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)], // الألوان الثابتة
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // تم تبسيط الكود (إزالة الـ Positioned.fill المكرر)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'ADVANCED EDITORS (FLATPAK)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Install Editors from Flathub',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Popular IDEs and editors installed via Flatpak. Ensure Flathub is enabled.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
