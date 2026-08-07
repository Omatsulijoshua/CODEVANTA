enum WorkspaceStyle { classic, minimal, focus }

class WorkspaceConfig {
  final WorkspaceStyle style;
  final bool showExplorer;
  final bool showAiPanel;
  final bool showTerminal;

  const WorkspaceConfig({
    this.style = WorkspaceStyle.classic,
    this.showExplorer = true,
    this.showAiPanel = false,
    this.showTerminal = false,
  });

  WorkspaceConfig copyWith({
    WorkspaceStyle? style,
    bool? showExplorer,
    bool? showAiPanel,
    bool? showTerminal,
  }) {
    return WorkspaceConfig(
      style: style ?? this.style,
      showExplorer: showExplorer ?? this.showExplorer,
      showAiPanel: showAiPanel ?? this.showAiPanel,
      showTerminal: showTerminal ?? this.showTerminal,
    );
  }
}
