import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lc_design/src/constants/font_sizes.dart';
import '../app_font/app_font.dart';
import '../constants/colors.dart';

class DateTimePickerHelper {
  static final instance = DateTimePickerHelper._();

  DateTimePickerHelper._();

  void showDateTimePicker(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    LocaleType locale = LocaleType.fr,
    int subtractYear = 5,
  }) {
    final temp = now ?? DateTime.now();
    DatePicker.showDateTimePicker(
      context,
      minTime: DateTime(temp.year - subtractYear, 0, 0),
      maxTime: DateTime(temp.year + subtractYear, 0, 0),
      theme: DatePickerTheme(
        headerColor: Colors.white,
        backgroundColor: Colors.white,
        itemStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
        doneStyle: regularFont.copyWith(
          color: UIColors.buttonBG,
          fontSize: FontSizes.big,
        ),
        cancelStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }

  void showTimePicker(
    Function(DateTime) callback, {
    required BuildContext context,
    LocaleType locale = LocaleType.fr,
    int subtractYear = 5,
  }) {
    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      theme: DatePickerTheme(
        headerColor: Colors.white,
        backgroundColor: Colors.white,
        itemStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
        doneStyle: regularFont.copyWith(
          color: UIColors.buttonBG,
          fontSize: FontSizes.big,
        ),
        cancelStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      locale: locale,
    );
  }

  void showDatePicker(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    LocaleType locale = LocaleType.fr,
    int subtractYear = 5,
    bool disableFuture = false,
    bool isBirthday = false,
  }) {
    final temp = now ?? DateTime.now();
    DatePicker.showDatePicker(
      context,
      minTime: DateTime(temp.year - subtractYear, 0, 0),
      maxTime: isBirthday
          ? DateTime.now()
          : DateTime(temp.year + (disableFuture ? 0 : subtractYear), 0, 0),
      theme: DatePickerTheme(
        headerColor: Colors.white,
        backgroundColor: Colors.white,
        itemStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
        doneStyle: regularFont.copyWith(
          color: UIColors.buttonBG,
          fontSize: FontSizes.big,
        ),
        cancelStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }

  void showDatePickerWithMinTime(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    LocaleType locale = LocaleType.fr,
    required DateTime minTime,
  }) {
    final temp = now ?? DateTime.now();
    DatePicker.showDatePicker(
      context,
      minTime: minTime,
      theme: DatePickerTheme(
        headerColor: Colors.white,
        backgroundColor: Colors.white,
        itemStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
        doneStyle: regularFont.copyWith(
          color: UIColors.buttonBG,
          fontSize: FontSizes.big,
        ),
        cancelStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }

  void showDatePickerWithMaxTime(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    LocaleType locale = LocaleType.fr,
    required DateTime maxTime,
  }) {
    final temp = now ?? DateTime.now();
    DatePicker.showDatePicker(
      context,
      maxTime: maxTime,
      theme: DatePickerTheme(
        headerColor: Colors.white,
        backgroundColor: Colors.white,
        itemStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
        doneStyle: regularFont.copyWith(
          color: UIColors.buttonBG,
          fontSize: FontSizes.big,
        ),
        cancelStyle: regularFont.copyWith(
          fontSize: FontSizes.big,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }
}
