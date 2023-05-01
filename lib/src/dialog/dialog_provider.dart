import 'package:flutter/material.dart';

import 'view/confirm_dialog.dart';
import 'view/message_dialog.dart';

class DialogProvider {
  static final DialogProvider instance = DialogProvider._();

  DialogProvider._();

  static bool isShowingMessage = false;

  Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmButtonTitle,
  }) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          title: title,
          message: message,
          confirmButtonTitle: confirmButtonTitle,
        );
      },
      barrierDismissible: false,
    );
  }

  Future<bool?> showMessageDialog(
    BuildContext context, {
    required String title,
    required String message,
    bool barrierDismissible = true,
    VoidCallback? callback,
  }) async {
    if (isShowingMessage) {
      return false;
    }
    isShowingMessage = true;
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return MessageDialog(
          title: title,
          message: message,
          callback: callback,
        );
      },
      barrierDismissible: barrierDismissible,
    ).then((value) {
      isShowingMessage = false;
      return null;
    });
  }

  Future<dynamic> showCustomDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    required Widget dialog,
  }) async {
    return await showDialog<dynamic>(
      context: context,
      builder: (context) {
        return dialog;
      },
      barrierDismissible: barrierDismissible,
    );
  }
}
