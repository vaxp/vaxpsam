import 'package:flutter/material.dart';

class DebuggingAction {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String commandKey;

  const DebuggingAction({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.commandKey,
  });
}
