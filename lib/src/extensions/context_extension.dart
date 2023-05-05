import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get paddingBottomForButton {
    final bottom = MediaQuery.of(this).viewPadding.bottom;
    if (bottom > 0) {
      return bottom + 16;
    }
    return 16;
  }

  double get screenHeight {
    return MediaQuery.of(this).size.height;
  }

  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }

  double get keyboardHeight {
    return  MediaQuery.of(this).viewInsets.bottom;
  }

  double get numberKeyboardHeight {
    final keyboardHeight = MediaQuery.of(this).viewInsets.bottom;
    if (keyboardHeight == 0) {
      return 0;
    }
    return keyboardHeight + 50;
  }

  double get correctHeightAboveKeyboard {
    final focus = MediaQuery.of(this).viewInsets.bottom;
    return focus == 0 ? 35 : (focus + 16);
  }

  double get correctHeightAboveNumberKeyboard {
    final focus = MediaQuery.of(this).viewInsets.bottom;
    return focus == 0 ? 35 : (focus + 56);
  }
}
