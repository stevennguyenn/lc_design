import 'package:flutter/material.dart';

import '../../src.dart';

class DisabledTextField extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? height;
  const DisabledTextField({
    super.key,
    required this.title,
    required this.subTitle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: LCColors.textFieldBG,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LCText.bold(
            title,
            fontSize: FontSizes.small,
            color: LCColors.gray,
          ),
          const SizedBox(
            height: 8,
          ),
          LCText.base(
            subTitle.isNotEmpty ? subTitle : "-",
            fontSize: FontSizes.medium,
            color: LCColors.gray,
          ),
        ],
      ),
    );
  }
}
