import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_font/app_font.dart';
import '../src.dart';

class LCText extends Text {
  LCText.base(
    String text, {
    Key? key,
    /// need list of size
    double? fontSize = FontSizes.medium,
    Color? color = UIColors.textColor,
    FontWeight? fontWeight,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? textOverflow = TextOverflow.ellipsis,
  }) : super(
          /// can use tr() if you use multiple language
          text.tr(),
          style: GoogleFonts.roboto(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
          ),
          overflow: textOverflow,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
        );

  LCText.regular(
    String text, {
    Key? key,

    /// need list of size
    double? fontSize = FontSizes.medium,
    Color? color = UIColors.textColor,
    FontWeight? fontWeight = FontWeight.w400,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? textOverflow = TextOverflow.ellipsis,
  }) : super(
          /// can use tr() if you use multiple language
          text.tr(),
          style: regularFont.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          maxLines: maxLines,
          key: key,
          textAlign: textAlign,
          overflow: textOverflow,
        );

  LCText.medium(
    String text, {
    Key? key,

    /// need list of size
    double? fontSize = FontSizes.medium,
    Color? color = UIColors.textColor,
    FontWeight? fontWeight = FontWeight.w500,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? textOverflow = TextOverflow.ellipsis,
  }) : super(
          /// can use tr() if you use multiple language
          text.tr(),
          style: mediumFont.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          maxLines: maxLines,
          key: key,
          textAlign: textAlign,
          overflow: textOverflow,
        );

  LCText.bold(
    String text, {
    Key? key,

    /// need list of size
    double? fontSize = FontSizes.medium,
    Color? color = UIColors.textColor,
    FontWeight? fontWeight = FontWeight.w700,
    int? maxLines,
    TextOverflow? textOverflow = TextOverflow.ellipsis,
    TextAlign? textAlign,
  }) : super(
          /// can use tr() if you use multiple language
          text.tr(),
          style: boldFont.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          overflow: textOverflow,
        );
}
