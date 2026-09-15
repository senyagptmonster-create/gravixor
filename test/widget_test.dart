import 'package:flutter_test/flutter_test.dart';
import 'package:gravixor/gravixor_app.dart';

void main() {
  testWidgets('GravixorApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GravixorApp());
    expect(find.text('Gravixor Inclinometer'), findsOneWidget);
  });
}
