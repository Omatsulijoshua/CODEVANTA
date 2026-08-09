import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/ghost_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';
import '../../../shared/widgets/cards/file_list_item.dart';
import '../../../shared/widgets/editor/breadcrumb_bar.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/codevanta_text_field.dart';
import '../../workspace/presentation/workspace_screen.dart';
import '../domain/project_model.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late List<FileNode> _files;
  late List<ProjectSnapshot> _snapshots;

  @override
  void initState() {
    super.initState();
    _files = [
      FileNode(name: 'lib', path: '${widget.project.path}/lib', isDirectory: true),
      FileNode(name: 'main.dart', path: '${widget.project.path}/main.dart', isDirectory: false),
      FileNode(name: 'pubspec.yaml', path: '${widget.project.path}/pubspec.yaml', isDirectory: false),
      FileNode(name: 'README.md', path: '${widget.project.path}/README.md', isDirectory: false),
    ];
    _snapshots = [
      ProjectSnapshot(
        id: 'snap_1',
        projectId: widget.project.id,
        label: 'Initial project setup',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        backupPath: '/snapshots/snap_1',
      ),
    ];
  }

  void _openFileInWorkspace(FileNode file) {
    if (file.isDirectory) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Opened folder: ${file.name}')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const WorkspaceScreen(),
      ),
    );
  }

  void _showNewFileDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create New File', style: TextStyle(fontWeight: FontWeight.bold)),
        content: CodeVantaTextField(label: 'File Name', hintText: 'app.dart', controller: nameController),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          PrimaryButton(
            label: 'Create File',
            fullWidth: false,
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final newFile = FileNode(
                  name: nameController.text,
                  path: '${widget.project.path}/${nameController.text}',
                  isDirectory: false,
                );
                setState(() {
                  _files.add(newFile);
                });
                Navigator.pop(ctx);
                _openFileInWorkspace(newFile);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showCreateSnapshotDialog() {
    final labelController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Snapshot', style: TextStyle(fontWeight: FontWeight.bold)),
        content: CodeVantaTextField(
          label: 'Snapshot Label',
          hintText: 'Before AI code refactoring',
          controller: labelController,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          PrimaryButton(
            label: 'Create Snapshot',
            fullWidth: false,
            onPressed: () {
              if (labelController.text.isNotEmpty) {
                setState(() {
                  _snapshots.insert(
                    0,
                    ProjectSnapshot(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      projectId: widget.project.id,
                      label: labelController.text,
                      timestamp: DateTime.now(),
                      backupPath: '/snapshots/${DateTime.now().millisecondsSinceEpoch}',
                    ),
                  );
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Snapshot created successfully!')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.project.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'File Explorer'),
              Tab(text: 'Snapshots'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.code_rounded),
              tooltip: 'Open IDE Workspace',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WorkspaceScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.archive_outlined),
              tooltip: 'Export ZIP Archive',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Exported ${widget.project.name}.zip to exports/ directory.')),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            BreadcrumbBar(pathSegments: [widget.project.name]),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: File Explorer
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatusPill(label: widget.project.language, type: StatusType.info),
                            SecondaryButton(
                              label: 'New File',
                              icon: Icons.note_add_outlined,
                              onPressed: _showNewFileDialog,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _files.length,
                            itemBuilder: (context, index) {
                              final item = _files[index];
                              return FileListItem(
                                fileName: item.name,
                                isFolder: item.isDirectory,
                                onTap: () => _openFileInWorkspace(item),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab 2: Snapshots
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Local Project Snapshots',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                              ),
                            ),
                            SecondaryButton(
                              label: 'New Snapshot',
                              icon: Icons.camera_alt_outlined,
                              onPressed: _showCreateSnapshotDialog,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _snapshots.length,
                            itemBuilder: (context, index) {
                              final snap = _snapshots[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: const Icon(Icons.history, color: CodeVantaColors.electricViolet),
                                  title: Text(snap.label, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(snap.timestamp.toString()),
                                  trailing: GhostButton(
                                    label: 'Restore',
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Restored project state from snapshot "${snap.label}".')),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
