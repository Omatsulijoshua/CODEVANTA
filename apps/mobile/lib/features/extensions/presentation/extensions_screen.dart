import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/buttons/ghost_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/search_input.dart';
import '../domain/extension_manifest_model.dart';
import '../services/extension_manager_service.dart';

class ExtensionsScreen extends StatefulWidget {
  const ExtensionsScreen({super.key});

  @override
  State<ExtensionsScreen> createState() => _ExtensionsScreenState();
}

class _ExtensionsScreenState extends State<ExtensionsScreen> {
  final _managerService = ExtensionManagerService();
  String _searchQuery = '';
  ExtensionType? _selectedTypeFilter;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final extensions = _managerService.marketplace.where((ext) {
      final matchesQuery = ext.name.toLowerCase().contains(_searchQuery.toLowerCase()) || ext.publisher.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesType = _selectedTypeFilter == null || ext.type == _selectedTypeFilter;
      return matchesQuery && matchesType;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extension Marketplace'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchInput(
              hintText: 'Search themes, syntax, AI prompt agents, tools...',
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 12),

            // Type Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('All Types'),
                    selected: _selectedTypeFilter == null,
                    onSelected: (_) => setState(() => _selectedTypeFilter = null),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: const Text('Themes'),
                    selected: _selectedTypeFilter == ExtensionType.theme,
                    onSelected: (_) => setState(() => _selectedTypeFilter = ExtensionType.theme),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: const Text('AI Agents'),
                    selected: _selectedTypeFilter == ExtensionType.aiAgent,
                    onSelected: (_) => setState(() => _selectedTypeFilter = ExtensionType.aiAgent),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: const Text('Syntax'),
                    selected: _selectedTypeFilter == ExtensionType.syntax,
                    onSelected: (_) => setState(() => _selectedTypeFilter = ExtensionType.syntax),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: const Text('Tools'),
                    selected: _selectedTypeFilter == ExtensionType.tool,
                    onSelected: (_) => setState(() => _selectedTypeFilter = ExtensionType.tool),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Extensions Grid / List
            Expanded(
              child: extensions.isEmpty
                  ? const Center(child: Text('No extensions found.'))
                  : ListView.builder(
                      itemCount: extensions.length,
                      itemBuilder: (context, index) {
                        final ext = extensions[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(ext.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                          Text('${ext.publisher} • v${ext.version}', style: TextStyle(fontSize: 12, color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary)),
                                        ],
                                      ),
                                    ),
                                    StatusPill(
                                      label: ext.type.name.toUpperCase(),
                                      type: ext.type == ExtensionType.aiAgent ? StatusType.warning : StatusType.info,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(ext.description, style: const TextStyle(fontSize: 13)),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (ext.permissions.isNotEmpty)
                                      Row(
                                        children: [
                                          const Icon(Icons.security, size: 14, color: CodeVantaColors.warningAmber),
                                          const SizedBox(width: 4),
                                          Text(ext.permissions.join(', '), style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
                                        ],
                                      )
                                    else
                                      const SizedBox.shrink(),
                                    Row(
                                      children: [
                                        if (ext.isInstalled) ...[
                                          GhostButton(
                                            label: ext.isEnabled ? 'Disable' : 'Enable',
                                            onPressed: () => setState(() => _managerService.toggleEnable(ext.id)),
                                          ),
                                          const SizedBox(width: 8),
                                          SecondaryButton(
                                            label: 'Uninstall',
                                            onPressed: () => setState(() => _managerService.toggleInstall(ext.id)),
                                          ),
                                        ] else
                                          PrimaryButton(
                                            label: 'Install Extension',
                                            fullWidth: false,
                                            onPressed: () => setState(() => _managerService.toggleInstall(ext.id)),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
