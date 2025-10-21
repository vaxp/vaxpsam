// lib/models/advanced_tool.dart

class AdvancedTool {
  final String name;
  final String ref; // مرجع Flatpak (Reference)
  final String desc;
  final String iconAsset;

  const AdvancedTool({
    required this.name,
    required this.ref,
    required this.desc,
    this.iconAsset = 'assets/ides/default.png', // قيمة افتراضية
  });
}