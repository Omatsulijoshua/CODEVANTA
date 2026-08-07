import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../domain/workspace_style.dart';
import 'layouts/classic_workspace_layout.dart';
import 'layouts/focus_workspace_layout.dart';
import 'layouts/minimal_workspace_layout.dart';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({super.key});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  WorkspaceStyle _activeStyle = WorkspaceStyle.classic;

  void _showWorkspaceStyleSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose Workspace Style', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.dashboard_outlined, color: CodeVantaColors.electricViolet),
              title: const Text('Style A — CLASSIC'),
              subtitle: const Text('Desktop IDE layout (Rail, Explorer, Tabs, AI Panel)'),
              trailing: _activeStyle == WorkspaceStyle.classic ? const Icon(Icons.check_circle, color: CodeVantaColors.electricViolet) : null,
              onTap: () {
                setState(() => _activeStyle = WorkspaceStyle.classic);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.crop_square_outlined, color: CodeVantaColors.cyanAccent),
              title: const Text('Style B — MINIMAL'),
              subtitle: const Text('Minimalist editor view with floating action palette'),
              trailing: _activeStyle == WorkspaceStyle.minimal ? const Icon(Icons.check_circle, color: CodeVantaColors.electricViolet) : null,
              onTap: () {
                setState(() => _activeStyle = WorkspaceStyle.minimal);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fullscreen, color: Colors.amber),
              title: const Text('Style C — FOCUS'),
              subtitle: const Text('Full-screen editor with edge swipe gestures'),
              trailing: _activeStyle == WorkspaceStyle.focus ? const Icon(Icons.check_circle, color: CodeVantaColors.electricViolet) : null,
              onTap: () {
                setState(() => _activeStyle = WorkspaceStyle.focus);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workspace — ${_activeStyle.name.toUpperCase()}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Switch Workspace Style',
            onPressed: _showWorkspaceStyleSelector,
          ),
        ],
      ),
      body: switch (_activeStyle) {
        WorkspaceStyle.classic => const ClassicWorkspaceLayout(),
        WorkspaceStyle.minimal => MinimalWorkspaceLayout(onOpenPalette: () {}),
        WorkspaceStyle.focus => const FocusWorkspaceLayout(),
      },
    );
  }
}
