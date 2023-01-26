import 'package:flutter/material.dart';
import 'package:lc_design/src/app_widgets/app_sized_box.dart';
import '../../src.dart';

class AppDropdownField extends StatefulWidget {
  final String title;
  final List<String> dropdownValues;
  final String? initValue;
  final Function(String)? callback;
  final bool isClearable;

  const AppDropdownField({
    super.key,
    required this.title,
    this.dropdownValues = const <String>["a", "b"],
    this.initValue,
    this.callback,
    this.isClearable = true,
  });

  @override
  State<AppDropdownField> createState() => AppDropdownFieldState();
}

class AppDropdownFieldState extends State<AppDropdownField>
    with AutomaticKeepAliveClientMixin {
  String currentValue = "";
  bool isShowClear = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    setCurrentValue(widget.initValue ?? '');
    super.initState();
  }

  void setCurrentValue(String value) {
    currentValue = value;

    if (currentValue.isNotEmpty == true) {
      isShowClear = true;
    }
  }

  @override
  void didUpdateWidget(covariant AppDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initValue != widget.initValue) {
      setCurrentValue(widget.initValue ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LCInkwell.base(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: UIColors.textFieldBG,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LCText.bold(
              widget.title,
              fontSize: FontSizes.small,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: LCText.regular(
                    currentValue.isNotEmpty == true && currentValue != '0'
                        ? currentValue
                        : "-",
                  ),
                ),
                const AppSizedBox.width(
                  width: 6,
                ),
                if (isShowClear == true && widget.isClearable)
                  LCInkwell.base(
                    onTap: () {
                      setState(() {
                        isShowClear = false;
                        currentValue = '0';
                      });
                    },
                    child: LCImage.asset(
                      name: UIImages.icDownloadBlack,
                    ),
                  ),
                const AppSizedBox.width(
                  width: 8,
                ),
                LCImage.asset(
                  name: UIImages.icDropDown,
                  width: 12,
                  height: 12,
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () async {
        final result = await PickerHelper.instance.showPicker(
          widget.dropdownValues,
          currentValue: currentValue == '0' ? "" : currentValue,
          context: context,
        );
        if (!mounted || result == null) {
          return;
        }
        setState(() {
          currentValue = result;
          isShowClear = true;
        });
        if (widget.callback != null) {
          widget.callback!(result);
        }
      },
    );
  }
}
