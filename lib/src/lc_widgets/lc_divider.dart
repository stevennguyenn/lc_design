import 'package:flutter/material.dart';

import '../src.dart';


class LCDivider extends Divider {
  const LCDivider.base({
    Key? key,
    Color color = LCColors.gray,
    double height = 1,
  }) : super(
    key: key,
    color: color,
    height: height,
  );
}
