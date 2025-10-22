// lib/models/forensics_tool.dart

class ForensicsTool {
  final String name;
  final String package;
  final String description;
  final String? iconAsset;

  const ForensicsTool({
    required this.name,
    required this.package,
    required this.description,
    this.iconAsset,
  });
}
