class DeveloperTool {
  final String name;
  final String package; 
  final String description;
  final String? iconAsset;

  const DeveloperTool({
    required this.name,
    required this.package,
    required this.description,
    this.iconAsset,
  });
}