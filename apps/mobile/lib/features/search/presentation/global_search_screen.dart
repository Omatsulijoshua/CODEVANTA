import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';
import '../../../shared/widgets/editor/status_pill.dart';
import '../../../shared/widgets/inputs/search_input.dart';
import '../domain/search_result_model.dart';
import '../services/search_engine.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final _searchEngine = SearchEngine();
  final _controller = TextEditingController();
  String _query = '';
  bool _useRegex = false;
  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fileResults = _searchEngine.searchFilenames(_query);
    final contentResults = _searchEngine.searchContent(_query, isRegex: _useRegex);
    final symbolResults = _searchEngine.indexSymbols().where((s) => s.name.toLowerCase().contains(_query.toLowerCase())).toList();

    List<dynamic> activeResults = [];
    if (_selectedFilterIndex == 0) {
      activeResults = [...fileResults, ...contentResults];
    } else if (_selectedFilterIndex == 1) {
      activeResults = fileResults;
    } else if (_selectedFilterIndex == 2) {
      activeResults = contentResults;
    } else if (_selectedFilterIndex == 3) {
      activeResults = symbolResults;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Search & Indexing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchInput(
                    controller: _controller,
                    hintText: 'Search files, text, symbols (regex supported)...',
                    onChanged: (val) => setState(() => _query = val),
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Regex .*'),
                  selected: _useRegex,
                  onSelected: (val) => setState(() => _useRegex = val),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Search Filter Segment Control
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: Text('All (${fileResults.length + contentResults.length})'),
                    selected: _selectedFilterIndex == 0,
                    onSelected: (_) => setState(() => _selectedFilterIndex = 0),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: Text('Files (${fileResults.length})'),
                    selected: _selectedFilterIndex == 1,
                    onSelected: (_) => setState(() => _selectedFilterIndex = 1),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: Text('Content (${contentResults.length})'),
                    selected: _selectedFilterIndex == 2,
                    onSelected: (_) => setState(() => _selectedFilterIndex = 2),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: Text('Symbols (${symbolResults.length})'),
                    selected: _selectedFilterIndex == 3,
                    onSelected: (_) => setState(() => _selectedFilterIndex = 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Search Results List
            Expanded(
              child: _query.isEmpty
                  ? Center(
                      child: Text(
                        'Type to search project files, content, or symbols...',
                        style: TextStyle(
                          color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
                        ),
                      ),
                    )
                  : activeResults.isEmpty
                      ? const Center(child: Text('No matching search results.'))
                      : ListView.builder(
                          itemCount: activeResults.length,
                          itemBuilder: (context, index) {
                            final item = activeResults[index];
                            if (item is SearchMatch) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: Icon(
                                    item.type == SearchResultType.file ? Icons.insert_drive_file : Icons.code,
                                    color: CodeVantaColors.electricViolet,
                                  ),
                                  title: Text(item.fileName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('Line ${item.lineNumber}: ${item.snippet}'),
                                  trailing: StatusPill(
                                    label: item.type.name.toUpperCase(),
                                    type: item.type == SearchResultType.file ? StatusType.success : StatusType.info,
                                  ),
                                ),
                              );
                            } else if (item is SymbolItem) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: const Icon(Icons.token, color: CodeVantaColors.cyanAccent),
                                  title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('${item.filePath}:${item.lineNumber}'),
                                  trailing: StatusPill(label: item.kind.toUpperCase(), type: StatusType.warning),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
