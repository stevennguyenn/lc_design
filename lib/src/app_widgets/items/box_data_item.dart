import 'package:flutter/cupertino.dart';

import '../../src.dart';

class BoxDataItem extends StatelessWidget {
  const BoxDataItem({
    super.key,
    required this.title,
    this.message,
    this.messageColor = UIColors.defaultText,
    this.maxLinesMessage = 1,
  });

  final String title;
  final String? message;
  final Color messageColor;
  final int maxLinesMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LCText.regular(
          title,
          color: UIColors.defaultText.withOpacity(0.5),
          maxLines: 1,
          fontSize: FontSizes.small,
        ),
        const SizedBox(
          height: 4,
        ),
        LCText.regular(
          message ?? "",
          maxLines: maxLinesMessage,
          color: messageColor,
        ),
      ],
    );
  }
}
