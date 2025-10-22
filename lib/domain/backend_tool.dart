class BackendTool {
  final String name;
  final String package; 
  final String description;
  final String? iconAsset;

  const BackendTool({
    required this.name,
    required this.package,
    required this.description,
    this.iconAsset,
  });
}