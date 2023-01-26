import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../src.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.size = 32,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: RepaintBoundary(
        child: LoadingIndicator(
          indicatorType: Indicator.lineSpinFadeLoader,
          colors: [UIColors.buttonBG],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: UIColors.buttonBG,
        ),
      ),
    );
  }
}

class ImageLoadingWidget extends StatelessWidget {
  const ImageLoadingWidget({
    Key? key,
    this.size = 32,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.dark,
        ),
      ),
      child: CupertinoActivityIndicator(
        radius: size / 2,
        animating: true,
      ),
    );
  }
}
