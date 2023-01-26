import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModuleBottomSheetHelper {
  static final instance = ModuleBottomSheetHelper._();

  ModuleBottomSheetHelper._();

  Future<dynamic> showView(
    Widget widget, {
    required BuildContext context,
    bool isDismissible = true,
    bool useRootNavigator = false,
  }) async {
    return showMaterialModalBottomSheet<dynamic>(
      context: context,
      isDismissible: isDismissible,
      duration: const Duration(
        milliseconds: 200,
      ),
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) => widget,
      closeProgressThreshold: 0.2,
      useRootNavigator: useRootNavigator,
    );
  }

  Future<dynamic> showViewWithModalStyle(
    Widget widget, {
    required BuildContext context,
    bool isDismissible = false,
    bool useRootNavigator = false,
    bool isScrollController = true,
    bool enableDrag = true,
  }) async {
    return showCupertinoModalBottomSheet<dynamic>(
      context: context,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 200),
      enableDrag: enableDrag,
      builder: (context) => SafeArea(
        bottom: false,
        child: Material(
          child: widget,
        ),
      ),
      useRootNavigator: useRootNavigator,
    );
  }
}
