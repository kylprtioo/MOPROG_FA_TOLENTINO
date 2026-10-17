import 'package:flutter_test/flutter_test.dart';
import 'package:fa2/home.dart';

void main() {
  testWidgets('Quiz App smoke test', (WidgetTester tester) async {
     await tester.pumpWidget(const Home());

    expect(find.text('Filipino Stews Quiz'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
  });
}