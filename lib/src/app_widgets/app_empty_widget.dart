import 'package:flutter/cupertino.dart';
import '../src.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LCImage.asset(
          name: LCCImages.icEmpty,
          width: 56,
          height: 56,
        ),
        const SizedBox(
          height: 8,
        ),
        LCText.base(
          "empty",
          color: LCColors.defaultText.withOpacity(0.5),
        ),
      ],
    );
  }
}
