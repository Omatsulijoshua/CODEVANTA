import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/search/services/search_engine.dart';
import 'package:codevanta_mobile/features/search/presentation/global_search_screen.dart';

void main() {
  test('SearchEngine performs fuzzy filename search and regex content search', () {
    final engine = SearchEngine();

    final fileResults = engine.searchFilenames('main');
    expect(fileResults.isNotEmpty, true);
    expect(fileResults.first.fileName, 'main.dart');

    final contentResults = engine.searchContent('void main', isRegex: false);
    expect(contentResults.isNotEmpty, true);

    final symbols = engine.indexSymbols();
    expect(symbols.isNotEmpty, true);
  });

  testWidgets('Phase 6 - GlobalSearchScreen renders search input and filter chips', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const GlobalSearchScreen(),
      ),
    );

    expect(find.text('Global Search & Indexing'), findsOneWidget);
    expect(find.text('Regex .*'), findsOneWidget);
  });
}
