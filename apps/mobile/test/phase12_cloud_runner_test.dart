import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/cloud_runner/presentation/cloud_runner_screen.dart';

void main() {
  testWidgets('Phase 12 - CloudRunnerScreen renders terminal output and container execution toolbar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const CloudRunnerScreen(),
      ),
    );

    expect(find.text('Cloud Runner Sandbox'), findsOneWidget);
    expect(find.text('CONTAINER: RUNNING'), findsOneWidget);
    expect(find.text('Run Build'), findsOneWidget);
    expect(find.text('Run Tests'), findsOneWidget);
    expect(find.text('Run Lint'), findsOneWidget);
    expect(find.text('Kill Sandbox'), findsOneWidget);
  });
}
