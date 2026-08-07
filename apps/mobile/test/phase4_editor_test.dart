import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/editor/controllers/editor_controller.dart';
import 'package:codevanta_mobile/features/editor/presentation/code_editor_screen.dart';

void main() {
  test('EditorController tracks line counts, undo and redo history', () {
    final controller = EditorController(initialContent: 'Line 1\nLine 2');
    expect(controller.lineCount, 2);

    controller.updateContent('Line 1\nLine 2\nLine 3');
    expect(controller.lineCount, 3);
    expect(controller.isDirty, true);
    expect(controller.canUndo(), true);

    controller.undo();
    expect(controller.lineCount, 2);
    expect(controller.canRedo(), true);
  });

  testWidgets('Phase 4 - CodeEditorScreen renders line numbers and status bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const CodeEditorScreen(),
      ),
    );

    expect(find.text('main.dart'), findsWidgets);
    expect(find.text('UTF-8'), findsOneWidget);
    expect(find.text('Spaces: 2'), findsOneWidget);
  });
}
