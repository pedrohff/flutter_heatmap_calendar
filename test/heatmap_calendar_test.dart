import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:heatmap_calendar/week_columns.dart';
import 'package:heatmap_calendar/week_labels.dart';

void main() {
  var key = Key('calendarKey');
  var subject = HeatMapCalendar(
    key: key,
    input: {
      TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 3))): 5,
      TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 2))): 35,
      TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 1))): 14,
      TimeUtils.removeTime(DateTime.now()): 5,
    },
    colorThresholds: {
      1: Colors.green[100],
      10: Colors.green[300],
      30: Colors.green[500]
    },
  );

  var app = MaterialApp(
    home: Scaffold(
      body: subject,
    ),
  );

  group('Testing HeatMapCalendar\'s widget tree', () {
    testWidgets('should have only one HeatMapCalendar',
        (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(find.byType(HeatMapCalendar), findsOneWidget);
    });

    testWidgets('should have only one LayoutBuilder',
        (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(find.byType(LayoutBuilder), findsOneWidget);
    });

    testWidgets('should have at least one Container',
        (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should have two Row widgets', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(find.byType(Row), findsNWidgets(2));
    });

    testWidgets('should have only one WeekLabels', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(find.byType(WeekLabels), findsOneWidget);
    });

    testWidgets('should have only one WeekColumnsBuilder',
        (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(find.byType(WeekColumns), findsOneWidget);
    });
  });

  group('Testing HeatMapCalendar\'s widget interactivity/state', () {
    testWidgets('validating opacity and the displayDates flag', (tester) async {
      await tester.pumpWidget(app);
      StatefulElement element = tester.element(find.byKey(key));
      HeatMapCalendarState state = element.state as HeatMapCalendarState;
      bool displayDatesBefore = state.displayDates;
      double opacityBefore = state.currentOpacity;

      await tester.tap(find.byKey(key), pointer: 1);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.byKey(key), pointer: 2);
      await tester.pump(const Duration(seconds: 1));

      expect(displayDatesBefore, isNot(state.displayDates));
      expect(opacityBefore, isNot(state.currentOpacity));
    });
  });

  group('Unit Testing HeatMapCalendar\'s state', () {
    group('method getColumnsToCreate', () {
      testWidgets('should have 10 columns with given width', (tester) async {
        await tester.pumpWidget(app);
        StatefulElement element = tester.element(find.byKey(key));
        HeatMapCalendarState state = element.state as HeatMapCalendarState;

        expect(
            state.getColumnsToCreate(200 + subject.safetyMargin), equals(10));
      });

      testWidgets('should throw assertion error if doesn\'t have enough space',
          (tester) async {
        await tester.pumpWidget(app);
        StatefulElement element = tester.element(find.byKey(key));
        HeatMapCalendarState state = element.state as HeatMapCalendarState;
        expect(() => state.getColumnsToCreate(19), throwsAssertionError);
      });
    });

    group('method onDoubleTap', () {
      testWidgets('should change the displayDates property', (tester) async {
        await tester.pumpWidget(app);

        StatefulElement element = tester.element(find.byKey(key));
        HeatMapCalendarState state = element.state as HeatMapCalendarState;

        bool displayDatesBefore = state.displayDates;
        state.onDoubleTap();
        expect(!displayDatesBefore, equals(state.displayDates));
      });

      testWidgets('should change the opacity property', (tester) async {
        await tester.pumpWidget(app);

        StatefulElement element = tester.element(find.byKey(key));
        HeatMapCalendarState state = element.state as HeatMapCalendarState;
        double opacityBefore = state.currentOpacity;
        state.onDoubleTap();
        expect(opacityBefore, isNot(state.currentOpacity));
      });
    });
  });
}
