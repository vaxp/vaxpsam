import 'package:flutter/material.dart';

enum InstallationMethod {
  apt, 
  debUrl, 
}

class DevTool {
  final String title;
  final String description;
  final InstallationMethod installMethod;
  final String installArgument; 
  final IconData icon;
  final Color color;

  const DevTool({
    required this.title,
    required this.description,
    required this.installMethod,
    required this.installArgument,
    required this.icon,
    required this.color,
  });
}
