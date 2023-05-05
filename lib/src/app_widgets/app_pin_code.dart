import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../app_font/app_font.dart';
import '../constants/colors.dart';
import '../constants/font_sizes.dart';

class AppPinCode extends StatelessWidget {
  const AppPinCode({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: PinCodeTextField(
        keyboardType: keyboardType,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          selectedFillColor: LCColors.textFieldBG,
          inactiveFillColor: LCColors.textFieldBG,
          activeColor: LCColors.textFieldBG,
          selectedColor: LCColors.textFieldBG,
          inactiveColor: Colors.transparent,
          activeFillColor: Colors.transparent,
        ),
        focusNode: focusNode,
        cursorColor: LCColors.buttonBG,
        animationDuration: const Duration(
          milliseconds: 300,
        ),
        scrollPadding: EdgeInsets.zero,
        errorTextSpace: 0,
        enableActiveFill: true,
        autoFocus: true,
        textStyle: boldFont.copyWith(
          fontSize: FontSizes.extra,
        ),
        controller: controller,
        onCompleted: (v) {
          onSubmit!.call(v);
        },
        onChanged: (value) {},
        beforeTextPaste: (text) {
          return true;
        },
        appContext: context,
      ),
    );
  }
}
