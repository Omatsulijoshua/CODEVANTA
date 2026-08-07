import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/terminal/domain/terminal_session.dart';
import 'package:codevanta_mobile/features/terminal/presentation/terminal_screen.dart';

void main() {
  test('TerminalSession adds commands and history', () {
    final session = TerminalSession(id: '1', title: 'zsh');

    session.addCommand('flutter test');
    expect(session.lines.last, '\$ flutter test');
    expect(session.history.last, 'flutter test');
  });

  testWidgets('Phase 13 - TerminalScreen renders session tabs, terminal output, and quick key bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const TerminalScreen(),
      ),
    );

    expect(find.text('zsh — 1'), findsOneWidget);
    expect(find.text('Tab'), findsOneWidget);
    expect(find.text('Ctrl+C'), findsOneWidget);
    expect(find.text('~'), findsOneWidget);
  });
}
