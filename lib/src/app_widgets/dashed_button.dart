import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../src.dart';

class DashedButton extends StatelessWidget {
  const DashedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.image,
  });

  final String title;
  final VoidCallback onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return LCInkwell.base(
      opacity: 0.6,
      onTap: onTap,
      child: DottedBorder(
        color: LCColors.black,
        dashPattern: const [6, 6, 6, 6],
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(6),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != null) ...[
                LCImage.asset(
                  name: image!,
                  width: 24,
                  height: 20,
                ),
                const SizedBox(
                  width: 5,
                )
              ],
              image != null
                  ? LCText.regular(
                      title,
                      fontWeight: FontWeight.bold,
                    )
                  : LCText.regular(
                      title,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
