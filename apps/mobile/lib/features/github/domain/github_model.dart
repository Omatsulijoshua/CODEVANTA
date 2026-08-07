class GitHubRepo {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final bool isPrivate;
  final int stars;
  final String language;

  const GitHubRepo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.isPrivate,
    required this.stars,
    required this.language,
  });
}

class GitHubIssue {
  final int number;
  final String title;
  final String state;
  final String author;

  const GitHubIssue({
    required this.number,
    required this.title,
    required this.state,
    required this.author,
  });
}

class GitHubPullRequest {
  final int number;
  final String title;
  final String state;
  final String author;
  final String branch;

  const GitHubPullRequest({
    required this.number,
    required this.title,
    required this.state,
    required this.author,
    required this.branch,
  });
}
