import 'package:flutter_test/flutter_test.dart';
import 'package:fht_app/main.dart';

void main() {
  testWidgets('FHTApp starts and shows welcome message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FHTApp());

    // Verify that our welcome message is displayed.
    expect(find.text('Welcome to FHT App'), findsOneWidget);
    expect(find.text('Modules Configured'), findsOneWidget);
  });
}
