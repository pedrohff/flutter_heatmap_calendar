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
  static DateTime firstDayOfTheWeek(DateTime today) {
    return safeSubtract(today, Duration(
        days: (today.weekday % DateTime.daysPerWeek),
        hours: today.hour,
        minutes: today.minute,
        seconds: today.second,
        microseconds: today.microsecond,
        milliseconds: today.millisecond));
  }

  static DateTime firstDayOfCalendar(DateTime day, int columnsAmount) {
    return safeSubtract(day, Duration(days: (DateTime.daysPerWeek * (columnsAmount - 1))));
  }

  /// Sets a DateTime hours/minutes/seconds/microseconds/milliseconds to 0
  static DateTime removeTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Returns date without timezone info (UTC format)
  static DateTime removeTZ(DateTime dateTime) {
    return DateTime.utc(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute,
        dateTime.second, dateTime.millisecond, dateTime.millisecond);
  }

  /// Returns date with local timezone
  static DateTime addTZ(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute,
        dateTime.second, dateTime.millisecond, dateTime.microsecond);
  }

  /// Subtract duration without timezone.
  /// That prevents from problems with time shift if DST changed
  static DateTime safeSubtract(DateTime dateTime, Duration duration) {
    DateTime add = removeTZ(dateTime).subtract(duration);
    return addTZ(add);
  }

  /// Add duration without timezone.
  /// That prevents from problems with time shift if DST changed
  static DateTime safeAdd(DateTime dateTime, Duration duration) {
    DateTime add = removeTZ(dateTime).add(duration);
    return addTZ(add);
  }

  /// Creates a list of [DateTime], including all days between [startDate] and [finishDate]
  static List<DateTime> datesBetween(DateTime startDate, DateTime finishDate) {
    assert(startDate.isBefore(finishDate));

    List<DateTime> datesList = [];
    DateTime aux = startDate;
    do {
      datesList.add(aux);
      aux = safeAdd(aux, Duration(days: 1));
    } while (finishDate.millisecondsSinceEpoch >= aux.millisecondsSinceEpoch);

    return datesList;
  }
}
