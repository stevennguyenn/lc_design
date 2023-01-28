import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lc_design/lc_design.dart';
import 'package:lc_design/src/app_font/app_font.dart';

class AppCountdownTimerWidget extends StatefulWidget {
  const AppCountdownTimerWidget({
    super.key,
    required this.initTimer,
    this.textStyle,
    this.endTime,
  });

  final int initTimer;
  final TextStyle? textStyle;
  final VoidCallback? endTime;

  @override
  State<StatefulWidget> createState() {
    return AppCountdownTimerState();
  }
}

class AppCountdownTimerState extends State<AppCountdownTimerWidget> {
  late Timer? _timer;
  late int _currentTime;
  Color _color = UIColors.buttonBG;

  @override
  void initState() {
    _currentTime = widget.initTimer;
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timer.tick >= widget.initTimer) {
          _timer?.cancel();
          _timer = null;
          widget.endTime?.call();
          return;
        }
        if (mounted) {
          final newTime = widget.initTimer - timer.tick;
          if (newTime < 600 && _color == UIColors.buttonBG) {
            _color = UIColors.red;
          }
          _currentTime = widget.initTimer - timer.tick;
          setState(() {
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 16,
          color: _color,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          _currentTime.formatTimer(),
          style: (widget.textStyle ?? regularFont).copyWith(
            color: _color,
          ),
        ),
      ],
    );
  }
}
