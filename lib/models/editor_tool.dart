// lib/models/editor_tool.dart

class EditorTool {
  final String name;
  final String pkg;
  final String desc;
  final String iconAsset;

  const EditorTool({
    required this.name,
    required this.pkg,
    required this.desc,
    this.iconAsset = 'assets/ides/default.png', // قيمة افتراضية
  });
}