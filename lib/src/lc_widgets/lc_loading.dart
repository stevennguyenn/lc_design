import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../src.dart';

class LCLoading extends StatelessWidget {
  const LCLoading({
    Key? key,
    this.showBackground = true,
    this.needSizeBox = true,
  }) : super(key: key);

  final bool showBackground;
  final bool needSizeBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LCColors.textFieldBG,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  color: showBackground
                      ? LCColors.gray.withOpacity(0.05)
                      : Colors.transparent,
                ),
                child: Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: RepaintBoundary(
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineSpinFadeLoader,
                        colors: [LCColors.buttonBG],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: LCColors.buttonBG,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox.expand(
            child: Container(
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
