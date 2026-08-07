import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/design_system/design_system_screen.dart';

void main() {
  testWidgets('Phase 1 - Design system components render in Dark and Light themes', (WidgetTester tester) async {
    // Dark Theme Verification
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const DesignSystemScreen(),
      ),
    );

    expect(find.text('CODEVANTA'), findsWidgets);
    expect(find.text('Create New Project'), findsOneWidget);

    // Light Theme Verification
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.lightTheme,
        home: const DesignSystemScreen(),
      ),
    );

    expect(find.text('CODEVANTA'), findsWidgets);
    expect(find.text('Create New Project'), findsOneWidget);
  });
}
