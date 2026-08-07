import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/inputs/search_input.dart';

class CommandActionItem {
  final String label;
  final String category;
  final IconData icon;
  final String? shortcut;
  final VoidCallback onExecute;

  const CommandActionItem({
    required this.label,
    required this.category,
    required this.icon,
    this.shortcut,
    required this.onExecute,
  });
}

class CommandPaletteModal extends StatefulWidget {
  final List<CommandActionItem> actions;

  const CommandPaletteModal({
    super.key,
    required this.actions,
  });

  static void show(BuildContext context, List<CommandActionItem> actions) {
    showDialog(
      context: context,
      builder: (_) => CommandPaletteModal(actions: actions),
    );
  }

  @override
  State<CommandPaletteModal> createState() => _CommandPaletteModalState();
}

class _CommandPaletteModalState extends State<CommandPaletteModal> {
  final _controller = TextEditingController();
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredActions = widget.actions
        .where((a) => a.label.toLowerCase().contains(_filter.toLowerCase()) || a.category.toLowerCase().contains(_filter.toLowerCase()))
        .toList();

    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(top: 60, left: 16, right: 16),
      backgroundColor: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder,
        ),
      ),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchInput(
              controller: _controller,
              hintText: 'Type a command or search actions (Cmd+Shift+P)...',
              onChanged: (val) => setState(() => _filter = val),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: filteredActions.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text('No matching commands found.'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredActions.length,
                      itemBuilder: (context, index) {
                        final item = filteredActions[index];
                        return ListTile(
                          dense: true,
                          leading: Icon(item.icon, size: 18, color: CodeVantaColors.electricViolet),
                          title: Text(item.label, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(item.category, style: const TextStyle(fontSize: 11)),
                          trailing: item.shortcut != null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: CodeVantaColors.electricViolet.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item.shortcut!,
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: CodeVantaColors.electricViolet),
                                  ),
                                )
                              : null,
                          onTap: () {
                            Navigator.pop(context);
                            item.onExecute();
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
