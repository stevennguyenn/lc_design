import 'package:flutter/cupertino.dart';

class LCInkwell extends CupertinoButton {
  LCInkwell.base({
    Key? key,
    required Widget child,
    VoidCallback? onTap,
    double padding = 0,
    bool showShadow = false,
    double opacity = 0.4,
    Alignment alignment = Alignment.center,
  }) : super(
          key: key,
          padding: const EdgeInsets.all(0),
          alignment: alignment,
          minSize: 5,
          borderRadius: BorderRadius.circular(0),
          onPressed: onTap,
          child: padding != 0
              ? Padding(
                  padding: EdgeInsets.all(padding),
                  child: child,
                )
              : child,
          pressedOpacity: opacity,
        );
}
