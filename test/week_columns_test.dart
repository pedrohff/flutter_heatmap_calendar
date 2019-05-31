import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/heatmap_day.dart';
import 'package:heatmap_calendar/month_label.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:heatmap_calendar/week_columns.dart';

void main() {
  final int columnAmount = 10;
  final int daysUntilWeekEnds = (6 - (DateTime.now().weekday & 7));

  WeekColumns subject = WeekColumns(
    squareSize: 16,
    labelTextColor: Colors.black,
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
    currentOpacity: 0,
    monthLabels: TimeUtils.defaultMonthsLabels,
    dayTextColor: Colors.red,
    columnsToCreate: columnAmount,
  );

  Widget app = MaterialApp(
    home: Scaffold(
      body: Row(
        children: <Widget>[subject],
      ),
    ),
  );

  group('Testing widgets children', () {
    testWidgets('should have only one WeekColumns widget', (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(WeekColumns), findsOneWidget);
    });

    testWidgets('should have only one Expanded widget', (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('should have only one Row', (tester) async {
      await tester.pumpWidget(app);

      expect(
          find.descendant(
              of: find.byType(WeekColumns), matching: find.byType(Row)),
          findsOneWidget);
    });

    testWidgets('should have the given columns', (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(Column), findsNWidgets(columnAmount+1));
    });

    testWidgets(
        'should have the amount of MonthLabel widgets equal to the given amount of columns',
        (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(MonthLabel), findsNWidgets(columnAmount+1));
    });

    testWidgets(
        'should have the amount of HeatMapDay widgets equal to the given amount of columns, times the amount of days in a week',
        (tester) async {
      await tester.pumpWidget(app);

      expect(find.byType(HeatMapDay),
          findsNWidgets((7 * (columnAmount+1)) - daysUntilWeekEnds));
    });
  });

  group('Unit testing', () {
    group('getCalendarDates method', () {
      test(
          'should have the given amount of columns when result is divided by the amount of days in a week',
          () {
        List<DateTime> calendarDates = subject.getCalendarDates(columnAmount);
        expect(calendarDates.length, greaterThan(0));

        int daysAmount = calendarDates.length + daysUntilWeekEnds;
        expect(columnAmount+1, equals((daysAmount ~/ 7)));
      });
    });

    group('buildWeekItems method', () {
      test('list should not be null', () {
        expect(subject.buildWeekItems(), isNotNull);
      });

      test('list should not be empty', () {
        expect(subject.buildWeekItems(), isNotEmpty);
      });

      test('list length should be equal to given columns amount', () {
        expect(subject.buildWeekItems().length, equals(columnAmount+1));
      });
    });
  });
}
