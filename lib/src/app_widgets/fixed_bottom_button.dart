import 'package:flutter/material.dart';
import '../src.dart';

class FixedBottomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double paddingLeft;
  final double paddingRight;
  final String? subTitle;

  const FixedBottomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.paddingLeft = 16,
    this.paddingRight = 16,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: UIColors.white,
        padding: EdgeInsets.only(
          bottom: context.paddingBottomForButton,
          left: paddingLeft,
          right: paddingRight,
        ),
        child: LCButton.base(
          title: title,
          titleWidget: subTitle == null
              ? null
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LCText.bold(
                      title,
                      color: UIColors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    LCText.bold(
                      subTitle!,
                      color: UIColors.white.withOpacity(0.5),
                    ),
                  ],
                ),
          onTap: onTap,
        ),
      ),
    );
  }
}
