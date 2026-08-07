import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/ghost_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/codevanta_text_field.dart';
import '../services/git_service.dart';
import 'diff_viewer_widget.dart';

class GitScreen extends StatefulWidget {
  const GitScreen({super.key});

  @override
  State<GitScreen> createState() => _GitScreenState();
}

class _GitScreenState extends State<GitScreen> {
  final _gitService = GitService();
  final _commitMessageController = TextEditingController();

  void _showCreateBranchDialog() {
    final branchController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create New Branch', style: TextStyle(fontWeight: FontWeight.bold)),
        content: CodeVantaTextField(label: 'Branch Name', hintText: 'feature/new-agent', controller: branchController),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          PrimaryButton(
            label: 'Create Branch',
            fullWidth: false,
            onPressed: () {
              if (branchController.text.isNotEmpty) {
                setState(() => _gitService.createBranch(branchController.text));
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
    final stagedFiles = _gitService.statusList.where((f) => f.isStaged).toList();
    final unstagedFiles = _gitService.statusList.where((f) => !f.isStaged).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Git Client'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Changes'),
              Tab(text: 'Branches'),
              Tab(text: 'History Log'),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: StatusPill(
                label: 'BRANCH: ${_gitService.branches.firstWhere((b) => b.isCurrent).name}',
                type: StatusType.info,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Tab 1: Changes & Staging
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CodeVantaTextField(
                    hintText: 'Enter commit message (e.g. feat: add authentication)...',
                    controller: _commitMessageController,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Commit (${stagedFiles.length} Staged)',
                          icon: Icons.check,
                          onPressed: stagedFiles.isEmpty || _commitMessageController.text.isEmpty
                              ? null
                              : () {
                                  setState(() {
                                    _gitService.commit(_commitMessageController.text, 'Alex Dev');
                                    _commitMessageController.clear();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Committed changes successfully!')),
                                  );
                                },
                        ),
                      ),
                      const SizedBox(width: 8),
                      SecondaryButton(
                        label: 'Stage All',
                        onPressed: () => setState(() => _gitService.stageAll()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        Text('Staged Changes (${stagedFiles.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 6),
                        ...stagedFiles.map((file) => Card(
                              margin: const EdgeInsets.only(bottom: 6),
                              child: ListTile(
                                dense: true,
                                title: Text(file.path),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GhostButton(
                                      label: 'Unstage',
                                      onPressed: () => setState(() => _gitService.toggleStage(file.path)),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.difference_outlined, size: 18),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => DiffViewerWidget(
                                              filePath: file.path,
                                              diffLines: _gitService.getDiff(file.path),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 16),
                        Text('Unstaged Changes (${unstagedFiles.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 6),
                        ...unstagedFiles.map((file) => Card(
                              margin: const EdgeInsets.only(bottom: 6),
                              child: ListTile(
                                dense: true,
                                title: Text(file.path),
                                trailing: GhostButton(
                                  label: 'Stage',
                                  onPressed: () => setState(() => _gitService.toggleStage(file.path)),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab 2: Branches
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Branches (${_gitService.branches.length})',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? CodeVantaColors.textDarkPrimary : CodeVantaColors.textLightPrimary,
                        ),
                      ),
                      SecondaryButton(
                        label: 'New Branch',
                        icon: Icons.add,
                        onPressed: _showCreateBranchDialog,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _gitService.branches.length,
                      itemBuilder: (context, index) {
                        final branch = _gitService.branches[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(
                              Icons.alt_route,
                              color: branch.isCurrent ? CodeVantaColors.electricViolet : CodeVantaColors.textDarkSecondary,
                            ),
                            title: Text(branch.name, style: TextStyle(fontWeight: branch.isCurrent ? FontWeight.bold : FontWeight.normal)),
                            trailing: branch.isCurrent ? const StatusPill(label: 'CURRENT', type: StatusType.success) : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Tab 3: History Log
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _gitService.commits.length,
                itemBuilder: (context, index) {
                  final commit = _gitService.commits[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: CodeVantaColors.electricViolet.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(commit.hash, style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: CodeVantaColors.electricViolet)),
                      ),
                      title: Text(commit.message, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${commit.author} • ${commit.date.toString().substring(0, 16)}'),
                    ),
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
