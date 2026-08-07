import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/ai/agent/domain/agent_permission_model.dart';
import 'package:codevanta_mobile/features/ai/agent/presentation/permission_dialog.dart';
import 'package:codevanta_mobile/features/ai/agent/presentation/ai_change_review_screen.dart';

void main() {
  testWidgets('Phase 11 - PermissionDialog renders permission request and action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: Scaffold(
          body: PermissionDialog(
            scope: PermissionScope.edit,
            actionDescription: 'Edit lib/main.dart',
            onResult: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('AI Permission Scope'), findsOneWidget);
    expect(find.text('Edit lib/main.dart'), findsOneWidget);
    expect(find.text('Deny'), findsOneWidget);
    expect(find.text('Allow Once'), findsOneWidget);
    expect(find.text('Always Allow'), findsOneWidget);
  });

  testWidgets('Phase 11 - AiChangeReviewScreen renders visual diffs and snapshot rollback button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const AiChangeReviewScreen(
          changes: [
            AiFileChange(
              filePath: 'lib/main.dart',
              oldContent: 'title: "Old Title"',
              newContent: 'title: "CodeVanta AI IDE"',
            ),
          ],
        ),
      ),
    );

    expect(find.text('Review AI Generated Changes'), findsOneWidget);
    expect(find.text('SNAPSHOT PROTECTED'), findsOneWidget);
    expect(find.text('Rollback Snapshot'), findsOneWidget);
    expect(find.text('Accept All Files'), findsOneWidget);
  });
}
