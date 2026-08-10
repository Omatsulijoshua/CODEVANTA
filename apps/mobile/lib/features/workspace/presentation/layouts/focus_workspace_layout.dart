import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../editor/presentation/code_editor_screen.dart';
import '../../../terminal/presentation/terminal_screen.dart';

class FocusWorkspaceLayout extends StatelessWidget {
  const FocusWorkspaceLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(title: const Text('File Explorer')),
            ListBody(
              children: [
                const ListTile(leading: Icon(Icons.folder), title: Text('lib')),
                const ListTile(leading: Icon(Icons.code), title: Text('main.dart')),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.terminal, color: CodeVantaColors.cyanAccent),
                  title: const Text('Open Terminal Shell'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TerminalScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            AppBar(title: const Text('AI Coding Assistant')),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Ask AI Agent to inspect or edit full-screen workspace...'),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! > 200) {
              Scaffold.of(context).openDrawer();
            } else if (details.primaryVelocity! < -200) {
              Scaffold.of(context).openEndDrawer();
            }
          }
        },
        child: Stack(
          children: [
            const CodeEditorScreen(),

            // Gesture hint indicator
            Positioned(
              top: 10,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: CodeVantaColors.electricViolet.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('FOCUS MODE (Swipe for Tools)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: CodeVantaColors.cyanAccent)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
