import 'package:flutter/material.dart';

class AppSizedBox extends SizedBox {
  const AppSizedBox.width({
    super.key,
    double width = 16,
  }) : super(width: width);

  const AppSizedBox.height({
    super.key,
    double height = 16,
  }) : super(height: height);
}
