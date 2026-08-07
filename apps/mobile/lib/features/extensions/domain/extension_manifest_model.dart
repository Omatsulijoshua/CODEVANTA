enum ExtensionType { syntax, theme, aiAgent, tool }

class ExtensionManifest {
  final String id;
  final String name;
  final String version;
  final String publisher;
  final String description;
  final ExtensionType type;
  final List<String> permissions;
  final bool isInstalled;
  final bool isEnabled;

  const ExtensionManifest({
    required this.id,
    required this.name,
    required this.version,
    required this.publisher,
    required this.description,
    required this.type,
    this.permissions = const [],
    this.isInstalled = false,
    this.isEnabled = true,
  });

  ExtensionManifest copyWith({bool? isInstalled, bool? isEnabled}) {
    return ExtensionManifest(
      id: id,
      name: name,
      version: version,
      publisher: publisher,
      description: description,
      type: type,
      permissions: permissions,
      isInstalled: isInstalled ?? this.isInstalled,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
