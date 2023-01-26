import 'package:flutter/cupertino.dart';

import '../src.dart';

class AppTag extends StatelessWidget {
  final String title;
  final bool isEnable;
  final VoidCallback? callback;

  const AppTag({
    super.key,
    required this.title,
    this.isEnable = false,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return LCInkwell.base(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: isEnable
              ? UIColors.buttonBG.withOpacity(0.1)
              : UIColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: LCText.regular(
          title,
          fontSize: FontSizes.small,
          color: isEnable ? UIColors.buttonBG : UIColors.defaultText,
        ),
      ),
    );
  }
}
