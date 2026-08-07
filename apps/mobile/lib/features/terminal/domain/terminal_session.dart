class TerminalSession {
  final String id;
  final String title;
  final List<String> lines;
  final List<String> history;
  int historyIndex;

  TerminalSession({
    required this.id,
    required this.title,
    List<String>? lines,
    List<String>? history,
    this.historyIndex = -1,
  })  : lines = lines ?? ['CodeVanta Local Shell v1.0.0', 'Type "help" for available commands.'],
        history = history ?? [];

  void addCommand(String cmd) {
    lines.add('\$ $cmd');
    if (cmd.isNotEmpty) {
      history.add(cmd);
      historyIndex = history.length;
    }
  }

  void addOutput(String output) {
    lines.add(output);
  }
}
