import 'package:flutter/material.dart';

// Mac App Store inspired colors
const Color macAppStoreDark = Color.fromARGB(29, 81, 81, 82);
const Color macAppStoreCard = Color.fromARGB(60, 75, 75, 75);
const Color macAppStorePurple = Color(0xFF8E44AD);
const Color macAppStoreBlue = Color(0xFF007AFF);
const Color macAppStoreGray = Color.fromARGB(255, 255, 255, 255);
const Color macAppStoreLightGray = Color.fromARGB(255, 49, 49, 49);

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color.fromARGB(62, 0, 123, 255),
    secondary: macAppStorePurple,
    surface: macAppStoreDark,
    onSurface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(29, 27, 27, 27),
  cardTheme: CardTheme(
    color: const Color.fromARGB(59, 39, 39, 39),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 0,
    margin: const EdgeInsets.all(8),
    shadowColor: Colors.black.withOpacity(0.3),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: macAppStoreDark,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.3,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.2,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: macAppStoreGray,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: macAppStoreGray,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.1,
    ),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: const Color.fromARGB(59, 31, 31, 31),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: macAppStoreBlue,
    secondary: macAppStorePurple,
    surface: macAppStoreDark,
    onSurface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: macAppStoreDark,
  cardTheme: CardTheme(
    color: const Color.fromARGB(59, 27, 27, 27),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 0,
    margin: const EdgeInsets.all(8),
    shadowColor: Colors.black.withOpacity(0.3),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: macAppStoreDark,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.5,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.3,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.2,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: macAppStoreGray,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: macAppStoreGray,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.1,
    ),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: const Color.fromARGB(59, 39, 39, 39),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
