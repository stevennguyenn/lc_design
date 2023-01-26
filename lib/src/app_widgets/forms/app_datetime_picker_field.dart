import 'package:flutter/material.dart';
import '../../src.dart';

enum LimitTimeStyle {
  min,
  max,
  none,
}

class AppDateTimePickerField extends StatelessWidget {
  final String title;
  final DateTime? date;
  final DateTimeFormat? format;
  final Function(DateTime)? callback;
  final LimitTimeStyle limitTimeStyle;
  final DateTime? limitTime;

  const AppDateTimePickerField({
    super.key,
    required this.title,
    this.date,
    this.format,
    this.callback,
    //need when you limit in picker
    this.limitTimeStyle = LimitTimeStyle.none,
    this.limitTime,
  });

  @override
  Widget build(BuildContext context) {
    String dateString = "-";
    if (date != null) {
      dateString = DateTimeHelper.getString(
        date!,
        format: format ?? DateTimeFormat.dd_MM_YYYY,
      );
    }
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
            title,
            fontSize: FontSizes.small,
          ),
          const SizedBox(
            height: 8,
          ),
          LCInkwell.base(
            opacity: 1,
            onTap: () {
              if (limitTimeStyle == LimitTimeStyle.none) {
                DateTimePickerHelper.instance.showDatePicker(
                  (newDate) {
                    callback?.call(newDate);
                  },
                  now: date,
                  context: context,
                );
              }
              if (limitTimeStyle == LimitTimeStyle.min) {
                DateTimePickerHelper.instance.showDatePickerWithMinTime(
                  (newDate) {
                    callback?.call(newDate);
                  },
                  now: date,
                  minTime: limitTime!,
                  context: context,
                );
              }
              if (limitTimeStyle == LimitTimeStyle.max) {
                DateTimePickerHelper.instance.showDatePickerWithMaxTime(
                  (newDate) {
                    callback?.call(newDate);
                  },
                  now: date,
                  maxTime: limitTime!,
                  context: context,
                );
              }
            },
            child: Row(
              children: [
                LCText.base(
                  dateString,
                  fontSize: FontSizes.medium,
                ),
                const Spacer(),
                ViHatImage.asset(
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
