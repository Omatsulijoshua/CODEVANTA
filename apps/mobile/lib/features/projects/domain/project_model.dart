class ProjectModel {
  final String id;
  final String name;
  final String path;
  final String language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.path,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'path': path,
        'language': language,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'isSynced': isSynced,
      };

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'],
        name: json['name'],
        path: json['path'],
        language: json['language'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        isSynced: json['isSynced'] ?? false,
      );
}

class FileNode {
  final String name;
  final String path;
  final bool isDirectory;
  final int size;
  final List<FileNode> children;

  const FileNode({
    required this.name,
    required this.path,
    required this.isDirectory,
    this.size = 0,
    this.children = const [],
  });
}

class ProjectSnapshot {
  final String id;
  final String projectId;
  final String label;
  final DateTime timestamp;
  final String backupPath;

  const ProjectSnapshot({
    required this.id,
    required this.projectId,
    required this.label,
    required this.timestamp,
    required this.backupPath,
  });
}
