import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/command_palette/services/command_registry_service.dart';
import 'package:codevanta_mobile/features/command_palette/presentation/global_command_palette_modal.dart';

void main() {
  test('CommandRegistryService registers commands and filters fuzzy search', () {
    final registry = CommandRegistryService();
    registry.registerDefaults(
      onNewFile: () {},
      onOpenGit: () {},
      onOpenAi: () {},
      onOpenTerminal: () {},
      onSwitchWorkspace: () {},
      onGlobalSearch: () {},
    );

    expect(registry.allCommands.isNotEmpty, true);
    final gitCmds = registry.search('Git');
    expect(gitCmds.isNotEmpty, true);
    expect(gitCmds.first.id, 'git.open');
  });

  testWidgets('Phase 14 - GlobalCommandPaletteModal renders command search and hotkey hints', (WidgetTester tester) async {
    final registry = CommandRegistryService();
    registry.registerDefaults(
      onNewFile: () {},
      onOpenGit: () {},
      onOpenAi: () {},
      onOpenTerminal: () {},
      onSwitchWorkspace: () {},
      onGlobalSearch: () {},
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: Scaffold(
          body: GlobalCommandPaletteModal(registryService: registry),
        ),
      ),
    );

    expect(find.text('Command Palette'), findsOneWidget);
    expect(find.text('Git: Open Touch Git Client'), findsOneWidget);
    expect(find.text('AI: Open AI Assistant Panel'), findsOneWidget);
  });
}
