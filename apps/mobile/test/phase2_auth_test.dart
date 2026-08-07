import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/core/theme/codevanta_theme.dart';
import 'package:codevanta_mobile/features/authentication/presentation/login_screen.dart';

void main() {
  testWidgets('Phase 2 - LoginScreen renders form inputs and auth actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CodeVantaTheme.darkTheme,
        home: const LoginScreen(),
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
  });
}
