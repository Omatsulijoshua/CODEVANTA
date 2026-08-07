import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/git/services/git_service.dart';
import 'package:codevanta_mobile/features/git/presentation/git_screen.dart';

void main() {
  test('GitService stages files, creates branches, and commits', () {
    final service = GitService();

    expect(service.statusList.isNotEmpty, true);
    service.stageAll();
    expect(service.statusList.every((f) => f.isStaged), true);

    final commit = service.commit('feat: test commit', 'Test Author');
    expect(commit.message, 'feat: test commit');
    expect(service.commits.first.message, 'feat: test commit');

    service.createBranch('feature/test');
    expect(service.branches.any((b) => b.name == 'feature/test'), true);
  });

  testWidgets('Phase 7 - GitScreen renders changes, branches, and log tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const GitScreen(),
      ),
    );

    expect(find.text('Git Client'), findsOneWidget);
    expect(find.text('Changes'), findsOneWidget);
    expect(find.text('Branches'), findsOneWidget);
    expect(find.text('History Log'), findsOneWidget);
  });
}
