import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/heatmap_day.dart';

void main() {
  group('HeatMapDay Widget', () {
    Widget subject;
    late Widget app;
    Color defaultColor = Colors.green;
    Map<int, Color?> thresholds = {
      1: Colors.red[100],
      30: Colors.red[300],
      60: Colors.red[700]
    };

    setUp(() {
      subject = HeatMapDay(
        value: 10,
        size: 5.0,
        thresholds: thresholds,
        currentDay: DateTime.now().day,
        fontWeight: FontWeight.normal,
        defaultColor: defaultColor,
      );

      app = new MaterialApp(home: subject);
    });

    testWidgets('should have only one HeatMapDay', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(HeatMapDay), findsOneWidget);
    });

    testWidgets('should have only one Container', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should have only one AnimatedOpacity',
        (WidgetTester tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(AnimatedOpacity), findsOneWidget);
    });

    testWidgets('should have only one Text', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('should find one widget with given text',
        (WidgetTester tester) async {
      await tester.pumpWidget(app);

      expect(find.text(DateTime.now().day.toString()), findsOneWidget);
    });
  });

  group('Testing method getColorFromThreshold', () {
    Color defaultColor = Colors.green;
    Map<int, Color?> thresholds = {
      1: Colors.red[100],
      30: Colors.red[300],
      60: Colors.red[700]
    };

    HeatMapDay subject = HeatMapDay(
      value: 10,
      size: 5.0,
      thresholds: thresholds,
      currentDay: DateTime.now().day,
      fontWeight: FontWeight.normal,
      defaultColor: defaultColor,
    );

    test('should return default color if no value is given', () {
      subject = HeatMapDay(
        size: 5.0,
        thresholds: thresholds,
        currentDay: DateTime.now().day,
        fontWeight: FontWeight.normal,
        defaultColor: defaultColor,
      );
      Color? color = subject.getColorFromThreshold();
      expect(color, equals(defaultColor));
    });

    test('should return the default color if value is zero', () {
      subject = HeatMapDay(
        value: 0,
        size: 5.0,
        thresholds: thresholds,
        currentDay: DateTime.now().day,
        fontWeight: FontWeight.normal,
        defaultColor: defaultColor,
      );
      Color? color = subject.getColorFromThreshold();
      expect(color, equals(defaultColor));
    });

    test('should return the first color', () {
      subject = HeatMapDay(
        value: 5,
        size: 5.0,
        thresholds: thresholds,
        currentDay: DateTime.now().day,
        fontWeight: FontWeight.normal,
        defaultColor: defaultColor,
      );
      Color? color = subject.getColorFromThreshold();
      expect(color, equals(Colors.red[100]));
    });

    test('should return the last color', () {
      subject = HeatMapDay(
        value: 100,
        size: 5.0,
        thresholds: thresholds,
        currentDay: DateTime.now().day,
        fontWeight: FontWeight.normal,
        defaultColor: defaultColor,
      );
      Color? color = subject.getColorFromThreshold();
      expect(color, equals(Colors.red[700]));
    });
  });
}
