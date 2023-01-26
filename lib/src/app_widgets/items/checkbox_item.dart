import 'package:flutter/cupertino.dart';

import '../../src.dart';

class CheckBoxItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? callback;

  const CheckBoxItem({
    super.key,
    required this.title,
    this.isSelected = false,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return LCInkwell.base(
      onTap: callback,
      child: Row(
        children: [
          ViHatImage.asset(
            name: isSelected ? UIImages.icCheck : UIImages.icCircle,
            width: 20,
            height: 20,
            color: isSelected ? UIColors.buttonBG : null,
          ),
          const SizedBox(
            width: 8,
          ),
          LCText.regular(
            title,
            color: isSelected ? UIColors.buttonBG : UIColors.defaultText,
          ),
        ],
      ),
    );
  }
}
