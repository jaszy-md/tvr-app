import 'package:flutter_test/flutter_test.dart';
import 'package:tvr_app/main.dart';

void main() {
  testWidgets('TVRApp toont welkomtekst op startscherm', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TVRApp());

    // Wacht op navigatie en animaties
    await tester.pumpAndSettle();

    // Zoek naar de tekst 'WELKOM' op de HomePage
    expect(find.text('WELKOM'), findsOneWidget);
  });

  testWidgets('TVRApp start zonder errors', (WidgetTester tester) async {
    await tester.pumpWidget(const TVRApp());
    expect(tester.takeException(), isNull);
  });
}
