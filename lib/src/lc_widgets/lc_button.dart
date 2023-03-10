import 'package:flutter/material.dart';

import '../src.dart';

class LCButton extends MaterialButton {
  LCButton.base({
    Key? key,
    required String title,
    required VoidCallback onTap,
    Color? bgColor,
    Color titleColor = UIColors.white,
    Color bgDisableColor = UIColors.gray,
    double? fontSize = FontSizes.medium,
    Widget? titleWidget,
    FontWeight? weight,
    bool status = true,
    bool hasBorder = false,
    double borderRadius = 12,
    EdgeInsets? padding,
    double minWidth = 44,
    double height = 56,
    VoidCallback? onLongPress,
  }) : super(
          key: key,
          minWidth: minWidth,
          elevation: 0,
          onPressed: status ? onTap : null,
          onLongPress: onLongPress,
          color: bgColor ?? UIColors.buttonBG,
          padding: padding,
          disabledColor: bgDisableColor,
          height: height,
          splashColor: status ? null : Colors.transparent,
          highlightColor: status ? null : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: hasBorder ? UIColors.gray : Colors.transparent,
              width: hasBorder ? 1 : 0,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: titleWidget ??
                LCText.bold(
                  title,
                  fontSize: fontSize,
                  color: titleColor,
                ),
          ),
        );
}

class LCImageButton extends StatelessWidget {
  const LCImageButton({
    Key? key,
    required this.image,
    this.height = 40,
    this.width = 40,
    this.status = true,
    required this.onClick,
    this.disableColor,
    this.color = UIColors.background,
    this.borderRadius = 12,
    this.imageColor,
  }) : super(key: key);

  final String image;
  final double? height;
  final double? width;
  final bool status;
  final VoidCallback onClick;
  final Color? color;
  final Color? disableColor;
  final Color? imageColor;
  final double borderRadius;
  // final Function onClick;
  @override
  Widget build(BuildContext context) {
    return LCInkwell.base(
      onTap: status == true ? onClick : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: status == true ? color : disableColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: LCImage.asset(
            name: image,
            width: 24,
            height: 24,
            color: imageColor,
          ),
        ),
      ),
    );
  }
}

class LCIconButton extends StatelessWidget {
  const LCIconButton({
    Key? key,
    required this.icon,
    this.height = 40,
    this.width = 40,
    this.status = true,
    required this.onClick,
    this.disableColor,
    this.color = UIColors.background,
    this.borderRadius = 12,
    this.size = 24,
    this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final double? height;
  final double? width;
  final bool status;
  final VoidCallback onClick;
  final Color? color;
  final Color? disableColor;
  final double borderRadius;
  final double size;
  final Color? iconColor;
  // final Function onClick;
  @override
  Widget build(BuildContext context) {
    return LCInkwell.base(
      onTap: status == true ? onClick : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: status == true ? color : disableColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Icon(
            icon,
            size: size,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
