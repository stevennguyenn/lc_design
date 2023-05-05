import 'package:flutter/material.dart';

import '../../src.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    Key? key,
    required this.title,
    required this.message,
    this.callback,
  }) : super(key: key);

  final String title;
  final String message;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
              height: 24,
            ),
            LCInkwell.base(
              onTap: () {
                Navigator.pop(context);
                if (callback != null) {
                  callback!.call();
                }
              },
              child: SizedBox(
                height: 40,
                child: Center(
                  child: LCText.regular(
                    "ok",
                    fontSize: FontSizes.medium,
                    color: LCColors.buttonBG,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
