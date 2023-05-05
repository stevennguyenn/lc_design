import 'package:flutter/cupertino.dart';

import '../src.dart';

class DisableCheckbox extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? callback;

  const DisableCheckbox({
    super.key,
    required this.title,
    this.isSelected = false,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LCImage.asset(
          name: isSelected ? LCCImages.icCheck : LCCImages.icCircle,
          width: 20,
          height: 20,
          color: isSelected ? LCColors.buttonBG : null,
        ),
        const SizedBox(
          width: 8,
        ),
        LCText.regular(
          title,
          color: isSelected ? LCColors.buttonBG : LCColors.defaultText,
        ),
      ],
    );
  }
}
