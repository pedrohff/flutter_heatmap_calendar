import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/heatmap_day.dart';
import 'package:heatmap_calendar/month_label.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:heatmap_calendar/week_columns.dart';

void main() {
  final int columnAmount = 10;

  //Week started from Sunday last day of previous month.
  //This order needed to test all week days and last and first day of the month
  final List<DateTime> weekDays = [
    DateTime(2020, 5, 31), //sunday
    DateTime(2020, 6, 1),
    DateTime(2020, 6, 2),
    DateTime(2020, 6, 3),
    DateTime(2020, 6, 4),
    DateTime(2020, 6, 5),
    DateTime(2020, 6, 6),
    DateTime(2020, 6, 7),
    DateTime(2020, 6, 8),
    DateTime(2020, 6, 9),
    DateTime(2020, 6, 10),
    DateTime(2020, 6, 11),
    DateTime(2020, 6, 12),
    DateTime(2020, 6, 13),
    DateTime(2020, 6, 14),
  ];

  WeekColumns getSubjectUnderTest(DateTime date,
      [Map<DateTime, int> input, Map<int, Color> colorThresholds]) {
    return WeekColumns(
      squareSize: 16,
      labelTextColor: Colors.black,
      input: input ?? {},
      colorThresholds: colorThresholds ?? {},
      currentOpacity: 0,
      monthLabels: TimeUtils.defaultMonthsLabels,
      dayTextColor: Colors.red,
      columnsToCreate: columnAmount,
      date: date,
    );
  }

  Widget getApp(DateTime date) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: <Widget>[getSubjectUnderTest(date)],
        ),
      ),
    );
  }

  weekDays.forEach((day) {
    group('Testing widgets children $day', () {
      testWidgets('should have only one WeekColumns widget', (tester) async {
        await tester.pumpWidget(getApp(DateTime(2020, 6, 14)));

        expect(find.byType(WeekColumns), findsOneWidget);
      });

      testWidgets('should have only one Expanded widget', (tester) async {
        await tester.pumpWidget(getApp(day));

        expect(find.byType(Expanded), findsOneWidget);
      });

      testWidgets('should have only one Row', (tester) async {
        await tester.pumpWidget(getApp(day));

        expect(
            find.descendant(
                of: find.byType(WeekColumns), matching: find.byType(Row)),
            findsOneWidget);
      });

      testWidgets('should have the given columns', (tester) async {
        await tester.pumpWidget(getApp(day));

        expect(find.byType(Column), findsNWidgets(columnAmount));
      });

      testWidgets(
          'should have the amount of MonthLabel widgets equal to the given amount of columns',
          (tester) async {
        await tester.pumpWidget(getApp(day));

        expect(find.byType(MonthLabel), findsNWidgets(columnAmount));
      });

      testWidgets(
          'should have the amount of HeatMapDay widgets equal to the given amount of columns, times the amount of days in a week',
          (tester) async {
        await tester.pumpWidget(getApp(day));

        int i = DateTime.daysPerWeek - day.weekday - 1;
        if (day.weekday == 7) {
            i = 6;
        }

        expect(find.byType(HeatMapDay),
            findsNWidgets((7 * columnAmount) - (i)));
      });
    });
  });

  weekDays.forEach((day) {
    group('Unit testing $day', () {
      group('getCalendarDates method', () {
        test(
            'should have the given amount of columns when result is divided by the amount of days in a week',
            () {
          List<DateTime> calendarDates =
              getSubjectUnderTest(day).getCalendarDates(columnAmount);
          expect(calendarDates.length, greaterThan(0));
          int daysAmount = calendarDates.length;
          expect(columnAmount, equals((daysAmount / 7).ceil()));
        });
      });

      group('buildWeekItems method', () {
        test('list should not be null, $day', () {
          expect(getSubjectUnderTest(day).buildWeekItems(), isNotNull);
        });

        test('list should not be null, $day', () {
          expect(getSubjectUnderTest(day).buildWeekItems(), isNotNull);
        });

        test('list should not be empty, $day', () {
          expect(getSubjectUnderTest(day).buildWeekItems(), isNotEmpty);
        });

        test('list length should be equal to given columns amount, $day', () {
          expect(getSubjectUnderTest(day).buildWeekItems().length, equals(columnAmount));
        });
      });
    });
  });

  Future _checkColoredDaysInWeek(
      DateTime date, Map<DateTime, int> inputDates, WidgetTester tester) async {
    Map<int, Color> colorThresholds = {30: Colors.green[500]};

    WeekColumns subject = getSubjectUnderTest(date, inputDates, colorThresholds);

    MaterialApp app = new MaterialApp(
        home: Row(
      children: <Widget>[
        subject,
      ],
    ));
    await tester.pumpWidget(app);

    Finder finder = find.byType(HeatMapDay);

    int daysColored = 0;
    List<int> checkedDays = inputDates.keys.map((d) => d.day).toList();
    for (Element element in finder.evaluate()) {
      HeatMapDay heatMapDay = element.widget as HeatMapDay;
      Color color = heatMapDay.getColorFromThreshold();
      int currentDay = heatMapDay.currentDay;
      if (color == colorThresholds[30]) {
        if (!checkedDays.contains(currentDay)) {
          fail("HeatMapDay with day $currentDay is colored, but it's not in input");
        }
        daysColored++;
      }
    }

    expect(daysColored, inputDates.length);
  }

  group('Unit testing changed time', () {
    testWidgets('Check DST', (WidgetTester tester) async {
      DateTime date = DateTime(2020, 3, 31);
      Map<DateTime, int> inputDates = {
        DateTime(2020, 3, 27): 35,
        DateTime(2020, 3, 28): 35,
        DateTime(2020, 3, 29): 35,
        DateTime(2020, 3, 30): 35,
      };

      await _checkColoredDaysInWeek(date, inputDates, tester);
    });
    testWidgets('Check winter time', (WidgetTester tester) async {
      DateTime date = DateTime(2020, 10, 27);
      Map<DateTime, int> inputDates = {
        DateTime(2020, 10, 23): 35,
        DateTime(2020, 10, 24): 35,
        DateTime(2020, 10, 25): 35,
        DateTime(2020, 10, 26): 35,
      };

      await _checkColoredDaysInWeek(date, inputDates, tester);
    });
  });
}
