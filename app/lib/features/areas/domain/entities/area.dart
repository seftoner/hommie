class Area {
  final String id;
  final String name;
  final String? icon;
  final String? picture;
  final List<String> aliases;
  final List<String> labels;

  const Area({
    required this.id,
    required this.name,
    this.icon,
    this.picture,
    this.aliases = const [],
    this.labels = const [],
  });
}
