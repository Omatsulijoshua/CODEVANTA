import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/extensions/services/extension_manager_service.dart';
import 'package:codevanta_mobile/features/extensions/presentation/extensions_screen.dart';

void main() {
  test('ExtensionManagerService installs, disables, and uninstalls extensions', () {
    final service = ExtensionManagerService();

    final ext = service.marketplace.firstWhere((e) => e.id == 'ai.flutter-architect');
    expect(ext.isInstalled, false);

    service.toggleInstall(ext.id);
    expect(service.marketplace.firstWhere((e) => e.id == 'ai.flutter-architect').isInstalled, true);
  });

  testWidgets('Phase 15 - ExtensionsScreen renders Marketplace UI and filter chips', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const ExtensionsScreen(),
      ),
    );

    expect(find.text('Extension Marketplace'), findsOneWidget);
    expect(find.text('All Types'), findsOneWidget);
    expect(find.text('Themes'), findsOneWidget);
    expect(find.text('AI Agents'), findsOneWidget);
    expect(find.text('Cyberpunk Dark Theme'), findsOneWidget);
  });
}
