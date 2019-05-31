import 'package:flutter/material.dart';
import 'package:heatmap_calendar/default_container.dart';

class WeekLabels extends StatelessWidget {
  final List<String> weekDaysLabels;
  final double squareSize;
  final Color labelTextColor;

  const WeekLabels(
      {Key key,
      @required this.weekDaysLabels,
      @required this.squareSize,
      @required this.labelTextColor})
      : assert(weekDaysLabels != null),
        assert(weekDaysLabels.length == 7),
        assert(squareSize != null),
        assert(squareSize > 0),
        assert(labelTextColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DefaultContainer(
          text: "",
          size: squareSize,
          textColor: labelTextColor,
          margin: 0,
        ),
        DefaultContainer(
          text: weekDaysLabels[0],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[1],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[2],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[3],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[4],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[5],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[6],
          size: squareSize,
          textColor: labelTextColor,
        ),
      ],
    );
  }
}
