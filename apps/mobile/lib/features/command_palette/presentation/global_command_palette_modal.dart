import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/search_input.dart';
import '../services/command_registry_service.dart';

class GlobalCommandPaletteModal extends StatefulWidget {
  final CommandRegistryService registryService;

  const GlobalCommandPaletteModal({
    super.key,
    required this.registryService,
  });

  static void show(BuildContext context, CommandRegistryService registry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => GlobalCommandPaletteModal(registryService: registry),
    );
  }

  @override
  State<GlobalCommandPaletteModal> createState() => _GlobalCommandPaletteModalState();
}

class _GlobalCommandPaletteModalState extends State<GlobalCommandPaletteModal> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final results = widget.registryService.search(_query);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(
          color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.bolt, color: CodeVantaColors.electricViolet, size: 22),
                  SizedBox(width: 8),
                  Text('Command Palette', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SearchInput(
            controller: _searchController,
            hintText: 'Type a command or search... (Cmd+Shift+P)',
            onChanged: (val) => setState(() => _query = val),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: results.isEmpty
                ? const Center(child: Text('No matching IDE commands found.'))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final cmd = results[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(cmd.icon, color: CodeVantaColors.electricViolet),
                          title: Text(cmd.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (cmd.shortcutHint != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    color: isDark ? CodeVantaColors.darkGraphite : CodeVantaColors.lightGraphite,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(cmd.shortcutHint!, style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
                                ),
                              StatusPill(label: cmd.category.name.toUpperCase(), type: StatusType.info),
                            ],
                          ),
                          onTap: () {
                            widget.registryService.markRecent(cmd.id);
                            Navigator.pop(context);
                            cmd.onExecute();
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
