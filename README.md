[![Build Status](https://travis-ci.org/pedrohff/flutter_heatmap_calendar.svg?branch=master)](https://travis-ci.org/pedrohff/flutter_heatmap_calendar)
# Flutter Heat Map Calendar
A Heat Map Calendar based on Github's contributions chart which can be used to visualize values over time

![HeatMap Calendar in action](https://thumbs.gfycat.com/ImmaculateRequiredLarva.webp)


## Installing

### 1. Depend on it
Add this to your package's pubspec.yaml file:

```
dependencies:
  heatmap_calendar: ^1.2.3
```

### 2. Install it
You can install packages from the command line:

with pub:

```shell
$ pub get
```

with Flutter:

```shell
$ flutter pub get
```

## Example
```dart
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';
...

HeatMapCalendar(
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
  squareSize: 16.0,
  textOpacity: 0.3,
  labelTextColor: Colors.blueGrey,
  dayTextColor: Colors.blue[500],
)
```
