import 'package:flutter/material.dart';

class BrowserTool {
  final String title;
  final String description;
  final String packageName;
  final IconData icon;
  final Color color;

  const BrowserTool({
    required this.title,
    required this.description,
    required this.packageName,
    required this.icon,
    required this.color,
  });
}
