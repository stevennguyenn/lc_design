import 'package:flutter/material.dart';

extension TextEditingExtension on TextEditingController {
  void checkDoubleValue() {
    if (text.isEmpty) {
      text = "0.0";
      return;
    }
  }

  void checkIntValue() {
    if (text.isEmpty) {
      text = "0";
      return;
    }
  }
}
