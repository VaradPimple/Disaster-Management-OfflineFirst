import 'package:flutter_test/flutter_test.dart';
import 'package:disaster_app/main.dart';

void main() {
  testWidgets('Disaster app loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DisasterApp());

    expect(find.text('Disaster Management'), findsOneWidget);
    expect(find.text('Offline-First Disaster Alert System'), findsOneWidget);
  });
}
