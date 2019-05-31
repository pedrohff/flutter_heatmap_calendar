class TimeUtils {
  /// The first element is an empty string,
  /// once Dart's DateTime counts months from 1 to 12
  static const List<String> defaultMonthsLabels = [
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
  ];

  static const List<String> defaultWeekLabels = [
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S'
  ];

  /// Obtains the first day of the current week,
  /// based on user's current day
  static DateTime firstDayOfTheWeek() {
    DateTime today = DateTime.now();
    return today.subtract(new Duration(
        days: today.weekday,
        hours: today.hour,
        minutes: today.minute,
        seconds: today.second,
        microseconds: today.microsecond,
        milliseconds: today.millisecond));
  }

  /// Sets a DateTime hours/minutes/seconds/microseconds/milliseconds to 0
  static DateTime removeTime(DateTime dateTime) {
    return dateTime.subtract(new Duration(
        hours: dateTime.hour,
        minutes: dateTime.minute,
        seconds: dateTime.second,
        microseconds: dateTime.microsecond,
        milliseconds: dateTime.millisecond));
  }

  /// Creates a list of [DateTime], including all days between [startDate] and [finishDate]
  static List<DateTime> datesBetween(DateTime startDate, DateTime finishDate) {
    assert(startDate.isBefore(finishDate));

    List<DateTime> datesList = new List();
    DateTime aux = startDate;
    do {
      datesList.add(aux);
      aux = aux.add(Duration(days: 1));
    } while (finishDate.isAfter(aux));

    return datesList;
  }
}
