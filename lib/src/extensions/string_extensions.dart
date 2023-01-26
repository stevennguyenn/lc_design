import 'dart:ui';

import 'package:email_validator/email_validator.dart';

extension StringExtension on String {
  int durationStringToInt() {
    final result = split(":");
    final minute = int.parse(result.first);
    final second = int.parse(result.last);
    return minute * 60 + second;
  }

  bool checkEmailValidation() {
    final result = EmailValidator.validate(this, true);
    return result;
  }

  bool checkPasswordValidation() {
    String p = r'^[a-zA-Z0-9]{8,30}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(this);
  }

  bool checkPhoneValidation() {
    String p = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(this);
  }

  Color get hexColor {
    final hexCode = replaceAll('#', '');
    return Color(int.parse(
      'FF$hexCode',
      radix: 16,
    ));
  }

  String doubleFixed() {
    final doubleValue = double.tryParse(this);
    if (doubleValue != null) {
      return doubleValue.toStringAsFixed(2);
    }
    return this;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String getNumbers() {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  String removeEmptyLines() {
    final temp = replaceAll(RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '\n');
    if (temp[temp.length - 1] == "\n") {
      return temp.substring(0, temp.length - 1);
    }
    return temp;
  }
}
