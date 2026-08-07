import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../editor/presentation/code_editor_screen.dart';

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

          // Floating Glassmorphic Quick Command Bar
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton.extended(
              backgroundColor: CodeVantaColors.electricViolet,
              elevation: 4,
              icon: const Icon(Icons.bolt, color: Colors.white),
              label: const Text('Commands', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: onOpenPalette,
            ),
          ),
        ],
      ),
    );
  }
}
