import '../domain/search_result_model.dart';

class SearchEngine {
  final Map<String, String> _fileCache; // filePath -> content

  SearchEngine({Map<String, String>? fileCache})
      : _fileCache = fileCache ??
            {
              '/lib/main.dart': '''import 'package:flutter/material.dart';
import 'core/theme/codevanta_theme.dart';

void main() {
  runApp(const CodeVantaApp());
}

class CodeVantaApp extends StatelessWidget {
  const CodeVantaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'CodeVanta');
  }
}''',
              '/lib/core/theme/codevanta_theme.dart': '''import 'package:flutter/material.dart';

class CodeVantaTheme {
  static const Color darkGraphite = Color(0xFF12121A);
  static const Color electricViolet = Color(0xFF6E00FF);
}''',
              '/pubspec.yaml': '''name: codevanta_mobile
version: 0.1.0
dependencies:
  flutter:
    sdk: flutter''',
            };

  List<SearchMatch> searchFilenames(String query) {
    if (query.isEmpty) return [];
    final results = <SearchMatch>[];
    final q = query.toLowerCase();

    for (final entry in _fileCache.entries) {
      final fileName = entry.key.split('/').last;
      if (fileName.toLowerCase().contains(q)) {
        results.add(SearchMatch(
          filePath: entry.key,
          fileName: fileName,
          type: SearchResultType.file,
          snippet: entry.key,
        ));
      }
    }
    return results;
  }

  List<SearchMatch> searchContent(String query, {bool isRegex = false}) {
    if (query.isEmpty) return [];
    final results = <SearchMatch>[];

    for (final entry in _fileCache.entries) {
      final fileName = entry.key.split('/').last;
      final lines = entry.value.split('\n');

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        bool isMatch = false;

        if (isRegex) {
          try {
            isMatch = RegExp(query).hasMatch(line);
          } catch (_) {
            isMatch = false;
          }
        } else {
          isMatch = line.toLowerCase().contains(query.toLowerCase());
        }

        if (isMatch) {
          results.add(SearchMatch(
            filePath: entry.key,
            fileName: fileName,
            type: SearchResultType.content,
            lineNumber: i + 1,
            snippet: line.trim(),
          ));
        }
      }
    }
    return results;
  }

  List<SymbolItem> indexSymbols() {
    final symbols = <SymbolItem>[];

    for (final entry in _fileCache.entries) {
      final lines = entry.value.split('\n');
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.startsWith('class ')) {
          final className = line.split(' ')[1];
          symbols.add(SymbolItem(
            name: className,
            kind: 'class',
            filePath: entry.key,
            lineNumber: i + 1,
          ));
        } else if (line.contains('void ') || line.contains('Widget build')) {
          symbols.add(SymbolItem(
            name: line.split('(')[0],
            kind: 'function',
            filePath: entry.key,
            lineNumber: i + 1,
          ));
        }
      }
    }
    return symbols;
  }
}
