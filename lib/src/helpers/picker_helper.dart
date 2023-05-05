import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src.dart';

class PickerHelper {
  PickerHelper._();

  static final instance = PickerHelper._();

  Future<String?> showPicker(
    List<String> titles, {
    String? currentValue,
    required BuildContext context,
  }) async {
    String current = titles[0];
    int index = 0;
    if (currentValue?.isNotEmpty == true) {
      index = titles.indexWhere((element) => element == currentValue);
      current = titles[index];
    }
    return showCupertinoModalPopup<String?>(
      context: context,
      builder: (context) {
        return Container(
          color: LCColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              Material(
                color: LCColors.white,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    LCInkwell.base(
                      child: LCText.regular("cancel"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    LCInkwell.base(
                      child: LCText.regular(
                        "confirm",
                        color: LCColors.buttonBG,
                      ),
                      onTap: () {
                        Navigator.pop(context, current);
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 240,
                child: CupertinoPicker(
                  squeeze: 1,
                  itemExtent: 40,
                  scrollController:
                      FixedExtentScrollController(initialItem: index),
                  children: titles.map((e) {
                    return Center(
                      child: LCText.regular(
                        e,
                        fontSize: FontSizes.big,
                      ),
                    );
                  }).toList(),
                  onSelectedItemChanged: (value) {
                    current = titles[value];
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
