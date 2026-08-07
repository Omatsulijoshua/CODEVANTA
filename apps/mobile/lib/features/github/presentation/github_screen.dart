import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/cards/project_card.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/search_input.dart';
import '../domain/github_model.dart';

class GitHubScreen extends StatefulWidget {
  const GitHubScreen({super.key});

  @override
  State<GitHubScreen> createState() => _GitHubScreenState();
}

class _GitHubScreenState extends State<GitHubScreen> {
  final List<GitHubRepo> _repos = [
    const GitHubRepo(
      id: 101,
      name: 'CODEVANTA',
      fullName: 'Omatsulijoshua/CODEVANTA',
      description: 'CODEVANTA — MOBILE AI DEVELOPMENT IDE',
      isPrivate: false,
      stars: 128,
      language: 'Dart/Flutter',
    ),
    const GitHubRepo(
      id: 102,
      name: 'nest-ai-gateway',
      fullName: 'Omatsulijoshua/nest-ai-gateway',
      description: 'Multi-provider AI Gateway API for CodeVanta',
      isPrivate: true,
      stars: 42,
      language: 'TypeScript',
    ),
  ];

  final List<GitHubIssue> _issues = [
    const GitHubIssue(number: 42, title: 'Add support for custom Ollama AI local endpoints', state: 'OPEN', author: 'Alex Dev'),
    const GitHubIssue(number: 38, title: 'Optimize syntax highlighting tokenizer latency on iPad Pro', state: 'OPEN', author: 'Josh Dev'),
  ];

  final List<GitHubPullRequest> _pullRequests = [
    const GitHubPullRequest(
      number: 15,
      title: 'feat: implement Phase 7 touch-friendly Git client',
      state: 'OPEN',
      author: 'Alex Dev',
      branch: 'feature/git-integration',
    ),
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredRepos = _repos.where((r) => r.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Integration'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Repositories'),
              Tab(text: 'Issues'),
              Tab(text: 'Pull Requests'),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: StatusPill(label: 'CONNECTED: @Omatsulijoshua', type: StatusType.success),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Tab 1: Repositories
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SearchInput(
                    hintText: 'Search GitHub repositories...',
                    onChanged: (val) => setState(() => _searchQuery = val),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredRepos.length,
                      itemBuilder: (context, index) {
                        final repo = filteredRepos[index];
                        return ProjectCard(
                          title: repo.fullName,
                          language: repo.language,
                          lastModified: '${repo.stars} ★',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Cloning ${repo.fullName} to local project workspace...')),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Tab 2: Issues
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _issues.length,
                itemBuilder: (context, index) {
                  final issue = _issues[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.error_outline, color: CodeVantaColors.warningAmber),
                      title: Text('#${issue.number} ${issue.title}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Opened by ${issue.author}'),
                      trailing: StatusPill(label: issue.state, type: StatusType.warning),
                    ),
                  );
                },
              ),
            ),

            // Tab 3: Pull Requests
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _pullRequests.length,
                itemBuilder: (context, index) {
                  final pr = _pullRequests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.merge_type, color: CodeVantaColors.electricViolet),
                      title: Text('#${pr.number} ${pr.title}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Branch: ${pr.branch} by ${pr.author}'),
                      trailing: PrimaryButton(
                        label: 'Merge PR',
                        fullWidth: false,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Pull Request #${pr.number} merged successfully.')),
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
    );
  }
}
