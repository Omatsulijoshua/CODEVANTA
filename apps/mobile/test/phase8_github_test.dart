import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/github/presentation/github_screen.dart';

void main() {
  testWidgets('Phase 8 - GitHubScreen renders repositories, issues, and PR tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const GitHubScreen(),
      ),
    );

    expect(find.text('GitHub Integration'), findsOneWidget);
    expect(find.text('CONNECTED: @Omatsulijoshua'), findsOneWidget);
    expect(find.text('Repositories'), findsOneWidget);
    expect(find.text('Issues'), findsOneWidget);
    expect(find.text('Pull Requests'), findsOneWidget);
  });
}
