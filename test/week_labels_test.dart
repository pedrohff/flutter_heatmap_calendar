import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/default_container.dart';
import 'package:heatmap_calendar/week_labels.dart';

void main() {
  group('WeekLabels Widget', () {
    Widget subject;
    var weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    var size = 5.0;
    var color = Colors.red;

    setUp(() {
      subject = new MaterialApp(
        home: WeekLabels(
          weekDaysLabels: weekDays,
          squareSize: size,
          labelTextColor: color,
        ),
      );
    });

    testWidgets('should have only one WeekLabel', (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      expect(find.byType(WeekLabels), findsOneWidget);
    });

    testWidgets('should have only one column', (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      find.descendant(
          of: find.byType(WeekLabels), matching: find.byElementType(Column));
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('should have 8 DefaultContainers', (WidgetTester tester) async {
      await tester.pumpWidget(subject);
      expect(find.byType(DefaultContainer), findsNWidgets(8));
    });

    testWidgets('should have all items in week labels array',
        (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      weekDays.forEach((label) => expect(find.text(label), findsWidgets));
    });

    testWidgets('should have only one widget with an empty string',
        (WidgetTester tester) async {
      await tester.pumpWidget(subject);

      expect(find.text(""), findsOneWidget);
    });
  });
}
