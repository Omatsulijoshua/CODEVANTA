enum GitFileState { modified, added, deleted, untracked }

class GitFileItem {
  final String path;
  final GitFileState state;
  final bool isStaged;

  const GitFileItem({
    required this.path,
    required this.state,
    this.isStaged = false,
  });

  GitFileItem copyWith({bool? isStaged}) {
    return GitFileItem(
      path: path,
      state: state,
      isStaged: isStaged ?? this.isStaged,
    );
  }
}

class GitBranch {
  final String name;
  final bool isCurrent;

  const GitBranch({
    required this.name,
    this.isCurrent = false,
  });
}

class GitCommit {
  final String hash;
  final String author;
  final String message;
  final DateTime date;

  const GitCommit({
    required this.hash,
    required this.author,
    required this.message,
    required this.date,
  });
}

class GitDiffLine {
  final String content;
  final String type; // 'add', 'delete', 'normal'
  final int? oldLineNumber;
  final int? newLineNumber;

  const GitDiffLine({
    required this.content,
    required this.type,
    this.oldLineNumber,
    this.newLineNumber,
  });
}
