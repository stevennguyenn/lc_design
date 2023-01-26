import 'package:flutter/cupertino.dart';

import '../../src.dart';

class TextSelectionItem extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool isEnabled;

  const TextSelectionItem({
    super.key,
    required this.text,
    required this.callback,
    this.isEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return LCInkwell.base(
      onTap: callback,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: LCText.regular(
          text,
          textAlign: TextAlign.left,
          fontWeight: isEnabled ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }
}
