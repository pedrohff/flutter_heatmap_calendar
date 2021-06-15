import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_day.dart';
import 'package:heatmap_calendar/month_label.dart';
import 'package:heatmap_calendar/time_utils.dart';

class WeekColumns extends StatelessWidget {
  final double squareSize;

  final Color labelTextColor;

  final Map<DateTime, int> input;

  final Map<int, Color?> colorThresholds;

  final double currentOpacity;

  final List<String> monthLabels;

  final Color dayTextColor;

  final int columnsToCreate;

  final DateTime date;

  final double? labelTextSize;

  WeekColumns(
      {Key? key,
        required this.squareSize,
        this.labelTextSize,
        required this.labelTextColor,
        required this.input,
        required this.colorThresholds,
        required this.currentOpacity,
        required this.monthLabels,
        required this.dayTextColor,
        required this.columnsToCreate,
        required this.date})
      : super(key: key);

  /// The main logic for generating a list of columns representing a week
  /// Each column is a week having a [MonthLabel] and 7 [HeatMapDay] widgets
  List<Widget> buildWeekItems() {
    List<DateTime> dateList = getCalendarDates(columnsToCreate);
    int totalDays = dateList.length;
    var daysPerWeek = DateTime.daysPerWeek;
    int totalWeeks = (totalDays / daysPerWeek).ceil();
    int amount = totalDays + totalWeeks;

    // The list of columns that will be returned
    List<Widget> columns = [];

    // The list of items that will be used to form a week
    List<Widget> columnItems = [];
    List<int> months = [];

    for (int i = 0; i < amount; i++) {
      // If true, it means that it should be a label,
      // if false, it should be a HeatMapDay
      if (i % 8 == 0) {
        String month = "";

        if (dateList.isNotEmpty && !months.contains(dateList.first.month)) {
          month = monthLabels[dateList.first.month];
          months.add(dateList.first.month);
        }

        columnItems.add(MonthLabel(
          size: squareSize,
          textSize: labelTextSize,
          textColor: labelTextColor,
          text: month,
        ));
      } else {
        DateTime currentDate = dateList.first;
        dateList.removeAt(0);

        final int? value = (input[currentDate] == null) ? 0 : input[currentDate];

        HeatMapDay heatMapDay = HeatMapDay(
          fontWeight: FontWeight.normal,
          value: value,
          thresholds: colorThresholds,
          size: squareSize,
          currentDay: currentDate.day,
          opacity: currentOpacity,
          textColor: dayTextColor,
        );
        columnItems.add(heatMapDay);

        // If the columnsItems has a length of 8, it means it should be ended.
        if (columnItems.length == 8) {
          columns.add(Column(children: columnItems));
          columnItems = [];
        }
      }
    }

    if (columnItems.isNotEmpty) {
      columns.add(Column(children: columnItems));
    }
    return columns;
  }

  /// Creates a list of all weeks based on given [columnsAmount]
  List<DateTime> getCalendarDates(int columnsAmount) {
    DateTime firstDayOfTheWeek = TimeUtils.firstDayOfTheWeek(date);
    DateTime firstDayOfCalendar = TimeUtils.firstDayOfCalendar(firstDayOfTheWeek, columnsAmount);
    return TimeUtils.datesBetween(firstDayOfCalendar, date);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: buildWeekItems(),
      ),
    );
  }
}
