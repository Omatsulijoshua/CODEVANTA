import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/projects/presentation/project_list_screen.dart';
import 'package:codevanta_mobile/features/projects/presentation/project_detail_screen.dart';
import 'package:codevanta_mobile/features/projects/domain/project_model.dart';

void main() {
  testWidgets('Phase 3 - ProjectListScreen displays local projects and offline status', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const ProjectListScreen(),
      ),
    );

    expect(find.text('Local Projects'), findsOneWidget);
    expect(find.text('OFFLINE MODE'), findsOneWidget);
    expect(find.text('CodeVanta IDE Client'), findsOneWidget);
  });

  testWidgets('Phase 3 - ProjectDetailScreen displays files and snapshot manager tabs', (WidgetTester tester) async {
    final proj = ProjectModel(
      id: 'test_id',
      name: 'Test App',
      path: '/local/test_app',
      language: 'Dart/Flutter',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: ProjectDetailScreen(project: proj),
      ),
    );

    expect(find.text('Test App'), findsWidgets);
    expect(find.text('File Explorer'), findsOneWidget);
    expect(find.text('Snapshots'), findsOneWidget);
  });
}
