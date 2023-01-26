import 'package:flutter/material.dart';
import 'package:lc_design/src/app_widgets/app_sized_box.dart';
import '../../src.dart';

class AppDateTimePickerStatefulField extends StatefulWidget {
  final String title;
  final DateTimeFormat? format;
  final String? initData;
  final bool isDisableFuture;
  final bool isBirthday;

  const AppDateTimePickerStatefulField({
    super.key,
    required this.title,
    this.format,
    this.initData,
    this.isDisableFuture = false,
    this.isBirthday = false,
    //need when you limit in picker
  });

  @override
  State<AppDateTimePickerStatefulField> createState() =>
      AppDateTimePickerStatefulFieldState();
}

class AppDateTimePickerStatefulFieldState
    extends State<AppDateTimePickerStatefulField>
    with AutomaticKeepAliveClientMixin {
  String _currentDateString = "";
  DateTime? currentDatePicker;
  bool isShowClear = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    setCurrentDate(widget.initData);
    super.initState();
  }

  void setCurrentDate(String? initData) {
    if (initData?.isNotEmpty == true) {
      _currentDateString = initData ?? "";
      isShowClear = true;
    }
  }

  @override
  void didUpdateWidget(covariant AppDateTimePickerStatefulField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initData != widget.initData) {
      setCurrentDate(widget.initData);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
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
          LCInkwell.base(
            opacity: 1,
            onTap: () {
              DateTimePickerHelper.instance.showDatePicker(
                (newDate) {
                  currentDatePicker = newDate;
                  setState(() {
                    _currentDateString = DateTimeHelper.getString(
                      newDate,
                      format: DateTimeFormat.dd_MM_YYYY,
                    );
                    isShowClear = true;
                  });
                },
                now: _currentDateString == ""
                    ? null
                    : DateTimeHelper.getDate(
                        _currentDateString,
                        format: DateTimeFormat.dd_MM_YYYY,
                      ),
                subtractYear: 70,
                disableFuture: widget.isDisableFuture,
                isBirthday: widget.isBirthday,
                context: context,
              );
            },
            child: Row(
              children: [
                LCText.base(
                  _currentDateString.isEmpty == true ? "-" : _currentDateString,
                  fontSize: FontSizes.medium,
                ),
                const Spacer(),
                if (isShowClear == true)
                  LCInkwell.base(
                    onTap: () {
                      setState(() {
                        _currentDateString = "";
                        isShowClear = false;
                        currentDatePicker = DateTime(1, 1, 1);
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
                  name: 'ic_calendar.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
