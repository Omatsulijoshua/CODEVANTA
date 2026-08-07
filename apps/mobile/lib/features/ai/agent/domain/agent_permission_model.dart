enum PermissionScope { read, search, edit, create, delete, terminal, network, deploy }

enum PermissionGrant { allowOnce, alwaysAllow, deny }

class AiFileChange {
  final String filePath;
  final String oldContent;
  final String newContent;
  final bool isNewFile;

  const AiFileChange({
    required this.filePath,
    required this.oldContent,
    required this.newContent,
    this.isNewFile = false,
  });
}
