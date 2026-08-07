import 'dart:io';
import 'package:archive/archive_io.dart';
import '../domain/project_model.dart';

class LocalProjectService {
  final Directory baseStorageDir;

  LocalProjectService({required this.baseStorageDir});

  Future<ProjectModel> createProject({
    required String name,
    required String language,
  }) async {
    final projectDir = Directory('${baseStorageDir.path}/projects/$name');
    if (!await projectDir.exists()) {
      await projectDir.create(recursive: true);
    }

    // Create initial template file
    final mainFile = File('${projectDir.path}/main.dart');
    await mainFile.writeAsString('''
// Welcome to CodeVanta IDE
// Project: $name

void main() {
  print("Hello from $name!");
}
''');

    return ProjectModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      path: projectDir.path,
      language: language,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<List<FileNode>> listFiles(String projectPath) async {
    final dir = Directory(projectPath);
    if (!await dir.exists()) return [];

    final List<FileNode> nodes = [];
    await for (final entity in dir.list(followLinks: false)) {
      final isDir = entity is Directory;
      final name = entity.path.split(Platform.pathSeparator).last;
      nodes.add(FileNode(
        name: name,
        path: entity.path,
        isDirectory: isDir,
        children: isDir ? await listFiles(entity.path) : [],
      ));
    }
    return nodes;
  }

  Future<ProjectSnapshot> createSnapshot(ProjectModel project, String label) async {
    final snapshotDir = Directory('${baseStorageDir.path}/snapshots/${project.id}/${DateTime.now().millisecondsSinceEpoch}');
    await snapshotDir.create(recursive: true);

    final projectDir = Directory(project.path);
    if (await projectDir.exists()) {
      await for (final entity in projectDir.list(recursive: true)) {
        final relativePath = entity.path.replaceFirst(project.path, '');
        final targetPath = '${snapshotDir.path}$relativePath';
        if (entity is Directory) {
          await Directory(targetPath).create(recursive: true);
        } else if (entity is File) {
          await entity.copy(targetPath);
        }
      }
    }

    return ProjectSnapshot(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      projectId: project.id,
      label: label,
      timestamp: DateTime.now(),
      backupPath: snapshotDir.path,
    );
  }

  Future<void> restoreSnapshot(ProjectModel project, ProjectSnapshot snapshot) async {
    final projectDir = Directory(project.path);
    if (await projectDir.exists()) {
      await projectDir.delete(recursive: true);
    }
    await projectDir.create(recursive: true);

    final backupDir = Directory(snapshot.backupPath);
    await for (final entity in backupDir.list(recursive: true)) {
      final relativePath = entity.path.replaceFirst(snapshot.backupPath, '');
      final targetPath = '${projectDir.path}$relativePath';
      if (entity is Directory) {
        await Directory(targetPath).create(recursive: true);
      } else if (entity is File) {
        await entity.copy(targetPath);
      }
    }
  }

  Future<String> exportZip(ProjectModel project) async {
    final encoder = ZipFileEncoder();
    final zipPath = '${baseStorageDir.path}/exports/${project.name}.zip';
    final zipFile = File(zipPath);
    if (!await zipFile.parent.exists()) {
      await zipFile.parent.create(recursive: true);
    }
    encoder.create(zipPath);
    encoder.addDirectory(Directory(project.path));
    encoder.close();
    return zipPath;
  }
}
