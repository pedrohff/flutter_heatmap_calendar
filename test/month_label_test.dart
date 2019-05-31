import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/month_label.dart';

void main() {
  String text = "20";

  MonthLabel subject = MonthLabel(
    size: 5.0,
    textColor: Colors.black,
    text: text,
  );

  Widget app = MaterialApp(
    home: Scaffold(
      body: subject,
    ),
  );

  group('Testing the MonthLabel widget', () {
    testWidgets('should have only one MonthLabel', (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(MonthLabel), findsOneWidget);
    });

    testWidgets('should have only one Container', (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should have only one Stack inside the Container',
        (tester) async {
      await tester.pumpWidget(app);

      expect(
          find.descendant(
              of: find.byType(Container), matching: find.byType(Stack)),
          findsOneWidget);
    });

    testWidgets('should have only one Positioned', (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(Positioned), findsOneWidget);
    });

    testWidgets('should have only one Text', (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('should have a widget with given text', (tester) async {
      await tester.pumpWidget(app);

      expect(find.text(text), findsOneWidget);
    });
  });
}
