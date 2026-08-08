import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/features/onboarding/presentation/onboarding_screen.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';

void main() {
  testWidgets('Phase 21 - OnboardingScreen renders slides and handles navigation', (WidgetTester tester) async {
    bool completed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: OnboardingScreen(
          onComplete: () {
            completed = true;
          },
        ),
      ),
    );

    // Verify slide 1 title
    expect(find.text('YOUR IDE. YOUR CODE. YOUR AI.'), findsOneWidget);

    // Tap Next button
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify slide 2 title
    expect(find.text('Multi-Provider AI Agents'), findsOneWidget);

    // Tap Next button to reach slide 3
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify slide 3 title and Get Started button
    expect(find.text('Local-First & Cloud Sandboxes'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap Get Started
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(completed, true);
  });
}
