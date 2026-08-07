import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/brand/codevanta_logo.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/cards/project_card.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/codevanta_text_field.dart';
import '../../../shared/widgets/inputs/search_input.dart';
import '../domain/project_model.dart';
import 'project_detail_screen.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final List<ProjectModel> _projects = [
    ProjectModel(
      id: '1',
      name: 'CodeVanta IDE Client',
      path: '/local/projects/codevanta_mobile',
      language: 'Dart/Flutter',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ProjectModel(
      id: '2',
      name: 'NestJS AI Gateway',
      path: '/local/projects/codevanta_backend',
      language: 'TypeScript',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  final _searchController = TextEditingController();
  String _searchQuery = '';

  void _showCreateProjectDialog() {
    final nameController = TextEditingController();
    String selectedLanguage = 'Dart/Flutter';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create New Local Project', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CodeVantaTextField(
              label: 'Project Name',
              hintText: 'my_flutter_app',
              controller: nameController,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedLanguage,
              decoration: const InputDecoration(labelText: 'Language / Framework'),
              items: ['Dart/Flutter', 'TypeScript/Node', 'Python', 'HTML/CSS/JS', 'Rust', 'Go']
                  .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (val) {
                if (val != null) selectedLanguage = val;
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          PrimaryButton(
            label: 'Create',
            fullWidth: false,
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _projects.insert(
                    0,
                    ProjectModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameController.text,
                      path: '/local/projects/${nameController.text}',
                      language: selectedLanguage,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  );
                });
                Navigator.pop(ctx);
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
    final filteredProjects = _projects
        .where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const CodeVantaLogo(size: 26, style: LogoStyle.horizontal),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: StatusPill(label: 'OFFLINE MODE', type: StatusType.success),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Local Projects',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                  ),
                ),
                PrimaryButton(
                  label: 'New Project',
                  icon: Icons.add,
                  fullWidth: false,
                  onPressed: _showCreateProjectDialog,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SearchInput(
              controller: _searchController,
              hintText: 'Filter local projects...',
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredProjects.isEmpty
                  ? Center(
                      child: Text(
                        'No local projects found.',
                        style: TextStyle(
                          color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, index) {
                        final proj = filteredProjects[index];
                        return ProjectCard(
                          title: proj.name,
                          language: proj.language,
                          lastModified: 'Just now',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProjectDetailScreen(project: proj),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
