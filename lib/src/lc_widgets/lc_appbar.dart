import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../src.dart';

const double appbarHeight = 60;

class LCAppbar extends PreferredSize {
  LCAppbar.base({
    Key? key,
    String? title,
    Color? backgroundColor = UIColors.white,
    bool centerTitle = true,
    bool showBackgroundBackButton = false,
    List<Widget>? actions,
  }) : super(
          key: key,
          child: AppBar(
            centerTitle: centerTitle,
            elevation: 0,
            backgroundColor: backgroundColor,
            actions: actions ?? [],
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,               // Only honored in Android M and above
              statusBarIconBrightness: Brightness.dark,  // Only honored in Android M and above
              statusBarBrightness: Brightness.light,
            ),
            title: LCText.bold(
              title ?? "",
              fontSize: FontSizes.big,
            ),
            leadingWidth: showBackgroundBackButton ? 60 : 40,
            titleSpacing: 0,
            leading: const BackButtonViHat(),
          ),
          preferredSize: const Size.fromHeight(appbarHeight),
        );

  LCAppbar.transparent({
    Key? key,
    Color? backgroundColor = UIColors.white,
  }) : super(
          key: key,
          child: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,               // Only honored in Android M and above
              statusBarIconBrightness: Brightness.dark,  // Only honored in Android M and above
              statusBarBrightness: Brightness.light,
            ),
            title: LCText.bold(
              "",
              fontSize: FontSizes.big,
            ),
            leadingWidth: 0,
            titleSpacing: 0,
            leading: const SizedBox(),
          ),
          preferredSize: const Size.fromHeight(appbarHeight),
        );

  LCAppbar.customTitle({
    Key? key,
    Widget? title,
    Color? backgroundColor = UIColors.white,
    bool centerTitle = true,
    bool showBackgroundBackButton = false,
    List<Widget>? actions,
  }) : super(
          key: key,
          child: AppBar(
            centerTitle: centerTitle,
            elevation: 0,
            backgroundColor: backgroundColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,               // Only honored in Android M and above
              statusBarIconBrightness: Brightness.dark,  // Only honored in Android M and above
              statusBarBrightness: Brightness.light,
            ),
            title: title,
            leadingWidth: showBackgroundBackButton ? 60 : 40,
            titleSpacing: 0,
            leading: const BackButtonViHat(),
            actions: actions,
          ),
          preferredSize: const Size.fromHeight(appbarHeight),
        );
}

class BackButtonViHat extends StatelessWidget {
  const BackButtonViHat({
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
        padding: 5,
        child: Container(
          margin: const EdgeInsets.only(
            left: 10,
          ),
          child: LCImage.asset(
            name: UIImages.icBack,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
