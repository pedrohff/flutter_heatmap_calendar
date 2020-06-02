import 'package:flutter_test/flutter_test.dart';
import 'package:heatmap_calendar/time_utils.dart';

final DateTime startWeek = DateTime(2020, 5, 31);
final DateTime friday = DateTime(2020, 6, 5);

void main() {
  group('Testing the firstDayOfTheWeek method', () {
    test('should return weekday as 7', () {
      expect(TimeUtils.firstDayOfTheWeek(friday).weekday, equals(7));
    });

    test('should return the first day of the week', () {
      expect(
          TimeUtils.firstDayOfTheWeek(friday),
          equals(startWeek));
    });

    test('should return same day if its first day of the week', () {
      expect(
          TimeUtils.firstDayOfTheWeek(startWeek),
          equals(startWeek));
    });
  });

  group('Testing the removeTime method', () {
    test('dateTime should be at 00:00:00.000', () {
      DateTime dateTime = TimeUtils.removeTime(DateTime.now());
      expect(dateTime.hour, equals(0));
      expect(dateTime.minute, equals(0));
      expect(dateTime.second, equals(0));
      expect(dateTime.millisecond, equals(0));
      expect(dateTime.microsecond, equals(0));
    });
  });

  group('Testing the dateBetween method', () {
    test('list should not be null', () {
      List<DateTime> datesBetween = TimeUtils.datesBetween(
          DateTime.now().subtract(Duration(days: 7)), DateTime.now());

      expect(datesBetween, isNotNull);
    });

    test('list should not be empty', () {
      List<DateTime> datesBetween = TimeUtils.datesBetween(
          DateTime.now().subtract(Duration(days: 7)), DateTime.now());

      expect(datesBetween, isNotEmpty);
    });

    test('should return a list with given date amount', () {
      List<DateTime> datesBetween = TimeUtils.datesBetween(
          DateTime.now().subtract(Duration(days: 7)), DateTime.now());

      expect(datesBetween.length, equals(8));
    });

    test('should have the initial value', () {
      DateTime initialDate = DateTime.now().subtract(Duration(days: 7));
      List<DateTime> datesBetween =
          TimeUtils.datesBetween(initialDate, DateTime.now());

      expect(datesBetween, contains(initialDate));
    });

    test('should fail assertion if initial date is after finisih date', () {
      expect(
          () => TimeUtils.datesBetween(
              DateTime.now(), DateTime.now().subtract(Duration(days: 7))),
          throwsAssertionError);
    });
  });
}
