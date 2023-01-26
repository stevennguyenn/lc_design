import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../app_font/app_font.dart';
import '../src.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
    required this.hintText,
    this.onChanged,
    this.onSubmit,
    this.textError,
    this.marginLeft = 6,
    this.height = 50,
    this.searchController,
    this.onDone,
    this.isAutoFocus = true,
  }) : super(key: key);
  final String? hintText;
  final String? textError;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final double marginLeft;
  final double height;
  final TextEditingController? searchController;
  final Function? onDone;
  final bool isAutoFocus;

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<SearchTextField> {
  // Use it to change color for border when textFiled in focus
  final FocusNode _focusNode = FocusNode();
  bool isEnableButton = false;
  bool isShowClearAll = false;

  @override
  void initState() {
    super.initState();
    // Change color for border if focus was changed
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          if (widget.searchController?.text.isNotEmpty == true) {
            isEnableButton = true;
            isShowClearAll = true;
          }
          return;
        }
        if (isShowClearAll) {
          isShowClearAll = false;
        }
      });
    });
    if (widget.searchController != null) {
      widget.searchController!.addListener(() {
        if (widget.searchController!.text.isNotEmpty == true) {
          if (isEnableButton != true) {
            setState(() {
              isEnableButton = true;
              if (isShowClearAll != true) {
                isShowClearAll = true;
              }
            });
          }
          return;
        }
        if (isEnableButton != false) {
          setState(() {
            isEnableButton = false;
            isShowClearAll = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color _getColorForTextFieldBorder() {
    if (_focusNode.hasFocus) {
      return UIColors.buttonBG;
    }
    return UIColors.backButtonBG;
  }

  Color _getColorForTextFieldBG() {
    if (_focusNode.hasFocus == true) {
      return UIColors.textFieldBGFC;
    }
    return UIColors.textFieldBG;
  }

  Widget? _renderSuffixIcon() {
    if (isShowClearAll) {
      return LCInkwell.base(
        padding: 0,
        onTap: () {
          widget.searchController!.clear();
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
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 2,
            ),
            height: widget.height,
            margin: EdgeInsets.only(
              left: widget.marginLeft,
            ),
            decoration: BoxDecoration(
              color: _getColorForTextFieldBG(),
              border: Border.all(color: _getColorForTextFieldBorder()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: widget.searchController,
              onChanged: widget.onChanged,
              autofocus: widget.isAutoFocus,
              focusNode: _focusNode,
              enableInteractiveSelection: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  hintStyle: regularFont.copyWith(
                    color: UIColors.blurTextColor,
                  ),
                  suffixStyle: regularFont,
                  suffixIcon: _renderSuffixIcon(),
                  labelStyle: regularFont,
                  isDense: true,
                  filled: true,
                  hintText: widget.hintText?.tr(),
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 24,
                    minWidth: 24,
                  ),
                  counterText: ''),
              onEditingComplete: () {
                widget.onDone?.call();
                _focusNode.unfocus();
              },
              maxLength: 100,
            ),
          ),
        ),
        if (widget.onSubmit != null) ...[
          const SizedBox(
            width: 16,
          ),
          ViHatImageButton(
            image: UIImages.icSearch,
            onClick: () {
              if (!isEnableButton) {
                return;
              }
              FocusScope.of(context).unfocus();
              if (widget.onSubmit != null) {
                widget.onSubmit!.call(widget.searchController!.text);
              }
            },
            status: isEnableButton,
            color: UIColors.buttonBG,
            disableColor: UIColors.gray,
            imageColor: UIColors.white,
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ],
    );
  }
}
