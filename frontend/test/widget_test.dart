import 'package:flutter_test/flutter_test.dart';
import 'package:lifeherba/main.dart';

void main() {
  testWidgets('LifeHerbaApp starts and shows welcome message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LifeHerbaApp());

    // Verify that our welcome message is displayed.
    expect(find.text('Welcome to LifeHerba'), findsOneWidget);
    expect(find.text('Modules Configured'), findsOneWidget);
  });
}
