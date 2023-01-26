import 'package:flutter/cupertino.dart';

import '../../src.dart';

class SelectionItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback callback;
  final double height;

  const SelectionItem({
    super.key,
    required this.title,
    this.isSelected = false,
    required this.callback,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return LCButton.base(
      title: title,
      onTap: callback,
      height: height,
      borderRadius: 6,
      bgColor: isSelected ? UIColors.buttonBG : UIColors.textFieldBG,
      titleColor: isSelected ? UIColors.white : UIColors.defaultText,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
    );
  }
}
