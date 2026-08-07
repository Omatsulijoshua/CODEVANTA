import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/workspace/presentation/workspace_screen.dart';
import 'package:codevanta_mobile/features/workspace/presentation/layouts/classic_workspace_layout.dart';
import 'package:codevanta_mobile/features/workspace/presentation/layouts/minimal_workspace_layout.dart';
import 'package:codevanta_mobile/features/workspace/presentation/layouts/focus_workspace_layout.dart';

void main() {
  testWidgets('Phase 5 - WorkspaceScreen renders Classic layout by default', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const WorkspaceScreen(),
      ),
    );

    expect(find.text('Workspace — CLASSIC'), findsOneWidget);
    expect(find.byType(ClassicWorkspaceLayout), findsOneWidget);
  });

  testWidgets('Phase 5 - Minimal and Focus layouts render cleanly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: Scaffold(body: MinimalWorkspaceLayout(onOpenPalette: () {})),
      ),
    );
    expect(find.text('Commands'), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const Scaffold(body: FocusWorkspaceLayout()),
      ),
    );
    expect(find.text('FOCUS MODE (Swipe for Tools)'), findsOneWidget);
  });
}
