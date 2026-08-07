import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/editor/breadcrumb_bar.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/editor/tab_item_widget.dart';
import '../controllers/editor_controller.dart';
import 'command_palette_modal.dart';
import 'search_replace_bar.dart';

class CodeEditorScreen extends StatefulWidget {
  final String fileName;
  final String initialCode;

  const CodeEditorScreen({
    super.key,
    this.fileName = 'main.dart',
    this.initialCode = '''void main() {
  print("Hello CodeVanta IDE!");
}''',
  });

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  late EditorController _controller;
  late TextEditingController _textEditingController;
  final _searchController = TextEditingController();
  final _replaceController = TextEditingController();
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    _controller = EditorController(initialContent: widget.initialCode);
    _textEditingController = TextEditingController(text: widget.initialCode);
  }

  void _openCommandPalette() {
    CommandPaletteModal.show(context, [
      CommandActionItem(
        label: 'Save File',
        category: 'File',
        icon: Icons.save_outlined,
        shortcut: 'Cmd+S',
        onExecute: () {
          _controller.markClean();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File ${widget.fileName} saved.')),
          );
        },
      ),
      CommandActionItem(
        label: 'Find in File',
        category: 'Edit',
        icon: Icons.search,
        shortcut: 'Cmd+F',
        onExecute: () => setState(() => _showSearch = true),
      ),
      CommandActionItem(
        label: 'Format Document',
        category: 'Format',
        icon: Icons.auto_awesome,
        shortcut: 'Shift+Alt+F',
        onExecute: () {},
      ),
      CommandActionItem(
        label: 'Create Snapshot',
        category: 'Project',
        icon: Icons.camera_alt_outlined,
        onExecute: () {},
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final lineCount = _controller.lineCount;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                TabItemWidget(
                  fileName: widget.fileName,
                  isActive: true,
                  isDirty: _controller.isDirty,
                  onTap: () {},
                  onClose: () {},
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.undo, size: 20),
                onPressed: _controller.canUndo() ? () => _controller.undo() : null,
              ),
              IconButton(
                icon: const Icon(Icons.redo, size: 20),
                onPressed: _controller.canRedo() ? () => _controller.redo() : null,
              ),
              IconButton(
                icon: const Icon(Icons.terminal, size: 20),
                onPressed: _openCommandPalette,
              ),
            ],
          ),
          body: Column(
            children: [
              BreadcrumbBar(pathSegments: ['lib', widget.fileName]),
              if (_showSearch)
                SearchReplaceBar(
                  searchController: _searchController,
                  replaceController: _replaceController,
                  onSearchChanged: (q) => _controller.search(q),
                  onReplaceAll: () => _controller.replaceAll(_searchController.text, _replaceController.text),
                  onClose: () => setState(() => _showSearch = false),
                ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Line numbers gutter
                    Container(
                      width: 44,
                      color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: List.generate(
                          lineCount,
                          (i) => SizedBox(
                            height: 22,
                            child: Text(
                              '${i + 1}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1, thickness: 1),
                    // Code Editor Text Area
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _textEditingController,
                          maxLines: null,
                          style: const TextStyle(fontFamily: 'monospace', fontSize: 14, height: 1.5),
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) => _controller.updateContent(val),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Editor Status Bar
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Ln ${_controller.cursorLine}, Col ${_controller.cursorColumn}', style: const TextStyle(fontSize: 11)),
                        const SizedBox(width: 12),
                        const Text('UTF-8', style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 12),
                        const Text('Spaces: 2', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                    const StatusPill(label: 'Dart', type: StatusType.info),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
