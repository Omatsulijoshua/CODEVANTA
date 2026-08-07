import '../domain/extension_manifest_model.dart';

class ExtensionManagerService {
  final List<ExtensionManifest> _marketplace = [
    const ExtensionManifest(
      id: 'theme.cyberpunk-dark',
      name: 'Cyberpunk Dark Theme',
      version: '1.2.0',
      publisher: 'CodeVanta Studio',
      description: 'Vibrant neon purple and cyan theme for CodeVanta editor',
      type: ExtensionType.theme,
      isInstalled: true,
      isEnabled: true,
    ),
    const ExtensionManifest(
      id: 'ai.flutter-architect',
      name: 'Flutter Clean Arch Agent',
      version: '2.0.1',
      publisher: 'Dart Community',
      description: 'Specialized AI Agent trained on Clean Architecture & Riverpod 2.x',
      type: ExtensionType.aiAgent,
      permissions: ['READ_WORKSPACE', 'EDIT_CODE'],
      isInstalled: false,
      isEnabled: true,
    ),
    const ExtensionManifest(
      id: 'syntax.prisma-graphql',
      name: 'Prisma & GraphQL Syntax',
      version: '1.0.4',
      publisher: 'Prisma Devs',
      description: 'Syntax highlighting grammar for .prisma and .graphql schema files',
      type: ExtensionType.syntax,
      isInstalled: false,
      isEnabled: true,
    ),
    const ExtensionManifest(
      id: 'tool.prettier-formatter',
      name: 'Prettier Code Formatter',
      version: '3.1.0',
      publisher: 'Prettier Org',
      description: 'Opinionated code formatter for JS, TS, HTML, and CSS',
      type: ExtensionType.tool,
      permissions: ['FORMAT_CODE'],
      isInstalled: true,
      isEnabled: true,
    ),
  ];

  List<ExtensionManifest> get marketplace => List.unmodifiable(_marketplace);

  void toggleInstall(String id) {
    final index = _marketplace.indexWhere((e) => e.id == id);
    if (index != -1) {
      final current = _marketplace[index];
      _marketplace[index] = current.copyWith(isInstalled: !current.isInstalled);
    }
  }

  void toggleEnable(String id) {
    final index = _marketplace.indexWhere((e) => e.id == id);
    if (index != -1) {
      final current = _marketplace[index];
      _marketplace[index] = current.copyWith(isEnabled: !current.isEnabled);
    }
  }
}
