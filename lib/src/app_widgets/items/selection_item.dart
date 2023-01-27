import 'package:flutter/cupertino.dart';

import '../../src.dart';

class SelectionItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback callback;
  final double height;
  final Color? enableColor;

  const SelectionItem({
    super.key,
    required this.title,
    this.isSelected = false,
    required this.callback,
    this.height = 40,
    this.enableColor,
  });

  @override
  Widget build(BuildContext context) {
    return LCButton.base(
      title: title,
      onTap: callback,
      height: height,
      borderRadius: 6,
      bgColor: isSelected
          ? (enableColor ?? UIColors.buttonBG)
          : UIColors.textFieldBG,
      titleColor: isSelected ? UIColors.white : UIColors.defaultText,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
    );
  }
}
