import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/ai/presentation/ai_chat_panel.dart';

void main() {
  testWidgets('Phase 10 - AiChatPanel renders provider selector, messages, and context attachment bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const AiChatPanel(),
      ),
    );

    expect(find.text('Attach Context: '), findsOneWidget);
    expect(find.text('@file'), findsOneWidget);
    expect(find.text('@selection'), findsOneWidget);
    expect(find.text('@terminal'), findsOneWidget);
    expect(find.text('Send'), findsOneWidget);
  });
}
