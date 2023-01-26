import 'package:intl/intl.dart';
import 'package:lc_design/src/extensions/string_extensions.dart';

extension DateTimeExtension on DateTime {
  int get lastDay => DateTime(year, month + 1, 0).day;

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  String getMonthRange() {
    final lastDay = DateTime(year, month + 1, 0).day;
    String monthWithStringType = "$month";
    if (month < 10) {
      monthWithStringType = "0$monthWithStringType";
    }
    return "01/$month - $lastDay/$monthWithStringType";
  }

  String getMonthAndYearWithLocalStyle() {
    final date = DateFormat("MMMM yyyy", 'fr_FR').format(this);
    return date.capitalize();
  }

  String getWeekRange() {
    final weekDay = weekday - 1;
    final firstWeekDate = DateTime(year, month, day - weekDay);
    final lastWeekDate = DateTime(year, month, day - weekDay + 6);
    String firstDay = "${firstWeekDate.day}";
    String firstMonth = "${firstWeekDate.month}";
    String lastDay = "${lastWeekDate.day}";
    String lastMonth = "${lastWeekDate.month}";
    if (firstWeekDate.day < 10) {
      firstDay = "0${firstWeekDate.day}";
    }
    if (firstWeekDate.month < 10) {
      firstMonth = "0${firstWeekDate.month}";
    }
    if (lastWeekDate.day < 10) {
      lastDay = "0${lastWeekDate.day}";
    }
    if (lastWeekDate.day < 10) {
      lastMonth = "0${lastWeekDate.day}";
    }
    return "$firstDay/$firstMonth - $lastDay/$lastMonth";
  }

  String getDayString() {
    String monthWithStringType = "$month";
    if (month < 10) {
      monthWithStringType = "0$monthWithStringType";
    }
    String dayWithStringType = "$day";
    if (day < 10) {
      dayWithStringType = "0$dayWithStringType";
    }
    return "$dayWithStringType/$monthWithStringType";
  }

  bool isSameTime(DateTime time) {
    return year == time.year && month == time.month && day == time.day;
  }

  bool isSameMonthAndYear(DateTime time) {
    return year == time.year && month == time.month;
  }
}
