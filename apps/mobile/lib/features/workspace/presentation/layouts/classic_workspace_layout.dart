import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../../shared/widgets/cards/file_list_item.dart';
import '../../../editor/presentation/code_editor_screen.dart';

class ClassicWorkspaceLayout extends StatefulWidget {
  const ClassicWorkspaceLayout({super.key});

  @override
  State<ClassicWorkspaceLayout> createState() => _ClassicWorkspaceLayoutState();
}

class _ClassicWorkspaceLayoutState extends State<ClassicWorkspaceLayout> {
  bool _showExplorer = true;
  bool _showAiPanel = false;
  int _activeRailIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Row(
        children: [
          // Left Activity Rail
          Container(
            width: 50,
            color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
            child: Column(
              children: [
                const SizedBox(height: 12),
                IconButton(
                  icon: Icon(Icons.folder_outlined, color: _activeRailIndex == 0 ? CodeVantaColors.electricViolet : null),
                  onPressed: () => setState(() {
                    _activeRailIndex = 0;
                    _showExplorer = !_showExplorer;
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: _activeRailIndex == 1 ? CodeVantaColors.electricViolet : null),
                  onPressed: () => setState(() => _activeRailIndex = 1),
                ),
                IconButton(
                  icon: Icon(Icons.psychology_outlined, color: _activeRailIndex == 2 ? CodeVantaColors.electricViolet : null),
                  onPressed: () => setState(() => _showAiPanel = !_showAiPanel),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1, thickness: 1),

          // Left File Explorer Panel
          if (_showExplorer) ...[
            Container(
              width: 220,
              color: isDark ? CodeVantaColors.darkGraphite : CodeVantaColors.lightGraphite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'EXPLORER',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        FileListItem(fileName: 'lib', isFolder: true, onTap: () {}),
                        FileListItem(fileName: 'main.dart', isFolder: false, onTap: () {}),
                        FileListItem(fileName: 'app_config.dart', isFolder: false, onTap: () {}),
                        FileListItem(fileName: 'pubspec.yaml', isFolder: false, onTap: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(width: 1, thickness: 1),
          ],

          // Central Code Editor Viewport
          const Expanded(
            child: CodeEditorScreen(),
          ),

          // Right AI Panel
          if (_showAiPanel) ...[
            const VerticalDivider(width: 1, thickness: 1),
            Container(
              width: 260,
              color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.psychology, color: CodeVantaColors.electricViolet, size: 18),
                          SizedBox(width: 6),
                          Text('AI ASSISTANT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: () => setState(() => _showAiPanel = false),
                      ),
                    ],
                  ),
                  const Divider(),
                  const Expanded(
                    child: Center(
                      child: Text('Ask AI Agent to explain, edit, or refactor code...', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
