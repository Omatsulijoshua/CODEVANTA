import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../editor/presentation/code_editor_screen.dart';
import '../../../terminal/presentation/terminal_screen.dart';

class MinimalWorkspaceLayout extends StatelessWidget {
  final VoidCallback onOpenPalette;

  const MinimalWorkspaceLayout({
    super.key,
    required this.onOpenPalette,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CodeEditorScreen(),

          // Floating Command & Terminal Buttons
          Positioned(
            bottom: 24,
            right: 24,
            child: Row(
              children: [
                FloatingActionButton(
                  heroTag: 'minimal_terminal_btn',
                  backgroundColor: CodeVantaColors.darkSurfaceCard,
                  elevation: 4,
                  child: const Icon(Icons.terminal, color: CodeVantaColors.cyanAccent),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TerminalScreen()));
                  },
                ),
                const SizedBox(width: 12),
                FloatingActionButton.extended(
                  heroTag: 'minimal_cmd_btn',
                  backgroundColor: CodeVantaColors.electricViolet,
                  elevation: 4,
                  icon: const Icon(Icons.bolt, color: Colors.white),
                  label: const Text('Commands', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  onPressed: onOpenPalette,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
