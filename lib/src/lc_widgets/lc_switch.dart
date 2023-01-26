import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../src.dart';

class LCSwitch extends StatelessWidget {
  const LCSwitch({
    Key? key,
    this.width = 35,
    this.height = 16,
    this.toggleSize = 16,
    this.status = true,
    required this.changed,
  }) : super(key: key);

  final double width;
  final double height;
  final double toggleSize;
  final Function(bool) changed;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: width,
      height: height,
      toggleSize: toggleSize,
      value: status,
      borderRadius: height / 2,
      padding: 0.5,
      activeColor: UIColors.red,
      inactiveTextColor: UIColors.gray,
      showOnOff: false,
      onToggle: changed,
      activeTextColor: UIColors.white,
    );
  }
}
