import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///calculate device pixel
// String convertUrlAndSize(
//     BuildContext context,
//     String url,
//     double width,
//     double height,
//     ) {
//   String urlResized = url;
//   MediaQueryData queryData = MediaQuery.of(context);
//   double devicePixelRatio = queryData.devicePixelRatio;
//   var iWidth = calculateImageWidth((devicePixelRatio * width).toInt());
//   var iHeight = ((height * iWidth) / width).round();
//   urlResized = '$url?w=$iWidth&h=$iHeight';
//   return urlResized;
// }
//
// int calculateImageWidth(int width) {
//   if (width < 80) {
//     return 80;
//   } else if (width < 160) {
//     return 160;
//   } else if (width < 240) {
//     return 240;
//   } else if (width < 320) {
//     return 320;
//   } else if (width < 480) {
//     return 480;
//   } else if (width < 640) {
//     return 640;
//   }
//   return 480;
// }

class LCInternetImage extends StatelessWidget {
  const LCInternetImage({
    Key? key,
    required this.url,
    this.width = 0,
    this.height = 0,
    // this.icon,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    // this.widthCorrectImage,
    // this.heightCorrectImage,
    this.placeHolder,
  }) : super(key: key);

  final String url;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final String? placeHolder;

  @override
  Widget build(BuildContext context) {
    return borderRadius == 0
        ? CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            errorWidget: (_, __, ___) {
              return LCImage.asset(
                ///replace error image asset
                name: placeHolder ?? "",
                boxFit: BoxFit.contain,
                width: width,
                height: height,
              );
            },
            placeholder: (BuildContext context, String url) {
              ///replace animation or loading widget
              return const SizedBox();
            },
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CachedNetworkImage(
              imageUrl: url,
              width: width,
              height: height,
              fit: fit,
              errorWidget: (_, __, ___) {
                return LCImage.asset(
                  ///replace error image asset
                  name: placeHolder ?? "",
                  boxFit: BoxFit.contain,
                  width: width,
                  height: height,
                );
              },
              placeholder: (BuildContext context, String url) {
                ///replace animation or loading widget
                return const SizedBox();
              },
            ),
          );
  }
}

class LCImage extends Image {
  LCImage.asset({
    Key? key,
    required String name,
    double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.cover,
    String subFolder = "images",
  }) : super(
          key: key,
          image: ResizeImage.resizeIfNeeded(
            null,
            null,
            AssetImage("assets/$subFolder/$name"),
          ),
          width: width,
          height: height,
          color: color,
          fit: boxFit,
        );

  LCImage.file({
    Key? key,
    required File file,
    double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.cover,
  }) : super(
          key: key,
          image: ResizeImage.resizeIfNeeded(
            null,
            null,
            FileImage(file),
          ),
          width: width,
          height: height,
          color: color,
          fit: boxFit,
        );
}
