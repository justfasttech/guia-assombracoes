import 'package:flutter_test/flutter_test.dart';
import 'package:betrayal_app/app.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const BetrayalApp());
    expect(find.text('BETRAYAL'), findsOneWidget);
  });
}
