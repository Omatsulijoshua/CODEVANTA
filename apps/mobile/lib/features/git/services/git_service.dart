import '../domain/git_models.dart';

class GitService {
  final List<GitFileItem> _statusList = [
    const GitFileItem(path: 'lib/main.dart', state: GitFileState.modified, isStaged: true),
    const GitFileItem(path: 'lib/features/git/git_screen.dart', state: GitFileState.added, isStaged: false),
    const GitFileItem(path: 'pubspec.yaml', state: GitFileState.modified, isStaged: false),
  ];

  final List<GitBranch> _branches = [
    const GitBranch(name: 'main', isCurrent: true),
    const GitBranch(name: 'feature/ai-agent-gateway', isCurrent: false),
    const GitBranch(name: 'feature/git-integration', isCurrent: false),
  ];

  final List<GitCommit> _commits = [
    GitCommit(
      hash: 'a1b2c3d',
      author: 'Alex Dev',
      message: 'feat: implement Phase 6 global search & indexing',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    GitCommit(
      hash: 'e5f6g7h',
      author: 'Alex Dev',
      message: 'feat: implement Phase 5 workspace styles (Classic, Minimal, Focus)',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<GitFileItem> get statusList => List.unmodifiable(_statusList);
  List<GitBranch> get branches => List.unmodifiable(_branches);
  List<GitCommit> get commits => List.unmodifiable(_commits);

  void toggleStage(String path) {
    final index = _statusList.indexWhere((f) => f.path == path);
    if (index != -1) {
      final current = _statusList[index];
      _statusList[index] = current.copyWith(isStaged: !current.isStaged);
    }
  }

  void stageAll() {
    for (int i = 0; i < _statusList.length; i++) {
      _statusList[i] = _statusList[i].copyWith(isStaged: true);
    }
  }

  void unstageAll() {
    for (int i = 0; i < _statusList.length; i++) {
      _statusList[i] = _statusList[i].copyWith(isStaged: false);
    }
  }

  GitCommit commit(String message, String author) {
    final newCommit = GitCommit(
      hash: DateTime.now().millisecondsSinceEpoch.toRadixString(16).substring(0, 7),
      author: author,
      message: message,
      date: DateTime.now(),
    );
    _commits.insert(0, newCommit);
    _statusList.removeWhere((f) => f.isStaged);
    return newCommit;
  }

  void createBranch(String name) {
    _branches.add(GitBranch(name: name, isCurrent: false));
  }

  List<GitDiffLine> getDiff(String filePath) {
    return [
      const GitDiffLine(content: 'import "package:flutter/material.dart";', type: 'normal', oldLineNumber: 1, newLineNumber: 1),
      const GitDiffLine(content: '- import "core/theme/codevanta_theme.dart";', type: 'delete', oldLineNumber: 2),
      const GitDiffLine(content: '+ import "core/theme/codevanta_colors.dart";', type: 'add', newLineNumber: 2),
      const GitDiffLine(content: 'void main() {', type: 'normal', oldLineNumber: 3, newLineNumber: 3),
    ];
  }
}
