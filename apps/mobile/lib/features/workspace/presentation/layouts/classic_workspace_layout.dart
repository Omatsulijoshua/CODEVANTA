import 'package:flutter/material.dart';
import '../../../../core/theme/codevanta_colors.dart';
import '../../../../core/services/termux_launcher_service.dart';
import '../../../../shared/widgets/cards/file_list_item.dart';
import '../../../ai/presentation/ai_chat_panel.dart';
import '../../../billing/presentation/billing_screen.dart';
import '../../../editor/presentation/code_editor_screen.dart';
import '../../../extensions/presentation/extensions_screen.dart';
import '../../../git/presentation/git_screen.dart';
import '../../../github/presentation/github_screen.dart';
import '../../../search/presentation/global_search_screen.dart';
import '../../../../shared/widgets/inputs/codevanta_text_field.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';

class WorkspaceFileItem {
  final String fileName;
  final String content;
  final bool isFolder;

  WorkspaceFileItem({
    required this.fileName,
    required this.content,
    this.isFolder = false,
  });
}

class ClassicWorkspaceLayout extends StatefulWidget {
  const ClassicWorkspaceLayout({super.key});

  @override
  State<ClassicWorkspaceLayout> createState() => _ClassicWorkspaceLayoutState();
}

class _ClassicWorkspaceLayoutState extends State<ClassicWorkspaceLayout> {
  bool _showExplorer = true;
  bool _showAiPanel = false;
  int _activeRailIndex = 0;

  final List<WorkspaceFileItem> _files = [
    WorkspaceFileItem(
      fileName: 'main.dart',
      content: '''void main() {
  print("Hello CodeVanta Mobile AI IDE!");
}''',
    ),
    WorkspaceFileItem(
      fileName: 'app_config.dart',
      content: '''class AppConfig {
  static const String appName = 'CodeVanta';
  static const String apiBaseUrl = 'https://codevanta-backend-api.onrender.com/api/v1';
}''',
    ),
    WorkspaceFileItem(
      fileName: 'pubspec.yaml',
      content: '''name: codevanta_mobile
description: CodeVanta Mobile AI IDE Client
version: 1.0.0+1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  flutter:
    sdk: flutter''',
    ),
    WorkspaceFileItem(
      fileName: 'README.md',
      content: '''# CodeVanta Mobile IDE
Your IDE. Your Code. Your AI.
Cross-platform mobile IDE for iOS, Android, and Web.''',
    ),
    WorkspaceFileItem(
      fileName: 'contracts.sol',
      content: '''// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CodeVantaToken {
    string public name = "CodeVanta Token";
    string public symbol = "VNT";
}''',
    ),
  ];

  int _activeFileIndex = 0;

  void _openFile(int index) {
    setState(() {
      _activeFileIndex = index;
    });
  }

  void _showNewFileDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create New File', style: TextStyle(fontWeight: FontWeight.bold)),
        content: CodeVantaTextField(
          label: 'File Name',
          hintText: 'e.g. server.ts, app.py, contract.sol',
          controller: nameController,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          PrimaryButton(
            label: 'Create File',
            fullWidth: false,
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _files.add(
                    WorkspaceFileItem(
                      fileName: nameController.text,
                      content: '// New file: ${nameController.text}\n',
                    ),
                  );
                  _activeFileIndex = _files.length - 1;
                });
                Navigator.pop(ctx);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeFile = _files[_activeFileIndex];

    return Scaffold(
      body: Row(
        children: [
          // Left Activity Rail
          Container(
            width: 52,
            color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
            child: Column(
              children: [
                const SizedBox(height: 12),
                IconButton(
                  tooltip: 'File Explorer',
                  icon: Icon(Icons.folder_outlined, color: _activeRailIndex == 0 ? CodeVantaColors.electricViolet : null),
                  onPressed: () => setState(() {
                    _activeRailIndex = 0;
                    _showExplorer = !_showExplorer;
                  }),
                ),
                IconButton(
                  tooltip: 'Global Search',
                  icon: Icon(Icons.search, color: _activeRailIndex == 1 ? CodeVantaColors.electricViolet : null),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GlobalSearchScreen()));
                  },
                ),
                IconButton(
                  tooltip: 'Git Version Control',
                  icon: Icon(Icons.fork_right_outlined, color: _activeRailIndex == 2 ? CodeVantaColors.electricViolet : null),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GitScreen()));
                  },
                ),
                IconButton(
                  tooltip: 'GitHub Integration',
                  icon: Icon(Icons.hub_outlined, color: _activeRailIndex == 3 ? CodeVantaColors.electricViolet : null),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GitHubScreen()));
                  },
                ),
                IconButton(
                  tooltip: 'Termux / Cloud Terminal',
                  icon: Icon(Icons.terminal, color: _activeRailIndex == 4 ? CodeVantaColors.cyanAccent : null),
                  onPressed: () {
                    TermuxLauncherService.openTermuxOrFallback(context);
                  },
                ),
                IconButton(
                  tooltip: 'AI Assistant',
                  icon: Icon(Icons.psychology_outlined, color: _activeRailIndex == 5 ? CodeVantaColors.electricViolet : null),
                  onPressed: () => setState(() => _showAiPanel = !_showAiPanel),
                ),
                IconButton(
                  tooltip: 'Extensions Marketplace',
                  icon: Icon(Icons.extension_outlined, color: _activeRailIndex == 6 ? CodeVantaColors.electricViolet : null),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ExtensionsScreen()));
                  },
                ),
                IconButton(
                  tooltip: 'Billing & Plans',
                  icon: Icon(Icons.card_membership_outlined, color: _activeRailIndex == 7 ? CodeVantaColors.electricViolet : null),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const BillingScreen()));
                  },
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
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EXPLORER',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                            letterSpacing: 1.0,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.note_add_outlined, size: 18),
                          tooltip: 'New File',
                          onPressed: _showNewFileDialog,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        final file = _files[index];
                        return FileListItem(
                          fileName: file.fileName,
                          isFolder: file.isFolder,
                          onTap: () => _openFile(index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(width: 1, thickness: 1),
          ],

          // Central Code Editor Viewport
          Expanded(
            child: KeyedSubtree(
              key: ValueKey(activeFile.fileName),
              child: CodeEditorScreen(
                fileName: activeFile.fileName,
                initialCode: activeFile.content,
              ),
            ),
          ),

          // Right AI Assistant Panel
          if (_showAiPanel) ...[
            const VerticalDivider(width: 1, thickness: 1),
            SizedBox(
              width: 320,
              child: Stack(
                children: [
                  const AiChatPanel(),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () => setState(() => _showAiPanel = false),
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
