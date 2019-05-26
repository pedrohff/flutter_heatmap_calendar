import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_day.dart';
import 'package:heatmap_calendar/month_label.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:heatmap_calendar/week_labels.dart';

class HeatMapCalendar extends StatefulWidget {

  /// The labels identifying the initials of the days of the week
  /// Defaults to [TimeUtils.defaultWeekLabels]
  final List<String> weekDaysLabels;

  /// The labels identifying the months of a year
  /// Defaults to [TimeUtils.defaultMonthsLabels]
  final List<String> monthsLabels;

  /// The inputs that will fill the calendar with data
  final Map<DateTime, int> input;

  /// The thresholds which will map the given [input] to a color
  ///
  /// Make sure to map starting on number 1, so the user might notice the difference between
  /// a day that had no input and one that had
  /// Example: {1: Colors.green[100], 20: Colors.green[200], 40: Colors.green[300]}
  final Map<int, Color> colorThresholds;

  /// The size of each item of the calendar
  final double squareSize;

  /// The opacity of the text when the user double taps the widget
  final double textOpacity;

  /// The color of the texts in the weeks/months labels
  final Color labelTextColor;

  /// The color of the text that identifies the days
  final Color dayTextColor;

  const HeatMapCalendar({
    Key key,
    @required this.input,
    @required this.colorThresholds,
    this.weekDaysLabels: TimeUtils.defaultWeekLabels,
    this.monthsLabels: TimeUtils.defaultMonthsLabels,
    this.squareSize: 16,
    this.textOpacity: 0.2,
    this.labelTextColor: Colors.black,
    this.dayTextColor: Colors.black
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeatMapCalendarState();
  }

}

class HeatMapCalendarState extends State<HeatMapCalendar> {

  static const double COLUMN_AMOUNT = 11;
  static const double DAYS_IN_A_WEEK = 7;
  static const double EDGE_SIZE = 4;
  double currentOpacity = 0;
  bool displayDates = false;

  /// Toggles the labels in all [HeatMapDay]s
  void onDoubleTap() {
    setState(() {
      displayDates = !displayDates;
      currentOpacity = displayDates ? widget.textOpacity : 0;
    });
  }

  /// The main logic for generating a list of columns representing a week
  /// Each column is a week having a [MonthLabel] and 7 [HeatMapDay]
  List<Widget> buildWeekItems(int totalDays, List<DateTime> dateList) {
    int totalWeeks = totalDays ~/ DAYS_IN_A_WEEK;
    int amount = totalDays + totalWeeks;

    // The list of columns that will be returned
    List<Widget> columns = new List();

    // The list of items that will be used to form a week
    List<Widget> columnItems = new List();
    List<int> months = new List();

    for (int i = 0; i <= amount; i++) {

      // If true, it means that it should be a label,
      // if false, it should be a HeatMapDay
      if (i % 8 == 0) {

        String month = "";
        if (!months.contains(dateList.first.month)) {
          month = TimeUtils.defaultMonthsLabels[dateList.first.month];
          months.add(dateList.first.month);
        }

        columnItems.add(
          MonthLabel(
            size: widget.squareSize,
            textColor: widget.labelTextColor,
            text: month,
          )
        );
      } else {
        DateTime currentDate = dateList.first;
        dateList.removeAt(0);

        final int value = (widget.input[currentDate] == null) ? 0 : widget.input[currentDate];

        HeatMapDay heatMapDay = HeatMapDay(
          value: value,
          thresholds: widget.colorThresholds,
          size: widget.squareSize,
          currentDay: currentDate.day,
          opacity: currentOpacity,
          textColor: widget.dayTextColor,
        );
        columnItems.add(heatMapDay);
      }

      // If the columnsItems has a length of 8, it means it should be ended.
      // The same rule applies if there's no more items in the dateList,
      // meaning a week hasn't finished yet
      if (columnItems.isNotEmpty && (columnItems.length == 8 || dateList.isEmpty)) {
        columns.add(Column(children: columnItems));
        columnItems = new List();
      }

    }

    return columns;
  }

  /// Groups the week labels with it items
  List<Widget> buildAllColumns() {
    DateTime today = DateTime.now();
    DateTime firstDayOfTheWeek = TimeUtils.firstDayOfTheWeek();
    DateTime firstDayOfCalendar = firstDayOfTheWeek.subtract(Duration(days: (7 * COLUMN_AMOUNT.floor())));
    var datesList = TimeUtils.datesBetween(firstDayOfCalendar, today);

    List<Widget> columns = new List();
    columns.add(
      WeekLabels(
        weekDaysLabels:
        widget.weekDaysLabels,
        squareSize: widget.squareSize,
        labelTextColor: widget.labelTextColor,
      )
    );
    columns.addAll(buildWeekItems(datesList.length, datesList));
    return columns;
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onDoubleTap: onDoubleTap,
      child: Container(
        height: (widget.squareSize + EDGE_SIZE) * (COLUMN_AMOUNT + 1),
        child: Row(
          children: buildAllColumns(),
        ),
      ),
    );
  }
}

