import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/default_container.dart';

void main() {
  group('DefaultContainer Widget', () {
    Widget subject;
    String text = "test";

    setUp(() {
      subject = MaterialApp(
          home: DefaultContainer(size: 10, textColor: Colors.grey, text: text));
    });

    testWidgets('should have only one DefaultContainer',
        (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      expect(find.byType(DefaultContainer), findsOneWidget);
    });

    testWidgets('should have only one Container', (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should have only one Text Widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('should find a widget with given text',
        (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      expect(find.text(text), findsOneWidget);
    });
  });
}
