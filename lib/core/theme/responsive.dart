import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double textScaleFactor;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    textScaleFactor = _mediaQueryData.textScaleFactor;
  }

  // Responsive width
  static double wp(double percentage) {
    return screenWidth * (percentage / 100);
  }

  // Responsive height
  static double hp(double percentage) {
    return screenHeight * (percentage / 100);
  }

  // Responsive font size
  static double sp(double size) {
    double scaleFactor = 1.0;

    if (screenWidth < 600) {
      // Mobile
      scaleFactor = 0.8;
    } else if (screenWidth < 900) {
      // Tablet
      scaleFactor = 0.9;
    } else if (screenWidth < 1200) {
      // Small desktop
      scaleFactor = 1.0;
    } else if (screenWidth < 1600) {
      // Medium desktop
      scaleFactor = 1.1;
    } else {
      // Large desktop
      scaleFactor = 1.2;
    }

    return size * scaleFactor * (textScaleFactor > 1.0 ? 1.0 : textScaleFactor);
  }

  // Responsive padding
  static double rp(double size) {
    return sp(size);
  }

  // Responsive margin
  static double rm(double size) {
    return sp(size);
  }

  // Responsive icon size
  static double ri(double size) {
    return sp(size);
  }

  // Check if device is mobile
  static bool isMobile() {
    return screenWidth < 600;
  }

  // Check if device is tablet
  static bool isTablet() {
    return screenWidth >= 600 && screenWidth < 900;
  }

  // Check if device is desktop
  static bool isDesktop() {
    return screenWidth >= 900;
  }

  // Check if device is large desktop
  static bool isLargeDesktop() {
    return screenWidth >= 1600;
  }

  // Get responsive grid columns
  static int getGridColumns() {
    if (isMobile()) return 2;
    if (isTablet()) return 3;
    if (screenWidth < 1200) return 4;
    if (screenWidth < 1600) return 5;
    return 6;
  }

  // Get responsive card aspect ratio
  static double getCardAspectRatio() {
    if (isMobile()) return 1.0;
    if (isTablet()) return 1.1;
    return 1.2;
  }

  // Get responsive sidebar width
  static double getSidebarWidth() {
    if (isMobile()) return screenWidth;
    if (isTablet()) return wp(35);
    if (screenWidth < 1200) return wp(25);
    return wp(20);
  }

  // Get responsive hero height
  static double getHeroHeight() {
    if (isMobile()) return hp(20);
    if (isTablet()) return hp(18);
    return hp(16);
  }

  // Get responsive console height
  static double getConsoleHeight() {
    if (isMobile()) return hp(30);
    if (isTablet()) return hp(25);
    return hp(20);
  }
}

// Responsive text styles
class ResponsiveTextStyles {
  static TextStyle headlineLarge(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(32),
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    );
  }

  static TextStyle headlineMedium(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(28),
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    );
  }

  static TextStyle titleLarge(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(22),
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.3,
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(18),
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.2,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(16),
      fontWeight: FontWeight.normal,
      color: Colors.white,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(14),
      fontWeight: FontWeight.normal,
      color: const Color(0xFF8E8E93),
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(12),
      fontWeight: FontWeight.normal,
      color: const Color(0xFF8E8E93),
    );
  }

  static TextStyle labelLarge(BuildContext context) {
    return TextStyle(
      fontSize: Responsive.sp(14),
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.1,
    );
  }
}
