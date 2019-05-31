import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: HeatMapCalendar(
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
            weekDaysLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
            monthsLabels: [
              "",
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec",
            ],
            squareSize: 20.0,
            textOpacity: 0.3,
            labelTextColor: Colors.blueGrey,
            dayTextColor: Colors.blue[500],
          ),
        ),
      ),
    );
  }
}
