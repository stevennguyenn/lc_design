import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../src.dart';

const double appbarHeight = 54;

class LCAppbar extends PreferredSize {
  LCAppbar.base({
    Key? key,
    String? title,
    Color? backgroundColor = UIColors.white,
    bool centerTitle = true,
    bool showBackButton = true,
    List<Widget>? actions,
    VoidCallback? customBackEvent,
  }) : super(
          key: key,
          child: AppBar(
            centerTitle: centerTitle,
            elevation: 0,
            backgroundColor: backgroundColor,
            actions: actions ?? [],
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              // Only honored in Android M and above
              statusBarIconBrightness: Brightness.dark,
              // Only honored in Android M and above
              statusBarBrightness: Brightness.light,
            ),
            title: LCText.bold(
              title ?? "",
              fontSize: FontSizes.extra,
            ),
            titleSpacing: 0,
            leading:
                showBackButton ? LCBackButton(callback: customBackEvent) : null,
          ),
          preferredSize: const Size.fromHeight(appbarHeight),
        );

  LCAppbar.customTitle({
    Key? key,
    Widget? title,
    Color? backgroundColor = UIColors.white,
    bool centerTitle = true,
    bool showBackgroundBackButton = false,
    bool showBackButton = true,
    List<Widget>? actions,
  }) : super(
          key: key,
          child: AppBar(
            centerTitle: centerTitle,
            elevation: 0,
            backgroundColor: backgroundColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              // Only honored in Android M and above
              statusBarIconBrightness: Brightness.dark,
              // Only honored in Android M and above
              statusBarBrightness: Brightness.light,
            ),
            title: title,
            titleSpacing: 0,
            leadingWidth: 12,
            leading: showBackButton ? const LCBackButton() : const SizedBox(),
            actions: actions,
          ),
          preferredSize: const Size.fromHeight(appbarHeight),
        );
}

class LCBackButton extends StatelessWidget {
  const LCBackButton({
    Key? key,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LCInkwell.base(
        onTap: () {
          if (callback != null) {
            callback!();
          } else {
            Navigator.pop(context);
          }
        },
        padding: 10,
        child: LCImage.asset(
          name: UIImages.icBack,
          width: 18,
          height: 18,
        ),
      ),
    );
  }
}
