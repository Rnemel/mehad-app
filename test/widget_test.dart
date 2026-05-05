import 'package:flutter_test/flutter_test.dart';

import 'package:mehad/main.dart';

void main() {
  testWidgets('App boots', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
  });
}
