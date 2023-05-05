import 'package:flutter/material.dart';

import '../../src.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.confirmButtonTitle,
  }) : super(key: key);

  final String title;
  final String message;
  final String confirmButtonTitle;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: LCColors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              if (title != "") ...[
                LCText.bold(
                  title,
                  fontSize: FontSizes.big,
                  maxLines: 10,
                ),
                const SizedBox(
                  height: 8,
                )
              ],
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: LCText.base(
                  message,
                  fontSize: FontSizes.medium,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LCInkwell.base(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Center(
                          child: LCText.base(
                            confirmButtonTitle,
                            color: LCColors.buttonBG,
                            fontSize: FontSizes.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LCInkwell.base(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 40,
                        child: Center(
                          child: LCText.base(
                            "cancel",
                            fontSize: FontSizes.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
