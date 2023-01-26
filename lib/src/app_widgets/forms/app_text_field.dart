import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app_font/app_font.dart';
import '../../src.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    this.labelText,
    required this.hintText,
    this.callback,
    this.isPassword = false,
    this.textError,
    this.headerMaxLines,
    this.tfMaxLines = 1,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.currentNode,
    this.nextNode,
    this.tfMaxLength,
    this.onSubmit,
    this.autoFocus = false,
    this.action = TextInputAction.done,
    this.inputFormatters,
  }) : super(key: key);
  final String? labelText;
  final String? hintText;
  final String? textError;
  final Function()? onSubmit;
  final Function(String)? callback;
  final bool isPassword;
  final TextInputType? keyboardType;
  final int? headerMaxLines;
  final int? tfMaxLines;
  final TextEditingController? controller;
  final FocusNode? currentNode;
  final FocusNode? nextNode;
  final int? tfMaxLength;
  final bool autoFocus;
  final TextInputAction? action;
  final List<TextInputFormatter>? inputFormatters;

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  // Color for border
  bool isHidePassword = true;
  String? errorMessage;
  late FocusNode currentNode;
  bool isShowClearAll = false;

  @override
  void initState() {
    currentNode = widget.currentNode ?? FocusNode();
    super.initState();
    // Change color for border if focus was changed
    currentNode.addListener(() {
      setState(() {
        if (currentNode.hasFocus) {
          errorMessage = null;
          if (widget.controller?.text.isNotEmpty == true) {
            isShowClearAll = true;
          }
          return;
        }
        if (isShowClearAll) {
          isShowClearAll = false;
        }
      });
    });

    if (widget.controller != null) {
      widget.controller!.addListener(() {
        if (currentNode.hasFocus == false) {
          return;
        }
        if (widget.controller!.text.isNotEmpty == true) {
          if (isShowClearAll != true) {
            setState(() {
              isShowClearAll = true;
            });
          }
          return;
        }
        if (isShowClearAll != false) {
          setState(() {
            isShowClearAll = false;
          });
        }
      });
    }
  }

  setErrorMessage(String message) {
    if (!mounted) {
      return;
    }
    setState(() {
      errorMessage = message;
    });
  }

  Color _getColorForTitle() {
    if (errorMessage != null) {
      return UIColors.red;
    }
    if (currentNode.hasFocus == true) {
      return UIColors.buttonBG;
    }
    return UIColors.textColor;
  }

  Color _getColorForTextFieldBorder() {
    if (errorMessage != null) {
      return UIColors.red;
    }
    if (currentNode.hasFocus == true) {
      return UIColors.buttonBG;
    }
    return Colors.transparent;
  }

  Color _getColorForTextFieldBG() {
    if (errorMessage != null) {
      return UIColors.textFieldBGER;
    }
    if (currentNode.hasFocus == true) {
      return UIColors.textFieldBGFC;
    }
    return UIColors.textFieldBG;
  }

  Widget getTitleWidget() {
    if (errorMessage != null) {
      return LCText.bold(
        errorMessage ?? "",
        fontSize: FontSizes.small,
        color: UIColors.red,
      );
    }
    if (widget.labelText != null) {
      return LCText.bold(
        widget.labelText ?? "",
        fontSize: FontSizes.small,
        maxLines: widget.headerMaxLines,
        color: _getColorForTitle(),
      );
    }
    return const SizedBox();
  }

  Widget? renderSuffixIcon() {
    if (widget.isPassword) {
      final name =
          isHidePassword ? UIImages.icVisibilityOff : UIImages.icVisibility;
      return LCInkwell.base(
        padding: 0,
        onTap: () {
          setState(() {
            isHidePassword = !isHidePassword;
          });
        },
        child: ViHatImage.asset(
          name: name,
        ),
      );
    }

    if (isShowClearAll) {
      return LCInkwell.base(
        padding: 0,
        onTap: () {
          widget.controller!.clear();
        },
        child: ViHatImage.asset(
          name: UIImages.icDownloadBlack,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: _getColorForTextFieldBG(),
        border: Border.all(color: _getColorForTextFieldBorder()),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleWidget(),
          TextField(
            autofocus: widget.autoFocus,
            controller: widget.controller,
            onChanged: widget.callback,
            focusNode: currentNode,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            textInputAction:
                widget.nextNode != null ? TextInputAction.next : widget.action,
            enableInteractiveSelection: true,
            obscureText: widget.isPassword == true ? isHidePassword : false,
            maxLines: widget.tfMaxLines,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              selectAll: true,
              paste: true,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              border: InputBorder.none,
              fillColor: Colors.transparent,
              hintStyle: regularFont.copyWith(
                color: UIColors.blurTextColor,
              ),
              suffixStyle: regularFont,
              labelStyle: regularFont,
              isDense: true,
              filled: true,
              hintText: widget.hintText?.tr(),
              suffixIconConstraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
              suffixIcon: renderSuffixIcon(),
              counterText: '',
            ),
            onEditingComplete: () {
              if (widget.nextNode != null) {
                widget.nextNode!.requestFocus();
              } else {
                currentNode.unfocus();
              }
              if (widget.onSubmit != null) {
                widget.onSubmit!.call();
              }
            },
            maxLength: widget.tfMaxLength,
          ),
        ],
      ),
    );
  }
}
