import 'package:flutter_test/flutter_test.dart';
import 'package:codevanta_mobile/main.dart';

void main() {
  testWidgets('Splash screen loads CodeVanta branding', (WidgetTester tester) async {
    await tester.pumpWidget(const CodeVantaApp());

    expect(find.text('CODEVANTA'), findsOneWidget);
    expect(find.text('YOUR IDE. YOUR CODE. YOUR AI.'), findsOneWidget);
  });
}
