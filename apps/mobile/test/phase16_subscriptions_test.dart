import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/billing/presentation/paywall_modal.dart';
import 'package:codevanta_mobile/features/billing/presentation/billing_screen.dart';

void main() {
  testWidgets('Phase 16 - BillingScreen renders plan status and usage meters', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const BillingScreen(),
      ),
    );

    expect(find.text('Subscriptions & Entitlements'), findsOneWidget);
    expect(find.text('CodeVanta Pro Plan'), findsOneWidget);
    expect(find.text('Cloud AI Queries'), findsOneWidget);
    expect(find.text('Cloud Runner Hours'), findsOneWidget);
  });

  testWidgets('Phase 16 - PaywallModal renders pricing tiers and trial button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: Scaffold(
          body: PaywallModal(onUpgrade: () {}),
        ),
      ),
    );

    expect(find.text('Upgrade to CodeVanta Pro'), findsOneWidget);
    expect(find.text('Start Pro Trial — \$19 / month'), findsOneWidget);
  });
}
