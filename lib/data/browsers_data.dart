import 'package:flutter/material.dart';
import 'package:vaxpsam/domain/browser_tool.dart';

class BrowsersData {
  static const List<BrowserTool> kBrowserTools = [
    // --- أدواتك الأصلية (4) ---
    BrowserTool(
      title: 'Firefox',
      description: 'Mozilla Firefox',
      packageName: 'firefox',
      icon: Icons.language,
      color: Color(0xFFFF9500), // لون برتقالي
    ),
    BrowserTool(
      title: 'Brave',
      description: 'Privacy-focused browser',
      packageName: 'brave-browser', // (يتطلب مستودع خارجي)
      icon: Icons.security,
      color: Color(0xFFFF6B35), // لون أحمر/برتقالي
    ),
    BrowserTool(
      title: 'Chromium',
      description: 'Open-source Chrome',
      packageName: 'chromium-browser', // (تم تصحيح الاسم لـ apt)
      icon: Icons.web,
      color: Color(0xFF4285F4), // لون أزرق جوجل
    ),
    BrowserTool(
      title: 'Opera',
      description: 'Fast and secure browser',
      packageName: 'opera', // (يتطلب مستودع خارجي)
      icon: Icons.public,
      color: Color(0xFFFF0000), // لون أحمر أوبرا
    ),

    // --- الإضافات الجديدة (8) ---
    BrowserTool(
      title: 'GNOME Web',
      description: 'Lightweight browser for GNOME',
      packageName: 'epiphany-browser',
      icon: Icons.explore,
      color: Color(0xFF5A9EE1), // أزرق GNOME
    ),
    BrowserTool(
      title: 'Falkon',
      description: 'Lightweight Qt browser (KDE)',
      packageName: 'falkon',
      icon: Icons.explore_outlined,
      color: Color(0xFF1DA1F2), // أزرق KDE
    ),
    BrowserTool(
      title: 'Konqueror',
      description: 'KDE file manager and browser',
      packageName: 'konqueror',
      icon: Icons.folder_open,
      color: Color(0xFF3498DB), // أزرق
    ),
    BrowserTool(
      title: 'Midori',
      description: 'Lightweight & private browser',
      packageName: 'midori',
      icon: Icons.eco,
      color: Color(0xFF2ECC71), // أخضر
    ),
    BrowserTool(
      title: 'Tor Browser',
      description: 'Launcher for Tor (anonymity)',
      packageName: 'torbrowser-launcher',
      icon: Icons.vpn_lock,
      color: Color(0xFF7D4698), // بنفسجي Tor
    ),
    BrowserTool(
      title: 'Lynx',
      description: 'Text-based terminal browser',
      packageName: 'lynx',
      icon: Icons.terminal,
      color: Color(0xFF333333), // رمادي غامق
    ),
    BrowserTool(
      title: 'w3m',
      description: 'Text-based browser (image support)',
      packageName: 'w3m',
      icon: Icons.terminal_outlined,
      color: Color(0xFF555555), // رمادي
    ),
    BrowserTool(
      title: 'ELinks',
      description: 'Advanced text-based browser',
      packageName: 'elinks',
      icon: Icons.text_fields,
      color: Color(0xFF444444), // رمادي
    ),
  ];
}