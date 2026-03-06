import 'package:flutter_test/flutter_test.dart';
import 'package:disaster_app/main.dart';

void main() {
  testWidgets('RakshaSetu app loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const RakshaSetuApp());

    expect(find.text('RakshaSetu'), findsOneWidget);
  });
}
