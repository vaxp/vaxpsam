class FrontendTool {
  final String name;
  final String package;
  final String description;
  final String? iconAsset;

  const FrontendTool({
    required this.name,
    required this.package,
    required this.description,
    this.iconAsset,
  });
}
